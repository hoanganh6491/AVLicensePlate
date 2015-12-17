<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Demo - Import Excel file data in mysql database using PHP, Upload Excel file data in database</title>
<meta name="description" content="This tutorial will learn how to import excel sheet data in mysql database using php. Here, first upload an excel sheet into your server and then click to import it into database. All column of excel sheet will store into your corrosponding database table."/>
<meta name="keywords" content="import excel file data in mysql, upload ecxel file in mysql, upload data, code to import excel data in mysql database, php, Mysql, Ajax, Jquery, Javascript, download, upload, upload excel file,mysql"/>


<style type="text/css">
body
{
	margin: 0;
	padding: 0;
	background-color:#D6F5F5;
	text-align:center;
}
.top-bar
	{
		width: 100%;
		height: auto;
		text-align: center;
		background-color:#FFF;
		border-bottom: 1px solid #000;
		margin-bottom: 20px;
	}
.inside-top-bar
	{
		margin-top: 5px;
		margin-bottom: 5px;
	}
.link
	{
		font-size: 18px;
		text-decoration: none;
		background-color: #000;
		color: #FFF;
		padding: 5px;
	}
.link:hover
	{
		background-color: #9688B2;
	}
</style>

<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-60962033-1', 'auto');
  ga('send', 'pageview');

</script>


</head>
<body>

<div class="top-bar">
		<div class="inside-top-bar">
			
			<br><br>
			<br><br>
			<br><br>
			<br><br>
		</div>
	</div>
    <div style="border:1px dashed #333333; width:300px; margin:0 auto; padding:10px;">
    
	<form name="import" method="post" enctype="multipart/form-data">
    	<input type="file" name="file" /><br />
        <input type="submit" name="submit" value="Submit" />
    </form>

<?php
/************************ YOUR DATABASE CONNECTION START HERE   ****************************/
if(isset($_POST["submit"]))
	{
		
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


$msg = 'Record has been added. <div style="Padding:20px 0 0 0;"><a href="">Go Back to tutorial</a></div>';
} else {
$msg = 'Record already exist. <div style="Padding:20px 0 0 0;"><a href="">Go Back to tutorial</a></div>';
}
}
echo "<div style='font: bold 18px arial,verdana;padding: 45px 0 0 500px;'>".$msg."</div>";
}

?>
<body>
<form name="import" method="post" enctype="multipart/form-data">
	Click submit store data in mysql
        <input type="submit" name="submit" value="Submit" style="margin-left:100px;"/>
    </form>
</html>