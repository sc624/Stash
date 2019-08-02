<?php
	require_once 'connection.php';
	
		
		$FirstName = $_POST['firstname'];
		$LastName = $_POST['lastname'];
		$Bio = $_POST['bio'];
		$EmailAddress = $_POST['emailaddress'];
		$DisplayName = $_POST['displayname'];
		$PassWord = $_POST['password'];

	$query = "INSERT INTO User (FirstName, 	LastName, Bio, EmailAddress, DisplayName, 	UserPass) VALUES ('$FirstName', '$LastName', '	$Bio', '$EmailAddress', '$DisplayName', '	$PassWord')";

	$exeQuery = mysqli_prepare($con, $query);
	mysqli_stmt_execute($stmt);
?>