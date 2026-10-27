{ inputs, pkgs, lib, ... }: pkgs.stdenvNoCC.mkDerivation (let
	runtimeLibs = with pkgs; [ libX11 webkitgtk_6_0 gtk4 libsoup_3 glib ];
in {
	name = "gotohp";
	src = inputs.gotohp;

	nativeBuildInputs = with pkgs; [ dpkg patchelf autoPatchelfHook ];
	buildInputs = runtimeLibs;

	unpackPhase = ''
		dpkg --extract -- $src ./tree/
		cd ./tree/usr/
	'';

	installPhase = ''
		${lib.getExe' pkgs.coreutils "mkdir"} --parents -- $out/
		${lib.getExe' pkgs.coreutils "mv"} -- ./local/bin/ ./share/ $out/

		patchelf --set-rpath "${lib.makeLibraryPath runtimeLibs}" $out/bin/gotohp # Work around a patchelf 0.19.2 regression. autoPatchelfHook first sets the interpreter and then the RUNPATH; on this Go binary the second rewrite leaves the PHDR outside of any LOAD segment, which makes the kernel/dynamic loader segfault before main() runs. Doing the RUNPATH rewrite first produces a valid layout, and the hook can then safely refresh it.
	'';

	meta = {
		description = "Unofficial Google Photos Desktop GUI Client";
		homepage = "https://github.com/xob0t/gotohp";
		license = lib.licenses.mit;
		mainProgram = "gotohp";
	};
})		 
