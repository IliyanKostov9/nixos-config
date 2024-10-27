{ ... }:

{
  systemd.sleep.extraConfig = ''
    AllowSuspend=yes
    AllowHibernation=yes
    AllowHybridSleep=yes
    AllowSuspendThenHibernate=yes

    HibernateDelaySec=1h
    IdleAction=suspend
    IdleActionSec=10m
  '';
}
