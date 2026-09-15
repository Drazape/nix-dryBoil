{ inputs, pkgs, lib, ... }: pkgs.stdenvNoCC.mkDerivation {
	name = "mosaic-wm-gnome-extension";
	src = inputs.mosaic-wm;
	nativeBuildInputs = [pkgs.buildPackages.glib];

	buildPhase = ''
		glib-compile-schemas --strict ./extension/schemas/
	'';

	installPhase = ''
		install_path=$out/share/gnome-shell/extensions/mosaicwm@cleomenezesjr.github.io/
		${lib.getExe' pkgs.coreutils "mkdir"} --parents -- $install_path
		${lib.getExe' pkgs.coreutils "cp"} --recursive --no-target-directory -- ./extension/ $install_path
	'';

	meta = {
		description = "Rethinking window management for GNOME Shell";
		homepage = "https://github.com/CleoMenezesJr/MosaicWM";
		license = lib.licenses.gpl2;
		platforms = lib.platforms.linux;
	};
}		 
