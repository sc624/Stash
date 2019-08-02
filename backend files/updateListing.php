<?php
    require_once('Connection.php');
    
  
    $listingtype = $_POST['listingtype'];
    $dimensions = $_POST['dimensions'];
    $listingprice = $_POST['listingprice'];
    $streetname = $_POST['streetname'];
    $zipcode = $_POST['zipcode'];
    $city = $_POST['city'];
    $state = $_POST['state'];
    $listingid = $_POST['listingid'];
    
    
    
    $query = "UPDATE Listing SET StreetName = '$streetname', ZipCode = '$zipcode', City = '$city', State = '$state', ListingPrice = '$listingprice', Dimensions = '$dimensions', ListingType = '$listingtype' WHERE ListingID = '$listingid'";
    $exeQuery = mysqli_query($con, $query);

    if($exeQuery){
        echo (json_encode(array('code' =>1, 'message' => 'Success')));
    }
    else {
        echo(json_encode(array('code' =>2, 'message' => 'Fail')));
    }

?>