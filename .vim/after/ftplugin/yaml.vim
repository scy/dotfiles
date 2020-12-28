setlocal ai et pi ts=2 sts=2 sw=2

function! s:InsertTimestamp()
	let l:ai = &ai
	setlocal noai
	execute "normal o" . strftime("%Y-%m-%dT%H:%M%z") . ":\n\t"
	let &l:ai = l:ai
	startinsert!
endfunction

noremap <buffer> <LocalLeader>n :call <SID>InsertTimestamp()<CR>
noremap <buffer> <LocalLeader>N G:call <SID>InsertTimestamp()<CR>
