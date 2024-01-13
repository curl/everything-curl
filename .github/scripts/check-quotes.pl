#!/usr/bin/perl -w

my $sum = shift @ARGV;

# Figure out all files in right order
open(F, "<$sum");
while(<F>) {
    if ($_ =~ /\[(.*)\]\(([^\)\#]*)\#([^\)]+)\)/) {
        my ($title, $file, $section_id) = ($1, $2, $3);
        push @files, $file;
    }
    elsif($_  =~ /\[(.*)\]\(([^\)]*)\)/) {
        my ($title, $file) = ($1, $2);
        push @files, $file;
    }
}
close(F);

my $errors = 0;

sub check {
    my ($f) = @_;
    open(F, "<$f") || die("ouch $f");
    my $l = 1;
    while(<F>) {
        if(/^(~~~|```)/) {
            print STDERR "$f:$l:1: uses $1, not 4-space indent\n";
            $errors++;
        }
        elsif(/^    / && (length($_)>79)) {
            print STDERR "$f:$l:1: woo wide quoted line, please wrap\n";
            $errors++;
        }
        $l++;
    }
    close(F);
};

for my $f (@files) {
    check($f);
}

exit $errors;
