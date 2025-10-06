
- lib.mkMerge CPU section and GPU section
- add 

  options.machine = {
    cpu-amd = {
      enable = lib.mkEnableOption "";
    };
    cpu-intel = {
      enable = lib.mkEnableOption "";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.machine.cpu-amd.enable {

    })
    (lib.mkIf config.machine.cpu-intel.enable {

    })
  ];