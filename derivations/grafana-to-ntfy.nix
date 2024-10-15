{ openssl, pkg-config, lib, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "grafana-to-ntfy";
  version = "1143ef47eca9298fd100c3b6bf0caa93f134c07a";
  doCheck = false;

  src = fetchFromGitHub {
    owner = "kittyandrew";
    repo = pname;
    rev = version;
    sha256 = "sha256-YtE3DNrGDsRdUuSCOqaIn/eqGjJh4EdvVEcTFN+UJkA=";
  };

  cargoHash = "sha256-AXJZrpRZ8lpsy9pJMkPrlsmleqF+G5ao5FazgiQYKiQ=";
  nativeBuildInputs = [ pkg-config ]; 
  buildInputs = [ openssl ];

  meta = with lib; {
    description = "Grafana-to-ntfy (ntfy.sh) alerts channel";
    homepage = "https://github.com/kittyandrew/grafana-to-ntfy";
    license = licenses.agpl3Only;
    maintainers = [ "kittyandrew" ];
  };
}
