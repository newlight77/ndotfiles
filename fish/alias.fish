
command -qv nvim && alias vim nvim

#   showa: to remind yourself of an alias (given some part of it)
#   ------------------------------------------------------------
function showa 
    grep --color=always -i -a1 $argv $HOME/.config/fish/alias.fish | grep -v '^\s*$' | less -FSRXc
end

alias cdsrc='cd ~/wks/src'
alias cdgithub='cd ~/wks/src/github'
alias cdgitlab='cd ~/wks/src/gitlab'
alias cdgclones='cd ~/wks/src/clones'

alias cdoneprofile='cd ~/wks/src/oneprofile'
alias cdtricefal='cd ~/wks/src/tricefal'
alias cdnewlight='cd ~/wks/src/github/newlight77'

alias ls "ls -p -G"
alias la "ls -A"
alias ll "ls -l"
alias lla "ll -A"
# alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias cd..='cd ..'

#alias cp='cp -iv'                           # Preferred 'cp' implementation
#alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias ll='ls -FGlAhp'                       # Preferred 'ls' implementation
alias less='less -FSRXc'                    # Preferred 'less' implementation
#cd() { builtin cd "$@"; ll; }               # Always list directory contents upon 'cd'
alias cd..='cd ../'                         # Go back 1 directory level (for fast typers)
alias ..='cd ../'                           # Go back 1 directory level
alias ...='cd ../../'                       # Go back 2 directory levels
alias .3='cd ../../../'                     # Go back 3 directory levels
alias .4='cd ../../../../'                  # Go back 4 directory levels
alias .5='cd ../../../../../'               # Go back 5 directory levels
alias .6='cd ../../../../../../'            # Go back 6 directory levels
alias edit='subl'                           # edit:         Opens any file in sublime editor
alias f='open -a Finder ./'                 # f:            Opens current directory in MacOS Finder
# alias ~="cd ~"                              # ~:            Go Home
alias c='clear'                             # c:            Clear terminal display
alias which='type -all'                     # which:        Find executables
# alias path='echo -e ${PATH//:/\\n}'         # path:         Echo all executable Paths
alias show_options='shopt'                  # Show_options: display bash options settings
alias fix_stty='stty sane'                  # fix_stty:     Restore terminal settings when screwed up
alias cic='set completion-ignore-case On'   # cic:          Make tab-completion case-insensitive

function mcd                                # mcd:          Makes new Dir and jumps inside
    mkdir -p "$1" && cd "$1"
end        

function trash                              # trash:        Moves a file to the MacOS trash
    command mv $argv ~/.Trash
end

function ql                                 # ql:           Opens any file in MacOS Quicklook Preview
    qlmanage -p "$argv" >& /dev/null
end

alias qfind="find . -name "                 # qfind:    Quickly search for file

#   lr:  Full Recursive Directory Listing
# alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'


# ==============================================================================
# Git shortcuts

# Git Shortcuts for the super lazy

alias g="git"
alias ga='git add'
alias gb='git branch'
alias gc='git checkout'
alias gd='git diff'
alias gf='git fetch --all --prune'
# alias gg='git log --graph --pretty=format:'\''%C(bold)%h%Creset%C(magenta)%d%Creset %s %C(yellow)<%an> %C(cyan)(%cr)%Creset'\'' --abbrev-commit --date=relative'
alias gm='git merge'
alias gp='git push'
alias gr='git remote'
alias gs="git status"
alias gt='git tag'
alias gu='git ls-files . --exclude-standard --others' # Show untracked files

alias gbr='git branch'
alias gck='git checkout'
alias gcl='git clone'
alias gcm="git commit -m"
alias gcp='git cherry-pick'
alias gdv='git_diff_ignore_spaces'
# alias ggf='git log --graph --date=short --pretty=format:'\''%C(auto)%h %Cgreen%an%Creset %Cblue%cd%Creset %C(auto)%d %s'\'''
alias ghm='cd "$(git rev-parse --show-toplevel)"' # Git home
alias glg='git log'
alias gmg='git merge'
alias gmv='git mv'
alias gpl='git pull'
alias gps='git push'
alias gpl='git pull'
alias gpr='git pull --rebase'
alias gpu='git push --set-upstream'
alias grb='git rebase'
alias grs='git reset'
alias grv='git remote -v'
alias gsh='git show'
alias gss='git status -s'
alias gst='git status'
alias gsu='git submodule update --init --recursive'
alias gsw='git switch'
alias gtl='git tag -l | sort -V'
alias gup='git fetch && git rebase'
alias gwc='git whatchanged'


alias gclean='git clean -fd'
alias gcount='git shortlog -sn'
alias gdefault='git checkout $(get_default_branch)'
alias gexport='git archive --format zip --output'
alias gnew='git log HEAD@{1}..HEAD@{0}' # Show commits since last pull, see http://blogs.atlassian.com/2014/10/advanced-git-aliases/
alias gpristine='git reset --hard && git clean -dfx'
alias gstash='git stash'
alias gsubmodules='git submodule update --init --recursive'

function git_diff_ignore_spaces
	git diff --ignore-all-space $argv | vim -R -
end

function get_default_branch
	if git branch | grep -q '^. main\s*$'
		echo main
	else
		echo master
	end
end
#================================================================================