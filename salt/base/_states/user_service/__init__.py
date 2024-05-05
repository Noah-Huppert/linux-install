"""
Overview
========
Manages user specific services.

Tools like systemd offer this capability.
"""

from typing import TypedDict, Optional, Dict, Union, List, Protocol
import logging

log = logging.getLogger(__name__)

SYSTEMD_RET_CODE_SERVICE_NOT_FOUND = 4

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

def __mk_systemctl_user_cmd(args: List[str], user: str) -> str:
    """ Assemble a systemctl user command to pass to a shell runner.

    Do not run this command output as the user specified, this command output must be run as root as it needs to drop into a users current session.
    
    Arguments:
    - args: Arguments to pass after "systemctl --user"
    - user: The user to run the command as

    Returns: Assembled command
    """
    cmd = [
        "machinectl",
        "shell",
        f"{user}@.host",
        "/usr/bin/env",
    ]
    
    cmd.append(" ".join([
        "systemctl",
        "--user",
        *args,
    ]))

    out_cmd = " ".join(cmd)

    log.info("Run: %d", out_cmd)

    return out_cmd

class SystemdServiceNotFoundError(Exception):
    """ Indicates a systemd service could not be found with the name.
    Fields:
    - name: Of service
    """
    name: str

    def __init__(self, name: str):
        """ Initialize.
        """
        super().__init__(f"Service '{name}' does not exist")
        self.name = name
    
def is_running(name: str, user: str) -> bool:
    """ Determine if service is running.
    Arguments:
    - name: Name of service
    - user: System user

    Returns: True if running, false if not

    Raises:
    - SystemdServiceNotFoundError
    """
    res = __salt__["cmd.run"](
        cmd=__mk_systemctl_user_cmd(
            args=[
                "is-active",
                name,
            ],
            user=user,
        ),
    )
    if "not found" in res:
        raise SystemdServiceNotFoundError(name)
    
    return "active" in res

def is_enabled(name: str, user: str) -> bool:
    """ Determine if a service is enabled.
    Arguments:
    - name: Of service
    - user: System user

    Returns: True if service is enabled, false if not

    Raises:
    - SystemdServiceNotFoundError
    """
    res = __salt__["cmd.run"](
        cmd=__mk_systemctl_user_cmd(
            args=[
                "is-enabled",
                name,
            ],
            user=user,
        ),
    )
    if "not found" in res:
        raise SystemdServiceNotFoundError(name)

    return "enabled" in res

def is_masked(name: str, user: str) -> bool:
    """ Determine if a service is masked.
    Arguments:
    - name: Of service
    - user: System user

    Returns: True if service is masked, false if not

    Raises:
    - SystemdServiceNotFoundError
    """
    res = __salt__["cmd.run"](
        cmd=__mk_systemctl_user_cmd(
            args=[
                "is-enabled",
                name,
            ],
            user=user,
        ),
    )
    if "not found" in res:
        raise SystemdServiceNotFoundError(name)

    return "masked" in res

def is_disabled(name: str, user: str) -> bool:
    return not is_enabled(name=name, user=user)

def is_stopped(name: str, user: str) -> bool:
    return not is_running(name=name, user=user)

def is_unmasked(name: str, user: str) -> bool:
    return not is_masked(name=name, user=user)


class StateChecker(Protocol):
    """ Determine the current state of a service.
    Arguments:
    - name: Of service
    - user: System user

    Returns: True if state is met, False if not
    """
    def __call__(self, name: str, user: str) -> bool: ...

class StateNames(TypedDict):
    """ Names of states for use in user facing messages.
    Fields:
    - met: Name of state when a service is in the correct state
    - not_met: Name of state when a service is not in the correct state
    - now_not_met: Name of state when service is in correct state but the --now version of the command would still perform work
    """
    met: str
    not_met: str

    now_not_met: str

