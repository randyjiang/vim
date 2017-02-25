
" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %
" forces Vim to source .vimrc file if it present in working directory, 
" thus providing a place to store project-specific configuration
set exrc

" Better copy & paste
" paste: stop doing autoident, make the paste behavior like clipbord paste
" When you want to paste large blocks of code into vim, press F2 before you
" paste. At the bottom you should see ``-- INSERT (paste) --``.
set pastetoggle=<F2>

" make the content of the copy in vim available in system clipbord
" won't work between a remote server and a local server
set clipboard=unnamed


" Mouse and backspace
set mouse=a  " enable using mouse in vim(on OSX press ALT and click)
set bs=2     " make backspace behave like normal again

" Real programmers don't use TABs but spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

" try to keep my lines 110 chars at most.  so I highlight column number 110 with color.
set colorcolumn=110
highlight ColorColumn ctermbg=darkgray

“ Show the command executing
set showcmd

" Rebind <Leader> key:
" I like to have it here because it is easier to reach than the default “\” and
" it is next to ``m`` and ``n`` which I use for navigating between tabs.
let mapleader = ","


" Bind nohl
" Removes highlight of your last search
" ``<C>`` stands for ``CTRL`` and therefore ``<C-n>`` stands for ``CTRL+n``
noremap <C-n> :nohl<CR>
vnoremap <C-n> :nohl<CR>
inoremap <C-n> :nohl<CR>


" Quicksave command
noremap <C-z> :update<CR>
vnoremap <C-z> <C-C>:update<CR>
inoremap <C-z> <C-O>:update<CR>


" Quick quit command
noremap <Leader>e :quit<CR>  " Quit current window
noremap <Leader>E :qa!<CR>   " Quit all windows


" bind Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w + <movement>
" Every unnecessary keystroke that can be saved is good for your health :)
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h


" easier moving between tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>


" map sort function to a key
vnoremap <Leader>s :sort<CR>


" easier moving of code blocks
" Try to go into visual mode (v), thenselect several lines of code here and
" then press ``>`` several times.
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation


" Show whitespace
" MUST be inserted BEFORE the colorscheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/


" Color scheme
" mkdir -p ~/.vim/colors && cd ~/.vim/colors
" wget -O wombat256mod.vim http://www.vim.org/scripts/download_script.php?src_id=13400
set t_Co=256
color wombat256mod


" Enable syntax highlighting
" You need to reload this file for the change to apply
filetype off
filetype plugin indent on
syntax on


" Showing line numbers and length
set number  " show line numbers
set tw=79   " width of document (used by gd)
set nowrap  " don't automatically wrap on load
set fo-=t   " don't automatically wrap text when typing
set colorcolumn=80
highlight ColorColumn ctermbg=233


" easier formatting of paragraphs
vmap Q gq
nmap Q gqap


" Useful settings
set history=700
set undolevels=700



" Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase


" Disable stupid backup and swap files - they trigger too many events
" for file system watchers
set nobackup
set nowritebackup
set noswapfile


“ ========== Plugin Management ===================
" Setup Pathogen to manage your plugins
" mkdir -p ~/.vim/autoload ~/.vim/bundle
" curl -so ~/.vim/autoload/pathogen.vim https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim
" Now you can install any plugin into a .vim/bundle/plugin-name/ folder, and they will be added to the 'runtimepath'. 
call pathogen#infect()


" ============================================================================
" Python IDE Setup
" ============================================================================


" vim-powerline:  Powerline is a utility plugin which allows you to create better-looking, more functional vim statuslines
" cd ~/.vim/bundle
" git clone git://github.com/Lokaltog/vim-powerline.git
 set laststatus=2


"  ctrlp:  Full path fuzzy file, buffer, mru, tag, ... finder for Vim
" cd ~/.vim/bundle
" git clone https://github.com/kien/ctrlp.vim.git
" Usage: file search
" CtrlP or :CtrlP [starting-directory] to invoke CtrlP in find file mode.
" CtrlPBuffer or :CtrlPMRU to invoke CtrlP in find buffer or find MRU file mode.
" CtrlPMixed to search in Files, Buffers and MRU files at the same time.
" <c-r> to switch to regexp mode.
" <c-j>, <c-k> or the arrow keys to navigate the result list.
" <c-t> or <c-v>, <c-x> to open the selected entry in a new tab or in a new split.
 let g:ctrlp_max_height = 30
 set wildignore+=*.pyc
 set wildignore+=*_build/*
 set wildignore+=*/coverage/*


" YouCompleteMe: a autocomplete engine for vim, supporting c,c++,python(using jedi)
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']
let g:ycm_confirm_extra_conf = 0
let g:ycm_complete_in_comments = 1
let g:ycm_always_populate_location_list = 1
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
inoremap <expr> <CR> pumvisible() ? '<C-y>' : '<CR>'
set completeopt = "menuone"
let g:ycm_add_preview_to_completeopt = 0
let g:syntastic_always_populate_loc_list = 1

