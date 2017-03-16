" without Normal vi
if 0 | finish | endif

" vimの設定 {{{
" color {{{
set t_Co=256
colorscheme molokai
"colorscheme desert
"hi Folded guifg=#606060 guibg=#202038
"hi StatusLine ctermfg=gray term=bold,reverse cterm=bold,reverse gui=bold,reverse

" vimdiff
"hi DiffAdd    ctermfg=black ctermbg=2
"hi DiffChange ctermfg=black ctermbg=3
"hi DiffDelete ctermfg=black ctermbg=6
"hi DiffText   ctermfg=black ctermbg=7
"highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=22
"highlight DiffDelete cterm=bold ctermfg=10 ctermbg=52
"highlight DiffChange cterm=bold ctermfg=10 ctermbg=17
"highlight DiffText   cterm=bold ctermfg=10 ctermbg=21

syntax on
" }}}

" key mappings {{{
" normal mode
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

nnoremap Q gq

noremap <Left> :tabp<CR>
noremap <Right> :tabn<CR>

nnoremap <F5> :cw<cr>
nnoremap <F4> :ccl<cr>
nnoremap <F3> :copen<cr>

" insert mode
ino <silent> jj <Esc>l
ino <silent> kk <Esc>l

" mouse
if has('mouse')
    set mouse=a
    set ttymouse=xterm2
endif
"}}}

" 常にONにすると事故るかも(開発環境ではアリか？)
" snippetテンプレとかで事故る
"autocmd BufWritePre * :%s/\s\+$//ge

" tab and shift settings
set tabstop=8
set expandtab
set softtabstop=4
set shiftwidth=4

set encoding=utf-8
set fencs=ucs-bom,utf-8,euc-jp,sjis

" edit
"set autoindent
"set smartindent
set backspace=indent,eol,start
set pastetoggle=<F12>
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

set incsearch
set nohls
set ignorecase
set smartcase

set showcmd

"" display settings
set number
"set ruler
set list
set listchars=tab:>-,extends:<,trail:-,eol:<
"set cursorline

"let php_folding = 2
set fdm=marker
"set foldmethod=syntax

set laststatus=2
"set statusline=%<%F%r%m%h%w
set statusline=%<%F%r%m%h%w[%{&fileencoding}]%=%l/%L,%c%V%8P

if v:version > 703
    hi ColorColumn ctermbg=black
    set colorcolumn=80
endif

" }}}

""""""""""""""""""""""""""
" プラグイン設定ここから "
""""""""""""""""""""""""""
" Neobundle Settings {{{
"---------------------------
" bundleで管理するディレクトリを指定
if has('vim_starting')
    set nocompatible

    " Required:
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" neobundle自体をneobundleで管理
NeoBundleFetch 'Shougo/neobundle.vim'

" いまのところプラグイン全部ここ
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle has('lua') ? 'Shougo/neocomplete' : 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Townk/vim-autoclose'
" :PhpMakeDict ja をやる
NeoBundleLazy 'violetyk/neocomplete-php.vim'
let g:neocomplete_php_locale = 'ja'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundleLazy 'davidhalter/jedi-vim'
NeoBundle 'TwitVim'
NeoBundleLazy 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }
NeoBundleLazy 'osyo-manga/unite-quickfix'
NeoBundleLazy 'osyo-manga/shabadou.vim'
NeoBundleLazy 'thinca/vim-quickrun'
"let g:quickrun_config={'_': {'split': ''}}
"let g:quickrun_config._={
let g:quickrun_config={
    \"_" : {
            \"outputter/buffer/split" : ":botright 8sp",
            \"outputter" : "multi:buffer:quickfix",
            \"hook/close_buffer/enable_empty_data" : 1,
            \"hook/close_buffer/enable_failure" : 1,
            \"hook/close_quickfix/enable_exit" : 1,
            \"hook/unite_quickfix/enable_failure" : 1,
            \"hook/close_unite_quickfix/enable_hook_loaded" : 1,
            \"hook/nuko/enable" : 1,
            \'runner':'vimproc',
            \"runner/vimproc/updatetime" : 10,
    \}
\ }
" w3mをyum installする
NeoBundle 'thinca/vim-ref'
let g:ref_phpmanual_path=$HOME . '/.vim/ref/php-chunked-xhtml'

NeoBundle 'taglist.vim'
NeoBundle 'vim-scripts/tagbar-phpctags', {
  \   'build' : {
  \     'others' : 'chmod +x bin/phpctags',
  \   },
  \ }
NeoBundle 'vim-scripts/tagbar'
NeoBundle 'Shougo/unite-outline'
nnoremap <silent> <F11> :TagbarToggle<CR>

