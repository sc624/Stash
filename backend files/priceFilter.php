<?php 
require_once 'Connection.php'; 

$listingprice=$_POST['listingprice'];

$query = "SELECT * FROM Listing, User WHERE ListingPrice <= '$listingprice' AND Listing.UserID = User.UserID";

$result = mysqli_query($con, $query);

$array = array();

while ($row  = mysqli_fetch_assoc($result))
{
	$array[] = $row; 
}


echo($result) ? json_encode($array) : json_encode(array("message"=>"Data not found !"));
// header("Refresh:0");
?>