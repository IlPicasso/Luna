package Election;

use strict;
use warnings;

use Method::Signatures;

method new($resChild) {
       my $obj = bless {}, $self;
       $obj->{child} = $resChild;
       return $obj;
}

method handleDonateCoins($strData, $objClient) {}

method handleSetPoll($strData, $objClient) {}

1;
