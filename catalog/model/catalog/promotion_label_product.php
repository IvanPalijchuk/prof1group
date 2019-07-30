<?php
class ModelCatalogPromotionLabelProduct extends Model {
	public function getProductsIDbyManufacturer($manufactures = array() , $sort) {
		$products = array();

		foreach ($manufactures as $manufacturer_id) {

			$sql = ("SELECT DISTINCT p.product_id");

			if($sort == 'rating-DESC' || $sort == 'rating-ASC') {
				$sql .= (", (SELECT AVG(rating) AS total FROM " . DB_PREFIX . "review r1 WHERE r1.product_id = p.product_id AND r1.status = '1' GROUP BY r1.product_id) AS rating");
			}

			if($sort == 'p.price-DESC' || $sort == 'p.price-ASC') {
				$sql .= (", (SELECT AVG(rating) AS total FROM " . DB_PREFIX . "review r1 WHERE r1.product_id = p.product_id AND r1.status = '1' GROUP BY r1.product_id) AS rating");
			}

			$sql .= (" FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "manufacturer m ON (p.manufacturer_id = m.manufacturer_id)");

			if($sort == 'pd.name-ASC' || $sort == 'pd.name-DESC') {

				$sql .= " LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id)";

			}

			$sql .= (" WHERE m.manufacturer_id = '" . (int)$manufacturer_id . "'");

			if($sort == 'pd.name-ASC') {
				$sql .= " ORDER By pd.name ASC";
			} else if($sort == 'pd.name-DESC'){
				$sql .= " ORDER By pd.name DESC";
			} else if($sort == 'p.sort_order-ASC'){
				$sql .= " ORDER By p.sort_order ASC";
			} else if($sort == 'p.price-ASC'){
				$sql .= " ORDER By p.price ASC";
			} else if($sort == 'p.price-DESC'){
				$sql .= " ORDER By p.price DESC";
			} else if($sort == 'p.model-ASC'){
				$sql .= " ORDER By p.model ASC";
			} else if($sort == 'p.model-DESC'){
				$sql .= " ORDER By p.model DESC";
			} else if($sort == 'p.viewed'){
				$sql .= " ORDER By p.viewed DESC";
			} else if($sort == 'p.date_added-ASC'){
				$sql .= " ORDER By p.date_added ASC";
			} else if($sort == 'p.date_added-DESC'){
				$sql .= " ORDER By p.date_added DESC";
			} else if($sort == 'rating-DESC'){
				$sql .= " ORDER By rating DESC";
			}  else if($sort == 'rating-ASC'){
				$sql .= " ORDER By rating ASC";
			} 

			$query = $this->db->query($sql);

			//$query = $this->db->query("SELECT DISTINCT p.product_id FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "manufacturer m ON (p.manufacturer_id = m.manufacturer_id) WHERE m.manufacturer_id = '" . (int)$manufacturer_id . "' ORDER BY p.date_added ASC");

			foreach ($query->rows as $result) {
				$product[] = $result['product_id'];
			}

			$products = array_merge($products, $product);

		}

		return array_unique($products);
	}

	public function getProductsIDbyCategories($categories = array() , $sort) {
		$products = array();

		foreach ($categories as $category_id) {

			$sql = ("SELECT DISTINCT ptc.product_id");

			if($sort == 'rating-DESC' || $sort == 'rating-ASC') {
				$sql .= (", (SELECT AVG(rating) AS total FROM " . DB_PREFIX . "review r1 WHERE r1.product_id = p.product_id AND r1.status = '1' GROUP BY r1.product_id) AS rating");
			}

			if($sort == 'p.price-DESC' || $sort == 'p.price-ASC') {
				$sql .= (", (SELECT AVG(rating) AS total FROM " . DB_PREFIX . "review r1 WHERE r1.product_id = p.product_id AND r1.status = '1' GROUP BY r1.product_id) AS rating");
			}

			$sql .= (" FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_to_category ptc ON (p.product_id = ptc.product_id) LEFT JOIN " . DB_PREFIX . "category c ON (ptc.category_id = c.category_id)");

			if($sort == 'pd.name-ASC' || $sort == 'pd.name-DESC') {

				$sql .= " LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id)";

			}

			$sql .= (" WHERE c.category_id = '" . (int)$category_id . "'");

			if($sort == 'pd.name-ASC') {
				$sql .= " ORDER By pd.name ASC";
			} else if($sort == 'pd.name-DESC'){
				$sql .= " ORDER By pd.name DESC";
			} else if($sort == 'p.sort_order-ASC'){
				$sql .= " ORDER By p.sort_order ASC";
			} else if($sort == 'p.price-ASC'){
				$sql .= " ORDER By p.price ASC";
			} else if($sort == 'p.price-DESC'){
				$sql .= " ORDER By p.price DESC";
			} else if($sort == 'p.model-ASC'){
				$sql .= " ORDER By p.model ASC";
			} else if($sort == 'p.model-DESC'){
				$sql .= " ORDER By p.model DESC";
			} else if($sort == 'p.viewed'){
				$sql .= " ORDER By p.viewed DESC";
			} else if($sort == 'p.date_added-ASC'){
				$sql .= " ORDER By p.date_added ASC";
			} else if($sort == 'p.date_added-DESC'){
				$sql .= " ORDER By p.date_added DESC";
			} else if($sort == 'rating-DESC'){
				$sql .= " ORDER By rating DESC";
			}  else if($sort == 'rating-ASC'){
				$sql .= " ORDER By rating ASC";
			} 

			$query = $this->db->query($sql);

			foreach ($query->rows as $result) {
				if($result) {
					$product[] = $result['product_id'];
				} else {
					$product[] = '';
				}
			}

			$products = array_merge($products, $product);

		}

		return array_unique($products);
	}

	public function getProductLabel($product_id) {
		$query = $this->db->query("SELECT * FROM oca_label_product olp LEFT JOIN oca_label ol ON (olp.label_id = ol.label_id) WHERE olp.product_id = '" . (int)$product_id . "' AND (olp.date_start = '0000-00-00' OR olp.date_start < NOW()) AND (olp.date_end = '0000-00-00' OR olp.date_end > NOW())");

		return $query->rows;

	}
}
?>