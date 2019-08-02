<?php 
    require_once 'Connection.php'; 
    
    $query = "SELECT * FROM (SELECT UI.Email, UI.UserID FROM User UI) AS TI INNER JOIN (SELECT LI.City, LI.ListingPrice, LI.UserID FROM Listing LI WHERE LI.ListingPrice IN (SELECT MIN(L.ListingPrice) FROM Listing L GROUP BY L.City) ORDER BY LI.City) AS T2 ON T2.UserID = TI.UserID";
        
    $result = mysqli_query($con, $query);
    $array = array();
    
    while ($row = mysqli_fetch_assoc($result)){
    	$array[] = $row; 
    }
    echo ($array) ? json_encode($array) : json_encode(array("message"=>"Data not found !"));

?>