{
	inputs,
	pkgs,
	lib,
	format ? ["standard"],
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

		configurePhase = builtins.concatStringsSep "\n" <| lib.attrsets.mapAttrsToList
				(formatName: fileNames: ''
						if ${if builtins.elem formatName format
								then "false"
								else "true"}
						then ${lib.meta.getExe' pkgs.coreutils "rm"} --recursive --force -- ./Bibata-Material-*-${theme}/{${builtins.concatStringsSep "," fileNames}}
						fi
					'')
				{
					standard = [ "cursors" "index.theme" ];
					hypr = [ "hyprcursors" "manifest.hl" ];
				};

		installPhase = ''
			install_path=$out/share/icons/
			${lib.meta.getExe' pkgs.coreutils "mkdir"} --parents -- $install_path
			for variant in ${builtins.concatStringsSep " " variants}
				do ${lib.meta.getExe' pkgs.coreutils "cp"} --recursive -- ./Bibata-Material-$variant-${theme}/ $install_path
			done
		'';

		meta = {
			description = "28 Bibata cursor themes, colored using Material Design 3's tonal system";
			homepage = "https://github.com/SakibShahariar/bibata-material-cursors";
			license = lib.licenses.gpl3;
			platforms = lib.platforms.linux;
		};
}
