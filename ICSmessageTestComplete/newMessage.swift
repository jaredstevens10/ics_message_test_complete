//
//  newMessage.swift
//  ICSmessageTestComplete
//
//  Created by Jared Stevens2 on 1/9/17.
//  Copyright © 2017 Jared Stevens. All rights reserved.
//

import Foundation


/*
 
 <?php
 
 header('Content-type: application/json');
 
 /*
 if($_GET) {
 $toUser = $_GET['toUser'];
 $date = $_GET['date'];
 $comments2 = $_GET['message'];
 $fromUser = $_GET['fromUser'];
 */
 
 if($_POST) {
 
 //get the information that the app is sending
 $toUser = $_POST['toUser'];
 $date = $_POST['date'];
 $comments2 = $_POST['message'];
 $fromUser = $_POST['fromUser'];
 
 //decode the message data
 $Message = rawurldecode($comments2);
 
 //get the current time date
 $time = date('Y-m-d H:i:s', time());
 
 $servername = "localhost";
 $A_username = "clavenso_Admin";
 $A_password = "claven01*";
 $dbname = "clavenso_ICSmessageTest";
 
 //application address
 define('DIR','http://clavensolutions.com/Apps/ICSmessageTest/');
 define('SITEEMAIL','admin@clavensolutions.com');
 
 //make a connection to the database
 try {
 
	//create PDO connection
	
 $dbh = new PDO("mysql:host=$servername;dbname=$dbname", $A_username, $A_password);
 $dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
 
	//if no errors have been created carry on
	if(!isset($error)){
 
 
 //SQL statement to insert the data into the database
 $stmt = $dbh->prepare("INSERT INTO messages (messageData, toUser, fromUser, date) VALUES (?, ?, ?, ?)");
 
 $stmt->bindParam(1, $Message);
 $stmt->bindParam(2, $toUser);
 $stmt->bindParam(3, $fromUser);
 $stmt->bindParam(4, $time);
 
 
 
 /*** execute the query ***/
 $stmt->execute();
 
 //find out how many rows were saved, we just need 1 :)
 $success = $stmt->rowCount();
 
 }
 }
 catch(Exception $e)
 {
 {
 //if there were any errors connecting to the database, let us know here
 echo '{"success":0,"error_message":'.$e->getMessage().'}';
 }
 
 
 }
 
 if ($success > 0) {
 
 //if one row was saved ($success) then let the application know that the message was successfully saved to the database
 
 echo '{"success":1}';
 
 } else {
 //if one row was not saved, then let the application know there was an error.
	echo '{"success":2,"error_message":"Message not sent."}';
	}
	
 } else {
 
 echo '{"success":0,"error_message":"Connection Error."}';
 
 }
 
 
 ?>

*/



/*

 
 <?php
 
 header('Content-type: application/json');
 if($_POST) {
 
 $UserName   = $_POST['username'];
 
 
 $servername = "localhost";
 $A_username = "clavenso_Admin";
 $A_password = "claven01*";
 $dbname = "clavenso_ICSmessageTest";
 
 
 //application address
 define('DIR','http://clavensolutions.com/Apps/ICSmessageTest/');
 define('SITEEMAIL','admin@clavensolutions.com');
 
 //try and make a connection to the database
 try {
 
	//create PDO connection
 
	$db = new PDO("mysql:host=$servername;dbname=$dbname", $A_username, $A_password);
 
	//if no errors have been created carry on
	if(!isset($error)){
 
 
 
 //select all the message data from the database where the toUser = the username who is requesting it
 $MessageData = "SELECT * FROM messages WHERE toUser = \"" . $UserName . "\" ORDER BY date DESC";
 
 $stmt = $db->prepare($MessageData);
 $stmt->execute();
 
 //let the app know that a connection was made.  for this example..success = 1
 echo"{\"success\":1,\"Data\":[";
 
 
 //Loop through each found message
 
 while($rows = $stmt->fetch(PDO::FETCH_ASSOC)){
 
 //encode the message data so it can be sent
 $CommentData = base64_encode($rows[messageData]);
 
 //return the message info to the application
 
 echo "{\"id\":\"$rows[id]\",\"toUser\":\"$rows[toUser]\",\"fromUser\":\"$rows[fromUser]\",\"message\":\"$CommentData\",\"datetimestamp\":\"$rows[date]\"},";
 
 }
 
 
 
 echo "{\"id\":\"NA\",\"toUser\":\"NA\",\"fromUser\":\"NA\",\"message\":\"NA\",\"datetimestamp\":\"NA\"}]}";
 }
 }
 catch(Exception $e)
 {
 {
 
 //if there is an error connecting to the database, return the error below
 echo '{"success":0,"error_message":'.$e->getMessage().'}';
 }
 
 
 }
 
 /*
 if ($success > 0) {
 
 
 } else {
 //echo '{"success":2,"error_message":"No Status Change."}';
 }
 */
	
 } else {
 
 echo '{"success":0,"error_message":"Invalid Data."}';
 
 }
 
 
 ?>
 
*/
