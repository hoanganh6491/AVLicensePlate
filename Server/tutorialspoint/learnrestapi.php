<?php
require_once("Rest.inc.php");

class API extends REST 
{
public $data = "";
const DB_SERVER = "localhost";
const DB_USER = "myDB";
const DB_PASSWORD = "";
const DB = "Book";

private $db = NULL;

public function __construct()
{
parent::__construct();// Init parent contructor
$this->dbConnect();// Initiate Database connection
}

//Database connection
private function dbConnect()
{
$this->db = mysql_connect(self::DB_SERVER,self::DB_USER,self::DB_PASSWORD);
if($this->db)
mysql_select_db(self::DB,$this->db);
}

//Public method for access api.
//This method dynmically call the method based on the query string
public function processApi()
{
$func = strtolower(trim(str_replace("/","",$_REQUEST['rquest'])));
if((int)method_exists($this,$func) > 0)
$this->$func();
else
$this->response('',404); 
// If the method not exist with in this class, response would be "Page not found".
}

function get_app_list() {
// Cross validation if the request method is POST else it will return "Not Acceptable" status
	if($this->get_request_method() != "GET")
	{
		$this->response('',406);
	}

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

private function login()
{
	// Cross validation if the request method is POST else it will return "Not Acceptable" status
	if($this->get_request_method() != "POST")
	{
		$this->response('',406);
	}

	$email = $this->_request['email'];  
	$password = $this->_request['pwd'];

	// Input validations
	if(!empty($email) and !empty($password))
	{
		if(filter_var($email, FILTER_VALIDATE_EMAIL)){
			$sql = mysql_query("SELECT user_id, user_fullname, user_email FROM users WHERE user_email = '$email' AND user_password = '".md5($password)."' LIMIT 1", $this->db);
			if(mysql_num_rows($sql) > 0){
				$result = mysql_fetch_array($sql,MYSQL_ASSOC);

				// If success everythig is good send header as "OK" and user details
				$this->response($this->json($result), 200);
			}
			$this->response('', 204); // If no records "No Content" status
		}
	}

	// If invalid inputs "Bad Request" status message and reason
	$error = array('status' => "Failed", "msg" => "Invalid Email address or Password");
	$this->response($this->json($error), 400);
}

private function users()
{

}

private function deleteUser()
{

}

//Encode array into JSON
private function json($data)
{
if(is_array($data)){
return json_encode($data);
}
}
}

// Initiiate Library
$api = new API;
$api->processApi();
?>