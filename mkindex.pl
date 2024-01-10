#!/usr/bin/perl -w

# Build an index of words in the file index-words that are found in the text.
# Words are compared case insensitively except for those starting with a dash
# (i.e. program option names). "Words" may actually be phrases consisting of
# more than one word separated by a space. The word as written in the index is
# as found in the file (i.e. using that case).

use feature "fc";

# import shared function
use lib '.';
require "urlify.pl";

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


sub single {
    my ($fname)=@_;
    my $depth;
    my $section;
    my $url;
    my $in_code_section = 0;

    open(F, "<$fname");
    while(<F>) {
        chomp;
        my $l=$_;

        # Track whether we are within a markdown code block that begins/ends with ```
        if($_ =~ /^\`\`\`.*/) {
            if($in_code_section) {
                $in_code_section = 0;
            } else {
                $in_code_section = 1;
            }
        }

        if(!$in_code_section) {
            if($_ =~ /^(#[\#]*) ([^\{]*)(\{\#(.*)\})/) {
                # This section header has an explicit ID specified, e.g. "#Foo {#foo}"
                $depth = $1;
                $section = $2;
                my $dest_id=$4;
                # trim whitespace off end of section
                $section =~ s/\s+$//;

                $url = "$fname#$dest_id";

                # Use only the anchor text when a section heading has an anchor tag
                if($section =~ m/(.*)\[(.*)\]\(.*\).*/) {
                    $section = "$1$2";
                }
                $l = $section;
            }
            elsif($_ =~ /^(#[\#]*) (.*)/) {
                # This section header has no explicit ID specified, e.g. "#Foo"
                $depth = $1;
                $section = $2;

                # trim whitespace off end of section
                $section =~ s/\s+$//;

                my $url_section  = urlify($section);
                $url = "$fname#$url_section";

                # Use only the anchor text when a section heading has an anchor tag
                if($section =~ m/(.*)\[(.*)\]\(.*\).*/) {
                    $section = "$1$2";
                }

                $l = $section; # use this too
            }
        }

        my @words = split(/[ \(\)]+/, $_);
        for my $w (@words) {
            $w =~ s/[,\.\`\'\]\[]//g;
            $w = folded($w);
            if($index{$w}) {
                if(!$word{$w}{$fname}) {
                    $word{$w}{$fname}++;
                    $all{$w} .= ($all{$w}?", ":"")."[$section]($url)";
                }
            }
        }

        # check longer words
        foreach my $w (@lwords) {
            if(folded($l) =~ /$w/) {
                if(!$word{$w}{$fname}) {
                    $word{$w}{$fname}++;
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
    $s =~ s/^[-<\/.]+//; # remove initial junk
    return $s;
}

sub byname {
    my $c = sorting($a) cmp sorting($b);
    if(!$c) {
        $c = $a cmp $b;
    }
    return $c;
}

my %letter;

foreach my $w (sort byname keys %all) {
    my $l = substr(sorting($w), 0, 1);
    if(!$letter{$l}) {
        $letter{$l}++;
        # Make sure headings have blank lines before and after
        print "\n## $l\n\n";
    }
    printf " - ".$index{$w}.": ";
    print $all{$w}."\n";
}
