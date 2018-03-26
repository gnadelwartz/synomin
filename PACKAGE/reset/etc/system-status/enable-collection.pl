#!/opt/bin/perl
open(CONF, "/var/packages/webmin/target/etc/miniserv.conf") || die "Failed to open /var/packages/webmin/target/etc/miniserv.conf : $!";
while(<CONF>) {
        $root = $1 if (/^root=(.*)/);
        }
close(CONF);
$root || die "No root= line found in /var/packages/webmin/target/etc/miniserv.conf";
$ENV{'PERLLIB'} = "$root";
$ENV{'WEBMIN_CONFIG'} = "/var/packages/webmin/target/etc";
$ENV{'WEBMIN_VAR'} = "/var/log/webmin";
chdir("$root/system-status");
exec("$root/system-status/enable-collection.pl", @ARGV) || die "Failed to run $root/system-status/enable-collection.pl : $!";
