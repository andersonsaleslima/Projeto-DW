<?php

 //let url = `../v1/create_user.php?name_of_share=${name_of_share}&user=${user}`;

	$name_of_share = $_GET['name_of_share'];
	$user = $_GET['user'];

	$connection = ssh2_connect('localhost', 22);
	ssh2_auth_password($connection, 'ubuntu', 'ubuntu');

 	$command = "sudo /var/www/html/src/project/home/remove_user/shell/msrmuser.sh {$name_of_share} {$user}";

	$stream = ssh2_exec($connection, $commando);
	stream_set_blocking($stream, true);
	$stream_out = ssh2_fetch_stream($stream, SSH2_STREAM_STDIO);
	$output = stream_get_contents($stream_out);
	echo "<pre>{$output}</pre>";


