{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../common.nix
  ];

  hardware.opengl = {
    extraPackages = with pkgs; [
      vulkan-validation-layers
      libvdpau-va-gl
      nvidia-vaapi-driver
      vaapiVdpau
    ];
  };

  hardware.nvidia = {
    powerManagement.enable = true;
    open = false;
    nvidiaSettings = true;
    modesetting.enable = true;
    nvidiaPersistenced = true;
  };

  services.xserver = {
    videoDrivers = ["nvidia"];
  };

  hardware.enableAllFirmware = true;

  nixpkgs = {
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  nix = {
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
  };

  programs = {
    dconf.enable = true;
  };

  environment.systemPackages = with pkgs; [
    tpm2-tss
  ];

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    LIBVA_DRIVER_NAME = "nvidia";
  };

  hardware.i2c.enable = true;

  services.logind = {
    extraConfig = "HandlePowerKey=suspend";
  };

  console.useXkbConfig = true;

  networking.hostName = "Waverley";

  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/";
  #boot.supportedFilesystems = ["exfat" "xfs" "ntfs"];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.blacklistedKernelModules = ["nouveau"];

  # enable networking
  networking.networkmanager.wifi.backend = "iwd";

  # Set a time zone
  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  users.users.marcy = {
    isNormalUser = true;
    description = "marcy";
    extraGroups = ["networkmanager" "wheel" ];
    openssh.authorizedKeys.keys = [
      # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
    ];
  };

  services.pipewire = {
    extraConfig = {
      pipewire = {
        "10-clock-rate" = {
          "context.properties" = {
            "default.clock.rate" = 96000;
          };
        };
      };

      pipewire-pulse = {
        "11-pulse-clock-rate" = {
          "pulse.properties" = {
            "pulse.default.req" = "128/96000";
          };
        };
      };
    };
  };

  services.openssh = {
    enable = false;
    settings = {
      PermitRootLogin = "yes";
      PasswordAuthentication = true;
    };
  };
}
