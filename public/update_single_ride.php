<?php

/**
 * Use an HTML form to edit an entry in the rides table.
 *
 */

require "../config.php";
require "../common.php";

if (isset($_POST['submit'])) {
	if (!hash_equals($_SESSION['csrf'], $_POST['csrf'])) die();

	try {
		$connection = new PDO($dsn, $username, $password, $options);
		
		$formatted_dateTime = date("Y-m-d H:i:s",strtotime($_POST['pickUpTime']));
		$old_time = $_POST['oldTime'];
		$old_time = date("Y-m-d H:i:s",strtotime($old_time));
		$driver= $_POST['driver'];
		$cust_id = $_POST['customer'];
		$cart_id = $_POST['golfCart'];

		//Get PickUpLocation ID
		$location = $_POST['pickUpLocation'];
		$statement = $connection->prepare("SELECT locationID FROM location WHERE locationName LIKE '$location'");
		$statement->execute();
		$result = $statement->fetchAll();		
		foreach($result as $row) :
			$location_id = $row[0];
		endforeach;

		$new_ride = array(
			"customer" => $cust_id,
			"driver" => $driver,
			"pickUpTime" => $formatted_dateTime,
			"pickUpLocation" => $location_id,
			"golfCart" => $cart_id
		);

		$sql = "UPDATE ride
				SET pickUpTime = \"$formatted_dateTime\", pickUpLocation = $location_id
				WHERE ride.customer = $cust_id 
				AND ride.driver = $driver 
				AND ride.pickUpTime = \"$old_time\"
				ORDER BY ride.pickUpTime";
	
		$statement = $connection->prepare($sql);
		$statement->execute($new_ride);
	} catch(PDOException $error) {
			echo $sql . "<br>" . $error->getMessage();
	}
}
	
if (isset($_GET['riderid'])) {
	try {
		$connection = new PDO($dsn, $username, $password, $options);
		$id = $_GET['riderid'];
		$time = $_GET['time'];
		$time = str_replace("_"," ",$time);
		// $formatted_dateTime = date("Y-m-d H:i:s",strtotime($_GET['time']));
		$driver = $_GET['driver'];
		
		// echo $id."<br>";
		// echo $_GET['time']."<br>";
		// echo $time."<br>";
		// echo $driver."<br>";

		// "SELECT * FROM `ride` WHERE `customer` = 62022838 AND `pickUpTime`='2019-02-10 13:00:00' AND `driver`= 265586444"
		$sql = "SELECT * FROM ride WHERE customer = :id AND pickUpTime = :time AND driver = :driver";
		$statement = $connection->prepare($sql);
		$statement->bindValue(':id', $id);
		$statement->bindValue(':time', $time);
		$statement->bindValue(':driver', $driver);
		$statement->execute();
		
		$user = $statement->fetch(PDO::FETCH_ASSOC);
	} catch(PDOException $error) {
			echo $sql . "<br>" . $error->getMessage();
	}
} else {
		echo "Something went wrong!";
		exit;
}
?>

<?php require "templates/header.php"; ?>

<?php if (isset($_POST['submit']) && $statement) : ?>
	<blockquote>Your ride is successfully updated.</blockquote>
<?php endif; ?>

<h2>Edit a ride</h2>

<form method="post">
		<input name="csrf" type="hidden" value="<?php echo escape($_SESSION['csrf']); ?>">
		
		<?php 
		// $user['customer']
		// $user['driver']
		// $user['pickUpTime']
		// $user['pickUpLocation']
		// $user['golfCart'] 
		// $html_time = date("m/d/Y H:i A",strtotime($user['pickUpTime']));
		$html_time = date("Y-m-d H:i",strtotime($user['pickUpTime']));
		$html_time = str_replace(" ","T",$html_time);
		echo $time."<br>";
		?>

		<label for="customer">Your ID</label>
		<input type="text" name="customer" id="customer" value="<?php echo escape($user['customer']); ?>" readonly>
		<label for="pickUpTime">Change your ride date-time?</label>
		<input type="datetime-local" name="pickUpTime" id="pickUpTime" value="<?php echo $html_time; ?>">
		<label for="pickUpLocation">Change your pick up location?</label>
		<select name="pickUpLocation" id="pickUpLocation">
		<?php 
		try  {
			$db = new PDO($dsn, $username, $password, $options);
			$query = $db->query("SELECT locationName FROM location"); // Run your query

			// Loop through the query results, outputing the options one by one
			while ($row = $query->fetch(PDO::FETCH_ASSOC)) {
				echo $row;
				if ($row['locationName'] == $_GET['pickup']) {
					echo '<option selected="selected" value="'.$row['locationName'].'">'.$row['locationName'].'</option>';
				} else {
					echo '<option value="'.$row['locationName'].'">'.$row['locationName'].'</option>';
				}
				
			}

			echo '</option>';// Close your drop down box 
		} catch(PDOException $error) {
			echo $query . "<br>" . $error->getMessage();
		}
		?>
		<input type="hidden" name="driver" id="driver" value="<?php echo $user['driver'] ?>" />
		<input type="hidden" name="golfCart" id="golfCart" value="<?php echo $user['golfCart'] ?>" />
		<input type="hidden" name="oldTime" id="oldTime" value="<?php echo $time ?>" />
		<input type="submit" name="submit" value="Submit">
</form>

<a href="index.php">Back to home</a>

<?php require "templates/footer.php"; ?>
