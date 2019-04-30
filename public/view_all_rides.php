<?php

/**
 * Function to query information based on 
 * a parameter: in this case, ride.
 *
 */

require "../config.php";
require "../common.php";

try  {
	$connection = new PDO($dsn, $username, $password, $options);

	$sql =  "SELECT r.customer,
			(SELECT Person.firstName FROM Person FORCE INDEX(Person_By_Type) WHERE personID = r.customer) AS
			customer_firstname,
			(SELECT Person.lastName FROM Person FORCE INDEX(Person_By_Type) WHERE personID = r.customer) AS
			customer_lastname,
			r.driver,
			(SELECT Person.firstName FROM Person FORCE INDEX(Person_By_Type) WHERE personID = r.driver) AS
			driver_firstname,
			(SELECT Person.lastName FROM Person FORCE INDEX(Person_By_Type) WHERE personID = r.driver) AS
			driver_lastname,
			r.golfCart,
			(SELECT g.Make FROM Golfcart g WHERE g.cartID = r.golfCart) AS golfcart_make,
			(SELECT l.locationName FROM location l WHERE l.locationID = r.pickupLocation) AS locationName,
			r.pickUpTime as 'date', r.pickUpTime as 'time'			
			FROM Ride r ORDER BY r.pickUpTime";

	$statement = $connection->prepare($sql);
	// $statement->bindParam(':location', $location, PDO::PARAM_STR);
	$statement->execute();

	$result = $statement->fetchAll();
} catch(PDOException $error) {
		echo $sql . "<br>" . $error->getMessage();
}

?>
<?php require "templates/header.php"; ?>
<h2>View all Rides</h2>			
<?php  
if ($result && $statement->rowCount() > 0) { ?>

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
			<tr>
				<td><?php echo escape($row["customer"]); ?></td>
				<td><?php echo escape($row["customer_firstname"]); ?></td>
				<td><?php echo escape($row["customer_lastname"]); ?></td>
				<td><?php echo escape($row["driver"]); ?></td>
				<td><?php echo escape($row["driver_firstname"]); ?></td>
				<td><?php echo escape($row["driver_lastname"]); ?></td>
				<td><?php echo escape($row["golfCart"]); ?></td>
				<td><?php echo escape($row["golfcart_make"]); ?></td>
				<td><?php echo escape($row["locationName"]); ?></td>
				<td><?php echo escape(date("F jS, Y", strtotime($row["date"]))); ?></td>
				<td><?php echo escape(date("h:i A", strtotime($row["time"]))); ?></td>				
			</tr>
		<?php endforeach; ?>
		</tbody>
	</table>
	<?php } else { ?>
		<blockquote>No results found for <?php echo escape($_POST['location']); ?>.</blockquote>
	<?php } ?> 

<br>
<a href="index.php">Back to home</a>

<?php require "templates/footer.php"; ?>
