{ pkgs, lib, inputs, ... }: pkgs.stdenvNoCC.mkDerivation {
	name = "fish-hashmap";
	src = inputs.fish-hashmap;

	installPhase = ''
	  for component in functions completions
	  do ${lib.meta.getExe' pkgs.coreutils "install"} -D --mode=644 -- ./$component/hmap.fish $out/share/fish/vendor_"$component".d/hmap.fish
	  done
	'';

  meta = {
    description = "Hash maps for Fish with list values, reference semantics, and scoped lifetime.";
    homepage = "https://github.com/JoelTowell/hashmap.fish";
    license = lib.licenses.mit;
  };
}
