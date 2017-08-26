<?php

 //let url = `../v1/create_user.php?name_of_share=${name_of_share}&user=${user}`;

	$user = $_POST['user'];

	$connection = ssh2_connect('localhost', 22);
	ssh2_auth_password($connection, 'ubuntu', 'ubuntu');

 	$command = "sudo /var/www/html/src/project/home/rm_user/shell/msrmuser.sh {$user}";

	$stream = ssh2_exec($connection, $command);
	stream_set_blocking($stream, true);
	$stream_out = ssh2_fetch_stream($stream, SSH2_STREAM_STDIO);
	$output = stream_get_contents($stream_out);
#	echo "<pre>{$output}</pre>";
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
    <link><a href="rm_user.html">click here to back</a><link>
  </main>
</body>
<script src="js/script.js"></script>
</html>

