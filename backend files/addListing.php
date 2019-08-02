<?php
 require_once('Connection.php');

                                    $listingtype=$_POST['listingtype'];
                                    $dimensions=$_POST['dimensions'];
                                    $userid=$_POST['userid'];
                                    $listingprice=$_POST['listingprice'];
                                    $streetname=$_POST['streetname'];
                                    $zipcode=$_POST['zipcode'];
                                    $city=$_POST['city'];
                                    $state=$_POST['state'];
                                    


  
    $insert = "INSERT INTO Listing (ListingType, Dimensions, ListingPrice, StreetName, ZipCode, City, State, UserID) VALUES ('$listingtype', '$dimensions', '$listingprice', '$streetname', '$zipcode', '$city', '$state', '$userid')";
    $exeQuery = mysqli_query($con, $insert);
  

    if($exeQuery){
        echo (json_encode(array('code' =>1, 'message' => 'Success')));
    } else {
        echo(json_encode(array('code' =>2, 'message' => 'Fail')));
    }
    
 ?>