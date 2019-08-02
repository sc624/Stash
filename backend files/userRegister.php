<?php
    require_once('Connection.php');

    $username = $_POST['username'];
    $email = $_POST['email'];
    $password = $_POST['password'];
    $firstname = $_POST['firstname'];
    $lastname = $_POST['lastname'];

    $insert = "INSERT INTO User (Username, Email, Password, FirstName, LastName) VALUES ('$username', '$email', '$password', '$firstname', '$lastname')";
    $exeQuery = mysqli_query($con, $insert);
  

    if($exeQuery){
        echo (json_encode(array('code' =>1, 'message' => 'Success')));
    } else {
        echo(json_encode(array('code' =>2, 'message' => 'Fail')));
    }

 ?>