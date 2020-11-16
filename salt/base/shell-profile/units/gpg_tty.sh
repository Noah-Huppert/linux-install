# Set GPG_TTY env var so that curses pin entry will work
# https://www.gnupg.org/documentation/manuals/gnupg/Common-Problems.html
export GPG_TTY=$(tty)
