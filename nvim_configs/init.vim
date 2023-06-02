" install Dein (Plugin manager)
let $CACHE = expand('~/.cache')
if !isdirectory($CACHE)
  call mkdir($CACHE, 'p')
endif
if &runtimepath !~# '/dein.vim'
  let s:dein_dir = fnamemodify('dein.vim', ':p')
  if !isdirectory(s:dein_dir)
    let s:dein_dir = $CACHE . '/dein/repos/github.com/Shougo/dein.vim'
    if !isdirectory(s:dein_dir)
      execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
    endif
  endif
  execute 'set runtimepath^=' . substitute(
        \ fnamemodify(s:dein_dir, ':p') , '[/\\]$', '', '')
endif

if dein#load_state('~/.cache/dein')
    call dein#begin('~/.cache/dein')
    call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
    call dein#add('tpope/vim-fugitive')
    call dein#add('Shougo/denite.nvim')
    call dein#add('scrooloose/nerdtree')
    call dein#add('airblade/vim-gitgutter')
    call dein#add('editorconfig/editorconfig-vim')
    call dein#add('derekwyatt/vim-scala')
    call dein#add('othree/yajs.vim')
    call dein#add('fatih/vim-go')
    call dein#add('vim-airline/vim-airline')
    call dein#add('vim-airline/vim-airline-themes')
    call dein#add('godlygeek/tabular')
    call dein#add('plasticboy/vim-markdown')
    call dein#add('Yggdroot/indentLine')
    call dein#add('tacroe/unite-mark')
    call dein#add('Xuyuanp/nerdtree-git-plugin')
    call dein#add('t9md/vim-quickhl')
    call dein#add('digitaltoad/vim-pug')
    call dein#add('simeji/winresizer')
    call dein#add('nanotech/jellybeans.vim')
    call dein#add('glidenote/memolist.vim')
    call dein#add('itchyny/vim-cursorword')
    call dein#add('elzr/vim-json')
    call dein#add('posva/vim-vue')
    call dein#add('pangloss/vim-javascript')
    call dein#add('MaxMEllon/vim-jsx-pretty')
    call dein#add('tshirtman/vim-cython')
    call dein#add('neoclide/coc.nvim', { 'merged': 0, 'rev': 'release'})
    ""call dein#add('rust-lang/rust.vim')
    call dein#add('tomlion/vim-solidity')
    call dein#add('xiyaowong/transparent.nvim', {'rev': '4c3c392f285378e606d154bee393b6b3dd18059c'})
    call dein#add('nvim-treesitter/nvim-treesitter', { 'merged': 0, 'do': ':TSUpdate' })
    call dein#end()
    call dein#save_state()
endif
if dein#check_install()
    call dein#install()
endif

" autocmds
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType java setlocal omnifunc=javacomplete#Complete
autocmd FileType vue syntax sync fromstart
filetype plugin on

" terminal mode setting
tnoremap <Esc> <C-\><C-n> # map Ctrl+\ Ctrl+n sequence to Esc key in termial mode

" Do not change line when pressing Enter during the autocompletion 
inoremap <expr><CR>  pumvisible() ? "<C-y>" : "<CR>"

"This unsets the "last search pattern" register by hitting ESC key
nnoremap <CR> :noh<CR><CR>

" tab
noremap <C-T> :tabnew<CR>
noremap <C-N> :tabNext<CR>

" Git
noremap <C-D> :Gdiff<CR>
noremap <C-B> :Git blame<CR>
noremap <C-S> :Git status<CR>

" airline setting
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'hybrid'

" NERDTree setting
nmap <C-f> :NERDTree<CR>

" mark setting
nmap <Space>m <Plug>(quickhl-manual-this)
xmap <Space>m <Plug>(quickhl-manual-this)
nmap <Space>M <Plug>(quickhl-manual-reset)
xmap <Space>M <Plug>(quickhl-manual-reset)

" transparent background
let g:transparent_enabled = v:true

" base settings
set ignorecase
set smartcase
set nu
set autoindent
set incsearch
set laststatus=2
set hlsearch
set encoding=utf-8
set background=dark
set backspace=indent,eol,start
set cursorline
syntax on
colorscheme hybrid
set modifiable
set title
set list
set listchars=tab:>_,trail:-,extends:>,precedes:<,nbsp:%,eol:↲
set tabstop=4
set expandtab
set shiftwidth=4
set completeopt=menuone
set conceallevel=0
set inccommand=split
hi clear CursorLine

" window split/switch
nnoremap <silent> <S-j> :split<CR>
nnoremap <silent> <S-l> :vsplit<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-Left> <C-w>h
nnoremap <C-Down> <C-w>j
nnoremap <C-Up> <C-w>k
nnoremap <C-Right> <C-w>l

" denite settings
noremap <C-P> :<C-u>Denite file/rec<CR>
noremap <C-G> :<C-u>Denite grep<CR>
call denite#custom#var('file/rec', 'command',
    \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
call denite#custom#var('grep', {
    \ 'command': ['ag'],
    \ 'default_opts': ['-i', '--vimgrep'],
    \ 'recursive_opts': [],
    \ 'pattern_opt': [],
    \ 'separator': ['--'],
    \ 'final_opts': [],
    \ })
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
    nnoremap <silent><buffer><expr> <CR>
    \ denite#do_map('do_action')
    nnoremap <silent><buffer><expr> o
    \ denite#do_map('do_action')
    nnoremap <silent><buffer><expr> s
    \ denite#do_map('do_action', 'split')
    nnoremap <silent><buffer><expr> v
    \ denite#do_map('do_action', 'vsplit')
    nnoremap <silent><buffer><expr> d
    \ denite#do_map('do_action', 'delete')
    nnoremap <silent><buffer><expr> p
    \ denite#do_map('do_action', 'preview')
    nnoremap <silent><buffer><expr> <Esc>
    \ denite#do_map('quit')
    nnoremap <silent><buffer><expr> q
    \ denite#do_map('quit')
    nnoremap <silent><buffer><expr> i
    \ denite#do_map('open_filter_buffer')
    nnoremap <silent><buffer><expr> <Space>
    \ denite#do_map('toggle_select').'j'
endfunction
autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
    imap <silent><buffer><C-o> <Plug>(denite_filter_quit)
endfunction
let s:denite_win_width_percent = 0.85
let s:denite_win_height_percent = 0.7
call denite#custom#option('default', {
    \ 'split': 'floating',
    \ 'winwidth': float2nr(&columns * s:denite_win_width_percent),
    \ 'wincol': float2nr((&columns - (&columns * s:denite_win_width_percent)) / 2),
    \ 'winheight': float2nr(&lines * s:denite_win_height_percent),
    \ 'winrow': float2nr((&lines - (&lines * s:denite_win_height_percent)) / 2),
    \ 'start_filter': v:true,
    \ 'match_highlight': v:true,
    \ })

" coc setting
if has("nvim-0.5.0") || has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
else
    set signcolumn=yes
endif
set updatetime=300
inoremap <silent><expr> <cr> pumvisible()
    \ ? coc#_select_confirm()
    \ : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction
let g:coc_global_extensions = [
    \ 'coc-json',
    \ 'coc-css',
    \ 'coc-pyright',
    \ 'coc-tsserver',
    \ 'coc-clangd',
    \ 'coc-cmake',
    \ 'coc-eslint',
    \ 'coc-texlab',
    \ 'coc-rls',
    \ 'coc-solidity',
    \ ]

" treesitter setting
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    ensure_installed = "all"
  }
}
EOF
