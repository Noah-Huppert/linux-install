from typing import Optional, List
import subprocess
import logging

log = logging.getLogger(__name__)

def _installed(pkgs: List[str]) -> bool:
    cmds = [
        "yay",
        "--sync",
        "--refresh",
        "--noconfirm",
    ] + pkgs
    log.info(cmds)
    proc = subprocess.Popen(
        cmds,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )
    stdout, stderr = proc.communicate()

    log.info("returncode=%d", proc.returncode)


    if stderr:
        log.error(stderr.decode(__salt_system_encoding__))

    if stdout:
        log.info(stdout.decode(__salt_system_encoding__))

    if proc.returncode != 0:
        log.error(f"failed to install: {pkgs}")
        return False

    return True

def installed(name: Optional[str]=None, pkgs: Optional[List[str]]=None) -> bool:
    """ Ensures AUR packages are installed.
    """
    if name is not None:
        return _installed([name])
    elif pkgs is not None:
        return _installed(pkgs)
    else:
        log.error("either name or pkgs required")
        return False
