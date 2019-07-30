<?php
class ModelCatalogPromotionLabelPro extends Model {

	public function CreateDB() {
		$this->db->query("CREATE TABLE IF NOT EXISTS `oca_label` (
		  `label_id` int(11) NOT NULL AUTO_INCREMENT,
		  `name` varchar(255) NOT NULL,
		  `image` varchar(255) NOT NULL,
		  `sort_order` int(3) NOT NULL DEFAULT '0',
		  PRIMARY KEY (`label_id`)
		)");

		$query = $this->db->query("SELECT COUNT(*) AS total FROM oca_label");

		if(!$query->row['total']) {

		$this->db->query("INSERT INTO `oca_label` (`label_id`, `name`, `image`, `sort_order`) VALUES
			(2, 'Sale Red', 'catalog/label/sale.png', 2),
			(3, 'Sale Blue', 'catalog/label/sale_blue.png', 2),
			(4, 'Percent red', 'catalog/label/percent_red.png', 2),
			(5, 'Percent blue', 'catalog/label/percent_blue.png', 2),
			(6, '10 Percent Blue', 'catalog/label/10_percent_blue.png', 2),
			(7, '10 Percent Red', 'catalog/label/10_percent_red.png', 2),
			(8, '20 Percent Blue', 'catalog/label/20_percent_blue.png', 2),
			(9, '20 Percent Red', 'catalog/label/20_percent_red.png', 2),
			(10, '30 Percent Blue', 'catalog/label/30_percent_blue.png', 2),
			(11, '30 Percent Red', 'catalog/label/30_percent_red.png', 2),
			(12, '40 Percent Blue', 'catalog/label/40_percent_blue.png', 2),
			(13, '40 Percent Red', 'catalog/label/40_percent_red.png', 2),
			(14, '50 Percent Blue', 'catalog/label/50_percent_blue.png', 2),
			(15, '50 Percent Red', 'catalog/label/50_percent_red.png', 2),
			(16, '70 Percent Blue', 'catalog/label/70_percent_blue.png', 2),
			(17, '70 Percent Red', 'catalog/label/70_percent_red.png', 2),
			(18, 'Best Price Blue', 'catalog/label/best-price-blue.png', 2),
			(19, 'Best Price Red', 'catalog/label/best-price-red.png', 2),
			(20, 'Best 2 Blue', 'catalog/label/best2-blue.png', 2),
			(21, 'Best 2 Red', 'catalog/label/best2-red.png', 2),
			(22, 'Buy Me Blue', 'catalog/label/buy-me-blue.png', 2),
			(23, 'Buy Me Red', 'catalog/label/buy-me-red.png', 2),
			(24, 'Free Blue', 'catalog/label/free-blue.png', 2),
			(25, 'Free Red', 'catalog/label/free-red.png', 2),
			(26, 'Hot 2 Blue', 'catalog/label/hot2-blue.png', 2),
			(27, 'hot 2 Red', 'catalog/label/hot2-red.png', 2),
			(28, 'Mega Sale Blue', 'catalog/label/mega-sale-blue.png', 2),
			(29, 'Mega Sale Red', 'catalog/label/mega-sale-red.png', 2),
			(30, 'New Blue', 'catalog/label/new-blue.png', 2),
			(31, 'New Red', 'catalog/label/new-red.png', 2),
			(32, 'New 2 Blue', 'catalog/label/new2-blue.png', 2),
			(33, 'New 2 Red', 'catalog/label/new2-red.png', 2),
			(34, '1 Free Blue', 'catalog/label/one-free-blue.png', 2),
			(35, '1 Free Red', 'catalog/label/one-free-red.png', 2),
			(36, 'Percent 2 Blue', 'catalog/label/percent2-blue.png', 2),
			(37, 'Percent 2 Red', 'catalog/label/percent2-red.png', 2),
			(39, 'Sale 2 Blue', 'catalog/label/sale2-blue.png', 2),
			(40, 'Sale 2 Red', 'catalog/label/sale2-red.png', 2),
			(41, 'Super Sale Blue', 'catalog/label/super-sale-blue.png', 2),
			(42, 'Super Sale Red', 'catalog/label/super-sale-red.png', 2),
			(47, 'Sale Ribbon Vertical', 'catalog/label/saleRibbon.png', 0),
			(48, 'Sale Ribbon Violet Vertical', 'catalog/label/sale badge.png', 0),
			(49, 'Sale Red Edge Bottom Right', 'catalog/label/ribbon-sale.png', 0),
			(50, 'Sale Red Edge Top Left', 'catalog/label/icon-sale.png', 0),
			(51, 'Ribbon Sale Red Top', 'catalog/label/ribbon-sale (1).png', 0),
			(52, 'Ribbon Sale Red Top Left', 'catalog/label/SaleRibbon (1).png', 0),
			(53, 'Special Offer Stamp 200x200', 'catalog/label/special_offer_stamp.png', 0),
			(54, 'Special Offer Ribbon Corner Top Left', 'catalog/label/mtd-corner-ribbon-specialoffer.png', 0),
			(55, 'Special Price ibbon ', '', 0),
			(56, 'Special Price Green Ribbon Corner Top Left', 'catalog/label/CORNER RIBBON GREEN 400X4001.PNG', 0),
			(57, '30 Day Warranty Blue', 'catalog/label/30day_warranty.png', 0),
			(58, 'New Red Badge', 'catalog/label/22416.png', 0),
			(59, 'Sale Blue Badge', 'catalog/label/43947.png', 0),
			(60, 'Sale Orange Badge', 'catalog/label/43939.png', 0),
			(61, 'Best Price Badge Red Stamp', 'catalog/label/bigstock-Best-price-rubber-stamp-17459288.png', 0),
			(62, 'Certified Original Red Stamp 260x200', 'catalog/label/Certified-Original-Grunge-Stamp.png', 0),
			(63, 'Special Offer Red Stamp 1 260x200', 'catalog/label/offers_stamp.png', 0),
			(64, 'Sale Red Stamp 260x200', 'catalog/label/red_sale_stamp_400_clr_3171.png', 0),
			(65, 'Coming Soon Stamp Red 260x200', 'catalog/label/red-coming-soon-stamp.png', 0),
			(66, 'Sale Stamp Bold Red 260x200', 'catalog/label/SaleStamp.gif', 0),
			(67, 'Sold Stamp Red 260x200', 'catalog/label/sold_out.png', 0),
			(68, 'Sold Out Stamp Red 260x200', 'catalog/label/sold_out_stamp.png', 0),
			(69, 'Sold Stamp Red 1 260x200', 'catalog/label/sold-stamp-angle.png', 0),
			(70, 'Special Offer Red Badge', 'catalog/label/Stamp.png', 0);");
		}

		$this->db->query("CREATE TABLE IF NOT EXISTS `oca_label_product` (
			  `product_label_id` int(11) NOT NULL AUTO_INCREMENT,
			  `product_id` int(11) NOT NULL,
			  `label_id` int(11) NOT NULL DEFAULT '0',
			  `position` varchar(12) NOT NULL,
			  `date_start` datetime NOT NULL,
			  `date_end` datetime NOT NULL,
			  PRIMARY KEY (`product_label_id`),
			  KEY `product_id` (`product_id`)
		)");

	}

	public function addLabel($data) {
		//$this->event->trigger('pre.admin.label.add', $data);

		$this->db->query("INSERT INTO oca_label SET sort_order = '" . (int)$data['sort_order'] . "', name = '" . $this->db->escape($data['name']) . "'");

		$label_id = $this->db->getLastId();

		if (isset($data['image'])) {
			$this->db->query("UPDATE oca_label SET image = '" . $this->db->escape($data['image']) . "' WHERE label_id = '" . (int)$label_id . "'");
		}

		//$this->event->trigger('post.admin.label.add', $label_id);

		return $label_id;
	}

	public function editLabel($label_id, $data) {
		//$this->event->trigger('pre.admin.label.edit', $data);

		$this->db->query("UPDATE oca_label SET sort_order = '" . (int)$data['sort_order'] . "', name = '" . $this->db->escape($data['name']) . "' WHERE label_id = '" . (int)$label_id . "'");

		if (isset($data['image'])) {
			$this->db->query("UPDATE oca_label SET image = '" . $this->db->escape($data['image']) . "' WHERE label_id = '" . (int)$label_id . "'");
		}

		//$this->event->trigger('post.admin.label.edit', $label_id);
	}

	public function deleteLabel($label_id) {
		//$this->event->trigger('pre.admin.label.delete', $label_id);

		$this->db->query("DELETE FROM oca_label WHERE label_id = '" . (int)$label_id . "'");

		//$this->event->trigger('post.admin.label.delete', $label_id);
	}

	public function getLabel($label_id) {
		$query = $this->db->query("SELECT * FROM oca_label WHERE label_id = '" . (int)$label_id . "'");

		return $query->row;
	}

	public function getLabels($data = array()) {
		$sql = "SELECT * FROM oca_label";

		if (!empty($data['filter_name'])) {
			$sql .= " WHERE name LIKE '" . $this->db->escape($data['filter_name']) . "%'";
		}

		$sort_data = array(
			'name',
			'sort_order'
		);

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY sort_order";
		}

		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC";
		} else {
			$sql .= " ASC";
		}

		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}

			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}

			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}

		$query = $this->db->query($sql);

		return $query->rows;
	}


	public function getTotalLabel() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM oca_label");

		return $query->row['total'];
	}

	public function getLabelProduct($product_label_id) {
		$query = $this->db->query("SELECT pd.name, p.product_id, p.image, olp.date_start, olp.date_end, olp.position, olp.label_id, ol.image as label_image, olp.product_label_id FROM oca_label_product olp LEFT JOIN oca_label ol ON (olp.label_id = ol.label_id) LEFT JOIN " . DB_PREFIX . "product p ON (olp.product_id = p.product_id) LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND olp.product_label_id = '" . (int)$product_label_id . "'");

		return $query->row;
	}

	public function getLabelProducts($data = array()) {
		$sql = "SELECT pd.name, p.product_id, p.image, olp.date_start, olp.date_end, olp.position, ol.image as label_image, olp.product_label_id FROM oca_label_product olp LEFT JOIN oca_label ol ON (olp.label_id = ol.label_id) LEFT JOIN " . DB_PREFIX . "product p ON (olp.product_id = p.product_id) LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "'";

		if (!empty($data['filter_name'])) {
			$sql .= " AND pd.name LIKE '" . $this->db->escape($data['filter_name']) . "%'";
		}

		$sort_data = array(
			'pd.name',
			'olp.date_start',
			'olp.date_end'
		);

		//$sql.= " GROUP BY olp.product_id";

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];
		}  else {
			$sql .= " ORDER BY olp.date_end";
		}

		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC";
		} else {
			$sql .= " ASC";
		}

		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}

			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}

			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}

		$query = $this->db->query($sql);

		return $query->rows;
	}

	public function getTotalLabelProducts() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM oca_label_product");

		return $query->row['total'];
	}

	public function addLabelProduct($data) {

		$this->db->query("INSERT INTO oca_label_product SET product_id = '" . (int)$data['product_id'] . "', label_id = '" . (int)$data['label_id'] . "', position = '" . $data['position'] . "' , date_start = '" . $this->db->escape($data['date_start']) . "', date_end = '" . $this->db->escape($data['date_end']) . "'");

	}

	public function editLabelProduct($product_label_id,$data) {

		$this->db->query("UPDATE oca_label_product SET product_id = '" . (int)$data['product_id'] . "', label_id = '" . (int)$data['label_id'] . "', position = '" . $data['position'] . "' , date_start = '" . $this->db->escape($data['date_start']) . "', date_end = '" . $this->db->escape($data['date_end']) . "' WHERE product_label_id = '" . (int)$product_label_id . "'");

	}

	public function deleteLabelProduct($product_label_id) {
		
		$this->db->query("DELETE FROM oca_label_product WHERE product_label_id = '" . (int)$product_label_id . "'");

	}

}
