#!/usr/bin/perl -w

# import shared function
use lib '.';
require "urlify.pl";

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


# Converts a file path to something that can be used in a section ID
sub urlify_file_path {
    my ($part) = @_;

    # Strip a leading '/' if present
    $part =~ s/^\///;

    $part =~ s/[\/\.]+/__/g;

    return $part;
}


# Converts a relative path and current directory to a full path relative
# to the "ROOT" directory.
sub make_full_file_path {
    my ($current_dir, $linked_file_path) = @_;

    # Handle pants with "../" in them
    while($linked_file_path =~ m/^\.\..*/) {
        # Strip leading ".."
        $linked_file_path =~ s/^..//;
        # Strinp leading "/" if present
        $linked_file_path =~ s/^\///;

        # Strip trailing /
        $current_dir =~ s/\/$//;
        if($current_dir =~ m/.*\/.*/) {
            # if there is more than one dir remaining, strip the last dir
            $current_dir =~ s/(.*)\/(.*)/$1/;
        } else {
            # only one dir remaining, use root of ""
            $current_dir = "";
        }
    }

    my $final_path="$current_dir/$linked_file_path";

    return $final_path;
}


# Rewrites an anchor destination to point to a section ID in the current file.
sub update_anchor {
    my ($anchor_text, $anchor_target, $dir, $f) = @_;
    my $final_target = $anchor_target;

    if($anchor_target =~ m/^(http\:|https\:).*$/ ) {
        # don't rewrite regular http / https urls
    } elsif($anchor_target =~ m/(^.*)(\.png|\.jpg)$/ ) {
        #
        # The anchor_target points to an image, add the image directory to the target
        #
        $final_target = "$dir$1$2";
    } elsif($anchor_target =~ m/((.+)\.md)\#(.+)/ ) {
        #
        # The anchor_target points a SPECIFIC section of a DIFFERENT *.md file
        #
        my $full_file_path=make_full_file_path($dir, $1);
        my $file_target=urlify_file_path($full_file_path);
        my $section_target=$3;

        $final_target = "#$file_target" . "-_-_-" . $section_target;
    } elsif($anchor_target =~ m/((.+)\.md)$/x) {
        #
        # The anchor_target points NO SECTION in a DIFFERENT *.md file
        #

        my $full_file_path=make_full_file_path($dir, $1);
        my $file_target=urlify_file_path($full_file_path);

        $final_target = "#$file_target";
    } elsif($anchor_target =~ m/\#(.+)$/x) {
        #
        # The anchor_target points A SECTION in THIS *.md file
        #

        my $full_file_path = $f;
        my $file_target=urlify_file_path($full_file_path);

        my $section_target=$1;

        $final_target = "#$file_target" . "-_-_-" . $section_target;
    }

    return $anchor_text . "($final_target)";
}

my $errors = 0;

sub include {
    my ($f) = @_;
    my $line;
    open(M, "<$f") || return;
    my $dir = dirname($f);

    my $same_dir_url_part = urlify_file_path($dir);
    my $same_file_url_part = urlify_file_path($f);

    my $in_code_section = 0;
    my $next_line_should_be_blank = 0;

    # Print an empty span at the top of each new file, to give "foo.md" links from other files a
    # place to target with a {#foo} style link in the combined .md file
    print "\n";
    print "[ ]\{#$same_file_url_part\}\n";
    print "\n";

    while(<M>) {
        $line++;
        my $complete_line = $_;

        if($next_line_should_be_blank) {
            if(! (($complete_line eq "") || ($complete_line =~ m/^[\s]*$/))) {
                print STDERR "WARNING: The line after a '#' header should be blank in $f, but was: $complete_line\n";
            }

            $next_line_should_be_blank = 0;
        }

        # Track whether we are within a markdown code block that begins/ends with ```
        if($complete_line =~ /^\`\`\`.*/) {
            if($in_code_section) {
                $in_code_section = 0;
            } else {
                $in_code_section = 1;
            }
        } elsif(!$in_code_section) {
            # Split line, so we can update multiple URLs on one line
            my @line_items = split( /( \[ [^]]*\]\([^)]*?\) )/x , $_);

            foreach my $item (@line_items) {
                # Update all of the anchor targets in the line
                $item =~ s/ (\[ [^]]*\]) \( ([^)]*?) \) /update_anchor($1 , $2, $dir, $f) /xge;
            }
            $complete_line = join('', @line_items);
            
            #
            # Check for section H1, H2, etc, definitions (starting with #, ##, etc)
            #
            # Add an explicit section ID to those if not present
            # Include in that section ID a reference to the full path to the current file
            my $full_file_path = $f;
            my $file_target=urlify_file_path($full_file_path);

            my $final_section_line = $complete_line;

            if($complete_line =~ /^(#[\#]*) ([^\{]*)(\{\#(.*)\})/) {
                $next_line_should_be_blank = 1;

                # This section header has an explicit ID specified, e.g. "#Foo {#foo}"
                my $depth = $1;
                my $section = $2;
                my $section_id=$4;

                # trim whitespace off end of section
                $section =~ s/\s+$//;

                $section_id = "$file_target" . "-_-_-" . $section_id;
                
                $final_section_line = "$depth $section \{\#$section_id\}\n";
            }
            elsif($complete_line =~ /^(#[\#]*) (.*)/) {
                $next_line_should_be_blank = 1;

                # This section header has no explicit ID specified, e.g. "#Foo"
                my $depth = $1;
                my $section = $2;

                # trim whitespace off end of section
                $section =~ s/\s+$//;

                my $section_id = "$file_target" . "-_-_-" . urlify($section);

                $final_section_line = "$depth $section \{\#$section_id\}\n";
            }

            $complete_line = $final_section_line;

            if($complete_line =~ /谭/) {
                # skip unicode letter pandoc does not like
            }
            else {
                print $complete_line;
            }
        } else {
            # in a code section, print lines as-is.
            
            if($complete_line =~ /谭/) {
                # skip unicode letter pandoc does not like
            }
            else {
                print $complete_line;
            }
        }
    }
    close(M);
}


for my $file (@files) {
    include($file);
}

exit $errors;
