<?php

include 'session.php';
include 'mysql.php';

$strError = '';
$strMessage = '';

if (isset($_POST['update'])) {
    $strNG = $_POST['nameglow'];
    $strNC = $_POST['namecolor'];
    $strBT = $_POST['bubbletext'];
    $strBC = $_POST['bubblecolor'];
    $strRC = $_POST['ringcolor'];
    $intSpeed = $_POST['speed'];

    if (isset($strNG) && isset($strNC) && isset($strBT) && isset($strBC) && isset($strRC)) {
        $strNG = $mysql->perfEscape(stripslashes($strNG));
        $strNC = $mysql->perfEscape(stripslashes($strNC));
        $strBT = $mysql->perfEscape(stripslashes($strBT));
        $strBC = $mysql->perfEscape(stripslashes($strBC));
        $strRC = $mysql->perfEscape(stripslashes($strRC));
        $intSpeed = $mysql->perfEscape(stripslashes($intSpeed));

        $strUsername = $_SESSION['login_user'];

        if (is_numeric($intSpeed) && $intSpeed <= 100) {
            if (ctype_alnum($strNG) && strlen($strNG) <= 6) {
                if (ctype_alnum($strNC) && strlen($strNC) <= 6) {
                    if (ctype_alnum($strBT) && strlen($strBT) <= 6) {
                        if (ctype_alnum($strBC) && strlen($strBC) <= 6) {
                            if (ctype_alnum($strRC) && strlen($strRC) <= 6) {
                                $strNGHex = '0x' . $strNG;
                                $strNCHex = '0x' . $strNC;
                                $strBTHex = '0x' . $strBT;
                                $strBCHex = '0x' . $strBC;
                                $strRCHex = '0x' . $strRC;
                                $mysql->perfQuery("UPDATE users SET nameglow = '$strNGHex' WHERE username = '$strUsername'");
                                $mysql->perfQuery("UPDATE users SET namecolour = '$strNCHex' WHERE username = '$strUsername'");
                                $mysql->perfQuery("UPDATE users SET bubbletext = '$strBTHex' WHERE username = '$strUsername'");
                                $mysql->perfQuery("UPDATE users SET bubblecolour = '$strBCHex' WHERE username = '$strUsername'");
                                $mysql->perfQuery("UPDATE users SET ringcolour = '$strRCHex' WHERE username = '$strUsername'");
                                $mysql->perfQuery("UPDATE users SET speed = '$intSpeed' WHERE username = '$strUsername'");
                                $strMessage = 'Successfully updated glow settings';
                            } else {
                                $strError = 'Invalid Ring Color Pattern';
                            }
                        } else {
                            $strError = 'Invalid Bubble Color Pattern';
                        }
                    } else {
                        $strError = 'Invalid Bubble Text Pattern';
                    }
                } else {
                    $strError = 'Invalid Name Color Pattern';
                }
            } else {
                $strError = 'Invalid Name Glow Pattern';
            }
        } else {
            $strError = 'Invalid Penguin Speed';
        }
    }
}

?>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Luna - Manager</title>
<link rel="stylesheet" href="css/style.css">
<script src="js/jscolor.js"></script>
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
</head>
<body>

<div class="wrapper">
<ul>
<li><a href="profile.php">Home</a></li>
<li><a href="settings.php">Settings</a></li>
<li><a class="active" href="glows.php">Glow Panel</a></li>
<li><a href="search.php">Search</a></li>
<?php if ($_SESSION['isStaff'] == true) { ?>
 <li><a href="moderator.php">Mod Panel</a></li>
<?php if ($_SESSION['isAdmin'] == true) { ?>
<li><a href="admin.php">Admin Panel</a></li>
<?php } } ?>
<li><a href="logout.php">Logout</a></li>
</ul>     
</div>

<div class="container">
<center>
<form class="form" name="form" method="post" action="<?php echo $_SERVER['PHP_SELF']; ?>">
       <label for="nameglow">Name Glow: </label>
       <input class="jscolor" type="text" name="nameglow" maxlength="6">
       <label for="namecolor">Name Color: </label>
       <input class="jscolor" type="text" name="namecolor" maxlength="6">
       <label for="bubbletext">Bubble Text Glow: </label>
       <input class="jscolor" type="text" name="bubbletext" maxlength="6">
       <label for="bubblecolor">Bubble Color: </label>
       <input class="jscolor" type="text" name="bubblecolor" maxlength="6">
       <label for="ringcolor">Ring Color: </label>
       <input class="jscolor" type="text" name="ringcolor" maxlength="6">
       <div data-role="rangeslider"/>
       <label for="speed">Speed: </label>
       <input type="range" name="speed" id="speed" value="5" min="0" max="100" placeholder="Penguin Speed">
       </div>
       <input type="submit" id="login-button" name="update" value="Update">
       <span><?php echo $strError; ?></span>
       <span><?php echo $strMessage; ?></span>
</form>
</center>
</div>
<footer class="bg-bubbles">
    <li></li>
		<li></li>
		<li></li>
		<li></li>
		<li></li>
		<li></li>
		<li></li>
		<li></li>
		<li></li>
		<li></li>
</footer>
<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script src="js/index.js"></script>
</body>
</html>
