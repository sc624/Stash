<?php
    require_once 'Connection.php';
    $username = $_POST['username'];
    $password = $_POST['password'];

    $query = "select * from User where Username = '$username' and Password = '$password'";
    $result = mysqli_query($con, $query);
    
    $array = array();
    
    while ($row  = mysqli_fetch_assoc($result)){
    	$array[] = $row; 
    }
    
    echo($result) ? json_encode($array) : json_encode(array("message"=>"Data not found !"));
?>