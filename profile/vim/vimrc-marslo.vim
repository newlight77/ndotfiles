" =============================================================================
"       FileName: vimrc_PublicEnv
"           Desc:
"         Author: Marslo
"         Email: marslo.jiao@gmail.com
"        Created: 2013-10-16 07:19:00
"        Version: 0.0.9
"    LastChange: 2014-09-16 04:43:23
" =============================================================================

let &runtimepath=printf('%s/vimfiles,%s,%s/vimfiles/after', $VIM, $VIMRUNTIME, $VIM)
let s:portable = expand('<sfile>:p:h')
let &runtimepath=printf('%s/.vim,%s/.vim,%s/.vim/after', s:portable, &runtimepath, s:portable)
let bud=expand('$HOME/.marslo/.vim/bundle')
" let s:portable = '$HOME/Marslo'
" let $runtimepath=~s:portable/.vim,usr/local/share/vim/vimfiles,/usr/local/share/vim/vim74,/usr/local/share/vim/vimfiles/after,/home/auto/.vim/after

set nocompatible
syntax enable on
filetype plugin indent on
set history=500
set diffopt=filler,context:3
runtime macros/matchit.vim
set wrap                                                            " Wrap lines
set fileformat=unix
set viminfo=%,<800,'10,/50,:100,h,f0,n~/.marslo/.vim/cache/.viminfo
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
set tags=./tags

" ====================================== For Property =====================================
let mapleader=","
let g:mapleader=","

" Vim Bundle
filetype off
let &runtimepath .= ',' . expand(bud . '/vundle')
call vundle#begin(bud)

Bundle 'gmarik/vundle'
Bundle 'Yggdroot/indentLine'
Bundle 'kien/ctrlp.vim.git'
Bundle 'sjl/gundo.vim'
Bundle 'majutsushi/tagbar'
Bundle 'dantezhu/authorinfo'
Bundle 'Marslo/EnhCommentify.vim'
Bundle 'tpope/vim-pathogen'
Bundle 'gregsexton/MatchTag'
Bundle 'ervandew/supertab'
Bundle 'Marslo/auto-pairs'
Bundle 'Marslo/snipmate.vim.git'
Bundle 'yegappan/mru'
Bundle 'Conque-Shell'
Bundle 'taglist.vim'
Bundle 'winmanager'
" For Moving faster
Bundle 'rhysd/accelerated-jk'
" Bundle 'yonchu/accelerated-smooth-scroll'
" For Loading my function after vim start (reduce vim start time)
Bundle 'Marslo/MarsloFunc'
" For Groovy
Bundle 'groovy.vim--Ruley'
" Bundle 'mwaisgold/groovy-vim-files'
" For Python
" Bundle 'python-mode'
Bundle 'python_fold'
" Bundle 'kevinw/pyflakes-vim'
Bundle 'pyflakes/pyflakes'
Bundle 'python_match.vim'
Bundle 'Marslo/python-syntax'
Bundle 'tarmack/vim-python-ftplugin'
" For ruby
Bundle 'tpope/vim-rails'
Bundle 'vim-ruby/vim-ruby'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'kana/vim-textobj-user'
Bundle 'ruby-matchit'
" For Javascript
Bundle 'pangloss/vim-javascript'
Bundle 'jelera/vim-javascript-syntax'
" For AngularJS
Bundle 'burnettk/vim-angular'
" For web design
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
" Colors and themes and syntax
Bundle 'luochen1990/rainbow'
Bundle 'txt.vim'
Bundle 'hail2u/vim-css3-syntax'
Bundle 'Marslo/vim-coloresque'
Bundle 'Marslo/marslo.vim'
Bundle 'Marslo/MarsloVimOthers'
Bundle 'plasticboy/vim-markdown.git'

call vundle#end()
call pathogen#infect()
filetype plugin indent on

" ====================================== For My Function =====================================
function! GetVundle()                                                   " GetVundle() inspired by: http://pastebin.com/embed_iframe.php?i=C9fUE0M3
  let vundleAlreadyExists=1
  let bud='~/.marslo/.vim/bundle'
  let vud=bud . '/vundle'
  let vudcfg=expand(vud . '/.git/config')
  if filereadable(vudcfg)
    echo "Vundle has existed at " . expand(vud)
  else
    echo "Installing Vundle..."
    echo ""
    if isdirectory(expand(bud)) == 0
      call mkdir(expand(bud), 'p')
    endif
    execute 'silent !git clone https://github.com/gmarik/vundle.git "' . expand(vud) . '"'
    let vundleAlreadyExists=0
  endif
