all: packer-update
	stow --verbose --no-folding --target=$$HOME --restow . 2>&1 | grep -v "BUG in find_stowed_path"

PACKER = ~/.local/share/nvim/site/pack/packer/start/packer.nvim
$(PACKER):
	git clone --depth 1 https://github.com/wbthomason/packer.nvim $@

.PHONY: packer-update
packer-update: $(PACKER)
	@cd $(PACKER) && git pull

clean:
	stow --verbose --target=$$HOME --delete . 2>&1 | grep -v "BUG in find_stowed_path"


