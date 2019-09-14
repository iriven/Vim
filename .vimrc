set nocompatible
set wrap
set encoding=utf8
"set guifont=SourceCodePro\ Nerd\ Font\ Mono\ Regular


"set updatetime=1000
set ttyfast

" Colours
set t_Co=256


set autoread
" Trigger autoread when changing buffers or coming back to vim in terminal.
au FocusGained,BufEnter * :silent! !


" Show linenumbers
set ruler
set number relativenumber

augroup numbertoggle
        autocmd!
        autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
        autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END


set history=100
set visualbell
set wildmenu
set wildmode=list:longest,full"


"Start scrolling when we're 8 lines away from margins
set scrolloff=8
set sidescrolloff=15
set sidescroll=1


" Set Proper Tabs
"set tabstop=4
"set shiftwidth=4
set smarttab
"set expandtab
set backspace=2



" search params
set hlsearch
set incsearch
set smartcase
set showmatch


" indentation
set autoindent
set smartindent


set autochdir
autocmd BufEnter * silent! lcd %:p:h


function! ResCur()
        if line("'\"") <= line("$")
                normal! g`"
                return 1
        endif
endfunction

augroup resCur
        autocmd!
        autocmd BufWinEnter * call ResCur()
augroup END


if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
        syntax on
endif


filetype plugin on
filetype plugin indent on


runtime bundle/vim-pathogen/autoload/pathogen.vim


" disable plugins
let g:pathogen_disabled = []
"call add(g:pathogen_disabled, 'youcompleteme')


if &diff
        call add(g:pathogen_disabled, 'nerdtree')
        call add(g:pathogen_disabled, 'tagbar')
        execute pathogen#infect()

        let g:solarized_diffmode="high"
        let g:solarized_termcolors=256
        colorscheme solarized8_dark
        set background=dark
else
        execute pathogen#infect()

        let g:solarized_termcolors=256
        colorscheme solarized8_dark
        set background=dark

        highlight ColorColumn guibg=Grey40
        set colorcolumn=80
endif


" Enable highlighting of the current line
highlight CursorLine term=bold cterm=bold guibg=Grey40
set cursorline



" ariline config
let g:airline_solarized_bg='dark'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#tabline#buffer_nr_show = 1

let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#syntastic#error_symbol = 'E:'
let g:airline#extensions#syntastic#stl_format_err = '%E{[%e(#%fe)]}'
let g:airline#extensions#syntastic#warning_symbol = 'W:'
let g:airline#extensions#syntastic#stl_format_err = '%W{[%w(#%fw)]}'

let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#tagbar#flags = ''

let g:airline#extensions#ycm#enabled = 1
let g:airline#extensions#ycm#error_symbol = 'E:'
let g:airline#extensions#ycm#warning_symbol = 'W:'



" nerdtree config
if ! &diff
        autocmd StdinReadPre * let s:std_in=1
        autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
        autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | wincmd p | ene | exe 'NERDTree' argv()[0] | endif

        augroup NERD
                au!
                autocmd VimEnter * NERDTree
                autocmd VimEnter * wincmd p
        augroup END

        let g:NERDTreeChDirMode=2
        let g:NERDTreeShowHidden=1
endif



" gitgutter config
let g:gitgutter_enabled = 1
let g:gitgutter_signs = 1
let g:gitgutter_highlight_lines = 1
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1



" tagbar config
if ! &diff
        autocmd FileType * nested :call tagbar#autoopen(0)
        autocmd BufEnter * nested :call tagbar#autoopen(0)
endif



" syntastic config
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0



" ctrlp config
let g:ctrlp_working_path_mode = 'a'
