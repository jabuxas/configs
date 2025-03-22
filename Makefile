all:
	xstow --target=$$HOME --restow shared/

delete:
	xstow --target=$$HOME --delete shared/
