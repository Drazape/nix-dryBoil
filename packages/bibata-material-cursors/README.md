# Bibata Material Cursors
The following sections describe package overrides and implementation details for [Bibata Material Cursor](https://github.com/SakibShahariar/material-bibata-cursor/)

## Package Overrides
| Name | Values | Default |
| :------: | :----: | :-----: |
| [`theme`](#Theme-Selection) | `Dark`, `Light` | `Light` |
| [`variants`](#Limiting-Variants) | see [definition][variants-definition] | all |
| [`format`](#Rendering-Format) | `standard`, `hypr` | `standard` |

### Theme Selection
You can select the theme the package installs (`Dark`, `Light`) using the `theme` override

**Default**: `Light`
```diff
- inputs.bibata-material-cursors.packages.${pkgs.stdenvNoCC.hostPlatform.system}.default
+ (inputs.bibata-material-cursors.packages.${pkgs.stdenvNoCC.hostPlatform.system}.default.override {theme="Dark";})
```
### Limiting Variants
By default, the package installs all the [cursor variants](https://github.com/SakibShahariar/material-bibata-cursor#themes "Preview of custom variants").  
You can select which cursor variants to install by specifying the [variant names][variants-definition] with the override option `variants`.

**Default**: all
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

> [!TIP]
> You can install multiple permutations of overrides by specifying the package multiple times with different overrides.

## Source
The package uses flake `inputs` to get the pre-build release assets from upstream


[variants-definition]: ./default.nix#L10 "A list of variant names from the pkg source"
