# Bibata Material Cursors
## Package Overrides
### Theme Selection
You can select the theme the package installs (`Dark`, `Light`) using the `theme` override

**Default**: `Light`
```diff
- inputs.bibata-material-cursors.packages.${pkgs.stdenvNoCC.hostPlatform.system}.default
+ (inputs.bibata-material-cursors.packages.${pkgs.stdenvNoCC.hostPlatform.system}.default.override {theme="Dark";})
```
### Limiting Variants
By default, the package installs all the [cursor variants](https://github.com/SakibShahariar/material-bibata-cursor#themes "Preview of custom variants").  
You can select which cursor variants to install by specifying the [variant names](./default.nix#L10 "A list of variant names from the pkg source") with the override option `variants`.
```diff
- inputs.bibata-material-cursors.packages.${pkgs.stdenvNoCC.hostPlatform.system}.default
+ (inputs.bibata-material-cursors.packages.${pkgs.stdenvNoCC.hostPlatform.system}.default.override {variants=[<variant>…];})
```
### Rendering Format
You can specify the formats (`standard`, `hypr`) that are supported by the compositors that you use in the `format` override list.

**Default**: `standard`
```diff
- inputs.bibata-material-cursors.packages.${pkgs.stdenvNoCC.hostPlatform.system}.default
+ (inputs.bibata-material-cursors.packages.${pkgs.stdenvNoCC.hostPlatform.system}.default.override {format=[<format>…];})
```

## Internal Working
The flake gets the pre-build cursors from the release assets by using the URL in the `inputs`
