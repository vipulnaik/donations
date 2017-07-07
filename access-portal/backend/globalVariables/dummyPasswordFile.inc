<?php
$mysqli = new mysqli("localhost", "username", "password", "database name");
$mysqli->set_charset("utf8");
$imagesPath = "(project folder)/images/";
$generateGraphCmdBase = "python3.5 /home/antivipulnaik/git/donations/python/graph.py ";

?>