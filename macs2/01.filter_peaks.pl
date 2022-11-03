# /usr/bin/perl

$input_narrowPeak = $ARGV[0];
$prefix = $ARGV[1];
$min_feature_size = $ARGV[2];

open IN, "bedtools merge -i $input_narrowPeak 2>/dev/null |";
open OUT, "| bedtools sort -i - 2>/dev/null | bedtools merge -i - > $prefix.$min_feature_size.tmp 2>/dev/null";
while ($l = <IN>) {
    chomp $l;
    @P = split(/\t/, $l);
    if ($P[2] !~ /(M|Y|L|K|G|Un|Random|Alt)/i) {
	if (($P[2]-$P[1])<$min_feature_size) {
	    $mid = ($P[2]+$P[1])/2;
	    $start = int($mid-($min_feature_size/2));
	    $end = int($mid+($min_feature_size/2));
	    print OUT "$P[0]\t$start\t$end\n";
	} else {
	    print OUT "$P[0]\t$P[1]\t$P[2]\n";
	}
    }
} close IN; close OUT;

open IN, "$prefix.$min_feature_size.tmp";
open OUT, ">$prefix.$min_feature_size.bed";
while ($l = <IN>) {
    chomp $l;
    @P = split(/\t/, $l);
    print OUT "$P[0]\t$P[1]\t$P[2]\t$P[0]_$P[1]_$P[2]\n";
} close IN; close OUT;
