<?php
 include('db.php');
  $select=mysql_query("SELECT * FROM licenseplate");
  $i=1;
  while($userrow=mysql_fetch_array($select))
  
  {
  $license_id=$userrow['license_id'];
  $license_name=$userrow['license_name'];
  $license_status=$userrow['license_status'];  
?>

<div class="display">
  <p> Biển số : <span><?php echo $license_id; ?></span>
  </p>
  <p> Tên : <span><?php echo $license_name; ?></span>
  </p>
  <p> Trạng thái : <span><?php echo $license_status; ?></span>
  </p>  
  <br />
</div>
<?php } ?>
