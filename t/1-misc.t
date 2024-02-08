use Test;
use Holidays::US::Federal;
use UUID::V4;

use-ok 'Holidays::US::Federal';

my $id = uuid-v4;
is is-uuid-v4($id), True;

done-testing;
