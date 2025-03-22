all:
	mkdir $$HOME/scripts
	xstow --verbose --target=$$HOME/scripts --restow scripts/

delete:
	xstow --verbose --target=$$HOME/scripts --delete scripts/
