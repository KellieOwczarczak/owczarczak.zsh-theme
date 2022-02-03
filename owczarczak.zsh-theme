# my personal theme based heavily on bira, and dieter, with a little influence from fino-time
# then I just started playing around until I got what I wanted (I think)

# Coloring the brackets
local lbrackett="%{$FG[153]%}╭─%{$reset_color%}"
local lbracketb="%{$FG[153]%}╰─%{$reset_color%}"

# Return code coloring
local return_code="%(?..%{$FG[124]%}%? ↵%{$reset_color%})"

# I think it is funny to put the Euro curreny symbol instead of Dollar sign
local user_symbol='%(!.#.€)'

# local time, color coded by last return code
time_enabled="%(?.%{$FG[087]%}.%{$FG[124]%})%* %{$reset_color%}"
time_disabled="%{$FG[087]%}%* %{$reset_color%}"

local time=$time_enabled

#Date added
local date="%{$FG[081]%} %D{%a %d. %b %y}%{$reset_color%}"

# Spacing funtion to setup the layout how I want it
function term_spacing() {
  local TERMWIDTH=$(( $COLUMNS - ${ZLE_RPROMPT_INDENT:-1} ))

  # Elements to help with the spacing function
  local zero='%([BSUbfksu]|([FB]|){*})' # element for just the visual elements
  local prompt_str=$1$2 # prompt string definied in pre_prompt function
  local prompt_leng=${#${(S%%)prompt_str//$~zero/}} # calculating the actual prompt length

  local term_free_space=$(( TERMWIDTH - prompt_leng ))

  local spacing=""
  for i in {1..$term_free_space}; do
    spacing="${spacing} "
  done
  echo $spacing
}

# This sets up the first line of the prompt; the pre-prompt if you will
function pre_prompt() {
  # Set the directory path
  local current_dir="%B%{$FG[093]%}%~ %{$reset_color%}"

  # Split out user and host to make user permissions coded
  local user="%B%(!.%{$FG[124]%}.%{$FG[063]%})%n%{$reset_color%}"
  local host="%B%{$FG[063]%}@%m:%{$reset_color%} "

  # Git branch info and Conda environment info
  local vcs_branch="$(git_prompt_info)"
  local venv_prompt="$(conda_prompt_info)"

  # Trimming for smaller panes
  if (( $COLUMNS < 33 + ${#${(%):-%~}} )); then
    host="%B%{$FG[063]%}: %{$reset_color%}"; current_dir="%B%{$FG[093]%}%c %{$reset_color%}"
    venv_prompt="$(conda_env_prompt_info)"
  elif (( $COLUMNS < 70 )); then
    host="%B%{$FG[063]%}: %{$reset_color%}"; venv_prompt="$(conda_env_prompt_info)"
  fi

  local pre_left="${lbrackett}${user}${host}${current_dir}"
  local pre_right="${venv_prompt}${vcs_branch}"

  local space="%{$FG[153]%}$(term_spacing $pre_left $pre_right)%{$reset_color%}"

  print -rP "${pre_left}${space}${pre_right}"
}

autoload -U add-zsh-hook
add-zsh-hook precmd  pre_prompt
setopt prompt_subst

# Now the actual prompt
PROMPT="${lbracketb}${time}%B${user_symbol}%b "
RPROMPT="%B${return_code}%b${date}"

# Small tweaks to the git prompt
ZSH_THEME_GIT_PROMPT_PREFIX="%{$FG[105]%} ‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="›%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$FG[196]%}✘%{$FG[105]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$FG[034]%}✔%{$FG[105]%}"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$FG[220]%}●%{$FG[105]%}"

# Small tweak to Conda prompt
ZSH_THEME_CONDA_PROMPT_PREFIX="%{$FG[028]%} ("
ZSH_THEME_CONDA_PROMPT_SEPARATOR="|"
