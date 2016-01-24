package CPCommands;

use strict;
use warnings;

use Switch;
use Method::Signatures;

method new($resChild) {
       my $obj = bless {}, $self;
       $obj->{child} = $resChild;
       return $obj;
}

method handlePenguinSuperSize($objClient, $intSize) {
       return if (!$objClient->{isVIP} || !int($intSize));
       $objClient->updateOpenGlow('penguin_size', $intSize);
}

method handlePenguinBlend($objClient, $strBlend) {
       return if (!$objClient->{isVIP});
       $objClient->updateOpenGlow('penguin_blend', $strBlend);
}

method handlePenguinAlpha($objClient, $intAlpha) {
       return if (!$objClient->{isVIP} || !int($intAlpha));
       $objClient->updateOpenGlow('penguin_alpha', $intAlpha);
}

method handleSetNameGlow($objClient, $strGlow) {
       return if (!$objClient->{isVIP} || $strGlow !~ m/0x[\da-fA-F]{1,4}/);
       $objClient->updateOpenGlow('nameglow', $strGlow);
}

method handleSetNameColour($objClient, $strNColour) {
       return if (!$objClient->{isVIP} || $strNColour !~ m/0x[\da-fA-F]{1,4}/);
       $objClient->updateOpenGlow('namecolour', $strNColour);
}

method handleSetChatGlow($objClient, $strCGGlow) {
       return if (!$objClient->{isVIP} || $strCGGlow !~ m/0x[\da-fA-F]{1,4}/);
       $objClient->updateOpenGlow('chatglow', $strCGGlow);
}

method handleClonePenguin($objClient, $strName) {
            my $objPlayer = $objClient->getClientByName($strName);
            $objClient->updatePlayerCard('upc', 'colour', $objPlayer->{colour});
            $objClient->updatePlayerCard('uph', 'head', $objPlayer->{head});
            $objClient->updatePlayerCard('upf', 'face', $objPlayer->{face});
            $objClient->updatePlayerCard('upn', 'neck', $objPlayer->{neck});
            $objClient->updatePlayerCard('upb', 'body', $objPlayer->{body});
            $objClient->updatePlayerCard('upa', 'hand', $objPlayer->{hand});
            $objClient->updatePlayerCard('upe', 'feet', $objPlayer->{feet});
            $objClient->updatePlayerCard('upp', 'photo', $objPlayer->{photo});
            $objClient->updatePlayerCard('upl', 'flag', $objPlayer->{flag});
}

method handleSetPenguinSpeed($objClient, $intSpeed) {
       return if (!$objClient->{isVIP} || !int($intSpeed) && $intSpeed < 4);
       $objClient->updateOpenGlow('speed', $intSpeed);
}

method handleSetBubbleColour($objClient, $strBColour) {
       return if (!$objClient->{isVIP} || $strBColour !~ m/0x[\da-fA-F]{1,4}/);
       $objClient->updateOpenGlow('bubblecolour', $strBColour);
} 

method handleSetBubbleText($objClient, $strText) {
       return if (!$objClient->{isVIP} || $strText !~ m/0x[\da-fA-F]{1,4}/);
       $objClient->updateOpenGlow('bubbletext', $strText);
}

method handleSetRingColour($objClient, $strRColour) {
       return if (!$objClient->{isVIP} || $strRColour !~ m/0x[\da-fA-F]{1,4}/);
       $objClient->updateOpenGlow('ringcolour', $strRColour);
}

method handleAddItem($objClient, $intItem) {
       $objClient->addItem($intItem);
}

method handleSendPong($objClient, $nullVar) {
       $self->handleServerSay($objClient, 'pong');
}

method handleSendID($objClient, $nullVar) {
       my $strName = $objClient->{username};
       my $intID = $objClient->{ID};
       my $strMsg = $strName . ' Your ID: ' . $intID;
       $self->handleServerSay($objClient, $strMsg);
}

method handleServerSay($objClient, $strMsg) {
       $objClient->botSay($strMsg);
}

