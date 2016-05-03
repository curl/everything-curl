#!/usr/bin/perl

# get all markdown files as arguments
my @files=@ARGV;

open(F, "<index-words") ||
    die "no words";
while(<F>) {
    chomp;
    my $w = $_;
    if($w =~ /[ .]/) {
        # word with spaces or periods
        push @lwords, $w;
    }
    $index{$w}=1;
}
close(F);

sub urlify {
    my ($fname, $section)=@_;

    $section =~ tr/[A-Z]/[a-z]/;

    # remove dashes amd slashes from like option names
    $section =~ s/^[-\.]+//g;

    # but replace spaces with dashes
    $section =~ s/ +/-/g;

    return "$fname#$section";
}

sub single {
    my ($fname)=@_;
    my $depth;
    my $section;
    my $url;

    open(F, "<$fname");
    while(<F>) {
        chomp;
        my $l=$_;
        if($_ =~ /^(#[\#]*) (.*)/) {
            $depth = $1;
            $section = $2;
            $url=urlify($fname, $section);
            # print "$fname / \"$2\"\n";

            $l = $section; # use this too
        }

        my @words = split(/[ \(\)]+/, $_);
        for my $w (@words) {
            $w =~ s/[,\.\`\']//g;
            if($index{$w}) {
                if(!$word{$w}{$url}) {
                    #print " $w ($url)\n";
                    $word{$w}{$url}++;
                    $all{$w} .= ($all{$w}?", ":"")."[$section]($url)";
                }
            }
        }
        # check longer words
        foreach my $w (@lwords) {
            if($l =~ /$w/) {
                if(!$word{$w}{$url}) {
                    #print " $w ($url)\n";
                    $word{$w}{$url}++;
                    $all{$w} .= ($all{$w}?", ":"")."[$section]($url)";
                }
            }
        }
    }
    close(F);
}

for my $f (@files) {
    single($f);
}

print "# Index\n\n";

sub sorting {
    my ($s) = @_;
    $s = uc($s); # first uppercase
    $s =~ s/^[-]+//; # remove initial junk
    return $s;
}

sub byname {
    return sorting($a) cmp sorting($b);
}

my %letter;

foreach my $w (sort byname keys %all) {
    my $l = substr(sorting($w), 0, 1);
    if(!$letter{$l}) {
        $letter{$l}++;
        print "## $l\n";
    }
    
    printf " - $w: ";
    print $all{$w}."\n";
}
