# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/usr/local/share/ohmyzsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="ys"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
		colored-man-pages 
		doas 
		extract 
		git 
		z
		zsh-autosuggestions 
		zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"









#====================================================================#
# The XDG Base Directory Specification
# The values are the default ones
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export XDG_STATE_HOME=$HOME/.local/state
export XDG_RUNTIME_DIR=/tmp
export MY_INCLUDE=$HOME/.local/include

# For compiling to set the path of cc 
# Check man cc for detail
#export CPATH="/usr/local/include:/usr/local/include/pixman-1"

#export CPATH="$MY_INCLUDE:/usr/local/include/pixman-1:/include/local"

# For compiling 
#export PATH="$PATH:$HOME/.local"

# The path for current record markdown file
export CURRENT_RECORD="$HOME/Documents/records/$(date "+%Y-%m-%d.md")"






# fast fast fast!!!!!!
alias viz="vim ~/.zshrc"
#alias vish="vim ~/.config/sxhkd/sxhkdrc"
alias cdc="cd ~/.config"
alias rb="doas reboot"
alias vic="doas vim /etc/rc.conf"
alias sz="source ~/.zshrc"
alias vip="vim ~/.scripts/status_panel"
alias rcd="vim ~/Documents/records/$(date "+%Y-%m-%d.md")"
alias conf='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias conf_add='conf add -A'
alias conf_status='conf status'
alias conf_push='conf push -u origin main'



# local proxy on & off
alias proxyon="export all_proxy=http://192.168.0.132:7890"
alias proxyoff="unset all_proxy"

# lemonbar
alias vib="vim ~/.scripts/status_panel.sh"




# window manager edit & start

## hikari
alias wmhk="hikari -a /usr/local/bin/waybar -c ~/.config/hikari/hikari.conf"
alias vihk="vim ~/.config/hikari/hikari.conf"
## wayfire
alias viwf="vim ~/.config/wayfire/wayfire.ini"
alias wmwf="wayfire -c ~/.config/wayfire/wayfire.ini"
## sway
alias wmsw="sway -c ~/.config/sway/config"
alias visw="vim ~/.config/sway/config"
## waybar
alias viwb="vim ~/.config/waybar/config"
## hyprland
alias wmhb="Hyprland"
alias vihb="vim ~/.config/hypr/hyprland.conf"
## river
alias wmrv="river"
alias virv="vim ~/.config/river/init"




alias cat="bat"
alias batt="sysctl hw.acpi.battery.life"
alias cdrw="cd ~/Works/Rust"
# alias nf="neofetch --acsii_distro"

# control vol
alias up="mixer vol +5"
alias down="mixer vol -5"

# lock
alias slock="~/.scripts/lock.sh"

# fcitx environment varies
export XIM=fcitx
export XIM_PROGRAM=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

# vi =vim
alias vim="nvim"
alias vi="nvim"



