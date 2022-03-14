{ stdenv
, lib
, fetchurl
, rev ? "dirty"
}:

stdenv.mkDerivation {
  pname = "thpoff";
  version = rev;

  src = ./thpoff.c;

  dontUnpack = true;
  dontConfigure = true;

  buildPhase = ''
    runHook preBuild

    cc -o thpoff $src

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    install -D -m 755 thpoff $out/bin/thpoff

    runHook postInstall
  '';

  meta = with lib; {
    platforms = platforms.linux;
  };
}
