" When opening a help window, if the terminal is at least 160 columns wide,
" make it a vertical split instead of a horizontal one and limit the help size
" to 80 columns (which is the maximum text width in help files anyway). Also,
" take care to not change windows that were already open.
" Based loosely on <https://stackoverflow.com/q/630884/417040>.
autocmd! BufWinEnter <buffer>
	\ if !exists('w:moved')
	\ | let w:moved = 1
	\ | if &columns >= 160
		\ | wincmd L
		\ | vert res 80
		\ | endif
	\ | endif
