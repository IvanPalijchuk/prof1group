<?php
ini_set('error_reporting', E_ALL);
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
// Version
define('VERSION', '2.3.0.2');

// Configuration
if (is_file('config.php')) {
	require_once('config.php');
}

// Install
if (!defined('DIR_APPLICATION')) {
	header('Location: install/index.php');
	exit;
}
if($_SERVER['REQUEST_URI'] == "/index.php") {
header("Location: /",TRUE,301);
exit();
}
if($_SERVER['REQUEST_URI'] == "/index.php?route=common/home") {
header("Location: /",TRUE,301);
exit();
}
// VirtualQMOD
require_once('./vqmod/vqmod.php');
VQMod::bootup();

// VQMODDED Startup
require_once(VQMod::modCheck(DIR_SYSTEM . 'startup.php'));

start('catalog');