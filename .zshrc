# shellcheck disable=SC2148
# If you come from bash you might have to change your $PATH.
current=$(pwd)
username=$(whoami)
# Load python
#export PATH="/usr/local/bin:$PATH"
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="/bin:/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH=/Users/${username}/.oh-my-zsh

# Path for aws
export PATH=~/Library/Python/3.6/bin:$PATH

# Path for google sdk
# shellcheck source=/dev/null
#source /Users/${username}/Downloads/google-cloud-sdk/completion.zsh.inc
# shellcheck source=/dev/null
#source /Users/${username}/Downloads/google-cloud-sdk/path.zsh.inc

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="refined"
#ZSH_THEME="robbyrussell"
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git history bundler knife docker zsh-autosuggestions) #per-directory-history
eval "$(hub alias -s)"
fpath=(~/.zsh/completions $fpath)
autoload -U compinit && compinit
# shellcheck source=/dev/null
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
export EDITOR='code --wait'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

######################################### ENVIRONMENT #########################################
export repo="/Users/${username}/repo"
export keys="/Users/${username}/.keys/"
export devkey="/Users/${username}/.keys/virtual_appliance_openstack_secrets"
export mapping="${repo}/appliance_mapping"
export HISTFILESIZE=10000000
export HISTSIZE=10000000
######################################### ALIAS #########################################
########## Docker Aliases ##########
alias kd="docker run -it --rm -v \$(pwd):/ -v \"$HOME/.chef:/root/.chef\" chef/chefdk knife"
alias d-c=docker-compose
alias k=kitchen
alias killdocker="docker kill \$(docker ps -q)"
alias cleandocker="docker system prune -a --volumes"
alias getaws="docker run --rm -it -v \"$HOME/.aws:/root/.aws\" docker-snapshot.cernerrepos.net/cloudbroker/awscli_setup:latest"
alias gabordoc="docker run -it --rm -v \$(pwd):/terraform -v \"$HOME/.aws:/root/.aws\" docker.cernerrepos.net/gabor/gabor-terraform:latest --deploy-type"
########## Chef Aliases ##########
alias kns='knife node show'
alias knl='knife node list'
alias krs='knife role show'
alias krf='knife role from file'
alias kre='knife role edit'
alias kel='knife environment list'
alias kes='knife environment show'
alias kef='knife environment from file'
alias ksn='knife search node'
alias kdbs='knife data bag show'
alias kdbe='knife data bag edit'
alias kdns='kd node show'
alias kdnl='kd node list'
alias kdrs='kd role show'
alias kdrf='kd role from file'
alias kdre='kd role edit'
alias kdel='kd environment list'
alias kdes='kd environment show'
alias kdef='kd environment from file'
alias kdsn='kd search node'
alias kddbs='kd data bag show'
alias kddbe='kd data bag edit'
########## Other Aliases ##########
alias cp="cp -R"
alias choap='ssh -i /Users/${username}/.keys/Jigar_Private_Key.pem ${username}@choaplmgmt101.cernerasp.com'
alias ausap='ssh ${username}@10.23.165.51'
alias devutil='ssh ${username}@10.144.0.122'
alias devholo='ssh ${username}@10.144.0.122'
alias gochochef201='ssh -i /Users/${username}/.keys/Jigar_Private_Key.pem root@gochochef201'
alias kc7crwlmgmt202='ssh -i /Users/${username}/.keys/Jigar_Private_Key.pem root@kc7crwlmgmt202'
alias c="clear"
alias vi="vim"
alias sound="soundscrape"
alias e="exit"
alias reload="source /Users/${username}/.zshrc"
alias startsplit='/Users/${username}/repo/split_tunnel/split_tunnel'
alias closesplit='sudo /Users/${username}/repo/split_tunnel/cleanup_split_tunnel'
alias hosts='/Users/${username}/repo/tweaks/hosts.sh'
alias cloud="gcloud compute --project \"third-expanse-93423\" ssh --zone \"us-central1-a\" \"chef\""
alias trash="rmtrash"
alias   del="rmtrash"
alias    rm="echo \"Please use rmtrash to remove files!\""
alias knfie="knife"
alias    be="bundle exec"
alias gu="gitupdate"
alias checksleeping="pmset -g assertions"
alias jiggytest="ssh -i /Users/jp053505/repo/personal-repos/playground/secrets/jiggy jiggy@localhost -p 2020"

# Load python3 and pip3 as default
alias python="python3"
alias pip="pip3"

# Load aws completer
#alias awss="source aws_zsh_completer.sh"
#awss
#unset awss
#unalias knife
#unalias irb

alias cwxvpn="/opt/cisco/anyconnect/bin/vpn -s connect rhovpn.cerner.com < ${HOME}/.ssh/creds > /dev/null 2>&1"

# Add the file if its missing
if ! [[ -f "${HOME}/.launches" ]]; then
  echo NumberOfLaunches=1 > "${HOME}/.launches"
fi
# Source the number of launches
source "${HOME}/.launches"

# Source files
if [[ -e /Users/${username}/.function ]]; then
  # shellcheck source=/dev/null
  source /Users/${username}/.function
fi

source "${HOME}/.oh-my-zsh/plugins/common-aliases/common-aliases.plugin.zsh"

if [[ -e ~/.bash_profile ]]; then
  # shellcheck source=/dev/null
  source /Users/${username}/.bash_profile
fi

# shellcheck source=/dev/null
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

cd $current

if [[ -e /Users/jp053505/.clients ]]; then
  source /Users/jp053505/.clients
fi

# Add to the total launches
NumberOfLaunches=$((NumberOfLaunches + 1))
echo "NumberOfLaunches=${NumberOfLaunches}" > "${HOME}/.launches"

# eval "$(rbenv init -)"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
