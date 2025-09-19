{lib, ...}: 
{
  # make a globals file
  options = {
    machine = {
      domain = lib.mkOption {
        type = lib.types.str;
        default = "spyral.me";
        description = "Local Homelab";
        # ${config.???.domain}
      };
      
    };
  };
}