{config, pkgs, ...}:

{
    # btrbk service & timer
    systemd.services.btrbk-backup = {
        unitConfig.Description = "Run btrbk for system snapshots";
        serviceConfig.ExecStart = "/run/current-system/sw/bin/btrbk run";
    };

    systemd.timers.btrbk-backup = {
        unitConfig.Description = "Run btrbk snapshots hourly";
        wantedBy = ["timers.target"];
        timerConfig.OnCalendar = "hourly";
        timerConfig.Persistent = true;
    };

    #borg service & timer
    systemd.services.borg-backup = {
        unitConfig.Description = "Run Borg backup for /home";
        serviceConfig.ExecStart = "./scripts/home_int_backup.sh";
    };

    systemd.timers.borg-backup = {
        unitConfig.Description = "Run Borg backups daily";
        wantedBy = ["timers.target"];
        timerConfig.OnCalendar = "daily";
        timerConfig.Persistent = true;
    };
}
