" Vim5 and later versions support syntax highlighting. Uncommenting the
" following enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" Have Vim jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

" Default command history is too small
set history=200

" Tab complete similar to zsh
set wildmenu
set wildmode=full

" Disable arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Default number format to base 10
" Necessary for vim's integer increment/decrement shortcuts
set nrformats=

"""""""""""" Colorscheme """"""""""""""
" Set vim to use 256 color
set t_Co=256

" Set default colorscheme
colorscheme zenburn_mod
let g:zenburn_high_Contrast=1

" Explicitly use tell vim to use the same scheme in vimdiff
if &diff
  colorscheme zenburn_mod
  let g:zenburn_high_Contrast=1
endif

" Handle indenting
set cindent
set cino=(0,W$,c1,C1,{0
set shiftwidth=4
set expandtab
set smarttab
set wrap

" If noet, 2 soft tabs will become a tab char
set tabstop=8

" Show line numbers, current row/col/%, and entered cmd
set number
set ruler
set showcmd

" Use system clipboard
set clipboard=unnamed

" Display name of the function the cursor is in.
fun! ShowFuncName()
  let lnum = line(".")
  let col = col(".")
  echohl ModeMsg
  echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
  echohl None
  call search("\\%" . lnum . "l" . "\\%" . col . "c")
endfun

" Use control + (HJKL) to navigate between vim splits
nnoremap <C-j> <C-W>j<C-W>_
nnoremap <C-k> <C-W>k<C-W>_
nnoremap <C-h> <C-W>h<C-W>_
nnoremap <C-l> <C-W>l<C-W>_

" Set fold colors
hi foldcolumn ctermbg=8
hi folded ctermbg=8

" Show non-printed characters and tabs as arrows
exec "set listchars=tab:\uBB-,trail:\uB7,nbsp:~"
set list

" Allow language specific plugins and indentation
filetype plugin on
filetype indent on

" Language specific style
if has("autocmd")
  " Remove trailing whitespace
  au BufWritePre * :%s/\s\+$//e

  " Disable automatic comment on new lines following comment line
  au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

  " Enforce formatting before gofmt
  au BufNewFile,BufReadPost *.go set filetype=go
  au FileType go set tabstop=4
  au FileType go set noet

  " Web dev rules
  au Filetype html,ruby setlocal ts=2 sts=2 sw=2
  au FileType css,html,js set indentkeys=0{,0},0#,!^F,o,O,e
  au FileType css set syntax=scss
  au FileType css,html,js,html.mustache,ruby colorscheme sexy-railscasts-256

  " Autoformat the following file types on save
  set autoindent
  au BufWrite *.css,*.html,*.js,*.rb :Autoformat
  au BufWritePost *.py :Autopep8
  let g:autopep8_disable_show_diff=1
  au BufRead,BufNewFile *.handlebars,*.hbs set ft=html.mustache
endif

" Set ctags to look for tags file in parent directory
set tags=TAGS;

" Disable swap files
set noswapfile

" Use vim-pathogen, needed for syntastic
call pathogen#infect()

" Automatically bring up the location list of issues
let g:syntastic_auto_loc_list = 0

" Tag completion after a 'comma slash'
inoremap ,/ </<C-X><C-O>

" Jump to the last position when reopening a file
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif


""""""""""""""" Misc """"""""""""""""""
" Ensure backspaces work properly
set bs=2

" Set file encoding
set encoding=utf-8
set fileencoding=utf-8

" Use conceal to draw lambda and not as special characters
if has('conceal')
    if has("autocmd")
        au Syntax * syn keyword Operator lambda conceal cchar=λ
        au Syntax ruby syn match rubyKeyword "->" conceal cchar=λ
        au Syntax haskell syn match hsKeyword "\\" conceal cchar=λ
        au Syntax * syn keyword Operator not conceal cchar=¬
        au Syntax * syn keyword Operator and conceal cchar=&
    endif
    hi! link Conceal Operator
    set conceallevel=2
endif

" Specially mapped shortcuts
let mapleader = ","

" Navigate the buffers
nnoremap <leader>n :bn<cr>
nnoremap <leader>p :bp<cr>

" Hide/Show the line numbers and fold column
nnoremap <leader>hi :set nonumber foldcolumn=0<cr>
nnoremap <leader>sh :set number foldcolumn=2

" Toggle spell checking 
nnoremap <leader>sp :set spell! spelllang=en_ca<cr>

" Diff ignore whitespace
nnoremap <leader>ws :set diffopt+=iwhite

" Toggle printing whitespace characters
nnoremap <leader>li :<c-u>setlocal lcs=tab:>-,trail:-,eol:$ list! list? <cr>

" Format JSON
nnoremap <Leader>js !python -m json.tool<CR>

" Toggle paste mode
set pastetoggle=<leader>pa

" Shortcut to escape
inoremap jk <esc>

" Clear highlighted search
nnoremap <silent> <cr> :noh<cr><cr>

" Comment out a visually selected region
vnoremap <silent> " :s#^#"#<cr>:noh<cr>
vnoremap <silent> -" :s#^"##<cr>:noh<cr>

vnoremap <silent> # :s#^#\##<cr>:noh<cr>
vnoremap <silent> -# :s#^\###<cr>:noh<cr>

vnoremap <silent> // :s#^#\/\/ #<cr>:noh<cr>
vnoremap <silent> -// :s#^\/\/\ ##<cr>:noh<cr>

" Use double slashes for Haskell comment shortcut
if has("autocmd")
    au Syntax haskell vnoremap // :s#^#-- #<cr>
    au Syntax haskell vnoremap -// :s#^-- ##<cr>
endif

" Blank out a visually selected region without removing lines
vnoremap -- :s#.*##<cr><cr> :noh<cr><cr>

if has("autocmd")
    " Check the file extension isn't html since there is a bug
    " that I'd rather not deal with when editing html
    if (expand('%:e') != "html")
        au VimEnter * RainbowParenthesesToggle
        au Syntax * RainbowParenthesesLoadRound
        au Syntax * RainbowParenthesesLoadSquare
        au Syntax * RainbowParenthesesLoadBraces
    endif
endif

" Switch buffers without saving
set hidden

" Highlight searched strings
" Searching with '*' highlights all occurences of a word.
set hlsearch
set incsearch

" Open ctags result in another tab
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

" Highlight the 81st character
call matchadd('ColorColumn', '\%81v', 100)

" Create a backup copy in tmp when saving over a file
set backup
set backupdir=/tmp

" Disable include checks for C/C++
"let g:syntastic_c_remove_include_errors = 1

let g:syntastic_c_remove_include_errors = 1

let g:syntastic_javascript_checkers = ['jshint']

let g:SuperTabDefaultCompletionType = "context"
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]

" Automatically close xml tags, 1 to close HTML tags also
let g:xmledit_enable_html = 0
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
let g:syntastic_javascript_checkers = ['jshint']

" TODO: Add 'if darwin' condition
let g:clang_library_path = "/Library/Developer/CommandLineTools/usr/lib/"

" TODO: Determine if these are necessary
let g:lisp_rainbow = 1
let g:mustache_abbreviations = 1

""" NERDTree Settings """

" Don't bring up nerdtree when any file is opened
let g:nerdtree_tabs_open_on_console_startup = 0
" open NERDTree with `Ctrl-n`
map <C-n> <plug>NERDTreeTabsToggle<CR>
" Show dot files
let NERDTreeShowHidden=1
" Open new tab for NERDTree
let NERDTreeMapOpenInTab='<ENTER>'
let g:nerdtree_tabs_open_on_new_tab=1

" Navigate tabs
noremap  <C-l> :tabn<CR>
noremap  <C-h> :tabp<CR>

function! Timestamp()
  let date = system("date '+%B %d, %Y %I:%M %p'")[:-2]
  execute "normal! o" . "\n" . date . "\n"
endfunction

command! Timestamp call Timestamp()
