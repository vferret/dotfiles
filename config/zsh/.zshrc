#!/usr/bin/env zsh

# Загрузка дополнений {{{
autoload -Uz compinit && compinit -i
autoload -Uz bashcompinit && bashcompinit -i
autoload -Uz colors && colors					# загружаем список цветов 
autoload -Uz promptinit && promptinit
autoload -U zargs
autoload -U zmv
autoload -U zed
autoload -U zcalc
autoload -U zftp
autoload -U url-quote-magic
autoload history-search-end
# }}}

# Командная строка gentoo {{{
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn hg
zstyle ':vcs_info:git:*' formats '[±:%b]'
zstyle ':vcs_info:hg:*' formats '[☿:%b]'
setopt PROMPT_SUBST
prompt_gentoovcs_help () {
  cat <<'EOF'
Standard Gentoo prompt theme with VCS info. Like original, it's color-scheme-able:
  prompt gentoovcs [<promptcolour> [<usercolour> [<rootcolour> [<vcsinfocolour>]]]]
EOF
}
prompt_gentoovcs_setup () {
  prompt_gentoo_prompt=${1:-'blue'}
  prompt_gentoo_user=${2:-'green'}
  prompt_gentoo_root=${3:-'red'}
  prompt_gentoo_vcs=${4:-'white'}
  prompt_gentoo_job=${5:-'magenta'}
  jobs="%F{$prompt_gentoo_job}%(1j. [%j] .)%f"
  if [ "$UID" = 0 ]
  then
    base_prompt="%B%F{$prompt_gentoo_root}%m%k "
  else
    base_prompt="%B%F{$prompt_gentoo_user}%n@%m%k "
  fi
  path_prompt="%B%F{$prompt_gentoo_prompt}%1~"
  vcs_prompt='%B%F{$prompt_gentoo_vcs}${vcs_info_msg_0_:+${vcs_info_msg_0_} }'
  post_prompt="%b%f%k"
  PS1="${jobs}${base_prompt}${vcs_prompt}${path_prompt} %% $post_prompt"
  PS2="$base_prompt$path_prompt %_> $post_prompt"
  PS3="$base_prompt$path_prompt ?# $post_prompt"
  add-zsh-hook precmd vcs_info
}
  prompt_gentoovcs_setup "$@"
# }}}

# Виджеты zle {{{
zle -N self-insert url-quote-magic
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
# }}}

# Загрузка модулей zsh {{{
zmodload zsh/complist
zmodload zsh/termcap
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
zmodload -ap zsh/mapfile mapfile
# }}}

