#!/usr/bin/perl

my $sum = shift @ARGV;

# Figure out all files in right order
open(F, "<$sum");
while(<F>) {
    if($_  =~ /\[(.*)\]\(([^\)]*)\)/) {
        my ($title, $file) = ($1, $2);
        push @files, $file;
        $title{$file} = $title;
    }
}
close(F);

sub check {
    my ($f) = @_;
    open(F, "<$f");
    while(<F>) {
        if(/^# (.*)/) {
            # verify
            if($1 ne $title{$f}) {
                printf STDERR "$f says '%s', not '%s' like SUMMARY.md\n",
                    $1, $title{$f};
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
