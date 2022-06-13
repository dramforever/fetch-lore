{ buildPackages, lib, runCommand, fetchpatch, fetchurl }:

{ messageId
, name ? messageId
, postFetch ? ""
, ...
} @ args:

assert !(args ? url);

let
  dummyFetchPatch = fetchpatch ({
    url = "file://${builtins.toFile "empty-file" ""}";
    hash = lib.fakeHash;
  } // builtins.removeAttrs args [
    "outputHash" "outputHashAlgo" "md5" "sha1" "sha256" "sha512" "recursiveHash"
    "messageId"
  ]);

  inherit (buildPackages) git b4;

in

fetchurl ({
  inherit name;
  url = "file://${builtins.toFile "empty-file" ""}";
  postFetch = ''
    PATH="$PATH:${lib.makeBinPath [ git b4 ]}" HOME=$TMPDIR \
      b4 am --no-cache -o - ${messageId} > $out

    ${dummyFetchPatch.postFetch}
  '';
} // builtins.removeAttrs args [
  "outputHash" "outputHashAlgo" "md5" "sha1" "sha256" "sha512" "recursiveHash"
  "messageId" "postFetch"
])
