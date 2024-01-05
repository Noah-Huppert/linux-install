"""
Overview
========
Manages user specific services.

Tools like systemd offer this capability.
"""

from typing import TypedDict, Optional, Dict, Union

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

def enabled(name: str, user: str, start: bool=False) -> SaltStateRes:
    systemctl_cmd = [
        "systemctl",
        "enable",
        "--user",
    ]

    if start:
        systemctl_cmd.append("--now")

    cmd = [
        "machinectl",
        "shell",
        f"{user}@.host",
        "/usr/bin/env",
    ]
    
    systemctl_cmd.append(name)
    cmd.append(" ".join(systemctl_cmd))

    if __opts__["test"]:
        return SaltStateRes(
            name=name,
            result=True,
            changes=SaltStateResChanges(
                old=f"{name} for {user} ?",
                new=f"{name} for {user} started",
            ),
            comment="Would be started",
        )

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
