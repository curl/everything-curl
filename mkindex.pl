#!/usr/bin/perl
# Build an index of words in the file index-words that are found in the text.
# Words are compared case insensitively except for those starting with a dash
# (i.e. program option names). "Words" may actually be phrases consisting of
# more than one word separated by a space. The word as written in the index is
# as found in the file (i.e. using that case).

use feature "fc";

# Return the case-folded keyword UNLESS it appears to be an option string
# in which case return it as-is. This makes word lookups case-insensitive
# but option name lookups case-sensitive.
sub folded {
    return $_[0] if $_[0] =~ /^-/;
    return fc($_[0]);
}

# get all markdown files as arguments
my @files=@ARGV;

open(F, "<index-words") ||
    die "no words";
while(<F>) {
    chomp;
    my $w = $_;
    if($w =~ /[ .]/) {
        # word with spaces or periods
        push @lwords, folded($w);
    }
    $index{folded($w)}=$w;
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
            $w = folded($w);
            if($index{$w}) {
                if(!$word{$w}{$url}) {
                    $word{$w}{$url}++;
                    $all{$w} .= ($all{$w}?", ":"")."[$section]($url)";
                }
            }
        }
        # check longer words
        foreach my $w (@lwords) {
            if(folded($l) =~ /$w/) {
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
    
    printf " - ".$index{$w}.": ";
    print $all{$w}."\n";
}
