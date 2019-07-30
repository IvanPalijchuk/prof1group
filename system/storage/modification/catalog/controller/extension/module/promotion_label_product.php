<?php
class ControllerExtensionModulePromotionLabelProduct extends Controller {
	public function index($setting) {

		$this->document->addStyle('catalog/view/javascript/promotionlabelpro/style.css');

		$this->load->language('extension/module/promotion_label_product');

		$data['text_tax'] = $this->language->get('text_tax');

		$data['button_cart'] = $this->language->get('button_cart');
$data['button_not'] = $this->language->get('button_not');
		$data['button_wishlist'] = $this->language->get('button_wishlist');
		$data['button_compare'] = $this->language->get('button_compare');

		$this->load->model('catalog/product');

		$this->load->model('catalog/promotion_label_product');

		$this->load->model('tool/image');

		$data['products'] = array();

		if (!$setting['limit']) {
			$setting['limit'] = 4;
		}

		$language_id = $this->config->get('config_language_id');

		$data['heading_title'] = $setting['module_name'][$language_id]['name'];

		if($setting['show_product'] == 'featured') {
			$products = array_slice($setting['product'], 0, (int)$setting['limit']);
		} else if($setting['show_product'] == 'manufacturer') {
			$product = $this->model_catalog_promotion_label_product->getProductsIDbyManufacturer($setting['manufacturer'] , $setting['sort_product']);
			$products = array_slice($product, 0, (int)$setting['limit']);
		} else if($setting['show_product'] == 'category') {
			$product = $this->model_catalog_promotion_label_product->getProductsIDbyCategories($setting['category'] , $setting['sort_product']);
			$products = array_slice($product, 0, (int)$setting['limit']);
		} else if($setting['show_product'] == 'latest') {
			$data['products'] = array();

			$filter_data = array(
				'sort'  => 'p.date_added',
				'order' => 'DESC',
				'start' => 0,
				'limit' => $setting['limit']
			);

			$results = $this->model_catalog_product->getProducts($filter_data);
			
		} else if($setting['show_product'] == 'special') {
			$data['products'] = array();

			$filter_data = array(
				'sort'  => 'pd.name',
				'order' => 'ASC',
				'start' => 0,
				'limit' => $setting['limit']
			);

			$results = $this->model_catalog_product->getProductSpecials($filter_data);
			
		} else if($setting['show_product'] == 'popular') {
			$data['products'] = array();
			
			$results = $this->model_catalog_product->getPopularProducts($setting['limit']);
			
		} else if($setting['show_product'] == 'bestseller') {
			$data['products'] = array();

			$results = $this->model_catalog_product->getBestSellerProducts($setting['limit']);
			
		}

		if(version_compare(VERSION, '2.2.0.0', '<') == true) {
			$desc_length = (int)$this->config->get('config_product_description_length');
		} else {
			$desc_length = (int)$this->config->get($this->config->get('config_theme') . '_product_description_length');
		}

		

		if($setting['show_product'] == 'featured' || $setting['show_product'] == 'manufacturer' || $setting['show_product'] == 'category') {

			foreach ($products as $product_id) {
				$product_info = $this->model_catalog_product->getProduct($product_id);

				if ($product_info) {
					if ($product_info['image']) {
						$image = $this->model_tool_image->resize($product_info['image'], $setting['width'], $setting['height']);
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $setting['width'], $setting['height']);
					}

					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						if(version_compare(VERSION, '2.2.0.0', '<') == true) {
							$price = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')));
						} else {
							$price = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
						}
					} else {
						$price = false;
					}

					if ((float)$product_info['special']) {
						if(version_compare(VERSION, '2.2.0.0', '<') == true) {
							$special = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')));
						} else {
							$special = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
						}
					} else {
						$special = false;
					}

					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$product_info['special'] ? $product_info['special'] : $product_info['price'], $this->session->data['currency']);
					} else {
						$tax = false;
					}

					if ($this->config->get('config_review_status')) {
						$rating = $product_info['rating'];
					} else {
						$rating = false;
					}

					$labels = array();

					$labels = $this->model_catalog_promotion_label_product->getProductLabel($product_info['product_id']);

					$data['products'][] = array(
						'product_id'  => $product_info['product_id'],
						'thumb'       => $image,
						'name'        => $product_info['name'],
						'description' => utf8_substr(strip_tags(html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8')), 0, $desc_length) . '..',
						'price'       => $price,
						'special'     => $special,
						'tax'         => $tax,
						'rating'      => $rating,
						'labels'	  => $labels,
						'href'        => $this->url->link('product/product', 'product_id=' . $product_info['product_id'])
					);
				}
			
			}

		} else if($setting['show_product'] == 'latest' || $setting['show_product'] == 'special' || $setting['show_product'] == 'bestseller' || $setting['show_product'] == 'popular') { 
			
			if ($results) {
				foreach ($results as $result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $setting['width'], $setting['height']);
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $setting['width'], $setting['height']);
					}

					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						if(version_compare(VERSION, '2.2.0.0', '<') == true) {
							$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
						} else {
							$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
						}
					} else {
						$price = false;
					}

					if ((float)$result['special']) {
						if(version_compare(VERSION, '2.2.0.0', '<') == true) {
							$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
						} else {
							$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
						}
					} else {
						$special = false;
					}

					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}

					if ($this->config->get('config_review_status')) {
						$rating = $result['rating'];
					} else {
						$rating = false;
					}

					$labels = array();

					$labels = $this->model_catalog_promotion_label_product->getProductLabel($result['product_id']);

					$data['products'][] = array(
						'product_id'  => $result['product_id'],
						'thumb'       => $image,
						'name'        => $result['name'],
						'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $desc_length) . '..',
						'price'       => $price,
						'special'     => $special,
						'tax'         => $tax,
						'rating'      => $rating,
						'labels'	  => $labels,
						'href'        => $this->url->link('product/product', 'product_id=' . $result['product_id']),
					);
				}
			}	

		}	
		
		return $this->load->view('extension/module/promotion_label_product', $data);
		
	}
}