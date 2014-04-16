#Place inside of your ~/.bashrc

#Place at top of .bashrc
shopt -s extglob

# You can echo $(tty) to see for yourself, might be different for you
case $(tty) in
  /dev/tty[0-9]*)
    # $TERM must be set to fbterm before fbterm starts, AND in fbterm before tmux starts.
    export TERM='fbterm';
    exec /home/lyle/scripts/fbterm-bi /home/lyle/pictures/bluewood.jpg;
    ;;
# /dev/pts/* isn't always the same, but seems to always start at 0 or 1 in my config, hence the extra checks.    
  /dev/pts/0)
    export TERM='fbterm';
    # Set fbterm's grey-ish white to an actual white
    echo -en "\e[3;7;255;255;255}";
    tmux;
    ;;
  /dev/pts/1)
    if [[ -n $TMUX ]]
    then
      # Once in tmux, $TERM must be set to screen-256color to get that colory goodness.
      export TERM='screen-256color';
    else
      export TERM='fbterm';
      echo -en "\e[3;7;255;255;255}";
      tmux;
    fi
    ;;
  *)
esac

# Bonus colored bash prompt
source /home/lyle/scripts/colors
export PS1="\[$orange\]u\[$peach\]@\[$light_green\]\h\[$peach\]:\[$light_blue\]\w\[$peach\]\$ \[$reset\]"
