<?php

/**
 * Delete a ride
 */

require "../config.php";
require "../common.php";

$success = null;

if (isset($_POST["submit"])) {
	if (!hash_equals($_SESSION['csrf'], $_POST['csrf'])) die();

	try {
		$connection = new PDO($dsn, $username, $password, $options);
	
		$cust_id = $_POST["submit"];
		$driver_id = $_POST["driver"];

		$sql = "DELETE FROM ride WHERE customer = $cust_id AND driver = $driver_id";

		$statement = $connection->prepare($sql);
		$statement->bindValue(':customer', $cust_id);
		$statement->bindValue(':driver', $driver_id);
		$statement->execute();

		$success = "Ride successfully canceled ";
	} catch(PDOException $error) {
		echo $sql . "<br>" . $error->getMessage();
	}
}


try {
	$connection = new PDO($dsn, $username, $password, $options);

	$sql =  "SELECT r.customer,
			(SELECT person.firstName FROM person FORCE INDEX(person_By_Type) WHERE personID = r.customer) AS
			customer_firstname,
			(SELECT person.lastName FROM person FORCE INDEX(person_By_Type) WHERE personID = r.customer) AS
			customer_lastname,
			r.driver,
			(SELECT person.firstName FROM person FORCE INDEX(person_By_Type) WHERE personID = r.driver) AS
			driver_firstname,
			(SELECT person.lastName FROM person FORCE INDEX(person_By_Type) WHERE personID = r.driver) AS
			driver_lastname,
			r.golfcart,
			(SELECT g.Make FROM golfcart g WHERE g.cartID = r.golfcart) AS golfcart_make,
			(SELECT l.locationName FROM location l WHERE l.locationID = r.pickupLocation) AS locationName,
			r.pickUpTime as 'date', r.pickUpTime as 'time'			
			FROM ride r ORDER BY r.pickUpTime";

	$statement = $connection->prepare($sql);
	$statement->execute();

	$result = $statement->fetchAll();
} catch(PDOException $error) {
	echo $sql . "<br>" . $error->getMessage();
}
?>
<?php require "templates/header.php"; ?>
				
<h2>Cancel Ride</h2>

<?php if ($success) echo $success; ?>


<table>
	<thead>
		<tr>
			<th>Rider ID</th>
			<th>Rider Firstname</th>
			<th>Rider Lastname</th>
			<th>Drive ID</th>
			<th>Driver Firstname</th>
			<th>Driver Lastname</th>
			<th>Golf Cart ID</th>
			<th>Golf Cart Model</th>
			<th>Location</th>
			<th>Ride Date</th>
			<th>Ride Time</th>
		</tr>
	</thead>
	<tbody>
	<?php foreach ($result as $row) : ?>

		<form method="post">
		<input name="csrf" type="hidden" value="<?php echo escape($_SESSION['csrf']); ?>">
		<tr>
			<td><?php echo escape($row["customer"]); ?></td>
			<td><?php echo escape($row["customer_firstname"]); ?></td>
			<td><?php echo escape($row["customer_lastname"]); ?></td>
			<td><?php echo escape($row["driver"]); ?></td>
			<td><?php echo escape($row["driver_firstname"]); ?></td>
			<td><?php echo escape($row["driver_lastname"]); ?></td>
			<td><?php echo escape($row["golfcart"]); ?></td>
			<td><?php echo escape($row["golfcart_make"]); ?></td>
			<td><?php echo escape($row["locationName"]); ?></td>
			<td><?php echo escape(date("F jS, Y", strtotime($row["date"]))); ?></td>
			<td><?php echo escape(date("h:i A", strtotime($row["date"]))); ?></td>
			<input type="hidden" name="driver" id="driver" value="<?php echo escape($row["driver"]) ?>" />
			<td><button type="submit" name="submit" value="<?php echo escape($row["customer"]); ?>">Delete</button></td>
		</tr>
		</form>
	<?php endforeach; ?>
	</tbody>
</table>


<a href="index.php">Back to home</a>

<?php require "templates/footer.php"; ?>