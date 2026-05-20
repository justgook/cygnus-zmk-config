## Dactyl Cygnus

### A 36 keys handwired split keyboard.

### Build Details

Dactyl Cygnus is a handwired board originally designed by @juhakaup and available at [https://github.com/juhakaup/keyboards](https://github.com/juhakaup/keyboards).

This is a wireless version of this keyboard targeting a nice!nano v1 (`nice_nano@1.0.0/nrf52840/zmk`). All build details can be found in the designer's page.

### Local Builds

With Nix installed, build both halves locally with:

```sh
nix develop -c make build
```

UF2 outputs are written under `build/cygnus_left/zephyr/zmk.uf2` and `build/cygnus_right/zephyr/zmk.uf2`.

### ZMK Studio

This board is compatible with [ZMK Studio](https://zmk.studio/). To live edit the keymap, connect the left side using a USB-C cable and follow the steps at https://zmk.studio.

![img](./img/cygnus.jpeg)
![img](./img/cygnus.svg)

## Resources

- [ZMK Docs](https://zmk.dev/docs)
- [Keyboard Tester](https://config.qmk.fm/#/test)
