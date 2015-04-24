<?php

$di = new \Phalcon\DI\FactoryDefault\CLI();

require('../vendor/autoload.php');

try {
	$console = new \Phalcon\CLI\Console();
	$console->setDI($di);

	$arguments = array();
	foreach ($argv as $k => $arg) {
		if ($k === 1) {
			$arguments['task'] = $arg;
		} else if ($k === 2) {
			$arguments['action'] = $arg;
		} else if ($k >= 3) {
			$arguments['params'][] = $arg;
		}
	}
	
	$loader = new \Phalcon\Loader();
	$loader->registerNamespaces(array(
		'Tasks' => './tasks'
	));
	$loader->register();

	$console->handle($arguments);
} catch (\Phalcon\Exception $e) {
	echo $e->getMessage();
} catch (\PDOException $e) {
	echo $e->getMessage();
}

