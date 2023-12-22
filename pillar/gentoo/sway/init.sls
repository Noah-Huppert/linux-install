sway:
  waybar_vpn_check_cmd: systemctl list-units --type=service --state=active | grep openvpn &> /dev/null
  
  waybar_modules:
    left:
      - sway/workspaces
      - sway/mode

    center:
      - wireplumber
      - backlight
      - network
      - custom/vpn

    right:
      - disk
      - battery
      - clock
  
  pkgs:
    - gui-wm/sway
    - gui-apps/waybar
    - x11-misc/rofi
