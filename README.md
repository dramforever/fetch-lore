# `fetch-lore`

## Nix Flake

This repository contains a Nix Flake. To use it, use the following Flake URL:

```plain
github:dramforever/fetch-lore
```

## Using `fetchPatchFromLore`

Fetch a patch or a patch series from <https://lore.kernel.org>, using the [b4] tool.

[b4]: https://git.kernel.org/pub/scm/utils/b4/b4.git/about/

Available as `legacyPackages.${system}.fetchPatchFromLore`, or after applying `overlays.default`.

```nix
fetchPatchFromLore {
  # Optional. If omitted, name will be based on messageId
  name = "test-patch";

  # Required. Message-Id of the patch or patch series found on lore.kernel.org
  messageId = "20200313231252.64999-1-keescook@chromium.org";

  # A hash is for network access when fetching patch. Other parameters like
  # sha256 are also supported.
  hash = "sha256-FddMrrGoi67IOQiZR+mKjiBK3jP7PkP8Ty3ai2INDp0=";

  # Other parameters to fetchpatch are supported
}
```
