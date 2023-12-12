from typing import Optional, List, TypedDict, Union, Dict
import subprocess
import logging
import os
from pwd import getpwnam
from grp import getgrnam

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

def _exec_demote() -> None:
    """ Drop down into the configured runner user and group.
    """
    try:
        build_user = None
        aurpkg_opts = __opts__.get(OPTS_PARENT_KEY)
        if aurpkg_opts is not None:
            build_user = aurpkg_opts.get(OPTS_BUILD_USER_KEY)

        if build_user is not None:
            uid = getpwnam(build_user).pw_uid
            gid = getgrnam(build_user).gr_gid
            
            os.setgid(gid)
            os.setuid(uid)

            log.info("Dropped down into user %s for execution", build_user)
        else:
            log.info("Not dropping down into execution user, not specified")
    except Exception as e:
        log.error("failed to preexec: %s", e)
        

def _installed(name: str, pkgs: List[str]) -> SaltStateRes:
    """ Actually performs the install logic.
    """
    args = [
        "yay",
        "--sync",
        "--refresh",
        "--noconfirm",
    ] + pkgs
    log.info("Executing: %s", " ".join(args))

    log.info("pre.Popen")
    proc = subprocess.Popen(
        args,
        preexec_fn=_exec_demote,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )
    stdout, stderr = proc.communicate()

    log.info("returncode=%d", proc.returncode)

    output = []

    if stderr:
        line = stderr.decode(__salt_system_encoding__)
        output.append(line)
        
        log.error(line)

    if stdout:
        line = stdout.decode(__salt_system_encoding__)
        output.append(line)
        
        log.info(line)

    pkgs_str = ", ".join(pkgs)

    res = SaltStateRes(
            name=name,
        result=True,
        changes=SaltStateResChanges(
            old=f"not all of {pkgs_str} installed",
            new=f"{pkgs_str} installed",
        ),
        comment="\n".join(output),
    )

    if proc.returncode != 0:
        res["result"] = False
        res["changes"]["new"] = f"{pkgs_str} failed to installed"

    return res

def _check_installed(name: str, pkgs: List[str]) -> SaltStateRes:
    """ Actually check if package is installed.
    """
    pkgs_space_sep_str = " ".join(pkgs)
    res = __salt__["cmd.run"](f"yay --query --info {pkgs_space_sep_str}")
    log.info("cmd.run res=%s", res)

    pkgs_str = ", ".join(pkgs)
        
    is_installed = res["result"] is True
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
        

    return _installed(name=name, pkgs=pkgs)
            
