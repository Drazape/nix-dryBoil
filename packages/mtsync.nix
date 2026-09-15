{ inputs, pkgs, lib, ... }: pkgs.stdenvNoCC.mkDerivation {
	name = "mtsync";
	src = inputs.mtsync;
	
	nativeBuildInputs = with pkgs; [ dpkg autoPatchelfHook makeWrapper ];
	buildInputs = with pkgs; [ gtkmm4 libadwaita libsoup_3 glib cairo stdenvNoCC.cc.cc.lib ];
	
	unpackPhase = ''
		dpkg --extract -- $src ./tree/
		cd ./tree/usr/
	'';
	
	installPhase = ''
		mkdir -p $out/
		mv ./bin/ ./share/ $out/
	'';

	postInstall = ''wrapProgram $out/bin/mtsync --prefix PATH : ${pkgs.rclone}/bin'';

	meta = {
		description = "A Gnome frontend to rclone to (auto)mount and sync your data";
		homepage = "https://github.com/gavindi/mtsync";
		license = lib.licenses.gpl2;
		mainProgram = "mtsync";
	};
}		 
