sway:
  app_launcher: bash -c 'wofi --show drun | { read -r id name; swaymsg "[con_id=$id]" focus; }'

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
    - sway
    - waybar
    - wofi
