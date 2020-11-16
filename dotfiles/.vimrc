set encoding=utf-8
" installed plugins
" - https://github.com/preservim/nerdtree
" - https://github.com/python-mode/python-mode
" - https://github.com/ycm-core/YouCompleteMe
" - https://github.com/kamykn/spelunker.vim
" - https://github.com/fatih/vim-go
" - https://github.com/tomlion/vim-solidity

filetype plugin indent on    " required
"set mouse=a

syntax on
set background=dark " better contrasts on dark screens
set number " display line numbers

" Spell checking configuration
set spelllang=en_us
set nospell
" Enable spelunker.vim. (default: 1)
" 1: enable
" 0: disable
let g:enable_spelunker_vim = 1

" Enable spelunker.vim on readonly files or buffer. (default: 0)
" 1: enable
" 0: disable
let g:enable_spelunker_vim_on_readonly = 0

" Check spelling for words longer than set characters. (default: 4)
let g:spelunker_target_min_char_len = 4

" Max amount of word suggestions. (default: 15)
let g:spelunker_max_suggest_words = 15

" Max amount of highlighted words in buffer. (default: 100)
let g:spelunker_max_hi_words_each_buf = 100

" Spellcheck type: (default: 1)
" 1: File is checked for spelling mistakes when opening and saving. This
" may take a bit of time on large files.
" 2: Spellcheck displayed words in buffer. Fast and dynamic. The waiting time
" depends on the setting of CursorHold `set updatetime=1000`.
let g:spelunker_check_type = 2

" Highlight type: (default: 1)
" 1: Highlight all types (SpellBad, SpellCap, SpellRare, SpellLocal).
" 2: Highlight only SpellBad.
" FYI: https://vim-jp.org/vimdoc-en/spell.html#spell-quickstart
let g:spelunker_highlight_type = 1

" Option to disable word checking.
" Disable URI checking. (default: 0)
let g:spelunker_disable_uri_checking = 1

" Disable email-like words checking. (default: 0)
let g:spelunker_disable_email_checking = 1

" Disable account name checking, e.g. @foobar, foobar@. (default: 0)
" NOTE: Spell checking is also disabled for JAVA annotations.
let g:spelunker_disable_account_name_checking = 1

" Disable acronym checking. (default: 0)
let g:spelunker_disable_acronym_checking = 1

" Disable checking words in backtick/backquote. (default: 0)
let g:spelunker_disable_backquoted_checking = 1

" Disable default autogroup. (default: 0)
let g:spelunker_disable_auto_group = 1

" Create own custom autogroup to enable spelunker.vim for specific filetypes.
augroup spelunker
  autocmd!
  " Setting for g:spelunker_check_type = 1:
  autocmd BufWinEnter,BufWritePost *.vim,*.js,*.jsx,*.json,*.md,*.py,*.htm,*.html call spelunker#check()

  " Setting for g:spelunker_check_type = 2:
  autocmd CursorHold *.vim,*.js,*.jsx,*.json,*.md,*.py,*.htm,*.html call spelunker#check_displayed_words()
augroup END

" Override highlight group name of incorrectly spelled words. (default:
" 'SpelunkerSpellBad')
let g:spelunker_spell_bad_group = 'SpelunkerSpellBad'

" Override highlight group name of complex or compound words. (default:
" 'SpelunkerComplexOrCompoundWord')
let g:spelunker_complex_or_compound_word_group = 'SpelunkerComplexOrCompoundWord'

" Override highlight setting.
highlight SpelunkerSpellBad cterm=underline ctermfg=247 gui=underline guifg=#9e9e9e
highlight SpelunkerComplexOrCompoundWord cterm=underline ctermfg=NONE gui=underline guifg=NONE 
" User Whitelist
let g:spelunker_white_list_for_user = ['django', 'queryset']


" Go fmt
autocmd  BufWritePost *.go !gofmt -w <afile> | edit

let g:localvimrc_ask = 0

"" for Python
" Make Vim detect Pipenv based Python environment
" https://duseev.com/articles/vim-python-pipenv/
let pipenv_venv_path = system('pipenv --venv')
if shell_error == 0
	" run pep8 and isort on save
	autocmd  BufWritePost *.py !pipenv run sh -c 'autopep8 --max-line-length=119 --in-place <afile>; isort <afile>;' | edit
else
	" run pep8 and isort on save
	autocmd  BufWritePost *.py !autopep8 --max-line-length=119 --in-place <afile> | !isort <afile> | edit
endif
"au FileType py
"    \ setlocal tabstop=8 softtabstop=4 shiftwidth=4 textwidth=119 expandtab autoindenti fileformat=unix

" YCM config
let g:ycm_confirm_extra_conf = 0
map <Leader>g :YcmCompleter GoTo<CR>
map <Leader>n :YcmCompleter GoToReferences<CR>
map <Leader>e :YcmCompleter GoToDeclaration<CR>
map <Leader>f :YcmCompleter GoToDefinition<CR>
map <Leader>d :YcmCompleter GetDoc<CR>
map <Leader>t :YcmCompleter GeType<CR>

