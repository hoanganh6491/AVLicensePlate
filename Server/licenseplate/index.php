<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Insert form</title>
<link type="text/css" media="all" rel="stylesheet" href="style.css">
</head>

<body>
<div class="display">
<form action="insert.php" method="post" name="insertform">
<p>
  <label for="id" id="preinput"> Biển số : </label>
  <input type="text" name="license_id" required placeholder="Nhập biển số" id="inputid"/>
</p>
<p>
  <label  for="name" id="preinput"> Tên : </label>
  <input type="text" name="license_name" required placeholder="Nhập tên" id="inputid" />
</p>
<p>
  <label  for="status" id="preinput"> Trạng thái : </label>
  <input type="checkbox" name="license_status" placeholder="Nhập trạng thái" id="inputid" />
</p>
<p>
  <input type="submit" name="send" value="Submit" id="inputid"  />
</p>
</form>
</div>
<?php include('view.php'); ?>
</body>
</html>