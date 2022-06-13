{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
  let
    generate = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
  in {
    overlays.default = final: prev: {
      fetchPatchFromLore =
        final.callPackage ./fetch-patch-from-lore.nix {};
    };

    legacyPackages = generate (system: {
      fetchPatchFromLore =
        nixpkgs.legacyPackages.${system}.callPackage
          ./fetch-patch-from-lore.nix {};
    });

    checks = generate (system: {
      # Example taken from b4 manpage
      test-patch = self.legacyPackages.${system}.fetchPatchFromLore {
        name = "test-patch";
        messageId = "20200313231252.64999-1-keescook@chromium.org";
        hash = "sha256-FddMrrGoi67IOQiZR+mKjiBK3jP7PkP8Ty3ai2INDp0=";
      };
    });
  };
}