method handleServerSayAll($objClient, $strMsg) {
       foreach (values %{$self->{child}->{clients}}) {
                $_->botSay('[' . $objClient->{username} . ']: ' . $strMsg);
       }
}


method handleAddCoins($objClient, $intCoins) {
       $objClient->updateCoins($intCoins);
}

method handleSendServerPopulation($objClient, $nullVar) {
       my $intCount = scalar(keys %{$self->{child}->{clients}});
       my $strMsg = 'There are currently ' . $intCount . ' users in this Server';
       $self->handleServerSay($objClient, $strMsg);
} 

method handleSendRoomPopulation($objClient, $nullVar) {
       my $intCount = $objClient->getRoomCount;
       my $strMsg = 'There are currently ' . $intCount . ' users in this Room';
       $self->handleServerSay($objClient, $strMsg);
}

method handleJoinRoom($objClient, $intRoom) {
       if ($intRoom > 0 && $intRoom < 1000) {
           $objClient->joinRoom($intRoom);
       }
}

method handleRebootServer($objClient, $nullVar) {
       return if (!$objClient->{isAdmin});
       foreach (values %{$self->{child}->{clients}}) {
                $_->sendError(990);
                $self->{child}->{modules}->{base}->removeClient($_->{sock});
       }
}

method handleKickClient($objClient, $strName) {
       return if ($objClient->{rank} < 4 && uc($objClient->{username}) eq uc($strName));
       my $objPlayer = $objClient->getClientByName($strName);
       return if ($objPlayer->{rank} > 4);
       $objPlayer->sendError(610);
       $self->handleServerSay($objClient, $objClient->{username} . ' has kicked ' . $strName . ' from the server');
       $self->{child}->{modules}->{base}->removeClient($objPlayer->{sock});
}

method handleFindClient($objClient, $strName) {
       return if (uc($objClient->{username}) eq uc($strName));
       my $objPlayer = $objClient->getClientByName($strName);
       my $strRoomName = $self->{child}->{modules}->{crumbs}->{roomCrumbs}->{$objPlayer->{room}}->{name};
       my $strMsg = $strName . ' is at the ' . $strRoomName;
       $self->handleServerSay($objClient, $strMsg);
}

method handleTeleportClient($objClient, $strName) {
       return if (uc($objClient->{username}) eq uc($strName));
       my $objPlayer = $objClient->getClientByName($strName);
       $objClient->joinRoom($objPlayer->{room});
}

method handleSummonClient($objClient, $strName) {
       return if ($objClient->{rank} < 4 && uc($objClient->{username}) eq uc($strName));
       my $objPlayer = $objClient->getClientByName($strName);
       $objPlayer->joinRoom($objClient->{room});
}

method handleMirrorClient($objClient, $strName) {
            return if ($objClient->{rank} < 4 && uc($objClient->{username}) eq uc($strName));
            my $objPlayer = $objClient->getClientByName($strName);       
            return if ($objPlayer->{rank} > 4);     
            my $arrInfo = $self->{child}->{modules}->{mysql}->fetchColumns("SELECT `isMirror` FROM users WHERE `username` = '" . $objPlayer->{username} . "'");
            my $blnMirror = $arrInfo->{isMirror};
            if ($blnMirror) {
                $objPlayer->{isMirror} = 0;
                $self->{child}->{modules}->{mysql}->updateTable('users', 'isMirror', 0, 'ID', $objClient->{ID});
            } else {
                $objPlayer->{isMirror} = 1;
                $self->{child}->{modules}->{mysql}->updateTable('users', 'isMirror', 1, 'ID', $objClient->{ID});
            }
}

method handleBanClient($objClient, $strName) {
       return if ($objClient->{rank} < 4 && uc($objClient->{username}) eq uc($strName));
       my $objPlayer = $objClient->getClientByName($strName);
       return if ($objPlayer->{rank} > 4);
       $objPlayer->sendError(603);
       $self->{child}->{modules}->{base}->removeClient($objPlayer->{sock});
       $self->{child}->{modules}->{mysql}->updateTable('users', 'isBanned', 'PERM', 'username', $strName);
       $objPlayer->{isBanned} = 'PERM';
       $self->handleServerSay($objClient, $objClient->{username} . ' has permanently banned ' . $strName);
}

