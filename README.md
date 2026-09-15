dryBoil mono-repo with practical packages and modules

# Installation Instructions
1. Add the input to your `flake.nix`
```nix
inputs = {
	…
	dryboil = {
		type="github"; owner="drazape"; repo="dryBoil";
		inputs.nixpkgs.follows = "nixpkgs"; # optional
	};
	…
};
…
```

2. Simply install the package you want to install in your system environment from the added input in a module.
```nix
environment.systemPackages = [
	…
	inputs.dryboil.packages.${pkgs.stdenvNoCC.hostPlatform.system}.<packageName>
	…
];
```


