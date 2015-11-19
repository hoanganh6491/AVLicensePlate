<html>
 <body>
 
<?php
if (isset ($_GET["action"]) && isset ($_GET["id"]) && $_GET["action"] == "get_app") {
    $app_info = file_get_contents('http://localhost/tutorialspoint/api2.php?action=get_app&id=' . $_GET["id"]);
    $app_info2 = json_decode($app_info, true);
    
    ?>
    <table border="1">
      <tr>
        <td>Book Number: </td><td> <?php echo $app_info2["id"];?></td>
      </tr>
      <tr>
        <td>Book Name: </td><td> <?php echo $app_info2["name"] ?></td>
      </tr>
    </table>
    <br />
    <a href="http://localhost/tutorialspoint/RestDBClient.php?action=get_app_list" alt="app list">Return to the app list</a>
          <?php
  }
  else // else take the app list
	  {

	  $app_list = file_get_contents('http://localhost/tutorialspoint/api2.php?action=get_app_list');
	  $app_list = json_decode($app_list, true);
	  ?>
<H2>Here is the list of Apps</H2>
<ul>
<?php foreach ($app_list as $app) : ?>
  <li>
	<a href=<?php echo "http://localhost/tutorialspoint/RestDBClient.php?action=get_app&id=" . $app["id"] ?> alt=<?php echo "id" . $app["id"] ?>><?php echo $app["name"] ?></a>
</li>
<?php endforeach;?>
</ul>
	  <?php
  }
      ?>
 </body>
</html>