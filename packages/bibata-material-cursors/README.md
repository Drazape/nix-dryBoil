# Bibata Material Cursors
## Package Overrides
### Theme Selection
You can select the theme the package installs (`Dark`, `Light`) using the `theme` override
> [!NOTE]
> **Default**: `Light`
```diff
- inputs.bibata-material-cursors.packages.${pkgs.stdenvNoCC.hostPlatform.system}.default
+ (inputs.bibata-material-cursors.packages.${pkgs.stdenvNoCC.hostPlatform.system}.default.override {theme="Dark";})
```
### Limiting Variants
By default, the package installs all the [cursor variants](https://github.com/SakibShahariar/material-bibata-cursor#themes "Preview of custom variants").  
You can select which cursor variants to install by specifying the [variant names](./pkg.nix#L6 "A list of variant names from the pkg source") with the override option `variants`  
```diff
- inputs.bibata-material-cursors.packages.${pkgs.stdenvNoCC.hostPlatform.system}.default
+ (inputs.bibata-material-cursors.packages.${pkgs.stdenvNoCC.hostPlatform.system}.default.override {variants=[<variants>];})
```

## Internal Working
The flake gets the pre-build cursors from the release assets by using the URL in the `inputs`
