{
	description = "Bevy Pong";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		utils.url = "github:numtide/flake-utils";
	};

	outputs = { self, nixpkgs, utils }:
	utils.lib.eachDefaultSystem(system:
		let
			pkgs = nixpkgs.legacyPackages.${system};
		in {
			devShells.default = pkgs.mkShell {
				buildInputs = [
					pkgs.cargo
					pkgs.rustc
					pkgs.rust-analyzer
					pkgs.rustfmt
					pkgs.cmake
				];
				nativeBuildInputs = [
					pkgs.pkg-config
					pkgs.fontconfig
					pkgs.libGL
					pkgs.xorg.libX11
					pkgs.xorg.libXcursor
					pkgs.xorg.libXrandr
					pkgs.xorg.libXi
					pkgs.libudev-zero
				];
				shellHook = ''
					export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${
						pkgs.lib.makeLibraryPath [
							pkgs.udev
							pkgs.libGL
						]
					}"
				'';
			};
		}
	);
}
