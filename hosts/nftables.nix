{ config, lib, ... }:

{
  networking.nftables.enable = true;

  networking.nftables.ruleset = ''
    table inet filter {
        chain input {
            type filter hook input priority 0; policy drop;

            # Allow loopback traffic
            iif lo accept

            # Allow established and related connections
            ct state established,related accept

            # Allow ICMP (ping) for diagnostics
            ip protocol icmp accept
            ip6 nexthdr icmpv6 accept

            # Allow SSH (rate-limited to prevent brute force attacks)
            tcp dport ssh ct state new limit rate 3/second accept

            # Allow HTTP/HTTPS for browsing and development
            tcp dport { 80, 443 } accept

            # Allow NTP (time synchronization)
            udp dport 123 accept

            # Allow DNS (name resolution)
            udp dport 53 accept
            tcp dport 53 accept
        }

        chain forward {
            type filter hook forward priority 0; policy drop;
        }

        chain output {
            type filter hook output priority 0; policy accept;
        }

       	# Logging chain for dropped packets
       	chain log_drop {
            limit rate 5/second log prefix "DROP: " group 0
            drop
        }
    }
  '';
}
