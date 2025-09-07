with import <nixpkgs> {}; let
  python3Env = pkgs.python3.withPackages (ps:
    with ps; [
      black
      pip
      pylint
      virtualenv
    ]);
in
  pkgs.mkShell rec {
    buildInputs = [
      python3Env
    ];

    shellHook = ''
      virtualenv --no-wheel --no-setuptools venv
      source ./venv/bin/activate
      unset PYTHONPATH
    '';
  }
