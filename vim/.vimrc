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

" Highlight column 80 and above.
" match ErrorMsg '\%>80v.\+'
set showcmd

" Show line numbers
set number

" missing ZZ and ZQ counterparts:
" quick save-buffer and quit-everything
nnoremap ZS :w<CR>
nnoremap ZX :qa<CR>

" Copy and paste between any two vim sessions
" REQUIRES xclip package to be installed
vmap <F5> :!xclip -f -sel clip<CR>
map <F6> :-1r !xclip -o -sel clip<CR>

" Tap 'f' in command-mode to display name of the function the cursor is in.
fun! ShowFuncName()
  let lnum = line(".")
  let col = col(".")
  echohl ModeMsg
  echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
  echohl None
  call search("\\%" . lnum . "l" . "\\%" . col . "c")
endfun
map f :call ShowFuncName() <CR>

" Use control + (HJKL) to navigate between vim splits
map <C-j> <C-W>j<C-W>_
map <C-k> <C-W>k<C-W>_
map <C-h> <C-W>h<C-W>_
map <C-l> <C-W>l<C-W>_

" Save with F2
inoremap <F2> <c-o>:w<cr>

" Set folding options
set foldcolumn=2
set foldmethod=syntax
" Limit folding
set foldnestmax=2
set foldminlines=2
" Use spacebar to open folds
nnoremap <space> za
vnoremap <space> zf
" Set fold colors
hi foldcolumn ctermbg=8
hi folded ctermbg=8

" Show non-printed characters and tabs as arrows
set list
set listchars=tab:>-,trail:-

filetype plugin on

" Python specific indenting
if has("autocmd")
    autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
    autocmd BufRead *.c,*.cc,*.cpp,*fsm*.h,*.java set tabstop=8
    autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``
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
imap ,/ </<C-X><C-O>

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
" Shortcut to escape
inoremap kj <Esc>

" Ensure backspaces work properly
set bs=2

let g:acp_behaviorJavaEclimLength = 3
function MeetsForJavaEclim(context)
  return g:acp_behaviorJavaEclimLength >= 0 &&
        \ a:context =~ '\k\.\k\{' . g:acp_behaviorJavaEclimLength . ',}$'
endfunction
let g:acp_behavior = {
    \ 'java': [{
      \ 'command': "\<c-x>\<c-u>",
      \ 'completefunc' : 'eclim#java#complete#CodeComplete',
      \ 'meets'        : 'MeetsForJavaEclim',
    \ }]
  \ }

" Enable spell checking for non-code
set spell spelllang=en_ca
set diffopt+=iwhite
