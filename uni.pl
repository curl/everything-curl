#!/usr/bin/perl

my $sum = shift @ARGV;

# Figure out all files in right order
open(F, "<$sum");
while(<F>) {
    if($_  =~ /\]\(([^\)]*)\)/) {
        my $file = $1;
        push @files, $1;
    }
}
close(F);

sub dirname {
    my ($path) = @_;
    if($path =~ /(.*)\//) {
        return "$1/";
    }
    return "";
}

sub include {
    my ($f) = @_;
    my $line;
    open(M, "<$f") || return;
    my $dir = dirname($f);
    print "\n";
    while(<M>) {
        $line++;
        # strip out links to markdown files
        $_ =~ s/\[([^]]*)\]\(.*\.md(|\#(.*))\)/$1/g;
        # add path to image links
        $_ =~ s/^!\[(.*)\]\(([^)]*)\)/![$1]($dir$2)/g;

        if($_ =~ /\]\(.*\.md/) {
            print STDERR "$f:$line:line-split markdown link\n";
            print STDERR "$_";
            $errors++;
        }
        if($_ =~ /谭/) {
            # skip unicode letter pandoc does not like
        }
        else {
            print $_;
        }
    }
    close(M);
}


for my $f (@files) {
    include($f);
}

exit $errors;
