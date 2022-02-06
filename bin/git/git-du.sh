for git_dir in $(find * -name ".git" -type d); do du -hs "$git_dir/objects/pack"; done
