<?php
class ModelCatalogTest extends Model {
	//Вибір всіх розпродажних позицій
	public function getSalesProducts(){
		$query = $this->db->query("SELECT product_id, sales FROM " . DB_PREFIX . "product WHERE sales = '1'");
		return $query->rows;
	}
	//очищаємо категорію розпродажів
	public function setNullCategoriesSales(){
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_to_category WHERE category_id = '137001'");
	}
	//Добавляємо розпродаж в відповідну категорію
	public function setAddProdToCatSales($product_id){
		$this->db->query("INSERT INTO " . DB_PREFIX . "product_to_category SET product_id = '" . (int)$product_id . "', category_id = '137001'");
	}
	//Вибираємо новинки з БД
	public function getNewProducts(){
		$query = $this->db->query("SELECT product_id, new FROM " . DB_PREFIX . "product WHERE new = '1'");
		return $query->rows;		
	}
	//Очищаємо категорію новинок
	public function setNullCategoriesNew(){
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_to_category WHERE category_id = '137004'");
	}
	//Добавляємо новинки  в відповідну категорію
	public function setAddProdToCatNew($product_id){
		$this->db->query("INSERT INTO " . DB_PREFIX . "product_to_category SET product_id = '" . (int)$product_id . "', category_id = '137004'");
	}	
	public function getProducts(){
		$query = $this->db->query("SELECT product_id FROM " . DB_PREFIX . "product");
		return $query->rows;
	}
	public function getProductCategory($product_id){
		$query = $this->db->query("SELECT category_id FROM " . DB_PREFIX . "product_to_category WHERE product_id = '".$product_id."'");
		if($query->num_rows > 0){
			return $query->row['category_id'];
		}
	}
	public function getProductParentCategory($category_to_product){
		$query = $this->db->query("SELECT parent_id FROM " . DB_PREFIX . "category WHERE category_id = '".$category_to_product."'");
		if($query->num_rows > 0){
			return $query->row['parent_id'];
		}else{
			return 0;
		}
	}
	public function UpdateCategoryProduct($key, $value){
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_to_category WHERE product_id = '".$key."'");
		foreach ($value as $cat) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "product_to_category SET product_id = '" . (int)$key . "', category_id = '".$cat."'");
		}
	}
}