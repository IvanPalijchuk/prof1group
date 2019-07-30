<?php
class ControllerProductTest extends Controller {
	public function index() {
		$this->load->model('catalog/test');
		//Расброс товаров по всем категориям
		//$this->load->model('catalog/product');
		// $products = $this->model_catalog_test->getProducts();
		// $arr_cat = array();
		// foreach ($products as $value) {
		// 	$category_to_product = $this->model_catalog_test->getProductCategory($value['product_id']);
		// 	if(!empty($category_to_product)){
		// 		$arr_cat[$value['product_id']][] = $category_to_product;
		// 	}
		// 	$par_cat = $this->model_catalog_test->getProductParentCategory($category_to_product);
		// 	if($par_cat != 0){
		// 		$arr_cat[$value['product_id']][] = $par_cat;
		// 		while($par_cat != 0){
		// 			$par_cat = $this->model_catalog_test->getProductParentCategory($par_cat);
		// 			if($par_cat != 0){
		// 				$arr_cat[$value['product_id']][] = $par_cat;
		// 			}
		// 		}
		// 	}
		// }
		// foreach ($arr_cat as $key => $value) {
		// 	$this->model_catalog_test->UpdateCategoryProduct($key, $value);
		// 	// echo '<pre>';print_r($key);echo '<pre>';
		// 	// echo '<pre>';print_r($value);echo '<pre>';die('die');
		// }
		// echo '<pre>';print_r($arr_cat);echo '<pre>';die('die');
		//вибираємо всі товари які на розпродажі
		$sales_product = $this->model_catalog_test->getSalesProducts();
		//очищаємо від розпродаж таблицю  категорій
		$this->model_catalog_test->setNullCategoriesSales();
		//записуємо дані в таблицю категорій
		foreach ($sales_product as $product) {
			$this->model_catalog_test->setAddProdToCatSales($product['product_id']);
		}
		//вибираємо всі новинки товарів
		$new_products = $this->model_catalog_test->getNewProducts();
		//очищаємо від новинок таблицю  категорій
		$this->model_catalog_test->setNullCategoriesNew();
		//записуємо дані в таблицю категорій
		foreach ($new_products as $product) {
			$this->model_catalog_test->setAddProdToCatNew($product['product_id']);
		}
	}
}