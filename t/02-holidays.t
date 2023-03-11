use Test;
use Holidays::US::Federal;

# holiday keys:
#   1 New Year's Day
#   2 Martin Luther King's Birthday
#   3 George Washington's Birthday
#   4 Memorial Day
#   5 Juneteenth National Independence Day
#   6 Independence Day
#   7 Labor Day
#   8 Columbus Day
#   9 Veterans Day
#  10 Thanksgiving
#  11 Christmas

my $year = 2023;
my %h = get-fedholidays :$year;
my @d = %h.keys.sort({$^a cmp $^b});
for @d -> $date {
    my $h = %h{$date}
}

done-testing;
