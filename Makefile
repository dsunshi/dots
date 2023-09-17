all:
	stow --verbose --no-folding --target=$$HOME --restow . 2>&1 | grep -v "BUG in find_stowed_path"

clean:
	stow --verbose --target=$$HOME --delete . 2>&1 | grep -v "BUG in find_stowed_path"

install: .local/scripts/pier.service .local/scripts/pier.timer .local/scripts/xsession.target
	cp .local/scripts/pier.service /etc/systemd/user/
	cp .local/scripts/pier.timer /etc/systemd/user/
	cp .local/scripts/xsession.target /etc/systemd/user/

enable:
	systemctl --user enable pier.service
	systemctl --user enable xsession.target
	systemctl --user enable pier.timer
	systemctl --user start xsession.target
	systemctl --user start pier.service
	systemctl --user start pier.timer

uninstall:
	systemctl --user stop pier.timer
	systemctl --user stop pier.service
	systemctl --user stop xsession.target
	systemctl --user disable pier.timer
	systemctl --user disable pier.service
	systemctl --user disable xsession.target
