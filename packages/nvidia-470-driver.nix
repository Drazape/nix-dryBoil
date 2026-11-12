# GT 740 is Kepler: 470.256.02 is the last NVIDIA branch that supports it.
# `inputs.nvidia-470xx` (haxllo/nvidia-470xx-linux-7.0) carries the kernel-compatibility patch series for the 470 driver up to Linux 7.0. That repository does not ship the
# 7.2/7.3 fixes yet, so the remainder comes from joanbm/nvidia-470xx-linux-mainline
# (the same series nixpkgs' `legacy_470` is built from).
{ config, inputs, ... }: config.boot.kernelPackages.nvidiaPackages.mkDriver {
	version = "470.256.02";
	sha256_64bit = "sha256-1kUYYt62lbsER/O3zWJo9z6BFowQ4sEFl/8/oBNJsd4=";
	settingsSha256 = "sha256-kftQ4JB0iSlE8r/Ze/+UMnwLzn0nfQtqYXBj+t6Aguk=";
	persistencedSha256 = "sha256-iYoSib9VEdwjOPBP1+Hx5wCIMhW8q8cCHu9PULWfnyQ=";
	useSettings = false; # nvidia-settings 470 is a GTK2 application and GTK2 is marked broken (removal in NixOS 27.05).
	patches = builtins.map (patch: inputs.nvidia-470xx + "/${patch}.patch") [
		"0001-Fix-conftest-to-ignore-implicit-function-declaration"
		"0002-Fix-conftest-to-use-a-short-wchar_t"
		"0003-Fix-conftest-to-use-nv_drm_gem_vmap-which-has-the-se"
		"nvidia-470xx-fix-gcc-15"
		"kernel-6.10"
		"kernel-6.12"
		"nvidia-470xx-fix-linux-6.13"
		"nvidia-470xx-fix-linux-6.14"
		"nvidia-470xx-fix-linux-6.15"
		"nvidia-470xx-fix-linux-6.17"
		"nvidia-470xx-fix-linux-6.19-part1"
		"nvidia-470xx-fix-linux-6.19-part2"
		"nvidia-470xx-fix-linux-7.0-dma-fence"
	] ++ builtins.map (patch: inputs.nvidia-470xx-upstream-patches + "/patches/nvidia-470xx-fix-linux-${patch}.patch") [
		"7.2-part1"
		"7.2-part2"
		"7.2-part3"
		"7.3"
	];
	patchFlags = [ "-p1" "--directory=kernel" ];
}