# Опции zsh {{{
setopt    ALWAYS_TO_END           #  В конец слова после выполнения дополнения
setopt    APPEND_HISTORY          #  Добавлять историю в файл каталога после дополнения
setopt    AUTO_CD                 #  Выполнят cd если команда При выполнении
setopt    AUTO_CONTINUE
setopt    AUTO_PUSHD              #  При выполнении cd выполнять pushd
setopt    AUTO_REMOVE_SLASH		  #  Удалять слеш из имени
setopt    AUTO_RESUME			  #  cmd может вести себя подобно %cmd
setopt    BANG_HIST				  #  Использовать !hist в командной строк
setopt    BASH_AUTO_LIST          #  Выдавать список только после второго нажатия на TAB
setopt    C_BASES                 #  0xFF
setopt    CDABLE_VARS             #  cd foo аналогично cd ~foo
setopt    CHASE_LINKS             #  Анализировать символьные ссылки в каталогах
setopt    CLOBBER				  #  > в существующий файл требует >|
setopt    COMPLETE_ALIASES		  #  Дополнения используют нераскрытые алиасы
setopt    COMPLETE_IN_WORD        #  Дополнять в точке курсора в слове
setopt    CORRECT_ALL             #  Корректировка всех аргументов
setopt    EXTENDED_GLOB           #  Использовать #, ~ и ^ в шаблонах
setopt    GLOB_COMPLETE			  #  Дополнять подстановки с помощью меню
setopt    GLOB_DOTS				  #  Ведущие точки соответствуют метасимволам (wildcards)
setopt    HASH_CMDS				  #  Хешировать команды при запуске
setopt    HASH_DIRS				  #  Хешировать каталоги при запуске команд
setopt    HIST_EXPIRE_DUPS_FIRST  #  Удалять дублирующиеся строки для уменьшения истории
setopt    HIST_FIND_NO_DUPS		  #  Никогда не показывать дубликаты в истории
setopt    HIST_IGNORE_ALL_DUPS    #  Игнopupoвaть вce пoвтopeнuя команд
setopt    HIST_IGNORE_DUPS		  #  Не допускать смежных повторений в истории
setopt    HIST_IGNORE_SPACE       #  Игнopupoвать лишние пpoбeлы
setopt    HIST_REDUCE_BLANKS      #  Удалять из файл истории пустые строки
setopt    HIST_SAVE_NO_DUPS		  #  Удалять дубликаты при сохранении истории
setopt    HIST_VERIFY			  #  Продолжать редактирование после раскрытия !
setopt    INC_APPEND_HISTORY      #  Сохранять историю по мере поступления
setopt    INTERACTIVE_COMMENTS	  #  Интерактивно использовать комментари
setopt    LIST_AMBIGUOUS		  #  Только отображать неоднозначные дополнения
setopt    LIST_PACKED			  #  Сжимать список дополнений
setopt    LIST_ROWS_FIRST         #  При дополнении первыми отображать строки
setopt    LONG_LIST_JOBS		  #  Всегда использовать jobs -l
setopt    MAGIC_EQUAL_SUBST       #  Любое выражение var=expr раскрывает файлы expr
setopt    MAIL_WARNING			  #  Выдавать предупреждение если был доступ к файлу почты
setopt    MARK_DIRS				  #  Добавлять / к списку каталогов при раскрытии
setopt    MENU_COMPLETE			  #  Прокручивать список дополнений при нажатии на TAB
setopt    MULTIOS                 #  Неявно выполнять tee/cat для множества <, >
setopt    NO_BEEP
setopt    NO_HIST_BEEP
setopt    NO_HUP
setopt    NOTIFY                  #  Сообщать при изменении статуса фонового задани
setopt    NULLGLOB                #  Удалить несуществующие раскрытия из списк
setopt    PATH_DIRS				  #  Производить поиск dir/cmd в путях поиска
setopt    PUSHD_MINUS			  #  Поменять местами минус и плюс в pushd
setopt    PUSHD_SILENT			  #  Не печатать стек каталогов
setopt    PUSHD_TO_HOME			  #  При запуске без аргументов, pushd переходит в домашний каталог
setopt    RC_QUOTES				  #  echo ’’’’ → ’
setopt    SHARE_HISTORY           #  Использовать один файл для всех сессий
setopt    TRANSIENT_RPROMPT
unsetopt  AUTO_PARAM_SLASH		  #  $path<TAB> в → $path/
unsetopt  EQUALS                  #  Убрать дополнение исполняемых файлов по =cmd
#setopt   PRINT_EXIT_VALUE        #  встречаются баги в работе, например, while через пайп
#setopt   REC_EXACT               #  встречаются баги
# }}}

# Параметры автозавершения команд {{{
compctl -z fg
compctl -j kill
compctl -u chown
compctl -u su
compctl -c sudo
compctl -c which
compctl -c type
compctl -c hash
compctl -c unhash
compctl -o setopt
compctl -o unsetopt
compctl -a alias
compctl -a unalias
compctl -A shift
compctl -v export
compctl -v unset
compctl -v echo
compctl -b bindkey
# }}}

# Установка нормального поведения клавиш Delete, Home, End и т.д. {{{
bindkey -e      # peжuм нaвuгaцuu в cтuлe emacs
bindkey "^[[2~" yank
bindkey "^[[3~" delete-char
bindkey "^[[5~" up-line-or-history
bindkey "^[[6~" down-line-or-history
bindkey "^[[7~" beginning-of-line
bindkey "^[[8~" end-of-line
bindkey "^[e" expand-cmd-path
bindkey "^[[A" history-beginning-search-backward-end   # up arrow for back-history-search
bindkey "^[[B" history-beginning-search-forward-end # down arrow for fwd-history-search
bindkey " "  magic-space           # do history expansion on space
bindkey "^[[H" beginning-of-line # Клавиша Home
bindkey "^[[F" end-of-line # Клавиша End
bindkey "^E" expand-cmd-path      # C-e добавляет к набираемой команде её
bindkey '^I' complete-word # complete on tab, leave expansion to _expand
bindkey "^[u"   undo
bindkey "^[r"   redo
## Примечание: если не определить здесь nocorrect,
## zsh будет настойчиво предлагать подстановку существующих имен
## при создании каталого, копировании и т.д.
# }}}

