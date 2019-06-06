" Based on :h last-position-jump, slightly improved
if has("autocmd")
	au BufReadPost *
	\ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
	\| exe "normal! g`\""
	\| endif
endif
