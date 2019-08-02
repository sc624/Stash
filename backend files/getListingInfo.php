<?php 
require_once 'Connection.php'; 

$listingid=$_POST['listingid'];

$query = "SELECT * FROM Listing WHERE ListingID = '$listingid'";
$result = mysqli_query($con, $query);
$array = array();
while ($row  = mysqli_fetch_assoc($result)){
	$array[] = $row; 
}

echo($result) ? json_encode($array) : json_encode(array("message"=>"Data not found !"));
// header("Refresh:0");
?>