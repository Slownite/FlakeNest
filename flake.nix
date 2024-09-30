{
  description = "My own collection of flake template";


  outputs = { self }: {
    templates = {
      python = {
        path = ./python;
        description = "a bare bone python project template using only nixpkgs";
      };
    };
      pythonPackage = {
        path = ./pythonPackage;
        description = "a bare bone python package template";
      };
  };
}
