" Markdown-based to do list. It usually lives in ~/my/todo.md.

" Insert a line with a (bold) timestamp above (where>0) or below (where<0) the
" current line. If the current line is non-empty, insert an empty line in
" between.
function! s:InsertTimestampLine(where)
	let l:notempty=!empty(getline("."))
	let l:content=strftime("**%Y-%m-%d %H:%M:** ")
	if a:where < 0
		if l:notempty
			normal O
		endif
		execute "normal O" . l:content
	else
		if l:notempty
			normal o
		endif
		execute "normal o" . l:content
	endif
	startinsert!
endfun

" Vim's Markdown filetype needs the g:markdown_folding variable to enable
" folding for Markdown at all. Also, we set the default folding level to 1,
" which will show status headings (like "To Do", "Doing" etc.) but fold the
" individual tasks.
augroup todo.md
	au!
	au BufReadPre **/my/todo.md let g:markdown_folding=1 | setl fdl=1
	au BufRead    **/my/todo.md nnoremap <buffer> <LocalLeader>o :call <SID>InsertTimestampLine(1)<CR>
	au BufRead    **/my/todo.md nnoremap <buffer> <LocalLeader>O :call <SID>InsertTimestampLine(-1)<CR>
augroup end
