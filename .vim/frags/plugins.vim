" {{{1 session management
let g:session_directory = g:vim_config_home . '/session'
let g:session_autoload = 'no'
let g:session_autosave = 'no'
let g:session_command_aliases = 1

" {{{1 grep
let g:Grep_Default_Options = '-IR'

" {{{1 ctrlp + cpsm
let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}

" {{{1 easymotion
let g:EasyMotion_keys = 'hjklasdfgyuiopqwertnmzxcvbHJKLASDFGYUIOPQWERTNMZXCVB'
let g:EasyMotion_leader_key = "'"
let g:EasyMotion_grouping = 1
let g:EasyMotion_use_migemo = 1

" {{{1 wildfire
let g:wildfire_water_map = '<S-Enter>'
let g:wildfire_objects = ["i'", 'i"', 'i)', 'i]', 'i}', 'ip', 'it', 'i>']

" {{{1 Rust: Tagbar settings
let g:tagbar_type_rust = {
    \ 'ctagstype' : 'rust',
    \ 'kinds' : [
        \'T:types,type definitions',
        \'f:functions,function definitions',
        \'g:enum,enumeration names',
        \'s:structure names',
        \'m:modules,module names',
        \'c:consts,static constants',
        \'t:traits,traits',
        \'i:impls,trait implementations',
    \]
    \}

" {{{1 vdebug
let g:vdebug_options = {
    \ 'server' : 0.0.0.0,
    \ 'break_on_open' : 0,
    \ 'path_maps' : {
    \ }}

" {{{1 gitgutter
let g:gitgutter_map_keys = 0

" {{{1 vim-python
augroup vimrc_python
  au!
  au FileType python setlocal expandtab shiftwidth=4 tabstop=8 colorcolumn=79
      \ formatoptions+=croq softtabstop=4 smartindent
      \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
augroup END

" {{{1 vim-airline
let g:airline#extensions#virtualenv#enabled = 1
let g:airline#extensions#tagbar#enabled = 1

" {{{1 Tagbar
let g:tagbar_autofocus = 1
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [  'p:package', 'i:imports:1', 'c:constants', 'v:variables',
        \ 't:types',  'n:interfaces', 'w:fields', 'e:embedded', 'm:methods',
        \ 'r:constructor', 'f:functions' ],
    \ 'sro' : '.',
    \ 'kind2scope' : { 't' : 'ctype', 'n' : 'ntype' },
    \ 'scope2kind' : { 'ctype' : 't', 'ntype' : 'n' },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
    \ }

" {{{1 Watchdogs

" Watchdogs target language's extension
let $watchdogs_target = '*.js,*.ts,*.go,*.php,*.py,*.lua,*.vim*,vimrc'
let g:watchdogs_check_CursorHold_enable = 1
let g:watchdogs_check_BufWritePost_enable = 1
augroup vimrc_local_watchdogs
    autocmd!
    " autocmd InsertLeave,BufWritePost,TextChanged $watchdogs_target WatchdogsRunSilent
    autocmd BufNewFile,BufRead $watchdogs_target WatchdogsRunSilent
augroup END

" {{{1 quickrun config
let g:quickrun_config = {
    \   '*': { 'hook/time/enable': '1' },
    \   '_': {
    \       'runner': 'vimproc',
    \       'outputter/quickfix/open_cmd': '',
    \       'runner/vimproc/updatetime': 10
    \   },
    \   'watchdogs_checker/_': {
    \       'runner/vimproc/updatetime': 10
    \   },
    \ }

" ==============================================================
" gtags
"
let g:quickrun_config['gtags'] = {
    \   'command': 'gtags',
    \   'exec': '%c',
    \   'outputter': 'error:buffer:quickfix'
    \ }

" ==============================================================
" vim
"
let g:quickrun_config['vim/watchdogs_checker'] = {
    \   'type': executable('vint') ? 'watchdogs_checker/vint' : 'watchdogs_checker/vim-vimlint'
    \ }
let g:quickrun_config['watchdogs_checker/vint'] = {
    \   'command': 'vint',
    \   'exec': '%c %o %s:p'
    \ }

" ==============================================================
" php
"
let g:quickrun_config['watchdogs_checker/php'] = {
    \   'command': 'php',
    \   'cmdopt':  '-l -d error_reporting=E_ALL -d display_errors=1 -d display_startup_errors=1 -d log_errors=0 -d xdebug.cli_color=0',
    \   'exec':    '%c %o %s:p',
    \   'errorformat': '%m\ in\ %f\ on\ line\ %l'
    \ }

" ==============================================================
" shell script
"
let g:quickrun_config['watchdogs_checker/shellcheck'] = {
    \   'command': 'shellcheck',
    \   'cmdopt': '-f gcc',
    \ }
let g:quickrun_config['sh/watchdogs_checker'] = {
    \   'type': 'watchdogs_checker/shellcheck'
    \ }

" ==============================================================
" typescript
"
let g:quickrun_config['watchdogs_checker/tslint'] = {
    \   'command': 'tslint',
    \   'exec': '%c %o %s:p',
    \   'cmdopt': '--module commonjs'
    \ }
let g:quickrun_config['typescript/watchdogs_checker'] = {
    \   'type': 'watchdogs_checker/tslint'
    \ }

" ==============================================================
" swift
"
let g:quickrun_config['watchdogs_checker/swiftc'] = {
    \   'command': 'swiftc',
    \   'exec': '%c %o %s:p',
    \   'cmdopt': ''
    \ }
let g:quickrun_config['swift/watchdogs_checker'] = {
    \   'type': 'watchdogs_checker/swiftc'
    \ }

" {{{1 Gtags
"let g:unite_source_gtags_ref_option = 'r'
let g:unite_source_gtags_def_option = 'i'
"let g:unite_source_gtags_result_option = 'ctags-x'

" {{{1 Go
filetype plugin indent on

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = 'goimports'
let g:go_fmt_fail_silently = 1

" {{{1 Ctags looks up and up
set tags=~/.cache/tags_dir/*/prj_tags

" {{{1 Riot
au BufRead,BufNewFile *.tag set filetype=javascript
let g:syntastic_javascript_checkers = ['jsxhint']
let g:syntastic_javascript_jsxhint_exec = 'jsx-jshint-wrapper'

" {{{1 TweetVim
let s:tweetvim_update_interval_seconds = 60
let s:tweetvim_timestamp = reltime()[0]

" {{{1 Markdown
set syntax=markdown
au BufRead,BufNewFile *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
let g:previm_enable_realtime = 1
let g:previm_custom_css_path = g:vim_config_home.'/previm.css'

" {{{1 deoplete
let g:deoplete#enable_at_startup = 1
