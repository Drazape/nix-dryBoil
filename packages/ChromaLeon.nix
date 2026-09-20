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

	fixupPhase = let chromaleon-preload = pkgs.stdenv.mkDerivation {
			name = "chromaleon-preload";
			src = inputs.chromaleon-preload;

			nativeBuildInputs = [pkgs.pkg-config];
			buildInputs = [pkgs.buildPackages.glib];

			installPhase = ''
				gcc -O3 -fPIC -shared chromaleon-preload.c -o libchromaleon.so $(pkg-config --cflags --libs gio-2.0 glib-2.0) -ldl
				${lib.meta.getExe' pkgs.coreutils "mkdir"} --parents -- $out/lib/
				${lib.meta.getExe' pkgs.coreutils "mv"} -- ./libchromaleon.so $out/lib/
			'';
		};
		in ''
			substituteInPlace $install_path/utils/recolorUtils.js \
				--replace-warn '/usr/share/icons/' '/run/current-system/sw/share/icons/'
			substituteInPlace $install_path/ui/preloadPage.js \
				--replace-warn $\{GLib.get_home_dir\(\)}/.local/lib/libchromaleon.so ${chromaleon-preload}/lib/libchromaleon.so
		'';

	meta = {
		description = "Change your GNOME Shell and GTK accent colors dynamically based on your wallpaper";
		homepage = "https://github.com/Fabito02/ChromaLeon";
		license = lib.licenses.gpl3;
		platforms = lib.platforms.linux;
	};
}		 
