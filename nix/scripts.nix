{pkgs}: let
  mkScript = name: text: (pkgs.writeShellScriptBin name text);

  attrs_to_list = attrs: let
    names = builtins.attrNames attrs;
    values = map (name: builtins.getAttr name attrs) names;
    size = builtins.length names;
  in
  builtins.genList (i: {
      name = (builtins.elemAt names i);
      value = (builtins.elemAt values i);
    }) size;

  gen_cmds = file: let
      icon_map_list = attrs_to_list (fromTOML (builtins.readFile file));
    in (map (icon: "mkicon '${icon.value}' ${icon.name}") icon_map_list);

  shellScripts = [
    (mkScript "mkicon" ''
      magick -background none \
        $1 \
        -trim \
        -resize 64x64 \
        -gravity center \
        -extent 64x64 \
        -depth 8 \
        icons/$2.png
    '')
    # `-resize 64x64` preserves aspect ratio. So a 512x256 image will be 64x32
    # `extent 64x64` will add whitespace to pad to 64x64.
    # `-depth 8` force a depth of 8 bits as grub has issues displaying 16 bit
    
    # We're using 64x64, cause grub does weird things to display detailed, low resolution PNGs.
    # The icons would get distorted and streched.

    (mkScript "mk-all-icons" (builtins.concatStringsSep "\n" (gen_cmds ../icons.toml)))
  ];
in
  shellScripts