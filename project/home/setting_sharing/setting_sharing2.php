<?php

 //let url = `../v1/ping.php?name_of_share=${name_of_share}&folder=${folder}&permission=${permission}`;


	$connection = ssh2_connect('localhost', 22);
	ssh2_auth_password($connection, 'ubuntu', 'ubuntu');

	echo "{$connection}-1-\n";

 	$command = "sudo /var/www/html/src/project/home/setting_sharing/shell/mssetting2.sh";

 	echo "{$command}-2-\n";

	$stream = ssh2_exec($connection, $command);

	echo "{$stream}-3-\n";

	stream_set_blocking($stream, true);
	$stream_out = ssh2_fetch_stream($stream, SSH2_STREAM_STDIO);

	echo "{$stream_out}-4-\n";

	$output = stream_get_contents($stream_out);
	echo "<pre>{$output}</pre>-5-";

?>
