{
  pkgs,
  lib,
  config,
  ...
}: {
  options.my.audio = {
    enable = lib.mkEnableOption "audio";
  };
  config = lib.mkIf config.my.audio.enable {
    # enable audio through pipewire
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
