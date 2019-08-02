<?php 
    require_once 'Connection.php'; 
    
    $query = "SELECT * FROM Listing, User WHERE Listing.UserID = User.UserID AND Listing.ReserverID IS NULL";
    $result = mysqli_query($con, $query);
    $array = array();
    
    while ($row  = mysqli_fetch_assoc($result)){
    	$array[] = $row; 
    }
    echo ($array) ? json_encode($array) : json_encode(array("message"=>"Data not found !"));

?>