{ inputs, pkgs, lib, ... }: pkgs.stdenvNoCC.mkDerivation {
	name = "gotohp";
	src = inputs.gotohp;

	nativeBuildInputs = with pkgs; [ dpkg autoPatchelfHook ];
	buildInputs = with pkgs; [ libX11 webkitgtk_6_0 gtk4 libsoup_3 glib ];

	unpackPhase = ''
		dpkg --extract -- $src ./tree/
		cd ./tree/usr/
	'';

	installPhase = ''
		${lib.getExe' pkgs.coreutils "mkdir"} --parents -- $out/
		${lib.getExe' pkgs.coreutils "mv"} -- ./local/bin/ ./share/ $out/
	'';

	meta = {
		description = "Unofficial Google Photos Desktop GUI Client";
		homepage = "https://github.com/xob0t/gotohp";
		license = lib.licenses.mit;
		mainProgram = "gotohp";
	};
}		 
