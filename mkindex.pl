#!/usr/bin/perl

# Words:
# cat *md | sed -e 's/[\.\[\]\(\)]/ /g' -e 's/ /\n/g' | sort | uniq -c | sort -rn | less

my %index=(
    '--location' => 1,
    'HttpGet' => 1,
    'etiquette' => 1,
    'bugreports' => 1,
    'testing' => 1,
    'snapshots' => 1,
    'releases' => 1,
    'contribute' => 1,
    'security' => 1,
    '-u' => 1,
    '-O' => 1,
    '-K' => 1,
    '--silent' => 1,
    'CURLOPT_VERBOSE' => 1);

# get all markdown files as arguments
my @files=@ARGV;

sub urlify {
    my ($fname, $section)=@_;

    $section =~ tr/[A-Z]/[a-z]/;

    # remove dashes from like option names
    $section =~ s/[-]//g;

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
        if($_ =~ /^(#[\#]*) (.*)/) {
            $depth = $1;
            $section = $2;
            $url=urlify($fname, $section);
            # print "$fname / \"$2\"\n";
        }
        else {
            chop;
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
                else  {
                    #print " $w\n";
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
