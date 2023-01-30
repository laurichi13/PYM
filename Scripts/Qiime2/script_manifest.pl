#!/usr/bin/perl
use Cwd 'abs_path';
   
open(OUT,">manifest.csv");

foreach $ar (@ARGV) {

	#To have the $name of the file:
	$name=$ar;	
	@field = split (/_/, $ar);
	$name2 = @field[0];
	
	#To have the $path:
	$path =abs_path($ar);
	
	if ($name =~ /1.fq.gz/)
	{ 
		print OUT "$name2,$path,forward\n";
	}else{  
		print OUT "$name2,$path,reverse\n";
	}
}

close OUT;