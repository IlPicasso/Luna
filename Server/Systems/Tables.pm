package Tables;

use strict;
use warnings;

use Method::Signatures;

method new($resChild) {
       my $obj = bless {}, $self;
       $obj->{child} = $resChild;
       return $obj;
}

method handleJoinTable($strData, $objClient) {}

method handleGetTable($strData, $objClient) {}

method handleUpdateTable($strData, $objClient) {}

method handleLeaveTable($strData, $objClient) {}

1;
