<?php
class ModelSettingSetting extends Model {
	public function getSetting($code, $store_id = 0) {
		$data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "setting WHERE store_id = '" . (int)$store_id . "' AND `code` = '" . $this->db->escape($code) . "'");

		foreach ($query->rows as $result) {
			if (!$result['serialized']) {
				$data[$result['key']] = $result['value'];
			} else {
				$data[$result['key']] = json_decode($result['value'], true);
			}
		}

		return $data;
	}
	public function getRedstring(){
		$query = $this->db->query("SELECT value FROM " . DB_PREFIX . "headerfooter WHERE `key` = 'red_string' AND `language_id` = '" . (int)$this->config->get('config_language_id') . "'");
		if($query->num_rows > 0){
			return $query->row['value'];
		}
	}
	public function getHwork(){
		$query = $this->db->query("SELECT value FROM " . DB_PREFIX . "headerfooter WHERE `key` = 'h_work' AND `language_id` = '" . (int)$this->config->get('config_language_id') . "'");
		if($query->num_rows > 0){
			return $query->row['value'];
		}
	}
	public function getFwork(){
		$query = $this->db->query("SELECT value FROM " . DB_PREFIX . "headerfooter WHERE `key` = 'f_work' AND `language_id` = '" . (int)$this->config->get('config_language_id') . "'");
		if($query->num_rows > 0){
			return $query->row['value'];
		}
	}
	public function getAdressStores(){
		$adress_stores = array();
		$query = $this->db->query("SELECT value, sorted FROM " . DB_PREFIX . "headerfooter  WHERE `language_id` = '".(int)$this->config->get('config_language_id')."' AND (`key` = 'tochka' OR `key` = 'forest' OR `key` = 'rekrut' OR `key` = 'polygon') ORDER BY sorted");
		if($query->num_rows > 0){
			foreach ($query->rows as $key => $value) {
				$list = json_decode($value['value'], true);
				$adr = explode("|", $list["'adress'"]);
				$adress_stores[] = array(
					"name" => $list["'name'"],
					"adress" => $adr,
					"work" => $list["'work'"]
				);
			}
		}
		return $adress_stores;
	}
}