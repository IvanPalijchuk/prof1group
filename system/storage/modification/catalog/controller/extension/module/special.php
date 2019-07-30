<?php
class ControllerExtensionModuleSpecial extends Controller {
	public function index($setting) {

                $this->document->addStyle('catalog/view/javascript/promotionlabelpro/style.css');
                
		$setting['width'] = 228;
		$setting['height'] = 228;
		$this->load->language('extension/module/special');

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

		$filter_data = array(
			'sort'  => 'pd.name',
			'order' => 'ASC',
			'start' => 0,
			'limit' => $setting['limit']
		);

		$results = $this->model_catalog_product->getProductSpecials($filter_data);

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

				/* Label For Specials */
				$dc_remaining_piece = $result['price'] - $result['special'];
				if($dc_remaining_piece > 0){
					$dc_special_percent = preg_replace('/\.(\d{2}).*/', '.$1', $dc_remaining_piece * 100 / $result['price']);
					$dc_special_amount = $this->currency->format($this->tax->calculate($dc_remaining_piece, $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
					$dc_special_text = $label_for_specials_label_text;
				} else {
					$dc_special_amount = false;
					$dc_special_percent = false;
					$dc_special_text = false;
				}
				/* Label For Specials */
			
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


                $labels = array();
                $labels = $this->model_catalog_promotion_label_product->getProductLabel($result['product_id']);
                
				$data['products'][] = array(

                'labels'   => $labels,
                

				/* Label For Specials */
				'dc_special_amount' => isset($dc_special_amount) && $dc_special_amount ? $dc_special_amount : false,
				'dc_special_percent' => isset($dc_special_percent) && $dc_special_percent ? $dc_special_percent : false,
				'dc_special_text' => isset($dc_special_text) && $dc_special_text ? $dc_special_text : false,
				/* Label For Specials */
			
					'product_id'  => $result['product_id'],
 
		        'quantity' => $result['quantity'], 'stock' => $result['stock_status'], 'model' => $result['model'],
			
					'thumb'       => $image,
					'name'        => $result['name'],
					'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
					'price'       => $price,
					'special'     => $special,
					'tax'         => $tax,
					'rating'      => $rating,
					'discount_card' => $result['discount_card'],
					'href'        => $this->url->link('product/product', 'product_id=' . $result['product_id'])
				);
			}

			return $this->load->view('extension/module/special', $data);
		}
	}
}