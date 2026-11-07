# Space Grub Theme 🛰️

A sleek space theme for grub.

![Preview](./preview.png)

- Background image: [NASA](https://www.flickr.com/photos/nasacommons/54678083846/)
- Font: [Hack](https://github.com/source-foundry/hack)

## Development
Preview with
```shell
nix develop # open nix shell

uv tool run --from grub2-theme-preview grub2-theme-preview ./. --verbose --resolution 1920x1080
```

Convert `.ttf` to `.pf2` with
```shell
grub-mkfont -o Hack-14.pf2 -s 14 ttf/Hack-Regular.ttf
```