case `uname` in
  Linux)
    # Linux-specific commands
    alias {start,open}="xdg-open"

    # Allow alt + L/R arrow to jump words like on mac
    bindkey "^[[1;3C" forward-word
    bindkey "^[[1;3D" backward-word
  ;;
  Darwin)
    # macOS-specific commands
  ;;
esac

# make ^u delete left from cursor like in bash
bindkey \^U backward-kill-line

command -v terraform && alias tf="terraform"
command -v kubectl && alias k="kubectl"

function __fast_git_branch() {
  local headfile head branch
  local dir="$PWD"
  while [ -n "$dir" ]; do if [ -e "$dir/.git/HEAD" ]; then
      headfile="$dir/.git/HEAD"
      break
    fi
    dir="${dir%/*}"
  done
  if [ -e "$headfile" ]; then
    read -r head < "$headfile" || return
    case "$head" in
      ref:*) branch="${head##*/}" ;;
      "") branch="" ;;
      *) branch="${head:0:7}" ;;  #Detached head. You can change the format for this too.
    esac
  fi
  if [ -z "$branch" ]; then return 0; fi

  printf "[%b] " "%F{175}$branch%F{default}"
}

setopt PROMPT_SUBST
PROMPT='%n@[%F{098}%m%f] %~ $(__fast_git_branch)%(?.%%.%F{196}%%%f) '
