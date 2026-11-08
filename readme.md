# Space Grub Theme 🛰️

A sleek space theme for grub.

![Preview](./preview.png)

- Background image: [NASA](https://www.flickr.com/photos/nasacommons/54678083846/)
- Font: [Hack](https://github.com/source-foundry/hack)
- Icons:
  - [NixOS](https://brand.nixos.org/logos/nixos-logomark-rainbow-flat-recommended.svg)
  - [UEFI](https://upload.wikimedia.org/wikipedia/commons/8/89/Logo_of_the_UEFI_Forum.svg)
  - [Windows](https://upload.wikimedia.org/wikipedia/commons/0/0a/Unofficial_Windows_logo_variant_-_2002%E2%80%932012_%28Multicolored%29.svg)

## Development
Preview with:
```shell
nix develop # open nix shell

uv tool run --from grub2-theme-preview grub2-theme-preview ./. --verbose --resolution 1920x1080
```

Convert `.ttf` to `.pf2` with:
```shell
grub-mkfont -o Hack-14.pf2 -s 14 ttf/Hack-Regular.ttf
```

Convert `.svg` to `.png` with [ImageMagick](https://github.com/imagemagick/imagemagick):
```shell
magick -background none 'https://brand.nixos.org/logos/nixos-logomark-rainbow-flat-recommended.svg' -trim -resize 16x16 -gravity center -extent 16x16 icons/nixos.png
```
- `-resize 16x16` preserves aspect ratio. So a 64x32 image will be 16x8.
- `-gravity center -extent 16x16` will add whitespace to pad to 16x16.