# Алиасы {{{
alias ...="cd ../..";
alias dir='dir --color'
alias du="du -hc";
alias top="htop -C||top -S -u"									# Запуск htop вместо top
alias grep="grep -E --color=auto"
alias h=history
alias less="less -M"
alias la='ls -lA --color=auto';									# вывoд всех файлов, включая dot-фaйлы, kpoмe . u ..
alias li='ls -ial';												# вывoд вcex фaйлoв в длuннoм фopмaтe, вkлючaя inodes
alias ll='ls -hl --color=auto --group-directories-first';		# вывoд в gлuннoм фopмaтe
alias lsa='ls -ld .*';											# вывoд тoльko dot-фaйлoв
alias lsd='ls -ld *(-/DN)';										# вывод только каталогов
alias ls='ls -Fh --color=auto --group-directories-first';		# показ классификации файлов в цвете и символически
alias man="man -a"
alias mtr="/usr/sbin/mtr -t"
alias mv="mv -i";
alias rm="rm -I";
alias netstat="netstat -W"
alias rehash="hash -r";
alias root="sudo -s"; 											# Получение root'a
alias tmux='tmux -u -2 attach || tmux -u -2 -f "$XDG_CONFIG_HOME"/tmux/tmux.conf'
alias update="sudo pacman -Sy";									# Обновление кеша пакетов
alias rclua="vim ~/.config/awesome/rc.lua"						# Открыть конфиг awesome для редактирования
alias vimconf="vim ~/.config/vim/vimrc"							# Открыть конфиг vim для редактирования
alias zshconf="vim ~/.config/zsh/.zshrc"						# Открыть конфиг zsh для редактирования
alias df="df -hT";
alias ping="ping -c 5"
alias -s {avi,mpeg,mpg,mov,wmv,flv,iflv,rm,vob,ac3,wav,mkv,mov,divx,xvid}='mplayer'
alias workon='sudo systemctl start vpnc@work; ssh aleksei@10.210.2.43'
alias workoff='sudo systemctl stop vpnc@work'
# alias update="layman -S && eix-sync"; # Обновление кеша пакетов и базы eix.
# alias cp="cp -i";
# alias ispell='ispell -d russian'
# alias ping6="ping6 -c 5"
# alias eix="noglob eix"
# alias wget="wget --continue --content-disposition" ## иногда мешает...
# alias -s {html,htm,pdf,djvu,doc,rtf,odt,chm,jpg,jpeg,gif,png}='kfmclient exec'
# }}}

# Установка глобальных псевдонимов для командных конвейеров {{{
alias -g M='|more'
alias -g L='|less'
alias -g H='|head'
alias -g T='|tail'
alias -g N='2>/dev/null'
# }}}

# Стиль автозавершения {{{
zstyle ':completion::complete:*' '\\'
zstyle ':completion::complete:*' cache-path ~/.zcompcache
zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~'
zstyle ':completion:*' completer _complete _prefix _correct _prefix _match _approximate
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate
zstyle ':completion::complete:*' use-cache on
zstyle ':completion:*:corrections' format '%B%d (ошибки: %e)%b'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:descriptions' format "$fg_bold[brown] %B%d%b $reset_color"
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*:expand:*' tag-order all-expansions
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' hosts $hosts
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt "%SСейчас на %p. Нажми TAB, чтобы листать далее или следующий символ для подстановки%s"
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*:ls:*' ignore-line yes
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z} r:|[._-]=** r:|=**' 'm:{a-z}={A-Z} m:{a-zA-Z}={A-Za-z} r:|[._-]=** r:|=** l:|=*' 'm:{a-zA-Z}={A-Za-z} r:|[._-]=** r:|=** l:|=*' 'm:{a-zA-Z}={A-Za-z} r:|[._-]=** r:|=** l:|=*'
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:match:*' original only
zstyle ':completion:*' menu select=long-list select=0
zstyle ':completion:*:messages' format "$fg_bold[purple] %d $reset_color"
zstyle ':completion:*' old-menu true
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*' original true
zstyle ':completion:predict:*' completer _complete
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*:processes' command 'ps -U $(whoami) +nc|sed "/ps/d"'
zstyle ':completion:*:processes' insert-ids menu yes select
zstyle ':completion:*:processes-names' command 'ps xho command +nc|sed "s/://g"'
zstyle ':completion:*:processes' sort false
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' '*?.old' '*?.pro'
zstyle ':completion:*:rm:*' ignore-line yes
zstyle ':completion:*:scp:*' ignore-line yes
zstyle ':completion:*' select-prompt %SСкроллинг активен. Текущее выделение на: %p%s
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
zstyle ':completion:*' substitute 1
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/sbin /sbin /usr/local/bin /usr/bin /bin /opt/bin /usr/X11R6/bin
zstyle ':completion:*:urls' local 'www' '/var/www/htdocs' 'public_html'
zstyle ':completion:*' use-compctl true
zstyle ':completion:*' verbose true
zstyle ':completion:*:warnings' format "$fg_bold[red] Нет совпадений с$reset_color %d"
zstyle ':completion:*' word true
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'
zstyle '*' single-ignored show
zstyle ':completion:*' completer _oldlist _expand _force_rehash _complete
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
#zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' '+ l:|=* r:|=*'
#zstyle ':completion:*' matcher-list 'm:{A-Z}={a-z}' 'm:{a-z}={A-Z}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
#zstyle ':completion:*' menu select=1
#zstyle ':completion:*:messages' format "$fg_bold[purple] -- %d --$reset_color"
#zstyle ':completion:*:processes' command 'ps -xuf'
#zstyle ':completion:*' squeeze-shlashes 'yes'
#zstyle ':completion:*' use-compctl true
#zstyle ':completion:*' verbose yes
#zstyle ':completion:*:warnings' format "$fg_bold[red] -- No Matches Found --$reset_color"
# }}}

