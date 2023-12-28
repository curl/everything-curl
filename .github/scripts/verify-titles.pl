#!/usr/bin/perl -w

my $sum = shift @ARGV;

# Figure out all files in right order
open(F, "<$sum");
while(<F>) {
    if ($_ =~ /\[(.*)\]\(([^\)\#]*)\#([^\)]+)\)/) {
        my ($title, $file, $section_id) = ($1, $2, $3);
        push @files, $file;
        $title{$file} = $title;
        $sections{$file} = $section_id;
    }
    elsif($_  =~ /\[(.*)\]\(([^\)]*)\)/) {
        my ($title, $file) = ($1, $2);
        push @files, $file;
        $title{$file} = $title;
    }
}
close(F);

my $errors = 0;

sub check {
    my ($f) = @_;
    open(F, "<$f") || die("ouch $f");
    while(<F>) {
        if(/^# (.*)/) {
            my $expected;
            if(exists $sections{$f}) {
                # This file was linked from SUMMARY.md with a section header
                $expected = "$title{$f} {#$sections{$f}}";
            } else {
                # This file was linked with no section header
                $expected = $title{$f};
            }
            if ($1 ne $expected) {
                printf STDERR "$f says '%s', not '%s' like SUMMARY.md\n",
                    $1, $expected;
                $errors++;
            }
            last;
        }
    }
    close(F);
};

for my $f (@files) {
    check($f);
}

exit $errors;
