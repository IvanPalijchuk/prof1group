<?php
class ControllerExtensionModuleBestSeller extends Controller {
	public function index($setting) {
		$setting['width'] = 228;
		$setting['height'] = 228;
		$this->load->language('extension/module/bestseller');

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_tax'] = $this->language->get('text_tax');

		$data['button_cart'] = $this->language->get('button_cart');
		$data['button_wishlist'] = $this->language->get('button_wishlist');
		$data['button_compare'] = $this->language->get('button_compare');

		$this->load->model('catalog/product');

		$this->load->model('tool/image');

		$data['products'] = array();

		$results = $this->model_catalog_product->getBestSellerProducts($setting['limit']);

		if ($results) {
			foreach ($results as $result) {
				if ($result['image']) {
					$image = $this->model_tool_image->resize($result['image'], $setting['width'], $setting['height']);
				} else {
					$image = $this->model_tool_image->resize('placeholder.png', $setting['width'], $setting['height']);
				}

				if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
					$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
				} else {
					$price = false;
				}

				if ((float)$result['special']) {
					$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
				} else {
					$special = false;
				}

				if ($this->config->get('config_tax')) {
					$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price'], $this->session->data['currency']);
				} else {
					$tax = false;
				}

				if ($this->config->get('config_review_status')) {
					$rating = $result['rating'];
				} else {
					$rating = false;
				}

				$pr_color_rel = array();
				//витягуємо при наявності інші варіанти кольорів
				if(!empty($result['mpn'])){
					$product_color_related = $this->model_catalog_product->getProductRelColor($result['mpn'], $result['product_id']);
					if(!empty($product_color_related)){
						foreach ($product_color_related as $pcr) {
							if(!empty($pcr['color'])){
								$color = trim($pcr['color']);
								$l = strlen($color);
								if($l < 9){
									while ( $l < 9) {
										$color = '0'.$color;
										$l++; 
									}
								}
								if (file_exists('image/color/'.$color.'.jpg')) {
								$pr_color_rel[] = array(
									"product_id" => $pcr['product_id'],
									"name" => $pcr['name'],
									"image" => 'image/color/'.$color.'.jpg',
									"href" => $this->url->link('product/product', '&product_id=' . $pcr['product_id'])
								);	
								}else{
									$pr_color_rel[] = array(
										"product_id" => $pcr['product_id'],
										"name" => $pcr['name'],
										"image" => $this->model_tool_image->resize($pcr['image'], $this->config->get($this->config->get('config_theme') . '_image_additional_width'), $this->config->get($this->config->get('config_theme') . '_image_additional_height')),
										"href" => $this->url->link('product/product', '&product_id=' . $pcr['product_id'])
									);
								}													
							}else{
								$pr_color_rel[] = array(
									"product_id" => $pcr['product_id'],
									"name" => $pcr['name'],
									"image" => $this->model_tool_image->resize($pcr['image'], $this->config->get($this->config->get('config_theme') . '_image_additional_width'), $this->config->get($this->config->get('config_theme') . '_image_additional_height')),
									"href" => $this->url->link('product/product', '&product_id=' . $pcr['product_id'])
								);
							}
						}
					}
				}	

				$data['products'][] = array(
					'product_id'  => $result['product_id'],
					'thumb'       => $image,
					'name'        => $result['name'],
					'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
					'price'       => $price,
					'special'     => $special,
					'sales'       => $result['sales'],
					'tax'         => $tax,
					'rating'      => $rating,
					'discount_card' => $result['discount_card'],
					'product_color_related' => $pr_color_rel,
					'href'        => $this->url->link('product/product', 'product_id=' . $result['product_id'])
				);
			}

			return $this->load->view('extension/module/bestseller', $data);
		}
	}
}
