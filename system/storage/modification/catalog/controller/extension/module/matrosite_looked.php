<?php

class ControllerExtensionModuleMatrositeLooked extends Controller {
	public function index() {
		
		$this->load->language('extension/module/matrosite/looked');
		
		$data['heading_title'] = $this->language->get('heading_title');
		$data['text_tax'] = $this->language->get('text_tax');
		$data['button_cart'] = $this->language->get('button_cart');
$data['button_not'] = $this->language->get('button_not');
		$data['button_wishlist'] = $this->language->get('button_wishlist');
		$data['button_compare'] = $this->language->get('button_compare');
		
		$this->load->model('setting/setting');
		
		$this->load->model('catalog/product');
		$this->load->model('tool/image');
		
		
		$setting = $this->model_setting_setting->getSetting('matrosite_looked');
		
		if ( !isset($setting['matrosite_looked_limit']) ) {
			$setting['matrosite_looked_limit'] = 4;
		}
		
		if ( (int)$setting['matrosite_looked_status'] == 1 ) {
			
			$data['heading_title'] = $this->language->get('matrosite_looked_title');
			
			if (isset($this->session->data['matrosite']['looked'])) {
				$products = $this->session->data['matrosite']['looked'];
			} else {
				$products = array();
			}
			
			if (isset($this->request->get['product_id'])) {
				
				$isset = false; // Флаг присутствия текущего товара в списке
			
				foreach($products as $key => $product_id){
					if ($product_id == $this->request->get['product_id']) {
						$isset = true;
						unset($products[$key]);
					}
				}
				
				if (!$isset) {
					$this->session->data['matrosite']['looked'][] = $this->request->get['product_id'];
				}
				
				// Удаляем излишки
				if (count($this->session->data['matrosite']['looked']) > (int)$setting['matrosite_looked_limit']) {
					$iteration = count($this->session->data['matrosite']['looked']) - (int)$setting['matrosite_looked_limit'];
					for ($i=0; $i<$iteration; $i++){
						array_shift($this->session->data['matrosite']['looked']);
					}
				}
			
			}
			
			$data['products'] = array();
			foreach(array_reverse($products) as $key => $product_id){
				$product_info = $this->model_catalog_product->getProduct($product_id);
				if ($product_info) {
					if ($product_info['image']) {
						$image = $this->model_tool_image->resize($product_info['image'], $this->config->get($this->config->get('config_theme') . '_image_product_width'), $this->config->get($this->config->get('config_theme') . '_image_product_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get($this->config->get('config_theme') . '_image_product_width'), $this->config->get($this->config->get('config_theme') . '_image_product_height'));
					}

					if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
					} else {
						$price = false;
					}

					if ((float)$product_info['special']) {
						$special = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
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

					$data['products'][] = array(
						'product_id'  => $product_info['product_id'],
						'thumb'       => $image,
						'name'        => $product_info['name'],
						'description' => utf8_substr(strip_tags(html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
						'price'       => $price,
						'special'     => $special,
						'tax'         => $tax,
						'rating'      => $rating,
						'href'        => $this->url->link('product/product', 'product_id=' . $product_info['product_id'])
					);
				}
			}
			
			$data['count'] = count($data['products']);
			
			if ($data['products']) {
				return $this->load->view('extension/module/matrosite_looked', $data);
			}
		
		}
	}
}