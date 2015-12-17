<?php
 ob_start();
  include("db.php");
  if(isset($_POST['send'])!="")
  {
  $license_id=mysql_real_escape_string($_POST['license_id']);
  $license_name=mysql_real_escape_string($_POST['license_name']);
  $license_status=mysql_real_escape_string(isset($_POST['license_status']));  
  // $update=mysql_query("INSERT INTO licenseplate(license_id,license_name,license_status)VALUES
		// 							  ('$license_id','$license_name','$license_status')");


  $result = mysql_query("SELECT * FROM licenseplate WHERE license_id ='$license_id'");

  if( mysql_num_rows($result) > 0) {
      $update = mysql_query("UPDATE licenseplate SET license_id = '$license_id', license_name = '$license_name', license_status = '$license_status' WHERE license_id = '$license_id' ");

      if($update)
      {
        $msg="Successfully Updated!!";
        echo "<script type='text/javascript'>alert('$msg');</script>";
        header('Location:index.php');
      }
      else
      {
       $errormsg="Something went wrong, Try again";
        echo "<script type='text/javascript'>alert('$errormsg');</script>";
        header('Location:index.php');
      }
  }
  else
  {
      $insert = mysql_query("INSERT INTO licenseplate(license_id,license_name,license_status)VALUES
                    ('$license_id','$license_name','$license_status')");

      if($insert)
      {
        $msg="Successfully Updated!!";
        echo "<script type='text/javascript'>alert('$msg');</script>";
        header('Location:index.php');
      }
      else
      {
       $errormsg="Something went wrong, Try again";
        echo "<script type='text/javascript'>alert('$errormsg');</script>";
        header('Location:index.php');
      }
  }
  
  
  }
 ob_end_flush();
?>