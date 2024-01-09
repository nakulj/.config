fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin

set fish_greeting

 set -gx KUBE_EDITOR nvim

 set -g tide_left_prompt_items jobs vi_mode pwd git
 set -g tide_right_prompt_items status cmd_duration context node virtual_env
