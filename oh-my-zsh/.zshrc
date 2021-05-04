# Path to your oh-my-zsh installation.
export ZSH=/home/hxr/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="hxr"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="false"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="false"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"
export HISTTIMEFORMAT="%Y-%m-%d-%H-%M-%S "
export HISTSIZE=1000000001
export SAVEHIST=$HISTSIZE
export HISTFILE=~/.zsh_history
setopt append_history
setopt EXTENDED_HISTORY
setopt hist_reduce_blanks
setopt hist_no_store
setopt hist_ignore_dups
setopt histignorespace
setopt share_history
setopt inc_append_history
export LESSHISTFILE=/dev/null
export XDG_CONFIG_HOME=/home/hxr/.config

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git history-substring-search)

# User configuration

#export PATH="/home/hxr/.local/bin/:/home/hxr/.bin:/usr/local/texlive/2015/bin/x86_64-linux:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/home/hxr/arbeit/go-src/bin:/home/hxr/work/go/bin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export EDITOR='vim'
export TEXMFHOME='~/.texmf'
export GOPATH=$HOME/arbeit/go
export GOROOT=$HOME/arbeit/deps/go
export PATH=$HOME/.local/bin/:$PATH:$GOROOT/bin:$GOPATH/bin:$HOME/.rvm/bin
# The folders are too damn annoying.
export PYTHONDONTWRITEBYTECODE=1
export ANSIBLE_NOCOWS=1
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
export GPG_TTY=$BYOBU_TTY
export R_LIBS_USER=~/arbeit/deps/R/x86_64-pc-linux-gnu-library/3.2
export PGHOST=localhost
export PGUSER=postgres
export PGPASSWORD=postgres
export PERL5LIB=~/arbeit/deps/perl5/lib/perl5
export TERM=xterm-256color # 'screen' screws p home/end.
export PYTHON_KEYRING_BACKEND=keyring.backends.null.Keyring # https://github.com/pypa/pip/issues/7883 GO AWAY.
export GREP_COLORS='mt=1;37;4;40'
export TZ_LIST="Europe/Amsterdam,Australia/Melbourne,Asia/Kolkata,US/Pacific,US/Central,US/Eastern"


# Use vim bindings
set -o vi
# but let ctrl-r still work
bindkey "^R" history-incremental-search-backward

# Secrets
. ~/Personal/secrets/env.secret


alias sl='ls'
alias ll='ls -al'
alias s='ls -al'
alias k='ls'
alias ks='ls -al'
alias kr='ls -al --sort=t -r'
alias rm='rm -i'
alias mkae='make'
alias woman='man'
alias cear='clear'
alias ckear='clear'
alias byobu-attach='byobu attach -t '
alias byobu-att='byobu attach -t '
alias python=python3.8
alias pip=pip3
alias axe="awk '{print \$2}' | xargs kill"
alias mpv="mpv --no-audio-display"
alias makep='make -f ~/dotfiles/oh-my-zsh/Makefile -f Makefile'
alias qmv='qmv -fdo'
alias ploc='plocate -d ~/.cache/plocate.db'
#alias cat='lolcat -t'

# ???
fg() {
    if [[ $# -eq 1 && $1 = -  ]]; then
        builtin fg %-
    else
        builtin fg %"$@"
    fi
}

bg() {
    if [[ $# -eq 1 && $1 = -  ]]; then
        builtin bg %-
    else
        builtin bg %"$@"
    fi
}

# Fun
#fortune | cowsay -W 60

# venv
function venv(){
	new_venv=0
	if [ ! -d '.venv' ]; then
		#virtualenv .venv -p $(which python3.7);
		python3.8 -mvenv .venv
		new_venv=1
	fi

	. .venv/bin/activate  # commented out by conda initialize

	if [ -e 'requirements.txt' ]; then
		venv_age=$(stat -c %Y .venv)
		reqs_age=$(stat -c %Y requirements.txt)
		if (( new_venv == 1 )) || (( reqs_age > venv_age )); then
			pip install -r requirements.txt;
		fi
	fi

	if (( $# > 0 )); then
		pip install $@;
	fi
}

function venv2(){
	if [ ! -d '.venv2' ];
	then
		virtualenv .venv2 -p $(which python2.7);
	fi
	. .venv2/bin/activate  # commented out by conda initialize

	if [ -e 'requirements.txt' ];
	then
		venv_age=$(stat -c %Y .venv2)
		reqs_age=$(stat -c %Y requirements.txt)
		if (( reqs_age > venv_age )); then
			pip install -r requirements.txt;
		fi
	fi
}

# I know what I'm doing, thank you.
setopt rmstarsilent
setopt no_nomatch
# Feck off with huping my stuff.
setopt nohup
setopt no_check_jobs

ossec(){
	if (( $# == 0 )); then
		echo "Current: ${_OSSEC:-none}"
		echo
		find ~/Personal/secrets/env.secret.* | sed 's/.*env.secret./  /g'
		echo
		echo "ossec clear - wipes out vars."
		return
	fi

	# TODO: support multiple
	if [[ $1 == "clear" ]]; then
		if [[ -n "$_OSSEC" ]]; then
			$(cat ~/Personal/secrets/env.secret.ansible | sed 's/export/unset/g;s/=.*//g')
			export _OSSEC=""
		else
			echo "No currently active environment(s)"
		fi
		return
	fi

	# And set some new ones
	source ~/Personal/secrets/env.secret.$1

	if [[ -n "$_OSSEC" ]]; then
		export _OSSEC="$_OSSEC:$1"
	else
		export _OSSEC=$1
	fi
}

shutter_session(){
	SHUTTER_PID=$(ps aux | grep 'perl /usr/bin/shutter -s' | grep -v grep | awk '{print $2}')
	kill ${SHUTTER_PID}
	shutter &
}

#pgrep syndaemon > /dev/null || syndaemon -i 1 -d -K &
#de.py

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.

activate-nvm() {
	export NVM_DIR="$HOME/.config"
	[ -s "$NVM_DIR/nvm.sh"  ] && \. "$NVM_DIR/nvm.sh" #
	[ -s "$NVM_DIR/bash_completion"  ] && \. "$NVM_DIR/bash_completion" #
}

activate-conda() {
	unset R_LIBS_USER
	eval "$(/home/hxr/arbeit/deps/miniconda3/bin/conda shell.bash hook)"
}

activate-circos() {
	export PATH=$(find ~/arbeit/circos/circos-tools-0.22/tools/*/bin -maxdepth 0 | paste -s -d:):$PATH

	# find latest circos
	if (( $# == 0 )); then
		latest=$(find ~/arbeit/circos/ -maxdepth 1 -name 'circos-[0-9.-]*' -type d | sort | tail -n 1)
		echo "Activating $latest"
	else
		latest=$(find ~/arbeit/circos/ -maxdepth 1 -name 'circos-[0-9.-]*' -type d | grep "$1" | sort | tail -n 1)
		if [[ "$latest" != "" ]]; then
			echo "Activating $latest"
		else
			echo "Could not activate circos"
		fi
	fi

	export PATH="$latest/bin:$PATH"
}

activate-rust() {
	source $HOME/.cargo/env
}

cdt() {
	if [[ $# -gt 0 ]]; then
		cd `mktemp -d /tmp/$1.XXXXXXXXXX`
	else
		cd `mktemp -d`
	fi
}

eval "$(direnv hook zsh)"
# again? idk.
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY
