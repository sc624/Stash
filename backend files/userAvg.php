<?php 
    require_once 'Connection.php'; 
    
    $query = "SELECT MyUsers.UserID, MyUsers.Username, AVGPrices.PersonAVGPrice FROM (SELECT UI.UserID, UI.Username FROM User UI) AS MyUsers INNER JOIN 
        (SELECT U.UserID, AVG(L.ListingPrice) AS PersonAVGPrice FROM Listing L INNER JOIN User U ON L.UserID = U.UserID GROUP BY U.UserID ORDER BY U.UserID ASC) AS AVGPrices
        ON MyUsers.UserID = AVGPrices.UserID";
        
    $result = mysqli_query($con, $query);
    $array = array();
    
    while ($row = mysqli_fetch_assoc($result)){
    	$array[] = $row; 
    }
    echo ($array) ? json_encode($array) : json_encode(array("message"=>"Data not found !"));

?>