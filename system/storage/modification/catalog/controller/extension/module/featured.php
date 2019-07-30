<?php
class ControllerExtensionModuleFeatured extends Controller {
	public function index($setting) {

                $this->document->addStyle('catalog/view/javascript/promotionlabelpro/style.css');
                
		$setting['width'] = 228;
		$setting['height'] = 228;
		$this->load->language('extension/module/featured');

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_tax'] = $this->language->get('text_tax');

		$data['button_cart'] = $this->language->get('button_cart');
$data['button_not'] = $this->language->get('button_not');
		$data['button_wishlist'] = $this->language->get('button_wishlist');
		$data['button_compare'] = $this->language->get('button_compare');

		$this->load->model('catalog/product');

		$this->load->model('tool/image');

                $this->load->model('catalog/promotion_label_product');
                


				/* Label For Specials */
				$data['label_for_specials_label_type'] = $this->config->get('label_for_specials_label_type');
				$data['label_for_specials_status'] = $this->config->get('label_for_specials_status');
				$label_for_specials_label_text = $this->config->get('label_for_specials_label_text')[$this->config->get('config_language_id')];
				/* Label For Specials */
			
		$data['products'] = array();

		if (!$setting['limit']) {
			$setting['limit'] = 4;
		}

		if (!empty($setting['product'])) {
			$products = array_slice($setting['product'], 0, (int)$setting['limit']);

			foreach ($products as $product_id) {
				$product_info = $this->model_catalog_product->getProduct($product_id);

				if ($product_info) {
					if ($product_info['image']) {
						$image = $this->model_tool_image->resize($product_info['image'], $setting['width'], $setting['height']);
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $setting['width'], $setting['height']);
					}

					if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
					} else {
						$price = false;
					}

					if ((float)$product_info['special']) {

				/* Label For Specials */
				$dc_remaining_piece = $product_info['price'] - $product_info['special'];
				if($dc_remaining_piece > 0){
					$dc_special_percent = preg_replace('/\.(\d{2}).*/', '.$1', $dc_remaining_piece * 100 / $product_info['price']);
					$dc_special_amount = $this->currency->format($this->tax->calculate($dc_remaining_piece, $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
					$dc_special_text = $label_for_specials_label_text;
				} else {
					$dc_special_amount = false;
					$dc_special_percent = false;
					$dc_special_text = false;
				}
				/* Label For Specials */
			
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

					$pr_color_rel = array();
					//витягуємо при наявності інші варіанти кольорів
					if(!empty($product_info['mpn'])){
						$product_color_related = $this->model_catalog_product->getProductRelColor($product_info['mpn'], $product_info['product_id']);
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


                $labels = array();
                $labels = $this->model_catalog_promotion_label_product->getProductLabel($product_info['product_id']);
                
					$data['products'][] = array(

                'labels'   => $labels,
                

				/* Label For Specials */
				'dc_special_amount' => isset($dc_special_amount) && $dc_special_amount ? $dc_special_amount : false,
				'dc_special_percent' => isset($dc_special_percent) && $dc_special_percent ? $dc_special_percent : false,
				'dc_special_text' => isset($dc_special_text) && $dc_special_text ? $dc_special_text : false,
				/* Label For Specials */
			
						'product_id'  => $product_info['product_id'],
 
		        'quantity' => $product_info['quantity'], 'stock' => $product_info['stock_status'], 
			
						'thumb'       => $image,
						'name'        => $product_info['name'],
						'description' => utf8_substr(strip_tags(html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
						'price'       => $price,
						'special'     => $special,
						'sales'       => $product_info['sales'],
						'tax'         => $tax,
						'rating'      => $rating,
						'discount_card' => $product_info['discount_card'],
						'product_color_related' => $pr_color_rel,
						'href'        => $this->url->link('product/product', 'product_id=' . $product_info['product_id'])
					);
				}
			}
		}

		if ($data['products']) {
			return $this->load->view('extension/module/featured', $data);
		}
	}
}