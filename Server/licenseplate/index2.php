<html>
<head>
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
	include ("db.php");
	date_default_timezone_set('America/Los_Angeles');

	include 'Classes/PHPExcel/IOFactory.php';
	
	//Check valid spreadsheet has been uploaded
	if(isset($_FILES['spreadsheet'])){
	if($_FILES['spreadsheet']['tmp_name']){
	if(!$_FILES['spreadsheet']['error'])
	{

	    $inputFile = $_FILES['spreadsheet']['tmp_name'];
	    $extension = strtoupper(pathinfo($inputFile, PATHINFO_EXTENSION));
	    if($extension == 'XLSX' || $extension == 'ODS'){

	        //Read spreadsheeet workbook
	        try {
	             $inputFileType = PHPExcel_IOFactory::identify($inputFile);
	             $objReader = PHPExcel_IOFactory::createReader($inputFileType);
	                 $objPHPExcel = $objReader->load($inputFile);
	        } catch(Exception $e) {
	                die($e->getMessage());
	        }

	        //Get worksheet dimensions
	        $sheet = $objPHPExcel->getSheet(0); 
	        $highestRow = $sheet->getHighestRow(); 
	        $highestColumn = $sheet->getHighestColumn();

	        //Loop through each row of the worksheet in turn
	        for ($row = 1; $row <= $highestRow; $row++){ 
	                //  Read a row of data into an array
	                $rowData = $sheet->rangeToArray('A' . $row . ':' . $highestColumn . $row, NULL, TRUE, FALSE);
	                //Insert into database
	        }
	    }
	    else{
	        echo "Please upload an XLSX or ODS file";
	    }
	}
	else{
	    echo $_FILES['spreadsheet']['error'];
	}
	}
	}
?>
    
    </div>
    <hr style="margin-top:300px;" />	
    

</body>
</html>