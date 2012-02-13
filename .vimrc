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
set tabstop=8
set cindent
set cino=(0,W$,c1,C1,{0
set shiftwidth=4
set expandtab

" Highlight column 80 and above.
match ErrorMsg '\%>80v.\+'
set showcmd

" Show line numbers
set number

" missing ZZ and ZQ counterparts:
" quick save-buffer and quit-everything
nnoremap ZS :w<CR>
nnoremap ZX :qa<CR>

" Copy and paste between any two vim sessions
" REQUIRES xclip package to be installed
vmap <F6> :!xclip -f -sel clip<CR>
map <F7> :-1r !xclip -o -sel clip<CR>

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
" set foldcolumn=1
" hi foldcolumn ctermbg=8

" Show non-printed characters and tabs as arrows
set list
set listchars=tab:>-,trail:-

filetype plugin on

" Python specific indenting
if has("autocmd")
    autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
    autocmd BufRead *.py set tabstop=4
    autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``
endif

" Change the color of comments for dark backgrounds
" highlight Comment ctermfg=darkgreen