NeoBundleLazy 'scrooloose/nerdtree'
nnoremap <silent><C-d> :NERDTreeToggle<CR>

NeoBundle 'scrooloose/syntastic'

if has('conceal')
  NeoBundleLazy 'Yggdroot/indentLine', { 'autoload' : {
        \   'commands' : ['IndentLinesReset', 'IndentLinesToggle'],
        \ }}
endif

"nnoremap <F9> :<C-u>IndentLinesReset<CR>
"nnoremap <F10> :<C-u>IndentLinesToggle<CR>
"        \   'filetypes': g:my.ft.program_files,

call neobundle#end()

" Required:
filetype plugin indent on

NeoBundleCheck

"-------------------------
" End Neobundle Settings }}}

" TwitVim {{{
let twitvim_browser_cmd = "browser.dummy"
let twitvim_force_ssl = 1
let twitvim_count = 40

nnoremap <F8> :<C-u>FriendsTwitter<CR>
nnoremap <F9> :<C-u>PosttoTwitter<CR>
nnoremap <F10> :<C-u>ListTwitter watch<CR>
"}}}

" EasyMotion {{{
"======================
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
" :h easymotion-command-line
nmap g/ <Plug>(easymotion-sn)
xmap g/ <Plug>(easymotion-sn)
omap g/ <Plug>(easymotion-tn)

map <Leader><Leader> <Plug>(easymotion-repeat)
map <C-n> <Plug>(easymotion-next)
map <C-p> <Plug>(easymotion-prev)

" Support mappings feature
"EMCommandLineNoreMap <Space> <CR>
"EMCommandLineNoreMap ; <CR>
"EMCommandLineNoreMap <C-j> <Space>

"" easymotion
nmap ; <Plug>(easymotion-s2)
map f <Plug>(easymotion-bd-fl)
map t <Plug>(easymotion-bd-tl)
"map f <Plug>(easymotion-fl)
"map t <Plug>(easymotion-tl)
"map F <Plug>(easymotion-Fl)
"map T <Plug>(easymotion-Tl)

" Jump to first match with enter & space
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_space_jump_first = 1
"======================
" }}}
" Unite {{{
"======================
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200
nnoremap <silent> <Space>uy :<C-u>Unite history/yank<CR>
nnoremap <silent> <Space>ub :<C-u>Unite buffer<CR>
nnoremap <silent> <Space>uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> <Space>ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> <Space>uu :<C-u>Unite file_mru buffer<CR>
nnoremap <silent> <Space>gg :<C-u>Unite vimgrep<CR>

" ファイルを開く時、ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')

" ファイルを開く時、ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')

"======================
" }}}
" NeoCompl[ete|chache] {{{
if neobundle#is_installed('neocomplete')
" NeoComplete {{{
"======================
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
                        \ 'default' : '',
                        \ 'vimshell' : $HOME.'/.vimshell_hist',
                        \ 'scheme' : $HOME.'/.gosh_completions'
                        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
        return neocomplete#close_popup() . "\<CR>"
        " For no inserting <CR> key.
        "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
"======================
" NeoComplete END }}}
elseif neobundle#is_installed('neocomplcache')
" NeoComplcache {{{
"======================
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : ''
    \ }

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

"======================
" NeoComplcache END }}}
endif
" }}}
" jedi - NeoComplete {{{
" =========================
autocmd FileType python setlocal omnifunc=jedi#completions
"autocmd FileType python setlocal completeopt-=preview

let g:jedi#completions_enabled = 0

" 勝手に補完候補を選んじゃうのを抑制
let g:jedi#auto_vim_configuration = 0

if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. *\t]\.\w*'
" =========================
" }}}
" neosnippet {{{
"======================
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable() <Bar><bar> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() <Bar><bar> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
"======================
" end of neosnippet }}}
" syntastic {{{
"======================

"let g:syntastic_mode_map = {
"  \ 'mode': 'active',
"  \ 'active_filetypes': ['php']
"  \}
"let g:syntastic_check_on_open=0
"let g:syntastic_enable_signs=1
"let g:syntastic_echo_current_error=1
"let g:syntastic_auto_loc_list=1
"let g:syntastic_enable_highlighting=1
let g:syntastic_php_checkers=['php', 'phpcs']
"let g:syntastic_php_phpcs_args='--standard=PHPCS'
let g:syntastic_php_phpcs_args='--standard=PSR2'

nnoremap <C-s> :SyntasticCheck<CR>
nnoremap <C-c> :Errors<CR>


"======================
" end of syntastic }}}
