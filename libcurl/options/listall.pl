#!/usr/bin/perl

my $opts_dir="/home/daniel/src/curl/docs/libcurl/opts";

opendir(my $dh, $opts_dir) || die "Can't opendir $opts_dir: $!";
my @pages = grep { /^CURLOPT_.*\.3\z/ && -f "$opts_dir/$_" } readdir($dh);
closedir $dh;

sub getdesc {
    my ($file)=@_;

    open(F, "$opts_dir/$file");
    my $mode = 0;
    my $opt = $file;
    my $desc;
    $opt =~ s/\.3\z//; # cut off ".3"
    while(<F>) {
        if(/^\.SH NAME/i) {
            $mode = 1;
        }
        if(($mode == 1) &&
           /^$opt \\- (.*)/) {
            $desc = $1;
            last;
        }
    }
    close(F);
    return $desc;
}

print "| Option | Purpose |\n".
    "|--------|---------|\n";

for my $p (sort @pages) {
    my $opt = $p;
    $opt =~ s/\.3\z//; # cut off ".3"
    printf "| %-35s | %s |\n", "`$opt`", getdesc($p);
}
