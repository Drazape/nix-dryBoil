{
	description = "dryBoil mono-repo with practical packages and modules";

	inputs = {
		flake-parts = { type="github"; owner="hercules-ci"; repo="flake-parts"; };
		nixpkgs = { type="github"; owner="NixOS"; repo="nixpkgs"; ref="nixpkgs-unstable"; };

		chromaleon = {
			url = "https://github.com/Fabito02/ChromaLeon/releases/latest/download/user-accent-colors@fabito02.shell-extension.zip";
			flake = false;
		};
		mtsync = {
			url = "https://github.com/gavindi/MtSync/releases/download/0.9.17/mtsync_0.9.17_ubuntu26.04_x86_64.deb";
			flake = false;
		};
		gnome-improved-media-controls = {
			type="github"; owner="m-obeid"; repo="gnome-improved-media-controls";
			flake = false;
		};
		gotohp = {
			url = "https://github.com/xob0t/gotohp/releases/latest/download/gotohp_amd64.deb";
			flake = false;
		};
		mosaic-wm = {
			type="github"; owner="CleoMenezesJr"; repo="MosaicWM";
			flake = false;
		};

		bibata-material-cursors-Light = {
			url = "https://github.com/SakibShahariar/material-bibata-cursor/releases/download/v1.3.0/bibata-material-light-v1.3.0.tar.gz";
			flake = false;
		};
		bibata-material-cursors-Dark = {
			url = "https://github.com/SakibShahariar/material-bibata-cursor/releases/download/v1.3.0/bibata-material-dark-v1.3.0.tar.gz";
			flake = false;
		};

		fish-subAbbr = {
			type="github"; owner="Drazape"; repo="fish-subAbbr";
			inputs = {
				nixpkgs.follows = "nixpkgs";
				flake-parts.follows = "flake-parts";
				fish-helpText.follows = "fish-helpText";
				fish-format.follows = "fish-format";
			};
		};
		fish-nixenv = {
			type="github"; owner="Drazape"; repo="fish-nixenv";
			inputs = {
				nixpkgs.follows = "nixpkgs";
				flake-parts.follows = "flake-parts";
			};
		};
		fish-helpText = {
			type="github"; owner="Drazape"; repo="fish-helpText";
			inputs = {
				nixpkgs.follows = "nixpkgs";
				flake-parts.follows = "flake-parts";
			};
		};
		fish-format = {
			type="github"; owner="Drazape"; repo="fish-format";
			inputs = {
				nixpkgs.follows = "nixpkgs";
				flake-parts.follows = "flake-parts";
			};
		};
	};

	outputs = inputs@{ flake-parts, ... }:
		flake-parts.lib.mkFlake { inherit inputs; } {
			systems = ["x86_64-linux"];
			perSystem = { inputs', pkgs, lib, ... }: {
				packages =
					# defined
					(builtins.mapAttrs (name: value: lib.callPackageWith { inherit pkgs lib inputs; } value {}) {
						bibata-material-cursors = ./packages/bibata-material-cursors;
						chromaleon-gnome-extension = ./packages/ChromaLeon.nix;
						mtsync = ./packages/MtSync.nix;
						gnome-improved-media-controls = ./packages/gnome-improved-media-controls.nix;
						gotohp = ./packages/gotohp.nix;
						mosaic-wm-gnome-extension = ./packages/mosaic-wm.nix;
					})
					# external
					// {
						inherit (inputs'.fish-subAbbr.packages) fish-subAbbr;
						inherit (inputs'.fish-nixenv.packages) fish-nixenv;
						inherit (inputs'.fish-helpText.packages) fish-helpText;
						inherit (inputs'.fish-format.packages) fish-format;
					};
			};
		};
}		 
