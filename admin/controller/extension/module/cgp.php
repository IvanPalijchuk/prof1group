<?php
class ControllerExtensionModuleCgp extends Controller {
	private $error = array(); 
	
	public function index() {  
	
		$this->load->language('extension/module/cgp');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
				
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('cgp', $this->request->post);		
					
			$this->session->data['success'] = $this->language->get('text_success');
						
			$this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'], true));
		}
				
		$data['heading_title'] = $this->language->get('heading_title');
		
		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		
 		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

  		$data['breadcrumbs'] = array();

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], true),
      		'separator' => false
   		);

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/extension', 'token=' . $this->session->data['token'], true),
      		'separator' => ' :: '
   		);
		
   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('extension/module/cgp', 'token=' . $this->session->data['token'], true),
      		'separator' => ' :: '
   		);
		
		$data['action'] = $this->url->link('extension/module/cgp', 'token=' . $this->session->data['token'], true);
		
		$data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'], true);

		$data['modules'] = array();
		
		$this->load->model('design/layout');
		
		$data['layouts'] = $this->model_design_layout->getLayouts();
		
		$this->children = array(
			'common/header',
			'common/footer'
		);
		
		//START
		$this->load->model('tool/image');
		$this->load->model('extension/module/cgp');
		
		//entry
		$this->setDataLang($data, 'entry_display_multiple_prices');
		$this->setDataLang($data, 'entry_customer_group_name');
		$this->setDataLang($data, 'entry_enable');
		$this->setDataLang($data, 'entry_show_as_reference_on_product_page');
		$this->setDataLang($data, 'entry_sort_order');
		$this->setDataLang($data, 'entry_use_custom_style');
		$this->setDataLang($data, 'entry_text_color');
		$this->setDataLang($data, 'entry_apply_style_to');
		
		//text
		$this->setDataLang($data, 'text_yes');
		$this->setDataLang($data, 'text_no');
		$this->setDataLang($data, 'text_name');
		$this->setDataLang($data, 'text_price');
		
		//data		
		$this->setData($data, 'cgp_enable', 'true');
		$this->setData($data, 'cgp_display_multiple_prices', 'false');
		$data['cgp_customer_group_settings'] = $this->model_extension_module_cgp->getCustomerGroupSettings();
		
		
		//END
		$data['token'] =  $this->session->data['token'];
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
		
		$this->response->setOutput($this->load->view('extension/module/cgp', $data));
	}
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'extension/module/cgp')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
	
	public function install()
	{
		// TODO set cgp_enable true
	}
	
	public function uninstall()
	{
		// TODO set cgp_enable false
	}
}
?>