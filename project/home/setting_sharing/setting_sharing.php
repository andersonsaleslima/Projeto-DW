<?php

 //let url = `../v1/ping.php?name_of_share=${name_of_share}&folder=${folder}&permission=${permission}`;

	$name_of_share = $_GET['name_of_share'];
	$folder = $_GET['folder'];
	$permission = $_GET['permission'];

	echo "{$name_of_share}\n";
	echo "{$folder}\n";
	echo "{$permission}\n";

	$connection = ssh2_connect('localhost', 22);
	ssh2_auth_password($connection, 'ubuntu', 'ubuntu');

	echo "{$connection}\n";

 	$command = "sudo /var/www/html/src/project/home/setting_sharing/shell/mssetting.sh {$name_of_share} {$folder} {$permission}";

 	echo "{$command}\n";

	$stream = ssh2_exec($connection, $command);

	echo "{$stream}\n";

	stream_set_blocking($stream, true);
	$stream_out = ssh2_fetch_stream($stream, SSH2_STREAM_STDIO);

	echo "{$stream_out}";

	$output = stream_get_contents($stream_out);
	echo "<pre>{$output}</pre>";

?>