endfunction
command! GetVundle :call GetVundle()

if isdirectory(expand(bud . '\MarsloFunc'))
  command! GetVim :call marslofunc#GetVim()<CR>
  nmap cmd :call marslofunc#OpenCMD()<CR>
  nmap gf :call marslofunc#GotoFile()<CR>
  xnoremap * :<C-u>call marslofunc#VSetSearch()<CR>/<C-R>=@/<CR><CR>
  xnoremap # :<C-u>call marslofunc#VSetSearch()<CR>?<C-R>=@/<CR><CR>
  map <M-o> :call marslofunc#OpenFoler()<CR>
  nmap <F12> :call marslofunc#UpdateTags()<CR>
  nmap <C-F5> :call marslofunc#RunResult()<CR>
  nmap <leader>ti :call marslofunc#callit()<CR>

  augroup resCur
    autocmd!
      autocmd BufWinEnter * call marslofunc#ResCur()
  augroup END

  " command! DiffSaved :call marslofunc#DiffWithSaved()<CR>
  " nnoremap <leader>df :call marslofunc#DiffWithSaved()<CR>

  set foldtext=v:folddashes.substitute(getline(v:foldstart),'/\\*\\\|\\*/\\\|{{{\\d\\=','','g')
  " set foldtext=marslofund#MyFoldText()<CR>

endif

" ====================================== For Programming =====================================
" Programming configs for Ruby and Rails
if has("autocmd")
  autocmd FileType ruby set omnifunc=rubycomplete#Complete
  autocmd FileType ruby let g:rubycomplete_buffer_loading=1
  autocmd FileType ruby let g:rubycomplete_classes_in_global=1
  augroup filetypedetect                                            " Inspired from :h new-filetype
    au BufNewFile,BufRead *.r.erb set filetype=r.ruby
  augroup end
  autocmd FileType ruby compiler ruby
endif
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1

" Programming configs for Python
if has("autocmd")
  au FileType python syn keyword pythonDecorator print self
  au FileType python set tabstop=2 softtabstop=2 shiftwidth=2
  au FileTYpe python set isk-=.
endif
let python_highlight_all = 1                                        " syntax-python
if !has('python')
  let g:pymode = 0
endif

if isdirectory(expand(bud . '\python-mode'))
  let g:pymode_lint_checker = ['pyflakes']
  let g:pymode_trim_whitespace = 0
  let g:pymode_options = 0
  let g:pymode_rope = 0
endif

" Programming configs for Groovy
if has("autocmd")
  au FileType groovy set tabstop=2 softtabstop=2 shiftwidth=2
endif

" ====================================== For Inteface =====================================
if 'xterm-256color' == $TERM
  set t_Co=256
  colorscheme marslo
  let psc_style='cool'
