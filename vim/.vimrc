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

" Handle indenting
set cindent
set cino=(0,W$,c1,C1,{0
set shiftwidth=4
set expandtab
set smarttab

set showcmd

" Show line numbers
set number

" missing ZZ and ZQ counterparts:
" quick save-buffer and quit-everything
nnoremap ZS :w<CR>
nnoremap ZX :qa!<CR>

" Use system clipboard
set clipboard=unnamedplus

" Tap 'f' in command-mode to display name of the function the cursor is in.
fun! ShowFuncName()
  let lnum = line(".")
  let col = col(".")
  echohl ModeMsg
  echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
  echohl None
  call search("\\%" . lnum . "l" . "\\%" . col . "c")
endfun
nnoremap f :call ShowFuncName() <CR>

" Use control + (HJKL) to navigate between vim splits
nnoremap <C-j> <C-W>j<C-W>_
nnoremap <C-k> <C-W>k<C-W>_
nnoremap <C-h> <C-W>h<C-W>_
nnoremap <C-l> <C-W>l<C-W>_

" Use spacebar to open folds
nnoremap <space> za
vnoremap <space> zf
" Set fold colors
hi foldcolumn ctermbg=8
hi folded ctermbg=8

" Show non-printed characters and tabs as arrows
set listchars=tab:>-,trail:-

filetype plugin on

" Language specific style
if has("autocmd")
    au BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
    au BufRead *.c,*.cc,*.cpp,*fsm*.h,*.java set tabstop=8
    au BufRead *.rb set shiftwidth=2
    au BufWritePre *.py normal m`:%s/\s\+$//e ``
    au BufNewFile,BufRead *.py compiler nose
endif

" Change the color of comments for dark backgrounds
" highlight Comment ctermfg=darkgreen

" Set ctags to look for tags file in parent directory
set tags=tags;

" Disable swap files
set noswapfile

" Use vim-pathogen, needed for syntastic
call pathogen#infect()

" Tag completion after a 'comma slash'
inoremap ,/ </<C-X><C-O>

" Save fold states
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview


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

" Run PyLint
nnoremap <leader>pl :PyLint<cr>

nnoremap <leader>hi :set nonumber foldcolumn=0<cr>
nnoremap <leader>sh :set number foldcolumn=2<cr>:set match ErrorMsg '\%>80v.\+'<cr>

" Toggle spell checking 
nnoremap <leader>sp :set spell! spelllang=en_ca<cr>

" Diff ignore whitespace
nnoremap <leader>ws :set diffopt+=iwhite

" Shortcut to escape
inoremap jk <esc>

" Clear highlighted search
nnoremap <silent> <cr> :noh<cr><cr>

" Comment out a visually selected region
vnoremap " :s#^#"#<cr>
vnoremap -" :s#^"##<cr>

vnoremap # :s#^#\##<cr>
vnoremap -# :s#^\###<cr>

vnoremap // :s#^#\/\/ #<cr>
vnoremap -// :s#^\/\/\ ##<cr>

" Blank out a visually selected region without removing lines
vnoremap -- :s#.*##<cr><cr> :noh<cr><cr>

if has("autocmd")
    au VimEnter * RainbowParenthesesToggle
    au Syntax * RainbowParenthesesLoadRound
    au Syntax * RainbowParenthesesLoadSquare
    au Syntax * RainbowParenthesesLoadBraces
endif

" switch buffers without saving
set hidden

" Highlight searched strings
" Searching with '*' highlights all occurences of a word.
set hlsearch
set ruler

if has("cscope")
    set csprg=/usr/bin/cscope
    set csto=0
    set cst
    set nocsverb
    set csre
    " add any database in current directory
    if filereadable("$PROJECT/cscope.out")
        cs add $PROJECT/cscope.out
        " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
endif
