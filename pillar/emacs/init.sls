emacs:
  # Package
  pkg: emacs

  # Configuration file
  configuration_file: /home/noah/.emacs.d/init.el

  # Plugins load path
  plugins_load_path: /home/noah/.emacs.d/lisp

  # Plugin files to download into Emacs load path
  plugin_files:
    - name: column-marker.el
      source: http://www.emacswiki.org/emacs/download/column-marker.el
    - name: flyspell.el
      source: http://www-sop.inria.fr/members/Manuel.Serrano/flyspell/flyspell-1.7q.el
