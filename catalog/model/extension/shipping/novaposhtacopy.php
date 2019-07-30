<?php
class ModelExtensionShippingNovaPoshtaCopy extends Model {
    function getQuote($address) {
        $this->load->language('extension/shipping/novaposhtacopy');

        if ($this->config->get('novaposhtacopy_status')) {
            $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "zone_to_geo_zone WHERE geo_zone_id = '" . (int) $this->config->get('novaposhtacopy_geo_zone_id') . "' AND country_id = '" . (int) $address['country_id'] . "' AND (zone_id = '" . (int) $address['zone_id'] . "' OR zone_id = '0')");

            if (!$this->config->get('novaposhtacopy_geo_zone_id')) {
                $status = TRUE;
            } elseif ($query->num_rows) {
                $status = TRUE;
            } else {
                $status = FALSE;
            }
			
        } else {
            $status = FALSE;
        }

        $method_data = array();

        if ($status) {
            $quote_data = array();

            $cost = 0.00;			
			
            if ($this->config->get('novaposhtacopy_min_total_for_free_delivery') > $this->cart->getSubTotal()) {
                $cost = (($this->cart->getWeight() * $this->config->get('novaposhtacopy_delivery_price')) + $this->config->get('novaposhtacopy_delivery_order') + ($this->cart->getSubTotal() * $this->config->get('novaposhtacopy_delivery_insurance') / 100) + ($this->cart->getSubTotal() * $this->config->get('novaposhtacopy_delivery_nal') / 100));
            }

            $quote_data['novaposhtacopy'] = array(
                'code' => 'novaposhtacopy.novaposhtacopy',
                'title' => $this->language->get('text_description'),
                'cost' => $cost,
                'tax_class_id' => 0,
                'text' => $this->currency->format($cost, $this->session->data['currency'])
            );

            $method_data = array(
                'code' => 'novaposhtacopy',
                'title' => $this->language->get('text_title'),
                'quote' => $quote_data,
                'sort_order' => $this->config->get('novaposhtacopy_sort_order'),
                'error' => FALSE
            );
        }

        return $method_data;
    }

}