method handleKickBanClient($objClient, $strName) {
       return if ($objClient->{rank} < 4 && uc($objClient->{username}) eq uc($strName));
       $self->handleKickClient($objClient, $strName);
       $self->handleBanClient($objClient, $strName);
}

method handleUnbanClient($objClient, $strName) {
       return if ($objClient->{rank} < 4 && uc($objClient->{username}) eq uc($strName));
       $self->{child}->{modules}->{mysql}->updateTable('users', 'isBanned', 0, 'username', $strName);
       $self->{child}->{modules}->{mysql}->updateTable('users', 'banCount', 0, 'username', $strName);
       $self->handleServerSay($objClient, $objClient->{username} . ' has unbanned ' . $strName);
}

method handleChangeNickname($objClient, $strNick) {
       if ($strNick !~ /^[a-zA-Z0-9]+$/) {
           return $objClient->sendError(441);
       }
       my $arrInfo = $self->{child}->{modules}->{mysql}->fetchColumns("SELECT `username`, `nickname` FROM users WHERE `nickname` = '$strNick'");
       my $strUCNick = uc($strNick);
       my $strDBName = uc($arrInfo->{username});
       my $strDBNick = uc($arrInfo->{nickname});
       if ($strUCNick eq $strDBName && $strDBNick eq $strUCNick) {
           return $objClient->sendError(441);
       }
       $self->{child}->{modules}->{mysql}->updateTable('users', 'nickname', $strNick, 'ID', $objClient->{ID});
       $self->handleServerSay($objClient, $objClient->{username} . ' please re-login to the game to see your new nickname');
}

method handleTimeBanClient($objClient, $strName) {
       return if ($objClient->{rank} < 4 && uc($objClient->{username}) eq uc($strName));
       my $objPlayer = $objClient->getClientByName($strName);
       return if ($objPlayer->{rank} > 4);
       switch ($objPlayer->{banCount}) {
               case (0) {
                     $objClient->updateBanCount($objPlayer, 1);
                     $self->{child}->{modules}->{mysql}->updateTable('users', 'isBanned', time + 86400, 'ID', $objPlayer->{ID});
                     $objPlayer->sendError(610 . '%' . 'Your account has temporarily been suspended for 24 hours by ' . $objClient->{username});
                     $self->handleServerSay($objClient, $objClient->{username} . ' has temporarily banned ' . $strName . ' for 24 hours');
                     return $self->{child}->{modules}->{base}->removeClient($objPlayer->{sock});
               }
               case (1) {
                     $objClient->updateBanCount($objPlayer, 2);
                     $self->{child}->{modules}->{mysql}->updateTable('users', 'isBanned', time + 172800, 'ID', $objPlayer->{ID});
                     $objPlayer->sendError(610 . '%' . 'Your account has been temporarily suspended for 48 hours by ' . $objClient->{username});
                     $self->handleServerSay($objClient, $objClient->{username} . ' has temporarily banned ' . $strName . ' for 48 hours');
                     return $self->{child}->{modules}->{base}->removeClient($objPlayer->{sock});
               }
               case (2) {
                     $objClient->updateBanCount($objPlayer, 3);
                     $self->{child}->{modules}->{mysql}->updateTable('users', 'isBanned', time + 259200, 'ID', $objPlayer->{ID});
                     $objPlayer->sendError(610 . '%' . 'Your account has been temporarily suspended for 72 hours by ' . $objClient->{username});
                     $self->handleServerSay($objClient, $objClient->{username} . ' has temporarily banned ' . $strName . ' for 72 hours');
                     return $self->{child}->{modules}->{base}->removeClient($objPlayer->{sock});
               } 
               case (3) {                        
                     $self->handleBanClient($objClient, $strName);
               }
       }
}

1;
