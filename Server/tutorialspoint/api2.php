
<?php
// This is the API, 2 possibilities: show the app list or show a specific app by id.
 header('Content-type: application/json');
function get_app_by_id($id) {
    $con = mysql_connect('localhost', 'root', '');
    if (!$con) {
        die('Could not connect: ' . mysql_error());
    }
 
    $db_selected = mysql_select_db('myDB', $con);
    if (!$db_selected) {
        die('Can\'t use dbname : ' . mysql_error());
    }
    $sql = "SELECT id,name from Book where id='" . $id . "'";
    $result = mysql_query($sql);
    if (!$result) {
        die('Invalid query: ' . $sql . "   " . mysql_error());
    }
//Allocate the array
    $app_info = array();
    $row = mysql_fetch_array($result);
 
    $f1 = $row['id'];
    $f2 = $row['name'];
 
    $app_info = array('id' => $f1, 'name' => $f2);
    mysql_close($con);
    return $app_info;
}

function insert_new_book() {
    // Connect db
	$books = $_REQUEST["books"];
	$con = mysql_connect('localhost', 'root', '');
    if (!$con) {
        die('Could not connect: ' . mysql_error());
    }
	//echo 'Connected successfully';
    $db_selected = mysql_select_db('myDB', $con);
    if (!$db_selected) {
        die('Can\'t use dbname: ' . mysql_error());
    }
    
		foreach ($books as $abc) {
			$getData = "SELECT * from Book where id='" .$abc["id"]. "'";
			$data = mysql_query($getData);
			if ($data) {
				$total_row =  mysql_num_rows($data);			
				if ($total_row > 0) {
					$sql = "UPDATE Book set name = '" . $abc["name"] . "' where id =" . $abc["id"] . "";                			
					$result = mysql_query($sql);
					if (!$result) {
						die('Invalid query: ' . $sql . "   " . mysql_error());
					}
				} else {
					$sql = "INSERT INTO Book (id, name) VALUES (". $abc["id"] .",". $abc["name"] .")";  
					$result = mysql_query($sql);
					if (!$result) {
						die('Invalid query: ' . $sql . "   " . mysql_error());
					}              			
				}
			} else {
				die('Invalid query: ' . $sql . "   " . mysql_error());
			}
		}

	
    $sql = "SELECT id,name from Book";
    $result = mysql_query($sql);
    if (!$result) {
        die('Invalid query: ' . $sql . "   " . mysql_error());
    }
	//Allocate the array
    $app_list = array();
	//Loop through database to add books to array
    while ($row = mysql_fetch_array($result)) {
        $app_list[] = array('id' => $row['id'], 'name' => $row['name']);
    }
    mysql_close($con);
    return $app_list;
    // Close connection
}

function get_app_list() {
//Build the JSON array from the database
    $con = mysql_connect('localhost', 'root', '');
    if (!$con) {
        die('Could not connect: ' . mysql_error());
    }
//echo 'Connected successfully';
    $db_selected = mysql_select_db('myDB', $con);
    if (!$db_selected) {
        die('Can\'t use dbname: ' . mysql_error());
    }
    $sql = "SELECT id,name from Book";
    $result = mysql_query($sql);
    if (!$result) {
        die('Invalid query: ' . $sql . "   " . mysql_error());
    }
//Allocate the array
    $app_list = array();
//Loop through database to add books to array
    while ($row = mysql_fetch_array($result)) {
        $app_list[] = array('id' => $row['id'], 'name' => $row['name']);
    }
    mysql_close($con);
    return $app_list;
}
$possible_url = array("get_app_list", "get_app", "insert_new_book");
$value = "An error has occurred";
$sAction = $_REQUEST["action"];
if (isset ($sAction) && in_array($sAction, $possible_url)) {
    switch ($sAction) {
        case "get_app_list" :
            $value = get_app_list();
            break; 
        case "insert_new_book" :
            $value = insert_new_book();
            break;                     
        case "get_app" :
            if (isset ($_GET["id"]))
                $value = get_app_by_id($_GET["id"]);
            else
                $value = "Missing argument";
            break;
    }
}
//return JSON array
exit (json_encode($value));
?>