# Плагин Base16-shell {{{
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
# }}}

# Прочее{{{
typeset -U path cdpath fpath manpath			# автоматическое удаление одинакового из этого массива 

RPROMPT="%(?,%{$fg[green]%}:%)%{$reset_color%},%{$fg[red]%}:(%{$reset_color%}"

# Force rehashing
_force_rehash() {
(( CURRENT == 1 )) && rehash
return 1
}

if [ -e $HOME/.ssh/known_hosts ] ; then
  hosts=(${${${${${${(f)"$(<$HOME/.ssh/known_hosts)"//\[/}//\]/}}//:/ }%%\ *}%%,*})
  zstyle ':completion:*:hosts' hosts $hosts
fi

# Path для поиска командой cd: то есть вместо cd $HOME/docs/editors/
# можно набирать просто cd editors
cdpath=(.. /media /var/lib/layman)
fpath=(/etc/zsh/comp $fpath)

if [[ -n $(whence dircolors) ]];
then
eval $( dircolors)
else
LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.pdf=00;32:*.ps=00;32:*.txt=00;32:*.patch=00;32:*.diff=00;32:*.log=00;32:*.tex=00;32:*.doc=00;32:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:';
export LS_COLORS;
fi
# }}}

# Отключено{{{
#. /etc/profile
#. /etc/zsh/zprofile
# if [[ -n ${TMUX} && -n ${commands[tmux]} ]];then
# 	case $(tmux showenv TERM 2>/dev/null) in
# 		*256color) 
# 			TERM=screen-256color ;;
# 		TERM=fbterm)
# 			TERM=screen-256color ;;
# 		*)
# 			TERM=screen
# 	esac
# fi

## Разные полезные (ИМХО) alias'ы
# Do we have tree?
# if ! type -p tree &> /dev/null ; then alias tree="etree" ; fi

## Rubyless omploading
# zld() {
# curl -s http://q.zash.se/ -H Expect: --data-binary "@${1--}"
# }
# ompld() {
# LOAD_URL="http://ompldr.org/upload"
# if [[ -n $1 ]]; then
#         c=1;
#         for i in ${@};
#         do
#                 OPTS+=(-F file${c}=@${i});
#                 let c+=1;
#         done
# else
#         echo "If you want to upload file via pipe, then you should use '-' as 1'st argument of function";
#         return 0;
# fi;
# 
# curl -\# ${OPTS} ${LOAD_URL} |awk '/Info:|File:|Thumbnail:|BBCode:|<div\ class="upload">/{sub(/<div\ class="upload">.*/,"\n");gsub(/<[^<]*?\/?>/,"");$1=$1;sub(/^/,"\033[0;34m");sub(/:/,"\033[0m: ");print}';
# OPTS="";
# }
# 
# ebldopen() { $EDITOR `equery which $1` }
# ebldlog() { $EDITOR $(dirname `equery which $1`)/ChangeLog }
# 
# compdef "_gentoo_packages available" ebldopen ebldlog
# compdef "_gentoo_packages available" "equo install"
# compdef "_gentoo_packages installed" "equo remove"}}}
