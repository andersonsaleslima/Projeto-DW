<?php

 //let url = `../v1/ping.php?name_of_share=${name_of_share}&folder=${folder}&permission=${permission}`;


	$connection = ssh2_connect('localhost', 22);
	ssh2_auth_password($connection, 'ubuntu', 'ubuntu');

 	$command = "sudo /var/www/html/src/project/home/shell/mslist.sh";

	$stream = ssh2_exec($connection, $command);

	stream_set_blocking($stream, true);
	$stream_out = ssh2_fetch_stream($stream, SSH2_STREAM_STDIO);

	$output = stream_get_contents($stream_out);
	#echo "<pre>{$output}</pre>";
	
	$line=explode("\n",$output);


	foreach($line as $key => $value) {
		$result[$key]=explode(":",$value);
	}


	header('Content-type: application/json; charset=UTF-8');
	header("Access-Control-Allow-Origin: *");
  	echo json_encode($result);

?>
