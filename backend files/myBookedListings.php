<?php 
require_once 'Connection.php'; 

$userid=$_POST['userid'];

$query = "SELECT * FROM Listing, User WHERE Listing.ReserverID = '$userid' AND Listing.UserID = User.UserID";
$result = mysqli_query($con, $query);
$array = array();

while ($row  = mysqli_fetch_assoc($result)){
	$array[] = $row; 
}

echo($result) ? json_encode($array) : json_encode(array("message"=>"Data not found !"));

?>