" python-mode
" Turn on the whole plugin
let g:pymode = 1
" Turn off plugin's warnings
let g:pymode_warnings = 1
" Value is list of path's strings
let g:pymode_paths = []
" Trim unused white spaces on save
let g:pymode_trim_whitespaces = 1
" Setup default python options
let g:pymode_options = 1
" Setup max line length
let g:pymode_options_max_line_length = 119
" Enable colorcolumn display at max_line_length
let g:pymode_options_colorcolumn = 1
" Setup pymode |quickfix| window
let g:pymode_quickfix_minheight = 3
let g:pymode_quickfix_maxheight = 6
" Set pymode |preview| window height
let g:pymode_preview_height = &previewheight
" Set where pymode |preview| window will appear.
let g:pymode_preview_position = 'botright'
" Python version
let g:pymode_python = 'python3'
" Enable pymode indentation
let g:pymode_indent = 1
" Enable pymode folding (experemental, has issues)
let g:pymode_folding = 0
" Support Vim motion (See |operator|) for python objects (such as functions,
" class and methods).
"
" `C` — means class
" `M` — means method or function
" 
" ====  ============================
" Key   Command
" ====  ============================
" [[    Jump to previous class or function (normal, visual, operator modes)
" ]]    Jump to next class or function  (normal, visual, operator modes)
" [M    Jump to previous class or method (normal, visual, operator modes)
" ]M    Jump to next class or method (normal, visual, operator modes)
" aC    Select a class. Ex: vaC, daC, yaC, caC (normal, operator modes)
" iC    Select inner class. Ex: viC, diC, yiC, ciC (normal, operator modes)
" aM    Select a function or method. Ex: vaM, daM, yaM, caM (normal, operator
" modes)
" iM    Select inner function or method. Ex: viM, diM, yiM, ciM (normal,
" operator modes)
" ====  ============================
let g:pymode_motion = 1
" Show documentation
let g:pymode_doc = 1
let g:pymode_doc_bind = 'K'
" Support virtualenv
let g:pymode_virtualenv = 1
let g:pymode_virtualenv_path = $VIRTUAL_ENV
" Run code
let g:pymode_run = 1
let g:pymode_run_bind = '<leader>r'
" Breakpoints
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>b'
let g:pymode_breakpoint_cmd = '' " leave empty for auto detection
" Code checking
" Commands:
" *:PymodeLint* -- Check code in current buffer
" *:PymodeLintToggle* -- Toggle code checking
" *:PymodeLintAuto* -- Fix PEP8 errors in current buffer automatically
let g:pymode_lint = 1
" Check code on every save (if file has been modified)
let g:pymode_lint_on_write = 1
" Check code on every save (every)
let g:pymode_lint_unmodified = 0
" Check code when editing (on the fly)
let g:pymode_lint_on_fly = 0
" Show error message if cursor placed at the error line 
let g:pymode_lint_message = 1
" Default code checkers
let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'mccabe']
" Skip errors and warnings
let g:pymode_lint_ignore = [] " [\"E501\", \"W\",]
" Select some error or warnings
let g:pymode_lint_select = [] " [\"E501\", \"W0011\", \"W430\"]
" Sort errors by relevance
let g:pymode_lint_sort = ['E', 'C', 'I'] " errors first
" Auto open cwindow (quickfix) if any errors have been found
let g:pymode_lint_cwindow = 1
" Place error |signs|
let g:pymode_lint_signs = 1
" Definitions for |signs|
let g:pymode_lint_todo_symbol = 'WW'
let g:pymode_lint_comment_symbol = 'CC'
let g:pymode_lint_visual_symbol = 'RR'
let g:pymode_lint_error_symbol = 'EE'
let g:pymode_lint_info_symbol = 'II'
let g:pymode_lint_pyflakes_symbol = 'FF'
" Set code checkers options
" Set PEP8 options 
let g:pymode_lint_options_pep8 =
	\ {'max_line_length': g:pymode_options_max_line_length}
" Set Pyflakes options
let g:pymode_lint_options_pyflakes = { 'builtins': '_' }
" Set mccabe options
let g:pymode_lint_options_mccabe = { 'complexity': 12 }
" Set pep257 options
let g:pymode_lint_options_pep257 = {}
" Set pylint options
let g:pymode_lint_options_pylint =
	\ {'max-line-length': g:pymode_options_max_line_length}
