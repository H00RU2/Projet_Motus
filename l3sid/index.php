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
		<title>Jeu du Motus</title>
		<link rel="stylesheet" href="css/main.css" />
		<script src="js/script.js"></script> 
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	</head>

	<body>
		<div class="container">
            <div class="row">
                <div class="col-md-3">
                	Créé par Cassandre Ollivier
                    et Paul Sinel--Boucher
                    <div class="form-group">
					    <label for="choix_niveau">Choisissez un niveau</label>
					    <select class="form-control" id="choix_niveau">
					       <option>1</option>
					       <option>2</option>
					       <option>3</option>
					       <option>4</option>
					       <option>5</option>
					       <option>6</option>
					       <option>7</option>
					       <option>8</option>
					       <option>9</option>
					       <option>10</option>
					    </select>
					</div>
                    <button id="lancer_partie" type="submit" class="btn btn-primary">
                    	Lancer la partie
                    </button>
                </div>
                <div class="col-md-6">
                	Motus
                	<input id="mot_tester" type="text" class="typeahead" placeholder="Entrez un mot">
                    <button id="test_mot" type="submit" class="btn btn-primary">
                    	Essayer le mot
                    </button> 
                    <div>
                    	<?php
                    	include("db/connect.php");
                    	for($i=0 ; $i<8 ; $i++) {
                    		echo "<tr>\n";
                    		for($j=0 ; $j < 8 ; $j++){
                    			echo "<td width='50px' height='50px'></td>\n" ;
                    		}
                    		echo "</tr>\n";
                    	}
                    ?>
                    </div>
                    description, règle
                </div>
                <div class="col-md-3">
                	idJoueur
                    High-Score
                </div>
            </div>
        </div>
	</body>
</html> 


