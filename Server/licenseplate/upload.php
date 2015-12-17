<?php

	/*
This script is use to upload any Excel file into database.
Here, you can browse your Excel file and upload it into 
your database.

Download Link: http://www.discussdesk.com/import-excel-file-data-in-mysql-database-using-PHP.htm

Website URL: http://www.discussdesk.com
*/

$uploadedStatus = 0;

if ( isset($_POST["submit"]) ) {
if ( isset($_FILES["file"])) {
//if there was an error uploading the file
if ($_FILES["file"]["error"] > 0) {
echo "Return Code: " . $_FILES["file"]["error"] . "<br />";
}
else {
if (file_exists($_FILES["file"]["name"])) {
unlink($_FILES["file"]["name"]);
}
$storagename = "testExcel.xlsx";
move_uploaded_file($_FILES["file"]["tmp_name"],  $storagename);
$uploadedStatus = 1;
}
} else {
echo "No file selected <br />";
}
}

?>



<html>

<head>
<title>Demo - Import Excel file data in mysql database using PHP, Upload Excel file data in database</title>
<meta name="description" content="This tutorial will learn how to import excel sheet data in mysql database using php. Here, first upload an excel sheet into your server and then click to import it into database. All column of excel sheet will store into your corrosponding database table."/>
<meta name="keywords" content="import excel file data in mysql, upload ecxel file in mysql, upload data, code to import excel data in mysql database, php, Mysql, Ajax, Jquery, Javascript, download, upload, upload excel file,mysql"/>

</head>

<body>

<table width="600" style="margin:115px auto; background:#f8f8f8; border:1px solid #eee; padding:10px;">

<form action="<?php echo $_SERVER["PHP_SELF"]; ?>" method="post" enctype="multipart/form-data">

<tr><td colspan="2" style="font:bold 21px arial; text-align:center; border-bottom:1px solid #eee; padding:5px 0 10px 0;">
</td></tr>

<tr><td colspan="2" style="font:bold 15px arial; text-align:center; padding:0 0 5px 0;">Data Uploading System</td></tr>

<tr>

<td width="50%" style="font:bold 12px tahoma, arial, sans-serif; text-align:right; border-bottom:1px solid #eee; padding:5px 10px 5px 0px; border-right:1px solid #eee;">Select file</td>

<td width="50%" style="border-bottom:1px solid #eee; padding:5px;"><input type="file" name="file" id="file" /></td>

</tr>





<tr>

<td style="font:bold 12px tahoma, arial, sans-serif; text-align:right; padding:5px 10px 5px 0px; border-right:1px solid #eee;">Submit</td>

<td width="50%" style=" padding:5px;"><input type="submit" name="submit" /></td>

</tr>

</table>

<?php
if($uploadedStatus==1)
{

echo "<table align='center'><tr><td  ><center>============================= <b>File Uploaded<b/> =============================================</center></td></tr>";

}?>
<?php
/************************ YOUR DATABASE CONNECTION START HERE   ****************************/
if(isset($_POST["submit"])) {
		
	define ("DB_HOST", "localhost"); // set database host
	define ("DB_USER", "root"); // set database user
	define ("DB_PASS","root"); // set database password
	define ("DB_NAME","myDB"); // set database name

	$link = mysql_connect(DB_HOST, DB_USER, DB_PASS) or die("Couldn't make connection.");
	$db = mysql_select_db(DB_NAME, $link) or die("Couldn't select database");

	$databasetable = "licenseplate";

	/************************ YOUR DATABASE CONNECTION END HERE  ****************************/


	set_include_path(get_include_path() . PATH_SEPARATOR . 'Classes/');
	include 'PHPExcel/IOFactory.php';


	// This is the file path to be uploaded.
	$inputFileName = 'testExcel.xlsx'; 

	try {
		$objPHPExcel = PHPExcel_IOFactory::load($inputFileName);
	} catch(Exception $e) {
		die('Error loading file "'.pathinfo($inputFileName,PATHINFO_BASENAME).'": '.$e->getMessage());
	}


	$allDataInSheet = $objPHPExcel->getActiveSheet()->toArray(null,true,true,true);
	$arrayCount = count($allDataInSheet);  // Here get total count of row in that Excel sheet


	for($i=2;$i<=$arrayCount;$i++){
		$license_id = trim($allDataInSheet[$i]["A"]);
		$license_name = trim($allDataInSheet[$i]["B"]);
		$license_status = trim($allDataInSheet[$i]["C"]);

		$query = "SELECT license_id FROM licenseplate WHERE license_id = '".$license_id."' and license_name = '".$license_name."'";
		$sql = mysql_query($query);
		$recResult = mysql_fetch_array($sql);
		$existName = $recResult["license_name"];

		if($existName=="") {
			$insertTable= mysql_query("insert into licenseplate (license_id, license_name, license_status) values('".$license_id."', '".$license_name."', '".$license_status."');");
			$msg = 'Record has been added. <div style="Padding:20px 0 0 0;">';
		} else {
			$msg = 'Record already exist. <div style="Padding:20px 0 0 0;"><a href="">Go Back to tutorial</a></div>';
		}
	}
	echo "<div style='font: bold 18px arial,verdana;padding: 45px 0 0 500px;'>".$msg."</div>";
}

?>
<body>

<?php include('view.php'); ?>

</form>
</body>

</html>