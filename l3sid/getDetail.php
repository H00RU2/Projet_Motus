<?php

include("db/connect.php");



$strSQL = "select Detail.NOMBRE, Produit.NOMP, Produit.PRIXP from Detail, Produit where Detail.IDP=Produit.IDP and Detail.IDCO=".$_GET["id"];
 
$stmt = oci_parse($dbConn,$strSQL);
if ( ! oci_execute($stmt) ){
$err = oci_error($stmt);
trigger_error('Query failed: ' . $err['message'], E_USER_ERROR);
};
 
?>
<h2> Detail de la commande</h2>
<table>
<tr>
<th>
Nombre
</th>
<th>
Nom produit
</th>
<th>
Prix
</th>
</tr>

<?php

while(oci_fetch($stmt)){
  $rsltnombre = oci_result($stmt, 1); 
  $rsltnomp = oci_result($stmt, 2); 
  $rsltprip = oci_result($stmt, 3); 
  print "<tr><td>".$rsltnombre."</td><td>".$rsltnomp."</td><td>".$rsltprip."</td>";
  print "</tr>\n";
}
?>
</table>
