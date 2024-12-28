{
  lib,
  fetchFromGitHub,
  buildGoModule,
  fetchpatch,
}:

buildGoModule rec {
  pname = "gost";
  version = "v3.0.0-nightly.20241227";

  src = fetchFromGitHub {
    owner = "go-gost";
    repo = "gost";
    rev = "2a9b7e7d9b98d2c968db9c4dec3fd4bea4e40de8";
    sha256 = "sha256-sIMGgzR7TvF/T2nZ21cfjU+rPa4v/JL8X1q7tYYtVY0=";
  };

  vendorHash = "sha256-lzyr6Q8yXsuer6dRUlwHEeBewjwGxDslueuvIiZUW70=";

  meta = with lib; {
    description = "Simple tunnel written in golang";
    homepage = "https://github.com/go-gost/gost";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    mainProgram = "gost";
  };
}
