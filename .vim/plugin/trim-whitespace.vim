" Automatically trim whitespace on save.
" Based on Martin Tournoij’s Stack Exchange answer <https://vi.stackexchange.com/a/456>.

function! TrimWhitespace()
	" Filetypes for which to do nothing.
	if &filetype == 'diff'
		return
	endif

	let l:save = winsaveview()
	keeppatterns %s/\s\+$//e
	call winrestview(l:save)
endfun

command! TrimWhitespace call TrimWhitespace()

autocmd BufWritePre * :TrimWhitespace