" Rope support
" Commands:
" |:PymodeRopeAutoImport| -- Resolve import for element under cursor
" |:PymodeRopeModuleToPackage| -- Convert current module to package
" |:PymodeRopeNewProject| -- Open new Rope project in current working
" directory
" |:PymodeRopeRedo| -- Redo changes from last refactoring
" |:PymodeRopeRegenerate| -- Regenerate the project cache
" |:PymodeRopeRenameModule| -- Rename current module
" |:PymodeRopeUndo| -- Undo changes from last refactoring
let g:pymode_rope = 0
" *:PymodeRopeNewProject* [<path>] -- Open new Rope project in the given path
" *:PymodeRopeRegenerate* -- Regenerate the project cache
" Enable searching for |.ropeproject| in parent directories
let g:pymode_rope_lookup_project = 0
" You can also manually set the rope project directory. If not specified rope
" will
" use the current directory.
let g:pymode_rope_project_root = ""
let g:pymode_rope_ropefolder='.ropeproject'
" Show documentation for object under cursor
let g:pymode_rope_show_doc_bind = '<C-c>d'
" Regenerate project cache on every save (if file has been modified) (SLOW)
let g:pymode_rope_regenerate_on_write = 0
" Completion
"If there's only one complete item, vim may be inserting it automatically
"instead of using a popup menu. If the complete item which inserted is not
"your wanted, you can roll it back use '<c-w>' in |Insert| mode or setup
"'completeopt' with `menuone` and `noinsert` in your vimrc. .e.g.
set completeopt=menuone,noinsert
" Turn on code completion support in the plugin
let g:pymode_rope_completion = 0
" Turn on autocompletion when typing a period
let g:pymode_rope_complete_on_dot = 0
" Keymap for autocomplete
let g:pymode_rope_completion_bind = '<C-Space>'
" Extended autocompletion (rope could complete objects which have not been
" imported) from project
let g:pymode_rope_autoimport = 0
" Load modules to autoimport by defaul
let g:pymode_rope_autoimport_modules = [] "['os', 'shutil', 'datetime']
"Offer to unresolved import object after completion
let g:pymode_rope_autoimport_import_after_complete = 0
" Find definition
let g:pymode_rope_goto_definition_bind = '<C-c>g'
" Command for open window when definition has been found
let g:pymode_rope_goto_definition_cmd = 'new'
" Refactoring
" Keymap for rename method/function/class/variables under cursor
let g:pymode_rope_rename_bind = '<C-c>rr'
" *:PymodeRopeRenameModule* -- Rename current module
" Keymap for rename current modul
let g:pymode_rope_rename_module_bind = '<C-c>r1r'
" Imports ~
"
" *:PymodeRopeAutoImport* -- Resolve import for element under cursor
let g:pymode_rope_organize_imports_bind = '<C-c>ro'
" Insert import for current word under cursor
let g:pymode_rope_autoimport_bind = '<C-c>ra'
" Convert module to package ~
"
" *:PymodeRopeModuleToPackage* - convert current module to package
let g:pymode_rope_module_to_package_bind = '<C-c>r1p'
" Extract method/variable from selected lines
let g:pymode_rope_extract_method_bind = '<C-c>rm'
let g:pymode_rope_extract_variable_bind = '<C-c>rl'
" Use function - tries to find the places in which a function can be used and
" changes the
" code to call it instead
let g:pymode_rope_use_function_bind = '<C-c>ru'
" Move method/fields
let g:pymode_rope_move_bind = '<C-c>rv'
" Change function signature
let g:pymode_rope_change_signature_bind = '<C-c>rs'
" Undo/Redo change
" *:PymodeRopeUndo* -- Undo last changes in the project
" *:PymodeRopeRedo* -- Redo last changes in the project
" Syntix
" Turn on pymode syntax
let g:pymode_syntax = 1
" Slower syntax synchronization that is better at handling code blocks in
" docstrings. Consider disabling this on slower hardware
let g:pymode_syntax_slow_sync = 0
" Enable all python highlights
let g:pymode_syntax_all = 1
" Highlight "print" as a function
let g:pymode_syntax_print_as_function = 0
" Highlight "async/await" keywords
let g:pymode_syntax_highlight_async_await = g:pymode_syntax_all
" Highlight '=' operator 
let g:pymode_syntax_highlight_equal_operator = g:pymode_syntax_all
" Highlight 'self' keyword
let g:pymode_syntax_highlight_self = g:pymode_syntax_all
" Highlight indent's errors
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
" Highlight space's errors 
let g:pymode_syntax_space_errors = g:pymode_syntax_all
" Highlight string formatting
let g:pymode_syntax_string_formatting = g:pymode_syntax_all
let g:pymode_syntax_string_format = g:pymode_syntax_all
let g:pymode_syntax_string_templates = g:pymode_syntax_all
let g:pymode_syntax_doctests = g:pymode_syntax_all
" Highlight builtin objects (True, False, ...)
let g:pymode_syntax_builtin_objs = g:pymode_syntax_all
" Highlight exceptions (TypeError, ValueError, ...)
let g:pymode_syntax_highlight_exceptions = g:pymode_syntax_all
" Highlight docstrings as pythonDocstring (otherwise as pythonString)
let g:pymode_syntax_docstrings = g:pymode_syntax_all



" for web

au FileType js, jsx, html css
    \ setlocal tabstop=2 softtabstop=2i shiftwidth=2 

