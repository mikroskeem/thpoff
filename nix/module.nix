{ lib
, ...
}:

{
  config = {
    systemd.services.disable-thp = {
      enable = true;
      description = "Disable THP";
      serviceConfig.Type = "oneshot";
      serviceConfig.RemainAfterExit = true;
      script = ''
        echo never > /sys/kernel/mm/transparent_hugepage/enabled
        echo never > /sys/kernel/mm/transparent_hugepage/defrag
      '';
      wantedBy = [ "basic.target" ];
    };
  };
}