def __change_state(
    action_cmd: str,
    name: str,
    user: str,
    check_state: StateChecker,
    check_now_state: StateChecker,
    state_names: StateNames,
    now: bool=False,
    test: bool=False,
) -> SaltStateRes:
    """ 
    Arguments:
    - action_cmd: Name of systemctl sub-command to run which will change the service's state, must accept a "--now" option which performs the equivalent immediate action
    - name: Name of service
    - user: System user for which to change service
    - check_state: Function (name, user) which when called determines if the service is in the correct state
    - check_now_state: Function which when called determines if the service is in the correct state if now=True
    - state_names: Used to display user interface messages
    - now: If service should have its state changes immediately
    - test: If running in test mode
    """
    # Prepare command
    systemctl_cmd = [action_cmd]

    if now:
        systemctl_cmd.append("--now")

    
    systemctl_cmd.append(name)

    # Determine current state of command
    needs_changing = not check_state(
        name=name,
        user=user,
    )
    needs_now_changing = False
    if now:
        needs_now_changing = not check_now_state(
            name=name,
            user=user,
        )

    work_required = needs_changing or needs_now_changing
    
    # Determine correct works for cmd output
    current_status = state_names["met"]
    if needs_changing:
        current_status = state_names["not_met"]
    if needs_now_changing:
        current_status += " and " + state_names["now_not_met"]

    if test:
        return SaltStateRes(
            name=name,
            result=None,
            changes=SaltStateResChanges(
                old=f"{name} for {user} {current_status}",
                new=f"{name} for {user} " + state_names["met"],
            ),
            comment="Would be set to " + state_names["met"],
        )

    res = None
    if work_required:
        res = __salt__["cmd.run"](
            cmd=__mk_systemctl_user_cmd(
                args=systemctl_cmd,
                user=user,
            ),
            raise_err=True,
        )

    return SaltStateRes(
        name=name,
        result=True,
        changes=SaltStateResChanges(
            old=f"{name} for {user} {current_status}",
            new=f"{name} for {user} " + state_names["met"],
        ) if work_required else {},
        comment=res,
    )

def enabled(name: str, user: str, start: bool=False) -> SaltStateRes:
    """ Ensure a user service is enabled.
    Arguments:
    - name: Of service
    - user: System user
    - start: If service should be started immeditely
    """
    return __change_state(
        action_cmd="enable",
        name=name,
        user=user,
        check_state=is_enabled,
        check_now_state=is_running,
        state_names={
            "met": "enabled",
            "not_met": "disabled",
            "now_not_met": "stopped",
        },
        now=start,
        test=__opts__["test"],
    )

def disabled(name: str, user: str, stop: bool=False) -> SaltStateRes:
    """ Ensure a user service is disabled.
    Arguments:
    - name: Of service
    - user: System user
    - start: If service should be stopped immediately
    """

    return __change_state(
        action_cmd="disable",
        name=name,
        user=user,
        check_state=is_disabled,
        check_now_state=is_stopped,
        state_names={
            "met": "disabled",
            "not_met": "enabled",
            "now_not_met": "running",
        },
        now=stop,
        test=__opts__["test"],
    )

def check_state_noop_true(name: str, user: str) -> bool:
    """ Fullfills StateChecker but always returns true.
    """
    return True

def running(name: str, user: str) -> SaltStateRes:
    """ Ensure a user service is running.
    Arguments:
    - name: Of service
    - user: System user
    """
    return __change_state(
        action_cmd="start",
        name=name,
        user=user,
        check_state=is_running,
        check_now_state=check_state_noop_true,
        state_names={
            "met": "running",
            "not_met": "stopped",
            "now_not_met": "!!INVALID!!",
        },
        now=False,
        test=__opts__["test"],
    )

def stopped(name: str, user: str) -> SaltStateRes:
    """ Ensure a user service is stopped.
    Arguments:
    - name: Of service
    - user: System user
    """
    return __change_state(
        action_cmd="stop",
        name=name,
        user=user,
        check_state=is_stopped,
        check_now_state=check_state_noop_true,
        state_names={
            "met": "stopped",
            "not_met": "running",
            "now_not_met": "!!INVALID!!",
        },
        now=False,
        test=__opts__["test"],
    )

def masked(name: str, user: str) -> SaltStateRes:
    """ Ensure a user service is masked.
    Arguments:
    - name: Of service
    - user: System user
    """
    return __change_state(
        action_cmd="mask",
        name=name,
        user=user,
        check_state=is_masked,
        check_now_state=check_state_noop_true,
        state_names={
            "met": "masked",
            "not_met": "unmasked",
            "now_not_met": "!!INVALID!!",
        },
        now=False,
        test=__opts__["test"],
    )

def unmasked(name: str, user: str) -> SaltStateRes:
    """ Ensure a user service is not masked.
    Arguments:
    - name: Of service
    - user: System user
    """
    return __change_state(
        action_cmd="unmask",
        name=name,
        user=user,
        check_state=is_masked,
        check_now_state=check_state_noop_true,
        state_names={
            "met": "unmasked",
            "not_met": "masked",
            "now_not_met": "!!INVALID!!",
        },
        now=False,
        test=__opts__["test"],
    )
