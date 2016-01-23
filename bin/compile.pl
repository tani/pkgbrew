#!/usr/bin/env perl

use strict;
use warnings;

my @hist;

sub compile{
    open(my $FILE,$_[0]) or die "$!";
    push(@hist,$_[0]);
    
    while(my $line = <$FILE>){
	if($line =~ /^#\?include\s+(.+)/){
	    &compile($1) unless grep {$_ eq $1} @hist;
	}else{
	    print $line;
	}
    }
    
    close($FILE);
}

&compile($ARGV[0]);
