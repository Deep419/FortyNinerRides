<?php

/**
 * Use an HTML form to create a new entry in the
 * users table.
 *
 */

require "../config.php";
require "../common.php";

if (isset($_POST['book'])) {
	if (!hash_equals($_SESSION['csrf'], $_POST['csrf'])) die();

	try  {
		$connection = new PDO($dsn, $username, $password, $options);
		
		//Check if user exists
		$cust_id = $_POST['p_id'];
		$statement = $connection->prepare("SELECT * FROM person WHERE personID LIKE $cust_id"); 
		$statement->execute();
		$result = $statement->fetchAll();
		if (sizeof($result) == 0) {
			echo "ID not found in Database! Enter valid ID. Use 21611647 for testing purposes.";
		}
		else {
			//Format date into correct MySQL format
			$formatted_dateTime = date("Y-m-d H:i:s",strtotime($_POST['date_t']));
			
			//Logic to get carts that are not in use. If all carts in use, prompt user to try different time.
			$statement = $connection->prepare(
				"SELECT golfCart 
				FROM ride 
				WHERE pickUpTime 
				BETWEEN \"$formatted_dateTime\" 
				AND DATE_ADD(\"$formatted_dateTime\",INTERVAL 1 HOUR);"); 
			$statement->execute();
			$result = $statement->fetchAll();
			$in_use_carts = array();
			if (sizeof($result) != 0) {
				foreach($result as $row) :
					array_push($in_use_carts,$row[0]);
				endforeach;
			} 
			
			$statement = $connection->prepare("SELECT cartID FROM golfcart");
			$statement->execute();
			$result = $statement->fetchAll();
			$unique_carts = array();		
			foreach($result as $row) :
				array_push($unique_carts,$row[0]);
			endforeach;

			//Grab free driver, randomly
			$statement = $connection->prepare("SELECT personID from driver");
			$statement->execute();
			$result = $statement->fetchAll();
			$unique_drivers = array();
			foreach($result as $row) :
				array_push($unique_drivers,$row[0]);
			endforeach;
			// print_r($unique_drivers);

			$in_use_carts = array();
			$free_carts = array_diff($unique_carts,$in_use_carts);

			//Get PickUpLocation ID
			$location = $_POST['location'];
			$statement = $connection->prepare("SELECT locationID FROM location WHERE locationName LIKE '$location'");
			$statement->execute();
			$result = $statement->fetchAll();		
			foreach($result as $row) :
				$location_id = $row[0];
			endforeach;

			//Pick the first free carts if free carts not empty
			if (sizeof($free_carts) == 0) {
				echo "All Carts in use. Try later time.";
			}
			else {
				//Pick first cart and random driver and INSERT ride
				$cart_id = $free_carts[0];
				$rand_keys = array_rand($unique_drivers, 1);
				$driver_id = $unique_drivers[$rand_keys];

				//Get Driver Details
				$statement = $connection->prepare("SELECT * FROM person WHERE personID LIKE $driver_id");
				$statement->execute();
				$driver_details = $statement->fetchAll();
				
				$new_ride = array(
					"customer" => $_POST['p_id'],
					"driver" => $driver_id,
					"pickUpTime" => $formatted_dateTime,
					"pickUpLocation" => $location_id,
					"golfCart" => $cart_id
				);

				$sql = sprintf(
					"INSERT INTO %s (%s) values (%s)",
					"ride",
					implode(", ", array_keys($new_ride)),
					":" . implode(", :", array_keys($new_ride))
				);

				print_r($sql);
				
				$statement = $connection->prepare($sql);
				$statement->execute($new_ride);
			}
		}
	} catch(PDOException $error) {
			echo $sql . "<br>" . $error->getMessage();
	}
}
?>
<?php require "templates/header.php"; ?>

<!-- Pop-up when ride is booked -->
<?php if (isset($_POST['book']) && $statement) : ?>
	<blockquote>Ride Booked! <br> Your Driver Details: <br>
		Name : <?php echo escape($driver_details[0][2]); ?> <br>
		Contact : <?php echo escape($driver_details[0][6]); ?> </blockquote>
<?php endif; ?>

<h2>Book A Ride!</h2>

<form method="post">
	<input name="csrf" type="hidden" value="<?php echo escape($_SESSION['csrf']); ?>">
	<label for="p_id">Your ID</label>
	<input type="text" name="p_id" id="p_id">
	<label for="date_t">Date-Time for Ride</label>
	<input type="datetime-local" name="date_t" id="date_t">
	<label for="location">Pick Up Location</label>
	<select name="location" id="location">
	<?php 
	try  {
		$db = new PDO($dsn, $username, $password, $options);
		$query = $db->query("SELECT locationName FROM location"); // Run your query

		echo '<option value="locationName">'; // Open your drop down box

		// Loop through the query results, outputing the options one by one
		while ($row = $query->fetch(PDO::FETCH_ASSOC)) {
			echo '<option value="'.$row['locationName'].'">'.$row['locationName'].'</option>';
		}

		echo '</option>';// Close your drop down box 
	} catch(PDOException $error) {
		echo $query . "<br>" . $error->getMessage();
	}
		?>
	<input type="submit" name="book" value="Book!">
</form>

<a href="index.php">Back to home</a>

<?php require "templates/footer.php"; ?>