else
  set t_Co=8
  set t_Sb=^[[4%dm
  set t_Sf=^[[3%dm
  colorscheme marslo16
endif

nmap <leader>v :e $HOME/.marslo/.vimrc<CR>
autocmd! bufwritepost $HOME/.marslo/.vimrc silent! source %

set iskeyword-=.
set autochdir
set fileencodings=utf-8,ucs-bom,gbk,cp936,gb2312,gb18030            " Code Format
set termencoding=utf-8
set encoding=utf-8                                                  " Input Chinese (=cp936)
set fileencoding=utf-8
let &termencoding=&encoding
set nobackup noswapfile nowritebackup
set number                                                          " number: line number
set report=0
set autoread                                                        " Set auto read when a file is changed by outside
set showmatch                                                       " Show matching bracets (shortly jump to the other bracets)
set matchtime=1                                                     " The shortly time
set tabstop=2                                                       " Tab width
set softtabstop=2                                                   " Width for backspace
set shiftwidth=2                                                    " the tab width by using >> & <<
set autoindent expandtab
set smartindent
set smarttab						                                            " smarttab: the width of <Tab> in first line would refer to 'Shiftwidth' parameter
set linebreak
set tw=0
set modifiable
set write
set incsearch hlsearch ignorecase smartcase                         " Search
set magic                                                           " Regular Expression
set linespace=0
set wildmenu
set wildmode=longest,list,full                                      " Completion mode that is used for the character
set noerrorbells novisualbell                                       " turn off error beep/flash
set t_vb=
set list listchars=tab:\ \ ,trail:·,extends:»,precedes:«,nbsp:·
set cursorline                                                      " Highlight the current line
set scrolloff=3                                                     " Scroll settings
set sidescroll=1
set sidescrolloff=5
set imcmdline                                                       " Fix context menu messing
set completeopt=longest,menuone                                     " Supper Tab
set foldenable                                                      " Enable Fold
set foldcolumn=1
set foldexpr=1                                                      " Shown line number after fold
set foldlevel=100                                                   " Not fold while VIM set up
set viewoptions=folds
set backspace=indent,eol,start                                      " make backspace h, l, etc wrap to
set whichwrap+=<,>,h,l
set go+=a                                                           " Visual selection automatically copied to the clipboard
set hidden                                                          " Switch between buffers with unsaved change
set equalalways
set formatoptions=tcrqn
set formatoptions+=B                                                " Remove the backspace for combine lines (Only for chinese)
set matchpairs+=<:>
set noendofline
if has('cmdline_info')
  set ruler                                                         " ruler: Show Line and colum number
  set showcmd                                                       " Show (partial) command in status line
endif
if has('statusline')
  set laststatus=2                                                  " Set status bar
  set statusline=%#User2#%m%r%*\ %F\ %y,%{&fileformat}
  set statusline+=%=\ %-{strftime(\"%H:%M\ %d/%m/%Y\")}\ %b[A],0x%B\ %c%V,%l/%L\ %1*--%n%%--%*\ %p%%\ |
endif
" set synmaxcol=128
" set binary
" set cryptmethod=blowfish

if has('persistent_undo')
  set noundofile
endif

noremap <F1> <ESC>
imap <F1> <ESC>a
nnoremap j gj
nnoremap gj j
nnoremap k gk
nnoremap gk k
nnoremap n nzzzv
nnoremap N Nzzzv
map ,bd :bd<CR>
map <C-k> <C-w>k
map <C-j> <C-w>j
map <C-a> <ESC>^
imap <C-a> <ESC>I
cnoremap <C-a> <Home>
map <C-e> <ESC>$
imap <C-e> <ESC>A
cnoremap <C-e> <End>
inoremap <A-f> <ESC><Space>Wi
cnoremap <A-f> <S-Right>
inoremap <A-b> <ESC>Bi
cnoremap <A-b> <S-Left>
inoremap <A-d> <ESC>lcW
inoremap <C-d> <Del>
nnoremap Y y$
nnoremap <Del> "_x
xnoremap <Del> "_d
" nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
nnoremap <space> za
nnoremap & :&&<CR>
xnoremap & :&&<CR>
vmap s <Plug>VSurround
inoremap <leader>tt <C-R>=strftime("%d/%m/%y %H:%M:%S")<cr>
inoremap <leader>fn <C-R>=expand("%:t:r")<CR>
inoremap <leader>fe <C-R>=expand("%:t")<CR>
inoremap <leader>w <C-O>:w<CR>

nnoremap zdb :%s/\s\+$//<CR>
nnoremap zhh :%s/^\s\+//<CR>
nnoremap zmm :g/^/ s//\=line('.').' '/<CR>
nnoremap zws :g/^\s*$/d<CR>
nnoremap zdm :%s/<C-v><CR>//ge<CR>
nnoremap zng :%s///gn<CR>

if version > 703
  " autocmd FocusLost * set norelativenumber
  autocmd FocusGained * set relativenumber
  autocmd InsertEnter * set norelativenumber
  autocmd InsertLeave * set relativenumber
  autocmd CmdwinEnter * set norelativenumber
  autocmd CmdwinLeave * set relativenumber
  autocmd CmdwinEnter * let b:ei_save = &eventignore | set eventignore=CursorHold,InsertEnter
  autocmd CmdwinLeave * let &eventignore = b:ei_save
endif

iabbrev <leader>/* /*********************************
iabbrev <leader>*/ *********************************/
iabbrev <leader>#- #------------------

" ====================================== For Function =====================================
let g:ctrlp_map = '<c-p>'                                           " CtrlP
let g:ctrlp_working_path_mode = 'ra'                                " Search parents as well (stop searching sartly)
let g:ctrlp_max_height = 8
let g:ctrlp_max_depth = 100
let g:ctrl_root_makers = ['.ctrlp']                                 " Stop search if these files present
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0                                 " Cross session caching
let g:ctrlp_cache_dir = '$HOME/.vim/cache/ctrlp'
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v\.(exe|so|dll|rpm|tar|gz|bz2|zip|ctags|tags)|tags|ctags$',
    \ 'link': 'some_bad_symbolic_links',
    \ }

nmap <leader>tv :ConqueTermSplit bash <CR>

let g:winManagerWidth = 20
let g:winManagerWindowLayout='FileExplorer|TagList'
nmap <leader>mm :WMToggle<cr>

let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Use_SingleClick=1
let Tlist_File_Fold_Auto_Close=1
let Tlist_GainFocus_On_ToggleOpen=1
let Tlist_show_Menu=1
let Tlist_sql_settings = 'sql;P:package;t:table'
let Tlist_Process_File_Always=0
nmap <leader>tl :TlistToggle<CR>

map <leader>ta :TagbarToggle<CR>
let g:tagbar_left=1
let g:tagbar_width=20
let g:tagbar_autofocus=1
let g:tagbar_expand=1
let g:tagbar_singleclick=1
let g:tagbar_iconchars=['+', '-']
let g:tagbar_autoshowtag=1
let g:tagbar_show_linenumbers=0

let g:EnhCommentifyAlignRight='Yes'
let g:EnhCommentifyRespectIndent='yes'
let g:EnhCommentifyPretty='Yes'
let g:EnhCommentifyMultiPartBlocks='Yes'
let g:EnhCommentifyUseSyntax='Yes'

map <leader>aid :AuthorInfoDetect<CR>
let g:vimrc_author='Marslo'
let g:vimrc_email='marslo.jiao@gmail.com'
au BufWritePre, FileWritePre * :AuthorInfoDetect<CR>

let MRU_Auto_Close = 1                                              " Most Recently Used(MRU)
let MRU_Max_Entries = 10
let MRU_Exclude_Files='^/tmp/.*\|^/temp/.*\|^/media/.*\|^/mnt/.*'
map <leader>re :MRU<CR>

noremap <Leader>u :GundoToggle<CR>

augroup vimrc
  au BufReadPre * setlocal foldmethod=indent
  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END

let g:rainbow_active = 1
let g:rainbow_operators = 1
let g:rainbow_conf = {
\   'guifgs' : ['#6A5ACD', '#B22222', '#C0FF3E', '#EEC900', '#9A32CD', '#EE7600', '#98fb98', '#686868'],
\   'ctermfgs' : 'xterm-256color' == $TERM ? ['141', '196', '112', '208', '129', '166', '85', '237'] : ['lightblue', 'lightgreen', 'yellow', 'red', 'magenta'],
\   'parentheses': [['(',')'], ['\[','\]'], ['{','}']],
\   'separately': {
\     'css': {
\       'parentheses': [['(',')'], ['\[','\]']],
\     },
\     'scss': {
\       'parentheses': [['(',')'], ['\[','\]']],
\     },
\     'html': {
\       'parentheses': [['(',')'], ['\[','\]'], ['{','}']],
\     },
\   }
\}

let g:indentLine_color_gui = "#282828"
let g:indentLine_color_term = 239
let g:indentLine_indentLevel = 20
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_color_tty = 0
" let g:indentLine_faster = 1
if 'xterm-256color' == $TERM
  let g:indentLine_char = '¦'
elseif has('win32')
  let g:indentLine_color_term = 8
  let g:indentLine_char = '|'
else
  let g:indentLine_color_tty_dark = 0
  let g:indentLine_char = '¦'
endif

let SuperTabDefaultCompletionType = '<c-p>'
let SuperTabMappingForward = '<c-p>'
let SuperTabMappingTabLiteral = '<Tab>'
let SuperTabClosePreviewOnPopupClose = 1

let g:AutoPairs = {'(':')', '[':']', '{':'}', '<':'>',"'":"'",'"':'"', '`':'`'}
let g:AutoPairsParens = {'(':')', '[':']', '{':'}', '<':'>'}
let g:AutoPairsFlyMode = 1
let g:AutoPairsShortcutBackInsert = '<M-b>'

match VendorPrefix /-\(moz\|webkit\|o\|ms\)-[a-zA-Z-]\+/            " For css3

" if isdirectory(bud . '\accelerated-jk')
  " nmap j <Plug>(accelerated_jk_gj)
  " nmap k <Plug>(accelerated_jk_gk)
" endif

autocmd BufWinLeave * silent! mkview
autocmd BufWinEnter * silent! loadview
autocmd BufRead,BufNewFile *.txt setfiletype txt
autocmd BufRead,BufNewFile *.t set ft=perl
autocmd FileType javascript syntax clear jsFuncBlock

" vim: tabstop=2:softtabstop=2:shiftwidth=2:expandtab
