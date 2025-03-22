all:
	xstow --target=$$HOME --restow scripts/
	xstow --target=$$HOME --restow shared/

delete:
	xstow --target=$$HOME --delete scripts/
	xstow --target=$$HOME --delete shared/
