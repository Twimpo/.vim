" Vim config
set number
set tabstop=2
set shiftwidth=2
set softtabstop=2
set clipboard=unnamedplus
set cursorline
set syntax=ON

" Use mouse
set mouse=nv

" Cursor shape
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

" Theme color
set termguicolors

" Tokyonight 
let g:tokyonight_style = 'storm' " available: night, storm
let g:tokyonight_enable_italic = 1

colorscheme tokyonight

" Buttom line (airline, lightline)
"" ( airline )
" set laststatus=2
" let g:airline#extensions#tabline#enabled = 1

" let g:airline#extensions#tabline#left_sep = ' '
" let g:airline#extensions#tabline#left_alt_sep = '|'

"" ( lightline )
set laststatus=2
let g:lightline = {
			\ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename' ] ],
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \ },
      \ }

function! LightlineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? ' +' : ''
  return filename . modified
endfunction

" Base keymap
imap jk <ESC>
let mapleader=' '

" Auto pair (auto-pairs)
let g:AutoPairsFlyMode = 0

" Tree (#nerdtree, coc-explorer)
" nmap <leader>e :NERDTreeToggle<CR>
nmap <leader>e :CocCommand explorer<CR>

" Terminal (vim-floaterm)
let g:floaterm_autoclose=2
nnoremap   <silent>   <F5>    :FloatermNew<CR>
tnoremap   <silent>   <F5>    <C-\><C-n>:FloatermNew<CR>
nnoremap   <silent>   <F6>    :FloatermPrev<CR>
tnoremap   <silent>   <F6>    <C-\><C-n>:FloatermPrev<CR>
nnoremap   <silent>   <F7>    :FloatermNext<CR>
tnoremap   <silent>   <F7>    <C-\><C-n>:FloatermNext<CR>
nnoremap   <silent>   <F8>    :FloatermToggle<CR>
tnoremap   <silent>   <F8>    <C-\><C-n>:FloatermToggle<CR>
" nnoremap   <leader>lg :!gcc % -o 
" nnoremap   <leader>lp :!python %<CR>
nnoremap		<leader>lg :FloatermNew! --autoclose=1 gcc % -o %< && ./%<<CR>
nnoremap		<leader>lp :FloatermNew! --autoclose=1 python %<CR>

" Keymap (Common)
" Window Navigation
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" Navigate buffers
nnoremap <S-l> :bnext<CR>
nnoremap <S-h> :bprevious<CR>
nnoremap <leader>x :bdelete<CR>

" Indent
vnoremap < <lt>gv
vnoremap > >gv

" Vim command 
nnoremap <leader>w :w<CR>
nnoremap <leader>Q :qa!<CR>

" Coc plugin 
" Markdown showing (coc-markdown)
nnoremap <leader>mo :CocCommand markdown-preview-enhanced.openPreview<CR>

"=== 
"=== LSP (Coc)
"===

" Auto install extensions you need
let g:coc_global_extensions = [
						\	'coc-vimlsp',
						\ 'coc-json',
						\ 'coc-marketplace',
						\ 'coc-python',
						\ 'coc-explorer',
						\ 'coc-clangd',
						\ 'coc-webview',
						\ 'coc-markdown-preview-enhanced']

" Allow you peek to another file without saving current file ( Save to the
" buffer )
set hidden

set updatetime=100
set signcolumn=yes

" Highlight
let g:coc_default_semantic_highlight_groups = 1

nmap <leader>cm :CocCommand<CR>
nmap <leader>cl :CocList

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Enter to comfirm your choose
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Open the choose list of coc
inoremap <silent><expr> <C-/> coc#refresh()

" Use `<leader>-` and `<leader>=` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent><nowait> <leader>- <Plug>(coc-diagnostic-prev)
nmap <silent><nowait> <leader>= <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent><nowait> gd <Plug>(coc-definition)
nmap <silent><nowait> gy <Plug>(coc-type-definition)
nmap <silent><nowait> gi <Plug>(coc-implementation)
nmap <silent><nowait> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> <leader>lk :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the word which your cursor is placed
autocmd CursorHold * silent call CocActionAsync('highlight')

" Rename symbol
nmap <leader>rn <Plug>(coc-rename)

" Plugin download
call plug#begin('~/.vim/plugged')
" Start page
" Plug 'mhinz/vim-startify'

" Auto Pairs
Plug 'jiangmiao/auto-pairs'

" Color theme
Plug 'ghifarit53/tokyonight-vim'
Plug 'ryanoasis/vim-devicons'
Plug 'itchyny/lightline.vim'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'

" Terminal
Plug 'voldikss/vim-floaterm'

" Commentary
Plug 'tpope/vim-commentary'

" LSP
Plug 'neoclide/coc.nvim', {'branch':'release'}

" Plug
Plug 'dstein64/vim-startuptime'

call plug#end()
