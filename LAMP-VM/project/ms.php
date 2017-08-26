<?php
	$name_share = $_GET{name_share}
	$folder = $_GET{folder}
	$permission = $_GET{permission}
	$users = $GET{users}

	$command = "./ms.sh ${name_share} ${folder} ${permission} ${users}"
	$result = shell_exec($command)

?>