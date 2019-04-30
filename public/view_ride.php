<?php

/**
 * Function to query information based on 
 * a parameter: in this case, ride.
 *
 */

require "../config.php";
require "../common.php";

if (isset($_POST['submit'])) {
	if (!hash_equals($_SESSION['csrf'], $_POST['csrf'])) die();

	try  {
		$connection = new PDO($dsn, $username, $password, $options);

		$sql = "SELECT ride.customer as CustomerID, 
				CONCAT(person.lastName,',',person.firstName) as Rider, 
				ride.pickUpTime as 'Pick Up Date', ride.pickUpTime as 'Pick Up Time', 
				location.locationName as Location
				FROM ride 
				INNER JOIN person
				ON person.personID = ride.customer 
				INNER JOIN location ON ride.pickUpLocation = location.locationID 
				WHERE ride.customer = :customer_id
				ORDER BY ride.pickUpTime";

		// $customer_id = $_POST['customer_id'];
		$statement = $connection->prepare($sql);
		$statement->bindParam(':customer_id', $customer_id, PDO::PARAM_STR);
		$statement->execute();

		$result = $statement->fetchAll();
	} catch(PDOException $error) {
			echo $sql . "<br>" . $error->getMessage();
	}
}
?>
<?php require "templates/header.php"; ?>
				
<?php  
if (isset($_POST['submit'])) {
	if ($result && $statement->rowCount() > 0) { ?>
		<h2>Results</h2>

		<table>
			<thead>
				<tr>
				<th>CustomerID</th>
				<th>Rider</th>
				<th>Ride Date</th>
				<th>Ride Time</th>
				<th>Location</th>
				</tr>
			</thead>
			<tbody>
			<?php foreach ($result as $row) : ?>
				<tr>
					<td><?php echo escape($row["CustomerID"]); ?></td>
					<td><?php echo escape($row["Rider"]); ?></td>
					<td><?php echo escape(date("F jS, Y", strtotime($row["Pick Up Date"]))); ?></td>
					<td><?php echo escape(date("h:i A", strtotime($row["Pick Up Time"]))); ?></td>
					<td><?php echo escape($row["Location"]); ?></td>
				</tr>
			<?php endforeach; ?>
			</tbody>
		</table>
		<?php } else { 
			if (strlen($_POST['customer_id']) == 0) {?>
				<blockquote>Please enter your ID.</blockquote>
			<?php } else {?>
			<blockquote>No results found for ID:<?php echo escape($_POST['customer_id']); ?>.</blockquote>
			<?php }?>
		<?php } 
} ?> 

<h2>View Rides.</h2>

<form method="post">
	<input name="csrf" type="hidden" value="<?php echo escape($_SESSION['csrf']); ?>">
	<label for="customer_id">Enter your ID</label>
	<input type="text" id="customer_id" name="customer_id">
	<input type="submit" name="submit" value="View Your Rides">
</form>
<a href="view_all_rides.php">Click here to view all rides.</a>
<br>
<a href="index.php">Back to home</a>

<?php require "templates/footer.php"; ?>