{ lib, ... }@args :
let
  moduleDir = ./.;
  filesToImport = builtins.readDir moduleDir;
  importFile = name: type:
    if type == "regular" && lib.hasSuffix ".nix" name && name != "default.nix" then
      import (moduleDir + "/${name}") args
    else
      null;
in {
  imports =  lib.filter (x: x != null) (lib.mapAttrsToList importFile filesToImport);
}
