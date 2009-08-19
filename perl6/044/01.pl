use v6;

# Problem 44
# 23 May 2003
# 
# Pentagonal numbers are generated by the formula, Pn=n(3n-1)/2. The first ten pentagonal numbers are:
# 
# 1, 5, 12, 22, 35, 51, 70, 92, 117, 145, ...
# 
# It can be seen that P4 + P7 = 22 + 70 = 92 = P8. However, their difference, 70 22 = 48, is not pentagonal.
# 
# Find the smallest pair of pentagonal numbers for which their sum and difference is pentagonal; what is their difference?

my $min_diff;
my %pents;

#say "pre-calculating 5000 pentagonal #s...";

%pents{ pentagonal($_) } = $_ for 1..5000;

#say "done, chcking pents for sum & differences";

for ( %pents.keys.sort({$^a <=> $^b}) ) -> $p1 {
    for ( %pents.keys.sort({$^a <=> $^b}) ) -> $p2 {
        say "checking $p1 v. $p2, abs($p1 - $p2) = ",abs($p1 - $p2);
        say "\%pents\{ $p1 + $p2 \}: ",%pents{ $p1 + $p2 };
        say "\%pents\{ abs($p1 - $p2) \}: ",%pents{ abs($p1 - $p2) };
        if %pents{ $p1 + $p2 } and %pents{ abs( $p1 - $p2 ) } and %pents{$p1} and %pents{$p2} {
            say "\nfound $p1 & $p2!                    (n1 = ",%pents{$p1}," & n2 = ",%pents{$p2},")\n",
                "sum:        @{[ $p1 + $p2 ]}        (n = ",%pents{$p1 + $p2},")\n",
                "difference: @{[ abs( $p1 - $p2 ) ]} (n = ",%pents{abs($p1-$p2)},")\n"
            ;
            say "Answer: ",abs( $p1 - $p2 );
            exit 0;
        }
    }
}



sub pentagonal(Int $n) {
    return ( $n * ( ( 3 * $n ) - 1 ) ) / 2;
}

