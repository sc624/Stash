<?php
    require_once('Connection.php');
    
    $listingid = $_POST['listingid'];

    $query = "UPDATE Listing SET ReserverID = NULL WHERE ListingID = '$listingid'";
    $exeQuery = mysqli_query($con, $query);

    if($exeQuery){
        echo (json_encode(array('code' =>1, 'message' => 'Success')));
    }else {
        echo(json_encode(array('code' =>2, 'message' => 'Fail')));
    }

?>