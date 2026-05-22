{
  config,
  pkgs,
  _utils,
  ...
}:
let
  secrets = _utils.setupSecrets config {
    secrets = [
      "networks"
    ];
  };

  ipv4 = {
    method = "auto";
  };
  ipv6 = {
    addr-gen-mode = "default";
    method = "auto";
  };

in
{
  imports = [
    secrets.generate
  ];
  networking.networkmanager.ensureProfiles = {
    environmentFiles = [
      "${secrets.get "networks"}"
    ];
    profiles =
      let
        mkWifi = name: args: {
          ${name} = {
            connection = {
              id = name;
              # uuid = "4da44d32-bd84-4e91-9f7b-649567c0bced";
              type = "wifi";
              permissions = "";
            };
            wifi = {
              mode = "infrastructure";
              ssid = name;
            };
            wifi-security = {
              key-mgmt = "wpa-psk";
              psk = if (args.password or "") != "" then args.password else "\$${name}_password";
            };
            inherit ipv4 ipv6;
          };
        };
      in
      mkWifi "qOnyx" {} //
      {
        eduroam = {
          connection = {
            id = "eduroam";
            type = "wifi";
          };
          wifi = {
            mode = "infrastructure";
            ssid = "eduroam";
          };
          wifi-security = {
            key-mgmt = "wpa-eap";
          };
          "802-1x" = {
            eap = "peap;";
            identity = "$eduroam_user";
            password = "$eduroam_password";
            phase2-auth = "mschapv2";
          };
          inherit ipv4 ipv6;
        };
      };
  };
}
