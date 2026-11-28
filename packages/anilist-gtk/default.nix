# abandonware
# functionality: viewing lists, changing episode progress
{ inputs, pkgs, lib, ... }: pkgs.stdenv.mkDerivation {
	name = "anilist-gtk";
	src = inputs.anilist-gtk;

	# Port the 2022 sources to libsoup 3 and the current libadwaita API.
	patches = [ ./revive.patch ];

	postPatch = ''
		# Cache updates are handled by the Nix build; the script also relies on
		# /usr/bin/env, which is unavailable in the build sandbox.
		substituteInPlace meson.build \
			--replace-fail "meson.add_install_script('build-aux/meson/postinstall.py')" ""
	'';

	nativeBuildInputs = with pkgs; [
		meson
		ninja
		pkg-config
		vala
		gettext
		wrapGAppsHook4
	];

	preFixup = ''
		${lib.getExe' pkgs.glib.dev "glib-compile-schemas"} \
			$out/share/gsettings-schemas/$name/glib-2.0/schemas
	'';

	buildInputs = with pkgs; [
		glib
		gtk4
		libadwaita
		libsecret
		json-glib
		libgee
		libsoup_3
	];

	meta = {
		description = "A native desktop client for AniList";
		homepage = "https://github.com/lunananananananana/AniList-GTK";
		license = lib.licenses.gpl3Plus;
		mainProgram = "ch.laurinneff.AniList-GTK";
		platforms = lib.platforms.linux;
	};
}
