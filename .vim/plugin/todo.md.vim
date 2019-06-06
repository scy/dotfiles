" Markdown-based to do list. It usually lives in ~/my/todo.md.

" Vim's Markdown filetype needs the g:markdown_folding variable to enable
" folding for Markdown at all. Also, we set the default folding level to 1,
" which will show status headings (like "To Do", "Doing" etc.) but fold the
" individual tasks.
augroup todo.md
	au!
	au BufReadPre **/my/todo.md let g:markdown_folding=1 | setl fdl=1
augroup end
