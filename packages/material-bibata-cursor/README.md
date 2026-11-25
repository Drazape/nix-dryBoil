# Material Bibata Cursor
The following sections describe package overrides and implementation details for [Bibata Material Cursor](https://github.com/SakibShahariar/material-bibata-cursor/)

> [!TIP]
> To install the package `material-bibata-cursor`, see [Installation Instructions](../../README.md#Installation-Instructions)

## Package Overrides
You can [override the package](https://ryantm.github.io/nixpkgs/using/overrides/) to customize the components that are installed.

| Name | Values | Default |
| :------: | :----: | :-----: |
| [`theme`](#Theme-Selection) | `Dark`, `Light` | `Light` |
| [`variants`](#Limiting-Variants) | see [definition][variants-definition] | all |
| [`formats`](#Rendering-Format) | `standard`, `hypr` | `standard` |

Example override usage:
```nix
environment.systemPackages = [
  …
  (inputs.dryboil.packages.${pkgs.stdenvNoCC.hostPlatform.system}.material-bibata-cursor.override {
      theme = "Dark";
      variants = ["Pink-Pastel"];
      formats = [ "standard" "hypr" ];
  })
  …
];
```

### Theme Selections
You can select the theme the package installs (`Dark`, `Light`) using the `theme` override

**Default**: `Light`
```nix
environment.systemPackages = [
  …
  (inputs.dryboil.packages.${pkgs.stdenvNoCC.hostPlatform.system}.material-bibata-cursor.override {
      theme = "Dark";
  })
  …
];
```
### Limiting Variants
By default, the package installs all the [cursor variants](https://github.com/SakibShahariar/material-bibata-cursor#themes "Preview of custom variants").  
You can select which cursor variants to install by specifying the [variant names][variants-definition] with the override option `variants`.

**Default**: all
```nix
environment.systemPackages = [
  …
  (inputs.dryboil.packages.${pkgs.stdenvNoCC.hostPlatform.system}.material-bibata-cursor.override {
      variants = [ "Deap-Blue" "Teal" ];
  })
  …
];
```
### Rendering Formats
You can specify the formats (`standard`, `hypr`) that are supported by the compositors that you use in the `format` override list.

**Default**: `standard`
```nix
environment.systemPackages = [
  …
  (inputs.dryboil.packages.${pkgs.stdenvNoCC.hostPlatform.system}.material-bibata-cursor.override {
      formats = ["hypr"];
  })
  …
];
```

> [!TIP]
> You can install multiple permutations of overrides by specifying the package multiple times with different overrides.

## Source
The package uses flake `inputs` to get the pre-build release assets from upstream


[variants-definition]: ./default.nix#L10 "A list of variant names from the pkg source"
