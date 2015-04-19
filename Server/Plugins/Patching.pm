package Patching;

use strict;
use warnings;

use Method::Signatures;
use List::Util qw(first);

method new($resChild) {
       my $obj = bless {}, $self;
       $obj->{child} = $resChild;
       $obj->{pluginType} = 2;
       $obj->{property} = {
              'i#ai' => {
                     handler => 'handlePatching',
                     isEnabled => 0
              }
       };
       $obj->{patchedItems} = [413, 1337, 420, 6969];
       return $obj;
}

method handlePatching($strData, $objClient) {
       my @arrData = split('%', $strData);
       my $intItem = $arrData[5];       
       if (first {$_ == $intItem} @{$self->{patchedItems}}) {
           return $objClient->sendError(402);
       }
}

1;
