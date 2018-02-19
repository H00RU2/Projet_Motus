<?php

include("db/connect.php");

$strSQL = "select Commande.IDCO, Commande.DATEC, Client.PRENOMC, Client.NOMC from Commande, Client where Commande.IDC=Client.IDC";
 
$stmt = oci_parse($dbConn,$strSQL);
if ( ! oci_execute($stmt) ){
$err = oci_error($stmt);
trigger_error('Query failed: ' . $err['message'], E_USER_ERROR);
};
 

?>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Liste de commandes</title>
	<link rel="stylesheet" href="css/main.css" />
	<script src="js/script.js"></script> 
</head>

<body>
	<section>
	<h1>Liste de commandes</h1>
		<table>
		<tr>
		<th>Id</th>
		<th>Date</th>
		<th>Client</th>
		<th>&nbsp;</th>
		</tr>

<?php
while(oci_fetch($stmt)){
  $rsltid = oci_result($stmt, 1); 
  $rsltdate = oci_result($stmt, 2); 
  $rsltpre = oci_result($stmt, 3); 
  $rsltnom = oci_result($stmt, 4); 
  print "<tr><td>".$rsltid."</td><td>".$rsltdate."</td><td>".$rsltpre." ".$rsltnom."</td>";
?>
  		<td><button type="button" onclick="loadDoc('getDetail.php?id=<?php echo $rsltid;?>', myFunction)">Afficher detail</button></td>
<?php
  print "</tr>\n";
}
?>
		</table>
	</section>
	<section id="detail">
	</section>
</body>
</html> 


