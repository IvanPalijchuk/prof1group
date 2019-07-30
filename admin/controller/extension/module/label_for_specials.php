<?php
class ControllerExtensionModulelabelforspecials extends Controller {
	private $error = array();
	private $moduleName = 'label_for_specials';
	private $moduleFilePath = 'extension/module/label_for_specials';
	private $moduleVersion = '1.0';

	public function index() {
		$lang = $this->load->language($this->moduleFilePath);
		
		foreach($lang as $k => $v){
			$data[$k] = $v;
		}
		
		$data['heading_title'] = $this->language->get('heading_title');

		$this->document->setTitle(STRIP_TAGS($this->language->get('heading_title')));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting($this->moduleName, $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true));

		}

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_module'),
			'href' => $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('extension/module/' . $this->moduleName, 'token=' . $this->session->data['token'], true)
		);

		$data['action'] = $this->url->link('extension/module/' . $this->moduleName, 'token=' . $this->session->data['token'], true);
		$data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true);
		
		$vars = array(
			'status' => 0,
			'label_type' => 'percent',
			'label_text' => '',
			'label_style' => array(
				'background_color' => '#E27C7C',
				'text_color' => '#FFFFFF',
				'padding' => '5',
			)
		);
		
		foreach($vars as $var => $default){
			if (isset($this->request->post[$this->moduleName . '_' . $var])) {
				$data[$this->moduleName . '_' . $var] = $this->request->post[$this->moduleName . '_' . $var];
			} elseif($this->config->get($this->moduleName . '_' . $var)) {
				$data[$this->moduleName . '_' . $var] = $this->config->get($this->moduleName . '_' . $var);
			} else {
				$data[$this->moduleName . '_' . $var] = $default;
			}
		}
		
		$this->load->model('localisation/language');
		$data['languages'] = $this->model_localisation_language->getLanguages();

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view($this->moduleFilePath . '.tpl', $data));
	}
	
	protected function validate() {
		if (!$this->user->hasPermission('modify', 'extension/module/' . $this->moduleName)) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}
}