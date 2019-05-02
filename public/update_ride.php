<?php

/**
 * List all rides with a link to edit.
 */

require "../config.php";
require "../common.php";

try {
	$connection = new PDO($dsn, $username, $password, $options);

	$sql = "SELECT ride.customer as RiderID, 
			CONCAT(person.lastName,', ',person.firstName) as Rider,
			ride.pickUpTime as 'Pick Up Date', ride.pickUpTime as 'Pick Up Time', 
			ride.driver,
			location.locationName as Location
			FROM ride
			INNER JOIN person
			ON person.personID = ride.customer 
			INNER JOIN location ON ride.pickUpLocation = location.locationID";

	$statement = $connection->prepare($sql);
	$statement->execute();

	$result = $statement->fetchAll();
} catch(PDOException $error) {
	echo $sql . "<br>" . $error->getMessage();
}
?>
<?php require "templates/header.php"; ?>
		
<h2>Update Rides</h2>

<table>
	<thead>
		<tr>
			<th>Rider ID</th>
			<th>Rider</th>
			<th>Ride Date</th>
			<th>Ride Time</th>
			<th>Location</th>
			<th>Edit</th>
		</tr>
	</thead>
	<tbody>
	<?php foreach ($result as $row) : ?>
		<tr>
			<td><?php echo escape($row["RiderID"]); ?></td>
			<td><?php echo escape($row["Rider"]); ?></td>
			<td><?php echo escape(date("F jS, Y", strtotime($row["Pick Up Date"]))); ?></td>
			<td><?php echo escape(date("h:i A", strtotime($row["Pick Up Time"]))); ?></td>
			<td><?php echo escape($row["Location"]); ?></td>
			<td><a href="update_single_ride.php?
				riderid=<?php echo escape($row["RiderID"]); ?>
				&time=<?php echo date("Y-m-d_H:i:s",strtotime($row["Pick Up Date"])); ?>
				&driver=<?php echo escape($row["driver"]); ?>
				&pickup=<?php echo escape($row["Location"]); ?>">Edit</a></td>
		</tr>
	<?php endforeach; ?>
	</tbody>
</table>

<a href="index.php">Back to home</a>

<?php require "templates/footer.php"; ?>