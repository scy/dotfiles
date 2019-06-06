function! s:NewTimesheetEntry(followed_by, ...)
	let l:insertmode = get(a:, 1, 1)
	" Go to the end of the file, because that's the only place where
	" inserting a new timestamped item makes sense.
	normal G
	" Look backwards for a date.
	let l:dateline = search('\v^\d{4}-\d{2}-\d{2}:$', 'bcnw')
	" If there's none or it's not the current day, create one.
	if !l:dateline || getline(l:dateline) != strftime("%Y-%m-%d:")
		execute "normal o\n" . strftime("%Y-%m-%d:")
	endif
	" Insert the timestamp and start insert mode.
	execute "normal o" . strftime("%H%M") . a:followed_by
	if l:insertmode
		startinsert!
	endif
endfunction

" Some mappings to insert a timestamped new line.
nnoremap <buffer> <LocalLeader>n :call <SID>NewTimesheetEntry('  ')<CR>
nnoremap <buffer> <LocalLeader>s :call <SID>NewTimesheetEntry('.', 0)<CR>
nnoremap <buffer> <LocalLeader>c :call <SID>NewTimesheetEntry('^', 0)<CR>
