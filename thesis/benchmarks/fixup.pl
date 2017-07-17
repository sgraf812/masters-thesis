#!/usr/bin/perl

use strict;
use warnings;

my $cols = scalar(@ARGV)-1;

my $skipped = 0;
while (<STDIN>) {
	last if /\\hline/;

	# remove absolute values
	s/\d+\.\d+( \&|\\\\)/$1/g;

	# any interesting? e.g. not in [0.0,0.1]
	if (!/[\s-]0\.[01]\\%/ || /\d\d\./) {
		s/^([^ ]*?) /\\progname{$1} /;
		print;
	} else {
		$skipped++;
	}
}
print "\\andmore{$skipped}" . (" &" x (2*$cols)) . " \\\\\n";
print "\\midrule\n";
while (<STDIN>) {
	s/^(.*?) &/\\totalname{$1} &/;
	print;
}
