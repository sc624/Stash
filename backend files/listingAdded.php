<html>
<head>
<title>Add Student</title>
</head>
<body>
<?php
if(isset($_POST['submit'])){
    $data_missing = array();
    if(empty($_POST['user_id'])){
        $data_missing[] = 'User Id';
    } else {
        $userId = trim($_POST['user_id']);
    }
    if(empty($_POST['address_id'])){
        $data_missing[] = 'Address Id';
    } else{
        $addressId = trim($_POST['address_id']);
    }
    if(empty($_POST['listing_type'])){
        $data_missing[] = 'Listing Type';
    } else {
        $listingType = trim($_POST['listing_type']);
    }
     if(empty($_POST['dimention'])){
        $data_missing[] = 'Dimention';
    } else{
        $Dimention = trim($_POST['dimention']);
    }
    if(empty($_POST['listing_price'])){
        $data_missing[] = 'Listing Price';
    } else {
        $listingPrice = trim($_POST['listing_price']);
    }
    
    if(empty($data_missing)){
     require_once('db.php');
     
    
     $query = "INSERT INTO Listing (user_id, address_id, listing_type, dimention, listing_price) VALUES (?,?,?,?,?)";
     $stmt = mysqli_prepare($dbc, $query);
    //   i Integers
    //   d Doubles
    //   b Blobs
    //   s Everything Else
      
      mysqli_stmt_bind_param($stmt, "iissi", $userId, $addressId, $listingType, $Dimention, $listingPrice);
      mysqli_stmt_execute($stmt);
      
       $affected_rows = mysqli_stmt_affected_rows($stmt);
        if($affected_rows == 1){
            echo 'Listing Added!';
            mysqli_stmt_close($stmt);
            mysqli_close($dbc);
        } else {
            echo 'Error Occurred<br />';
            echo mysqli_error();
            mysqli_stmt_close($stmt);
            mysqli_close($dbc);
        }
    } else {
        echo 'You need to enter the following data<br />';
        foreach($data_missing as $missing){
            echo "$missing<br />";   
        }
    }
}
?>
<form action="http://mysterymachine.web.illinois.edu/listingAdded.php" method="post">
<b>Add a New Listing abcde</b>
<p>User Id:
<input type="text" name="user_id" size="30" value="" />
</p>

<p>address Id:
<input type="text" name="address_id" size="30" value="" />
</p>

<p>Listing Type:
<input type="text" name="listing_type" size="30" value="" />
</p>

<p>Dimention:
<input type="text" name="dimention" size="30" value="" />
</p>

<p>Listing Price:
<input type="text" name="listing_price" size="30" value="" />
</p>
<p>
<input type="submit" name="submit" value="Send" />
</p>

</form>
</body>
</html>
