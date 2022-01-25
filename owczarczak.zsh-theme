# my personal theme based heavily on bira, and dieter, with a little influence from fino-time


local return_code="%(?..%{$FG[124]%}%? ↵%{$reset_color%})"
local user="%B%(!.%{$FG[124]%}.%{$FG[063]%})%n%{$reset_color%}"
local host="%B%{$FG[063]%}@%m%{$reset_color%} "
local user_symbol='%(!.#.€)'
local current_dir="%B%{$FG[093]%}%~ %{$reset_color%}"

local vcs_branch='$(git_prompt_info)'
local venv_prompt='$(conda_prompt_info)'

# local time, color coded by last return code
time_enabled="%(?.%{$FG[087]%}.%{$FG[124]%})%* %{$reset_color%}"
time_disabled="%{$FG[087]%}%* %{$reset_color%}"

local time=$time_enabled

#Date added
local date="%{$FG[081]%}%D{%d/%m/%y} %{$reset_color%}"

PROMPT="╭─${user}${host}${current_dir}${vcs_branch}${venv_prompt}
╰─${date}${time}%B${user_symbol}%b "
RPROMPT="%B${return_code}%b"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$FG[220]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$FG[196]%}●%{$FG[220]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$FG[034]%}✔%{$FG[220]%}"
