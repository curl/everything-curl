#!/usr/bin/env perl
# Copyright (C) Daniel Stenberg, <daniel@haxx.se>, et al.
#
# SPDX-License-Identifier: curl
#
# Input: a markdown file, it gets modified *in place*
#
# The main purpose is to strip off quotes, lines starting with four spaces,
# so that the result can be run through proselint better.
#

my $f = $ARGV[0];

open(F, "<$f") or die;

while(<F>) {
    $_ =~ s/^    .*//g;

    push @out, $_;
}
close(F);

open(O, ">$f") or die;
print O @out;
close(O);
