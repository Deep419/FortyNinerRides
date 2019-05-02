<?php

/**
 * Open a connection via PDO to create a
 * new database and table with structure.
 * 
 * Sometimes has issues with running all SQL queries. 
 * Current alternative, import dump file using phpmyadmin's import feature. *
 */

// require "config.php";

// try {
//     $connection = new PDO("mysql:host=$host", $username, $password, $options);
//     $sql = file_get_contents("data/Dump20190416.sql");
//     $connection->exec($sql);
    
//     echo "Database and table users created successfully.";
// } catch(PDOException $error) {
//     echo $sql . "<br>" . $error->getMessage();
// }
