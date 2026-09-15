{ inputs, pkgs, lib, ...}: pkgs.stdenvNoCC.mkDerivation {
	name = "chromaleon-gnome-extension";
	src = inputs.chromaleon;
	nativeBuildInputs = [pkgs.buildPackages.glib];

	buildPhase = ''
		glib-compile-schemas --strict ./schemas/
	'';

	installPhase = ''
		install_path=$out/share/gnome-shell/extensions/user-accent-colors@fabito02
		${lib.getExe' pkgs.coreutils "mkdir"} --parents -- $install_path
		${lib.getExe' pkgs.coreutils "cp"} --recursive --no-target-directory -- ./ $install_path
	'';

	fixupPhase = ''
		substituteInPlace $install_path/utils/recolorUtils.js \
			--replace-warn "/usr/share/icons/" "/run/current-system/sw/share/icons/"
	'';

	meta = {
		description = "Change your GNOME Shell and GTK accent colors dynamically based on your wallpaper";
		homepage = "https://github.com/Fabito02/ChromaLeon";
		license = lib.licenses.gpl3;
		platforms = lib.platforms.linux;
	};
}		 
