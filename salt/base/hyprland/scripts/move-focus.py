#!/usr/bin/env python
from typing import List, TypedDict
from enum import Enum

import subprocess
import argparse
import json
import logging

logging.basicConfig()
logger = logging.getLogger(__name__)

class HyprctlError(Exception):
    pass

def hyprctl(args: List[str]) -> str:
    """ Run hyprctl and returns result.
    Arguments:
    - args: hyprctl arguments

    Returns: Standard out from hyprctl

    Raises:
    - HyprctlError with stderr if fails to run
    """
    logger.debug("run: hyprctl %s", " ".join(args))
    
    proc = subprocess.Popen(
        ["hyprctl"] + args,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )

    stdout, stderr = proc.communicate()

    logger.debug("result: hyprctl %s, returncode=%d, stdout=%s, stderr=%s", " ".join(args), proc.returncode, stdout.decode() if stdout is not None else None, stderr.decode() if stderr is not None else None)

    if proc.returncode != 0:
        stderr_decoded = stderr.decode() if stderr is not None else ""
        raise HyprctlError(f"hyprctl stderr: '{stderr_decoded}'")

    return stdout.decode() if stdout is not None else ""

class IsCurrentlyFocusedInGroupRes(TypedDict):
    in_group: bool
    active_window_id: str
    group_windows: List[str]

def is_currently_focused_in_group() -> IsCurrentlyFocusedInGroupRes:
    """ Determine if the current Hyprland focus is within a group of windows.
    """
    output = hyprctl([
        "activewindow",
        "-j",
    ])
    output_json = json.loads(output)

    return {
        "in_group": len(output_json["grouped"]) > 0,
        "active_window_id": output_json["address"],
        "group_windows": output_json["grouped"],
    }

class MoveDirection(str, Enum):
    """ Direction in which to move focus.
    """
    LEFT = "left"
    RIGHT = "right"

def move_focus(
    direction=MoveDirection,
) -> None:
    """ Move focus within Hyprland.
    If focus is currently within a group then moves to the next window in the direction within the group. If on the edge of a group (ex., the left most or right most window) and the movement of direction is towards the edge (ex., left most window and direction is left) then moves out of the group.
    Arguments:
    - direction: In which to move focus
    """
    # Issue different move commands if in a group of windows
    move_out_of_group = False
    in_group = is_currently_focused_in_group()

    if in_group["in_group"]:
        # Check if on the edge of a group
        group_idx = in_group["group_windows"].index(in_group["active_window_id"])

        if group_idx == 0 and direction == MoveDirection.LEFT:
            move_out_of_group = True
        elif group_idx == len(in_group["group_windows"]) - 1 and direction == MoveDirection.RIGHT:
            move_out_of_group = True
    else:
        move_out_of_group = True

    move_cmd = "changegroupactive"
    move_dir = "b" if direction == MoveDirection.LEFT else "f"
    if move_out_of_group:
        move_cmd = "movefocus"
        move_dir = "l" if direction == MoveDirection.LEFT else "r"

    # Issue move command
    hyprctl(["dispatch", move_cmd, move_dir])
                

def main():
    """ Main entrypoint.
    """
    # Parse arguments
    parser = argparse.ArgumentParser(
        description="""Move focus in Hyprland.
Intelligently moves focus within or out of groups. If not in a group of windows then moves focus to next window or group of windows. If in a group of windows then moves focus within windows unless:
        
- If the currently focused window is in a group and on the edge of the group
- If the direction of movement is towards the edge the window is one

Then will move the focus out of the group."""
    )
    parser.add_argument(
        "-d", "--direction",
        help="Direction in which to move",
        type=MoveDirection,
        choices=list(MoveDirection),
        required=True,
    )
    parser.add_argument(
        "-v", "--verbose",
        help="Output debug logs",
        action='store_true',
        default=False,
    )

    args = parser.parse_args()

    # Run logic
    if args.verbose:
        logger.setLevel(logging.DEBUG)
    
    move_focus(
        direction=args.direction,
    )

if __name__ == "__main__":
    main()
