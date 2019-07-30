<?php
/**
* Клас для роботи з вмістом шапки та підвалу сайта
*/
class ControllerExtensionModuleHeaderFooter extends Controller {
	public function index(){
		ini_set('error_reporting', E_ALL);
		ini_set('display_errors', 1);
		ini_set('display_startup_errors', 1);
		$this->load->language('extension/module/headerfooter');
		$this->document->setTitle($this->language->get('heading_title'));
		$this->load->model('setting/setting');
		if (($this->request->server['REQUEST_METHOD'] == 'POST')) {
			$this->model_setting_setting->setAddHeaderfooter($this->request->post);
		}
		//$this->model_setting_setting->getAdressStores();
		$data['red_string'] = $this->model_setting_setting->getRedString();
		$data['polygon'] = $this->model_setting_setting->getPolygon();
		$data['rekrut'] = $this->model_setting_setting->getRekrut();
		$data['tochka'] = $this->model_setting_setting->getTochka();
		$data['forest'] = $this->model_setting_setting->getForest();
		//echo '<pre>';print_r($data);echo '<pre>';die('die');
		$data['h_work'] = $this->model_setting_setting->getHwork();
		$data['f_work'] = $this->model_setting_setting->getFwork();
		$data['heading_title'] = $this->language->get('heading_title');
		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		$data['text_edit_h'] = $this->language->get('text_edit_h');
		$data['text_edit_f'] = $this->language->get('text_edit_f');
		$data['text_h_text_string'] = $this->language->get('text_h_text_string');
		$data['text_h_work'] = $this->language->get('text_h_work');
		$data['text_f_work'] = $this->language->get('text_f_work');
		$data['adress_poligon'] = $this->language->get('adress_poligon');
		$data['adress_rekrut'] = $this->language->get('adress_rekrut');
		$data['adress_tochka'] = $this->language->get('adress_tochka');
		$data['adress_forest'] = $this->language->get('adress_forest');
		$data['text_name_store'] = $this->language->get('text_name_store');
		$data['text_adress_store'] = $this->language->get('text_adress_store');
		$data['h_work_store'] = $this->language->get('h_work_store');
		$data['sorted_store'] = $this->language->get('sorted_store');
		$data['token'] = $this->session->data['token'];
		$this->load->model('localisation/language');
		$data['languages'] = $this->model_localisation_language->getLanguages();		
		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}
		$data['breadcrumbs'] = array();
		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);
		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_extension'),
			'href' => $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true)
		);
		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('extension/module/account', 'token=' . $this->session->data['token'], true)
		);
		$data['action'] = $this->url->link('extension/module/headerfooter', 'token=' . $this->session->data['token'], true);
		$data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true);
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
		$this->response->setOutput($this->load->view('extension/module/headerfooter', $data));		
	}
}