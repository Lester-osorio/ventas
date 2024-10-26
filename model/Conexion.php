<?php

$conexion = new mysqli("localhost", "root", "", "multisucursal");
	
	if (mysqli_connect_errno()) {
	    printf("Connect failed: %s\n", mysqli_connect_error());
	    exit();
	}
