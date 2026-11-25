dryBoil mono-repo with practical packages and modules

> [!NOTE]
> The repository is currently in alpha

# Installation Instructions
## 1. Add input
Add `dryboil` as an input to your `flake.nix`
```nix
inputs = {
	…
	dryboil = {
		type="github"; owner="drazape"; repo="dryBoil";
		ref = "alpha"; # most up-to-date packages
		inputs.nixpkgs.follows = "nixpkgs"; # optional
	};
	…
};
…
```

## 2. Install package
Simply install the package you want to install in your system environment from the added input in a module
```nix
environment.systemPackages = [
	…
	inputs.dryboil.packages.${pkgs.stdenvNoCC.hostPlatform.system}.<packageName>
	…
];
```

> [!TIP]
> See a package's Readme for special instructions, and refer [package names from the flake](./flake.nix#L99)
