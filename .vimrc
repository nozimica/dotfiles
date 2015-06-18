set nocp
set showmatch
set ts=4
set shiftwidth=4
set expandtab
" pathogen
execute pathogen#infect()

syntax on
set autoindent
set smartindent
set mouse=a
"set ttymouse=xterm2
let loaded_matchparen = 1
set encoding=utf8
set fileencoding=utf8
filetype on
filetype plugin indent on

set foldmethod=syntax
let php_folding=1
let javaScript_folding=1

"tip 14
set nohlsearch
" tip 15
set laststatus=2

" tip 22
command! Q  quit
command! W  write
command! Wq wq
" tip 34
se splitbelow
se splitright
" tip 598
set keywordprg=~/bin/php_doc

if has("unix")
    map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
else
    map ,e :e <C-R>=expand("%:p:h") . "\" <CR>
endif

map <F3> :tabe<CR>:Project<CR>
map <F4> :Project<CR>
map <F10> :!make<CR>
map <F11> :!make complete<CR>
map <F8> :!xpdf -remote fromvim informe.pdf >& /dev/null &<CR><CR>
map <F6> :b#<CR>
map <F5> :!xpdf -remote fromvim -reload <CR><CR>
map <S-F10> :!make<CR><CR><ESC> :!xpdf -remote fromvim -reload <CR><CR>
map <C-Left> :!xpdf -remote fromvim -exec pageUp <CR><CR>
map <C-Right> :!xpdf -remote fromvim -exec pageDown <CR><CR>
map <C-Up> :!xpdf -remote fromvim -exec "gotoPage(1)" <CR><CR>
map <C-Down> :!xpdf -remote fromvim -exec gotoLastPage <CR><CR>

" tip 91
set dictionary-=/usr/share/dict/words dictionary+=/usr/share/dict/words

" tip 102
function InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>


"function! CleverTab()
"    if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
"        return "\<Tab>"
"    else
"        return "\<C-N>"
"endfunction
"inoremap <Tab> <C-R>=CleverTab()<CR>

" , #perl # comments
map ,, :s/^/#/<CR>

" ,/ C/C++/C#/Java // comments
map ,/ :s/^/\/\//<CR>

" ,< HTML comment
map ,< :s/^\(.*\)$/<!-- \1 -->/<CR><Esc>:nohlsearch<CR>

" c++ java style comments
map ,* :s/^\(.*\)$/\/\* \1 \*\//<CR><Esc>:nohlsearch<CR>

" tip 64
map ,cd :cd %:p:h<CR>

"function! JavaScriptFold()
"    setl foldmethod=syntax
"    setl foldlevelstart=1
"    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend
"
"    function! FoldText()
"        return substitute(getline(v:foldstart), '{.*', '{...}', '')
"    endfunction
"    setl foldtext=FoldText()
"endfunction
"au FileType javascript call JavaScriptFold()
""au FileType javascript setl fen

function FileHeading()
  let s:line=line(".")
  call setline(s:line,"/*")
  call append(s:line," * ")
  call append(s:line+1," * @name")
  "call append(s:line+3," * Fecha - ".strftime("%d %M %Y"))
  call append(s:line+2," * @param")
  call append(s:line+3," * @param")
  call append(s:line+4," * @return")
  "call append(s:line+1," * Author: Nicolas E. Ozimica <nozimica@gmail.com>")
  "call append(s:line+5," * =============================================================================")
  call append(s:line+5," *")
  call append(s:line+6," */")
  unlet s:line
endfunction

map <S-F12> <Esc>mz:execute FileHeading()<CR>`zjjA

"" http://www.reddit.com/r/vim/comments/kz84u/what_are_some_simple_yet_mindblowing_tweaks_to/
"" move a line of text using ALT+[jk], indent with ALT+[hl]
nnoremap <A-j> :m+<CR>==
nnoremap <A-k> :m-2<CR>==
nnoremap <A-h> <<
nnoremap <A-l> >>
inoremap <A-j> <Esc>:m+<CR>==gi
inoremap <A-k> <Esc>:m-2<CR>==gi
inoremap <A-h> <Esc><<`]a
inoremap <A-l> <Esc>>>`]a
vnoremap <A-j> :m'>+<CR>gv=gv
vnoremap <A-k> :m-2<CR>gv=gv
vnoremap <A-h> <gv
vnoremap <A-l> >gv

" start scrolling when within 5 lines near the top/bottom
set scrolloff=5

" allow freeform selection (i.e. ignoring line endings) in visual block mode
set virtualedit+=block
