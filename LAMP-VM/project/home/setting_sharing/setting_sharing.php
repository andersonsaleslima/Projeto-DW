<?php

 //let url = `../v1/ping.php?name_of_share=${name_of_share}&folder=${folder}&permission=${permission}`;

	$name_of_share = $_POST['name_of_share'];
	$folder = $_POST['folder'];
	$permission = $_POST['permission'];

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

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Document</title>
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons|Ruda" rel="stylesheet">
  <link href="css/style.css" rel="stylesheet">
</head>
<body>
  <header>
    <h1 id="title">MS - Manager Samba</h1>    
  </header>
  <main>
    <h2><?php echo $output ?></h2>
    <link><a href="setting_sharing.html">click here to back</a><link>
  </main>
</body>
<script src="js/script.js"></script>
</html>


