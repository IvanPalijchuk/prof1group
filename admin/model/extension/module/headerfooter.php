<?php

class ModelExtensionModuleHeaderfooter extends Model
{
	public function setAddDataHF($data){
		echo '<pre>';print_r($data);echo '<pre>';die('die');
		$this->db->query("DELETE * FROM `" . DB_PREFIX . "headerfooter WHERE key = 'red_string'");
		if(isset($data['red_string'])&&!empty($data['red_string'])){
			echo '<pre>';print_r($data);echo '<pre>';die('die');
			// foreach ($data['red_string'] as $key => $value) {
			// 	$this->db->query("INSERT INTO `" . DB_PREFIX . "headerfooter` (`key`,`language_id`,`value`) VALUES('red_string','" . (int)$key . "','" . $this->db->escape($value) . "')");
			// }
		}
	}
}