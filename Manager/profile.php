<?php

set_time_limit(0);

include('session.php');

?>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Luna - Manager</title>
<link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="wrapper">

<ul>
<li><a class="active" href="profile.php">Home</a></li>
<li><a href="settings.php">Settings</a></li>
<li><a href="search.php">Search</a></li>
<?php 
    if ($_SESSION['isStaff'] == true) { 
?>
 <li><a href="moderator.php">Mod Panel</a></li>
<?php 
    if ($_SESSION['isAdmin'] == true) { 
?>
<li><a href="admin.php">Admin Panel</a></li></ul>
<?php 
} 
} 
?>
<li><a href="logout.php">Logout</a></li>
</ul>     

<div class="container">

<?php

include "config.php";

$resMysql = mysqli_connect($strDBHost, $strDBUser, $strDBPass, $strDBName);

$strUsername = $_SESSION['login_user'];

$resQuery = mysqli_query($resMysql, "SELECT * FROM users WHERE username = '$strUsername'");

$arrResults = mysqli_fetch_assoc($resQuery);

echo '<center>';
echo '<p>Username: ' . $arrResults['username'] . '</p>';
echo '<p>Email: ' . $arrResults['email'] . '</p>';
echo '<p>Penguin Age: ' . round((time() - strtotime($arrResults['age'])) / 86400) . '</p>';
echo '<p>Rank: ' . $arrResults['rank'] . '</p>';
echo '<p>Last Seen: ' . $arrResults['LastLogin'] . '</p>';
echo '<p>Status: ' . $arrResults['mood'] . '</p>';
echo "</center>";

?>

</div>
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
