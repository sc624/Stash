<?php 
    require_once 'Connection.php';
    $listingID = $_POST['listing'];
    $sql = "SELECT * FROM Image WHERE Image.ListingID = '$listingID'";
    $result = mysqli_query($con, $sql);
    
    while ($row = mysqli_fetch_array($result)) {
    	$array[] = $row; 
    }
    
    echo ($array) ? json_encode($array) : json_encode(array("message"=>"Data not found !"));
?>