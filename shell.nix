let
    name = "d8268e24-8963-4621-ba81-33615c57c983";
    pkgs = import <nixpkgs> {};
    venv = "~/.local/nix-shells/${name}/venv";
in (pkgs.mkShell rec {
    inherit name;
    buildInputs = with pkgs; [ python310 gcc ];
    nativeBuildInputs = buildInputs;
    shellHook = ''
        python3 -m venv ${venv}
        source ${venv}/bin/activate
        pip install --upgrade pip || :
        pip install . \
                    coconut \
                    cytoolz \
                    xonsh || :
        exec xonsh
    '';
})
