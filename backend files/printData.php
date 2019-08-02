<?php

require_once 'Connection.php';

//$listingid=$_POST['listingid'];
$description = $_POST['Description'];
$dimensions = $_POST['dimensions'];
$city = $_POST['city'];
$state = $_POST['state'];


//$query = "SELECT * FROM Listing WHERE Listing.UserID = '$listingid'";
$query = "SELECT ListingID, Dimensions, Description, ListingPrice, City, State, ListingType FROM Listing";
$result = mysqli_query($con, $query);
$array = array();
while ($row  = mysqli_fetch_assoc($result)){
	$array[] = $row; 
}
$json  = json_encode($array);

$my_file = 'chinnyfile.txt';
$handle = fopen($my_file, 'w') or die('Cannot open file:  '.$my_file); //implicitly creates file
$data = $json;
fwrite($handle, $data);
fclose($handle);


//store the parameters gotten from the PHP file for later reading. 
$usefulInfo =  $description . 'AAA' . $dimensions . 'AAA' . $city . 'AAA' . $state;
$user_file = 'userinfo.txt';
$handle1 = fopen($user_file, 'w') or die('Cannot open file:  '.$my_file); //implicitly creates file
fwrite($handle1, $usefulInfo);
fclose($handle1);

$array = array();
$output = shell_exec('python advancedml.py');
// $array[] = $output;
echo ($output) ? json_encode($output) : json_encode("Data not found !");


#$launchpy = 'python advancedml.py '.' MY HOME'.'  '.'MY PRICE'.'  '. 'MY CITY'.'  '.'MY STATE';
// echo $launchpy;
// shell_exec($launchpy);
//echo "hello there";

?>