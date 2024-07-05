"""
Overview
========
Allows installing of a variety of packages from different sources.
"""

from typing import TypedDict, Optional, Dict, Union, List

class SaltStateResChanges(TypedDict):
    """ Describes changes.
    Fields:
    - old: User facing string describing previous status before changes
    - new: User facing string describing status after changes
    """
    old: str
    new: str

class SaltStateRes(TypedDict):
    """ Describes the result of a salt state execution.
    Fields:
    - name: Identifier of state block
    - result: Indicates if the state was successful, failed, or shouldn't run, see for more details: https://docs.saltproject.io/en/latest/ref/states/writing.html#return-data
    - changes: Describes what changed due to this state running, SaltStateResChanges if changes were made, an empty dict if no changes were made
    - comment: Single line descibing what changed
    """
    name: str
    result: Optional[bool]
    changes: Union[SaltStateResChanges, Dict[str, str]]
    comment: str

PkgDef = Union[str, List[str], Dict[str, Union[str, List[str]]]]

class InvalidPkgDefError(Exception):
    pass

def installed(name: str, pkgs: List[PkgDef]) -> SaltStateRes:
    """ Installs packages from many different sources.
    Arguments:
    - name: Name of state
    - pkgs: Must be one of the following formats:
      - List of dictionaries with only one key. Where the key is the name of the Salt state used to install the package named by value. The value can either be a single package or a list of packages. In this list a dictionary key can only appear once
      - List of strings or single string. The default `pkg` state is used to install these packages

    Raises:
    - InvalidPkgDefError: If an item of the pkgs argument does not meet the format laid out
    """
    results: List[SaltStateRes] = []

    if not isinstance(pkgs, list):
        raise InvalidPkgDefError(f"Package definitions must be a list")

    
    for pkg_def in pkgs:
        pkg_state = "pkg"
        pkgs_list = []

        # Allow a pkg def to either be a list
        if isinstance(pkg_def, list):
            pkgs_list = pkg_def
        elif isinstance(pkg_def, str): # Single string
            pkgs_list = [pkg_def]
        elif isinstance(pkg_def, dict): # Or a dict
            # Check pkg_def format
            if len(pkg_def) != 1:
                raise InvalidPkgDefError(f"A package definition must have only one key, had: {len(pkg_def)}")

            pkg_state, pkgs_value = pkg_def.popitem()

            # Determine if one or many packages to install
            pkgs_list = []
            if isinstance(pkgs_value, list):
                pkgs_list = pkgs_value
            elif isinstance(pkgs_value, str):
                pkgs_list = [pkgs_value]
            else:
                raise InvalidPkgDefError(f"A package definition's one value must either be a list or a string, was: {type(pkgs_value)}")
        else:
            # pkg def was not one of the allowed formats
            raise InvalidPkgDefError(f"A package definition must either be a dict or a list, was: {type(pkg_def)}")

        # Run install
        res = __states__[f"{pkg_state}.installed"](name=f"{name}.{pkg_state}", pkgs=pkgs_list)
        results.append(res)

    # Aggregate results
    changed_state_results = len(list(filter(lambda res: res['result'], results)))
    old_changes_results = list(filter(lambda res: 'old' in res['changes'], results))
    new_changes_results = list(filter(lambda res: 'new' in res['changes'], results))

    changes = {}
    if len(old_changes_results) > 0 or len(new_changes_results) > 0:
        old_changes = list(map(lambda res: f"{res['name']}: {res['changes']['old']}", old_changes_results))
        new_changes = list(map(lambda res: f"{res['name']}: {res['changes']['new']}", new_changes_results))
        
        changes = SaltStateResChanges(
            old=", ".join(old_changes),
            new=", ".join(new_changes),
        )

    comments = list(map(lambda res: f"{res['name']}: {res['comment']}", results))
    
    return SaltStateRes(
        name=name,
        result= changed_state_results > 0,
        changes=changes,
        comment="\n".join(comments),
    )

def enabled(name: str, user: str) -> SaltStateRes:
    systemctl_cmd = [
        "systemctl",
        "enable",
        "--user",
        "--now",
    ]

    cmd = [
        "machinectl",
        "shell",
        f"{user}@.host",
        "/usr/bin/env",
    ]
    
    systemctl_cmd.append(name)
    cmd.append(" ".join(systemctl_cmd))

    res = __salt__["cmd.run"](
        cmd=" ".join(cmd),
        raise_err=True,
    )

    return SaltStateRes(
        name=name,
        result=True,
        changes=SaltStateResChanges(
            old=f"{name} for {user} not started",
            new=f"{name} for {user} started",
        ),
        comment=res,
    )
