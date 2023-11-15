all:
	stow --verbose --no-folding --target=$$HOME --restow . 2>&1 | grep -v "BUG in find_stowed_path"

clean:
	stow --verbose --target=$$HOME --delete . 2>&1 | grep -v "BUG in find_stowed_path"


