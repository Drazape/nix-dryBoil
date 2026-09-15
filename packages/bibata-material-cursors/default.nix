{
	inputs,
	pkgs,
	lib,
	variants ? [
		"Apricot"
		"Beige"
		"Blush"
		"Brown"
		"Charcoal"
		"Cloud"
		"Deep-Blue"
		"Grey"
		"Ice-Blue"
		"Lilac"
		"Lime"
		"Midnight"
		"Mint"
		"Moss"
		"Noir"
		"Peach"
		"Pink-Pastel"
		"Pink-Rose"
		"Sage"
		"Salmon"
		"Sand"
		"Seafoam"
		"Sky-Blue"
		"Slate"
		"Soft-Blue"
		"Sunset"
		"Teal"
		"Violet"
	],
	theme ? "Light",
	... }: pkgs.stdenvNoCC.mkDerivation {
		name = "bibata-material-cursors";
		src = inputs.${"bibata-material-cursors-"+theme};

		installPhase = ''
			install_path=$out/share/icons/
			${lib.getExe' pkgs.coreutils "mkdir"} --parents -- $install_path
			for variant in ${builtins.concatStringsSep " " variants}
				do ${lib.getExe' pkgs.coreutils "cp"} --recursive -- $src/Bibata-Material-$variant-${theme}/ $install_path
			done
		'';

		meta = {
			description = "28 Bibata cursor themes, colored using Material Design 3's tonal system";
			homepage = "https://github.com/SakibShahariar/bibata-material-cursors";
			license = lib.licenses.gpl3;
			platforms = lib.platforms.linux;
		};
}
