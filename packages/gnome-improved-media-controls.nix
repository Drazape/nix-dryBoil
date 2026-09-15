{ inputs, pkgs, lib, ... }: pkgs.stdenvNoCC.mkDerivation {
	name = "gnome-improved-media-controls";
	src = inputs.gnome-improved-media-controls;
	nativeBuildInputs = [pkgs.buildPackages.glib];

	configurePhase = ''
		substituteInPlace ./Makefile \
			--replace-fail '$(HOME)/.local' "$out"
	'';

	meta = {
		description = "GNOME Shell extension that extends the native MPRIS implementation ";
		homepage = "https://github.com/m-obeid/gnome-improved-media-controls";
		license = lib.licenses.mit;
		platforms = lib.platforms.linux;
	};
}		 
