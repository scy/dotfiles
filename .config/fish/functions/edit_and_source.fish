function edit_and_source -d 'Edit a shell config file and then reload it'
	edit $argv[1]
	and source $argv[1]
end
