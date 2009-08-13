#!/usr/local/bin/perl6


#Problem 79
#
#A common security method used for online banking is to ask the user for three random characters from a passcode. For example, if the passcode was 531278, they may asked for the 2nd, 3rd, and 5th characters; the expected reply would be: 317.
#
#The text file, keylog.txt, contains fifty successful login attempts.
#
#Given that the three characters are always asked for in order, analyse the file so as to determine the secret passcode of unknown length. 

# assumptions - every digit that is in the passcode is in the file
# no digit is repeated in the sequence


my $fh = open 'keylog.txt', :r or die "Could not open file keylog.txt: $!";

my @entries = $fh.lines;   # slurp it in
my $passcode =  @entries.shift;
$passcode.chomp;

say "passcode: $passcode";

for @entries -> $entry {
    chomp $entry;

    my ($first, $second, $third) = $entry.comb;

    my $first_chunk  = $entry.substr(0, 2);
    my $second_chunk = $entry.substr(1, 3);

    #say "first: $first";
    #say "second: $second";
    #say "third: $third";
    #say "first chunk: $first_chunk";
    #say "second chunk: $second_chunk";

    # insert new digits
    eval "regex fu \{ $first \}";
    $passcode = $passcode.subst( rx/<fu>/, $first_chunk )  unless $passcode ~~ $second;
    eval "regex gu \{ $second \}";
    $passcode = $passcode.subst( rx/<gu>/, $first_chunk )  unless $passcode ~~ $first;
    $passcode = $passcode.subst( rx/<gu>/, $second_chunk ) unless $passcode ~~ $third;
    eval "regex hu \{ $third \}";
    $passcode = $passcode.subst( rx/<hu>/, $second_chunk ) unless $passcode ~~ $second;

    #$passcode = $passcode.comb.uniq.join('');

    my $pre_swap = $passcode;

    eval "regex first_re  \{ $first  \}";
    eval "regex second_re \{ $second \}";
    eval "regex third_re  \{ $third  \}";

    $passcode = $passcode.subst( rx/<second_re><first_re>/, { $first ~  $second } );
    $passcode = $passcode.subst( rx/<third_re><second_re>/, { $second ~  $third } );
    
    #eval "regex swap_second_and_first \{ $second(.*)$third \}";
    #eval "regex swap_third_and_second \{ $third(.*)$second \}";

    #$passcode = $passcode.subst( rx/<swap_second_and_first>/, { $first ~ $0 ~ $second } );
    #$passcode = $passcode.subst( rx/<swap_third_and_second>/, { $second ~ $0 ~ $third } );

    #if ! $passcode =~ /$second/ {
    #    if $passcode =~ /$first/ {
    #        my $index = $passcode.index($first);
    #        $passcode.subst($index, $index+1) = $first_chunk;
    #    }
    #    #$passcode.substr(0, 1) = $first_chunk;
    #}
    ##unless $passcode =~ /$first/ {
    #   $passcode.substr(1, 1) = $first_chunk;
    ##}
    ##unless $passcode =~ /$third/ {
    #   $passcode.substr(1, 1) = $second_chunk;
    ##}
    ##unless $passcode =~ /$second/ {
    #    $passcode.substr(2, 1) = $second_chunk;
    ##}

    #$passcode =~ s/$second(.*)$first/$first$1$second/;
    #$passcode =~ s/$third(.*)$second/$second$1$third/;
    
    #remove duplicates:
    #say "\$passcode.comb: ", $passcode.comb;
    #say "\$passcode.comb.uniq: ", $passcode.comb.uniq;
    #say "Passcode: $passcode";
    $passcode = $passcode.comb.uniq.join('');
    #say "Passcode: $passcode";
    say "entry: $entry, pre swap: $pre_swap, passcode: $passcode";
}

say "Passcode: $passcode";


