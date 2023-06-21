#!/usr/bin/perl

my $fh;

if(@ARGV < 1){
	die("Usage: file name\n");
}

open($fh, "<", $ARGV[0]) or die("The specified file could not be opened.\n");

`wc -l $ARGV[0]` =~ /(\d+)/;
my $length = $1;

my $iter = 0, $unique;

while(<$fh>){

	if($iter >= 3 && $iter < $length - 1){

		my @entries;

		while($_ =~ /(-?\d*\.?\d+)/g){
			$unique = 1;
			my $number = $1;

			foreach my $entry (@entries){
				if($entry == $number){
					$unique = 0;
					break;
				}
			}
			if($unique){
				push @entries, $number;
			}

		}

		foreach my $next_num (@entries){
			my $replacement = sqrt(2)*2*$next_num;
			my $rep_string = sprintf("%10.9f", $replacement);
			$_ =~ s/"$next_num"/"$rep_string"/g;
		}
	}

	print $_;

	$iter ++;
}

close($fh);
