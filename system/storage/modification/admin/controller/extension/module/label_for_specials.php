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
		
$data['button_apply'] = $this->language->get('button_apply');
		$data['heading_title'] = $this->language->get('heading_title');

		$this->document->setTitle(STRIP_TAGS($this->language->get('heading_title')));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting($this->moduleName, $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');


				if (isset($this->request->get['route'])) {
					$get = explode("/", $this->request->get['route']);
					if ($get[0] == 'extension') {
						$ext = $get[0];
						$folder = $get[1];
						$file = $get[2];
					} else {
						$folder = $get[0];
						$file = $get[1];
					}
					if ($file == 'user_permission') {
						$table = 'user_group';
					} else {
						if($folder == 'module'){
							$table = 'module';
						}
						elseif($folder == 'newsblog') {
							$table = $folder.'_'.$file;
						} else {
							$table = $file;
						}
					}
					$this->load->model('setting/setting');
					if ($file == 'user_permission' || $folder == 'module') {
						$id = $this->model_setting_setting->getLastId($table, $table);
					} else {
						$id = $this->model_setting_setting->getLastId($table, $file);
					}

					if ($folder != 'module') {
						if ($file == 'setting') {
							$route = 'setting/store';
							$editroute = 'setting/setting';
						} else {
							$route = $folder.'/'.$file;
							$editroute = $folder.'/'.$file.'/edit';
						}
					} else {
						if (isset($ext)) {
							$route = 'extension/'.$folder.'/'.$file;
							$editroute = 'extension/'.$folder.'/'.$file;
						} else {
							$route = $folder.'/'.$file;
							$editroute = $folder.'/'.$file;
						}
					}

					if (!isset($url)) $url = '';

					if(($folder != 'module') && ($folder != 'newsblog')) {
						if (($file != 'setting') && (isset($this->request->get[$table.'_id']) || isset($id))) {
							$url .= '&'.$table.'_id='.(isset($this->request->get[$table.'_id']) ? $this->request->get[$table.'_id'] : $id);
						}
					}
					elseif($folder == 'newsblog') {
						$url .= '&'.$file.'_id='.(isset($this->request->get[$file.'_id']) ? $this->request->get[$file.'_id'] : $id);
					} else {
						$url .= '&module_id='.(isset($this->request->get['module_id']) ? $this->request->get['module_id'] : $id);
					}
					if (isset($this->request->post['apply']) && $this->request->post['apply'] == '1') {
						$this->response->redirect($this->url->link($editroute, 'token=' . $this->session->data['token'] . $url, true));
					} else {
						if($folder != 'module') {
							$this->response->redirect($this->url->link($route, 'token=' . $this->session->data['token'] . $url, true));
						}
					}
				}
			
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