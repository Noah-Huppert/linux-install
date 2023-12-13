from typing import Optional, List, TypedDict, Union, Dict
import subprocess
import logging
import os
from pwd import getpwnam
from grp import getgrnam

from salt.exceptions import CommandExecutionError

log = logging.getLogger(__name__)

OPTS_PARENT_KEY = "aurpkg"
OPTS_BUILD_USER_KEY = "build_user"

class SaltStateResChanges(TypedDict):
    """ Describes changes.
    """
    old: str
    new: str

class SaltStateRes(TypedDict):
    """ Describes the result of a salt state execution.
    """
    name: str
    result: bool
    changes: Union[SaltStateResChanges, Dict[str, str]]
    comment: str

def _cmd_run(cmd: str) -> str:
    """ Run a command as the correct user.
    """
    kwargs = {
        "cmd": cmd,
        "raise_err": True,
    }
    
    # Figure out if we want to run as a specific user
    build_user = None
    aurpkg_opts = __opts__.get(OPTS_PARENT_KEY)
    if aurpkg_opts is not None:
        build_user = aurpkg_opts.get(OPTS_BUILD_USER_KEY)

    if build_user is not None:
        kwargs["runas"] = build_user
        kwargs["group"] = build_user


    return __salt__["cmd.run"](**kwargs)
    

def _installed(name: str, pkgs: List[str]) -> SaltStateRes:
    """ Actually performs the install logic.
    """
    pkgs_space_sep_str = " ".join(pkgs)

    res = SaltStateRes(
            name=name,
        result=True,
        changes=SaltStateResChanges(
            old=f"not all of {pkgs_space_sep_str} installed",
            new=f"{pkgs_space_sep_str} installed",
        ),
        comment="",
    )

    try:
        _cmd_run(f"yay --sync --refresh --noconfirm {pkgs_space_sep_str}")
    except CommandExecutionError:
        res["result"] = False
        res["changes"]["new"] = f"{pkgs_space_sep_str} failed to installed"
    
    return res

def _check_installed(name: str, pkgs: List[str]) -> SaltStateRes:
    """ Actually check if package is installed.
    """
    pkgs_space_sep_str = " ".join(pkgs)
    is_installed = True

    try:
        _cmd_run(f"yay --query --info {pkgs_space_sep_str}")
    except CommandExecutionError:
        is_installed = False

    pkgs_str = ", ".join(pkgs)
    installed_comment = f"{pkgs_str} installed" if is_installed else f"{pkgs_str} not installed",

    return SaltStateRes(
        name=name,
        result=is_installed,
        changes=SaltStateResChanges(
            old="",
            new=installed_comment
        ),
        comment=installed_comment,
    )
    

def check_installed(name: str, pkgs: Optional[List[str]]=None) -> SaltStateRes:
    """ Determines if a package is installed.
    """
    return _check_installed(name=name, pkgs=pkgs if pkgs is not None else [name])


def installed(name: str, pkgs: Optional[List[str]]=None) -> SaltStateRes:
    """ Ensures AUR packages are installed.
    """
    # Check if already installed
    pkgs_str = ", ".join(pkgs) if pkgs is not None else name
    check_res = check_installed(name=name, pkgs=pkgs)
    
    # Check if in test mode
    if __opts__["test"]:
        res = SaltStateRes(
            name=name,
            result=None,
            changes=SaltStateResChanges(
                old=f"{pkgs_str} not installed",
                new=f"{pkgs_str} installed",
            ),
            comment=f"would have installed {pkgs_str}",
        )
            
        if check_res["result"]:
            res["result"] = True
            res["changes"] = {}
            res["comment"] = f"{pkgs_str} already installed"

        return res

    if check_res["result"] is True:
        return SaltStateRes(
            name=name,
            result=True,
            changes={},
            comment=f"already installed {pkgs_str}",
        )

    return _installed(name=name, pkgs=pkgs)
            
