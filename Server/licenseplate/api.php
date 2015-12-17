
<?php
// This is the API, 2 possibilities: show the app list or show a specific app by id.
 if(!headers_sent() ) { header('Content-Type: application/json'); }

function get_all() {
    $con = mysql_connect('localhost', 'root', 'root');
    if (!$con) {
        die('Could not connect: ' . mysql_error());
    }
    //echo 'Connected successfully';
    $db_selected = mysql_select_db('myDB', $con);
    if (!$db_selected) {
        die('Can\'t use dbname: ' . mysql_error());
    }
    $sql = "SELECT license_id,license_name,license_status from licenseplate";
    $result = mysql_query($sql);
    if (!$result) {
        die('Invalid query: ' . $sql . "   " . mysql_error());
    }
    //Allocate the array
    $license_list = array();
    //Loop through database to add books to array
    while ($row = mysql_fetch_array($result)) {
        $license_list[] = array(
            'license_id' => $row['license_id'], 
            'license_name' => $row['license_name'], 
            'license_status' => $row['license_status']);
    }
    mysql_close($con);
    return $license_list;
}


$possible_url = array("get_all", "get_all_2", "get_app_list", "get_app", "insert_new_book");
$value = "An error has occurred";
$sAction = $_REQUEST["action"];
if (isset ($sAction) && in_array($sAction, $possible_url)) {
    switch ($sAction) {
        case "get_all" :
            $value = get_all();
            break;
        case "get_all_2" :
            $value = get_all_2();
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