<?php
class ControllerCatalogPromotionLabelToProduct extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('catalog/promotion_label_to_product');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/promotion_label_pro');
		$this->model_catalog_promotion_label_pro->CreateDB();

		$this->getList();
	}

	public function add() {
		$this->load->language('catalog/promotion_label_to_product');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/promotion_label_pro');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {

			$this->model_catalog_promotion_label_pro->addLabelProduct($this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['filter_name'])) {
				$url .= '&filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}


				if (isset($this->request->get['route'])) {
					$get = explode("/", $this->request->get['route']);
					$folder = $get[0];
					$file = $get[1];
					
					if ($file == 'user_permission') {
						$table = 'user_group';
					} else {
						if($folder == 'module') {
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
						$route = $folder.'/'.$file;
						$editroute = $folder.'/'.$file;
					}
					
					if (!isset($url)) $url = '';

					if(($folder != 'module') && ($folder != 'newsblog')) {
						if (($file != 'setting') && (isset($this->request->get[$table.'_id']) || isset($id))) {
							$url .= '&'.$table.'_id='.(isset($this->request->get[$table.'_id']) ? $this->request->get[$table.'_id'] : $id);
						}
					}
					elseif($folder == 'newsblog') {
						$url .= '&'.$file.'_id='.(isset($this->request->get[$file.'_id']) ? $this->request->get[$file.'_id'] : $id);
					}
					else{
						$url .= '&module_id='.(isset($this->request->get['module_id']) ? $this->request->get['module_id'] : $id);
					}
					if (isset($this->request->post['apply']) && $this->request->post['apply'] == '1') {
						$this->response->redirect($this->url->link($editroute, 'token=' . $this->session->data['token'] . $url, (version_compare(VERSION, '2.2.0.0') >= 0) ? true : 'SSL'));
					} else {
						if($folder != 'module') {
							$this->response->redirect($this->url->link($route, 'token=' . $this->session->data['token'] . $url, (version_compare(VERSION, '2.2.0.0') >= 0) ? true : 'SSL'));
						}
					}
				}
			
			$this->response->redirect($this->url->link('catalog/promotion_label_to_product', 'token=' . $this->session->data['token'] . $url, true));
		}

		$this->getForm();
	}

	public function edit() {
		$this->load->language('catalog/promotion_label_to_product');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/promotion_label_pro');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {

			$this->model_catalog_promotion_label_pro->editLabelProduct($this->request->get['product_label_id'], $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['filter_name'])) {
				$url .= '&filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}


				if (isset($this->request->get['route'])) {
					$get = explode("/", $this->request->get['route']);
					$folder = $get[0];
					$file = $get[1];
					
					if ($file == 'user_permission') {
						$table = 'user_group';
					} else {
						if($folder == 'module') {
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
						$route = $folder.'/'.$file;
						$editroute = $folder.'/'.$file;
					}
					
					if (!isset($url)) $url = '';

					if(($folder != 'module') && ($folder != 'newsblog')) {
						if (($file != 'setting') && (isset($this->request->get[$table.'_id']) || isset($id))) {
							$url .= '&'.$table.'_id='.(isset($this->request->get[$table.'_id']) ? $this->request->get[$table.'_id'] : $id);
						}
					}
					elseif($folder == 'newsblog') {
						$url .= '&'.$file.'_id='.(isset($this->request->get[$file.'_id']) ? $this->request->get[$file.'_id'] : $id);
					}
					else{
						$url .= '&module_id='.(isset($this->request->get['module_id']) ? $this->request->get['module_id'] : $id);
					}
					if (isset($this->request->post['apply']) && $this->request->post['apply'] == '1') {
						$this->response->redirect($this->url->link($editroute, 'token=' . $this->session->data['token'] . $url, (version_compare(VERSION, '2.2.0.0') >= 0) ? true : 'SSL'));
					} else {
						if($folder != 'module') {
							$this->response->redirect($this->url->link($route, 'token=' . $this->session->data['token'] . $url, (version_compare(VERSION, '2.2.0.0') >= 0) ? true : 'SSL'));
						}
					}
				}
			
			$this->response->redirect($this->url->link('catalog/promotion_label_to_product', 'token=' . $this->session->data['token'] . $url, true));
		}

		$this->getForm();
	}

	public function delete() {
		$this->load->language('catalog/promotion_label_to_product');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/promotion_label_pro');

		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $product_label_id) {
				$this->model_catalog_promotion_label_pro->deleteLabelProduct($product_label_id);
			}

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['filter_name'])) {
				$url .= '&filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
			}
		
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}


				if (isset($this->request->get['route'])) {
					$get = explode("/", $this->request->get['route']);
					$folder = $get[0];
					$file = $get[1];
					
					if ($file == 'user_permission') {
						$table = 'user_group';
					} else {
						if($folder == 'module') {
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
						$route = $folder.'/'.$file;
						$editroute = $folder.'/'.$file;
					}
					
					if (!isset($url)) $url = '';

					if(($folder != 'module') && ($folder != 'newsblog')) {
						if (($file != 'setting') && (isset($this->request->get[$table.'_id']) || isset($id))) {
							$url .= '&'.$table.'_id='.(isset($this->request->get[$table.'_id']) ? $this->request->get[$table.'_id'] : $id);
						}
					}
					elseif($folder == 'newsblog') {
						$url .= '&'.$file.'_id='.(isset($this->request->get[$file.'_id']) ? $this->request->get[$file.'_id'] : $id);
					}
					else{
						$url .= '&module_id='.(isset($this->request->get['module_id']) ? $this->request->get['module_id'] : $id);
					}
					if (isset($this->request->post['apply']) && $this->request->post['apply'] == '1') {
						$this->response->redirect($this->url->link($editroute, 'token=' . $this->session->data['token'] . $url, (version_compare(VERSION, '2.2.0.0') >= 0) ? true : 'SSL'));
					} else {
						if($folder != 'module') {
							$this->response->redirect($this->url->link($route, 'token=' . $this->session->data['token'] . $url, (version_compare(VERSION, '2.2.0.0') >= 0) ? true : 'SSL'));
						}
					}
				}
			
			$this->response->redirect($this->url->link('catalog/promotion_label_to_product', 'token=' . $this->session->data['token'] . $url, true));
		}

		$this->getList();
	}

	protected function getList() {
		if (isset($this->request->get['filter_name'])) {
			$filter_name = $this->request->get['filter_name'];
		} else {
			$filter_name = null;
		}

		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'pd.name';
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
		}

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		$url = '';

		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
		}
	
		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('catalog/promotion_label_to_product', 'token=' . $this->session->data['token'] . $url, true)
		);

		$data['add'] = $this->url->link('catalog/promotion_label_to_product/add', 'token=' . $this->session->data['token'] . $url, true);
		$data['delete'] = $this->url->link('catalog/promotion_label_to_product/delete', 'token=' . $this->session->data['token'] . $url, true);

		$data['products'] = array();

		$filter_data = array(
			'filter_name'	  => $filter_name,
			'sort'            => $sort,
			'order'           => $order,
			'start'           => ($page - 1) * $this->config->get('config_limit_admin'),
			'limit'           => $this->config->get('config_limit_admin')
		);

		$this->load->model('tool/image');

		$product_total = $this->model_catalog_promotion_label_pro->getTotalLabelProducts($filter_data);

		$results = $this->model_catalog_promotion_label_pro->getLabelProducts($filter_data);

		foreach ($results as $result) {
			if (is_file(DIR_IMAGE . $result['image'])) {
				$image = $this->model_tool_image->resize($result['image'], 180, 180);
			} else {
				$image = $this->model_tool_image->resize('no_image.png', 180, 180);
			}

			$data['products'][] = array(
				'product_label_id' => $result['product_label_id'],
				'image'      => $image,
				'name'       => $result['name'],
				'position'   => $result['position'],
				'label_img'  => HTTP_CATALOG . 'image/' .$result['label_image'],
				'date_start' => date($this->language->get('date_format_short'), strtotime($result['date_start'])),
				'date_end'   => date($this->language->get('date_format_short'), strtotime($result['date_end'])),
				'edit'       => $this->url->link('catalog/promotion_label_to_product/edit', 'token=' . $this->session->data['token'] . '&product_label_id=' . $result['product_label_id'] . $url, true)
			);
		}

$data['button_apply'] = $this->language->get('button_apply');
		$data['heading_title'] = $this->language->get('heading_title');
		
		$data['text_list'] = $this->language->get('text_list');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_no_results'] = $this->language->get('text_no_results');
		$data['text_confirm'] = $this->language->get('text_confirm');

		$data['column_image'] = $this->language->get('column_image');
		$data['column_name'] = $this->language->get('column_name');
		$data['column_date_start'] = $this->language->get('column_date_start');
		$data['column_date_end'] = $this->language->get('column_date_end');
		$data['column_action'] = $this->language->get('column_action');

		$data['entry_name'] = $this->language->get('entry_name');

		$data['button_copy'] = $this->language->get('button_copy');
		$data['button_add'] = $this->language->get('button_add');
		$data['button_edit'] = $this->language->get('button_edit');
		$data['button_delete'] = $this->language->get('button_delete');
		$data['button_filter'] = $this->language->get('button_filter');

		$data['token'] = $this->session->data['token'];

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

		if (isset($this->request->post['selected'])) {
			$data['selected'] = (array)$this->request->post['selected'];
		} else {
			$data['selected'] = array();
		}

		$url = '';

		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
		}

		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$data['sort_name'] = $this->url->link('catalog/promotion_label_to_product', 'token=' . $this->session->data['token'] . '&sort=pd.name' . $url, true);
		$data['sort_date_start'] = $this->url->link('catalog/promotion_label_to_product', 'token=' . $this->session->data['token'] . '&sort=olp.date_start' . $url, true);
		$data['sort_date_end'] = $this->url->link('catalog/promotion_label_to_product', 'token=' . $this->session->data['token'] . '&sort=olp.date_end' . $url, true);

		$url = '';

		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
		}
	
		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $product_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_limit_admin');
		$pagination->url = $this->url->link('catalog/promotion_label_to_product', 'token=' . $this->session->data['token'] . $url . '&page={page}', true);

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($product_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($product_total - $this->config->get('config_limit_admin'))) ? $product_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $product_total, ceil($product_total / $this->config->get('config_limit_admin')));

		$data['filter_name'] = $filter_name;
	
		$data['sort'] = $sort;
		$data['order'] = $order;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('catalog/promotion_label_to_product_list', $data));
	}

	protected function getForm() {
$data['button_apply'] = $this->language->get('button_apply');
		$data['heading_title'] = $this->language->get('heading_title');
		
		$data['text_form'] = !isset($this->request->get['product_label_id']) ? $this->language->get('text_add') : $this->language->get('text_edit');

		$data['entry_product'] = $this->language->get('entry_product');
		$data['entry_label'] = $this->language->get('entry_label');
		$data['entry_date_start'] = $this->language->get('entry_date_start');
		$data['entry_date_end'] = $this->language->get('entry_date_end');
		$data['entry_position'] = $this->language->get('entry_position');

		$data['text_none'] = $this->language->get('text_none');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
	
		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['product'])) {
			$data['error_product'] = $this->error['product'];
		} else {
			$data['error_product'] = '';
		}

		if (isset($this->error['date_start'])) {
			$data['error_date_start'] = $this->error['date_start'];
		} else {
			$data['error_date_start'] = '';
		}

		if (isset($this->error['date_end'])) {
			$data['error_date_end'] = $this->error['date_end'];
		} else {
			$data['error_date_end'] = '';
		}
		
		$url = '';

		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('catalog/promotion_label_to_product', 'token=' . $this->session->data['token'] . $url, true)
		);

		if (!isset($this->request->get['product_label_id'])) {
			$data['action'] = $this->url->link('catalog/promotion_label_to_product/add', 'token=' . $this->session->data['token'] . $url, true);
		} else {
			$data['action'] = $this->url->link('catalog/promotion_label_to_product/edit', 'token=' . $this->session->data['token'] . '&product_label_id=' . $this->request->get['product_label_id'] . $url, true);
		}

		$data['cancel'] = $this->url->link('catalog/promotion_label_to_product', 'token=' . $this->session->data['token'] . $url, true);

		if (isset($this->request->get['product_label_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$label_product_info = $this->model_catalog_promotion_label_pro->getLabelProduct($this->request->get['product_label_id']);
		}

		$data['token'] = $this->session->data['token'];

		$this->load->model('catalog/promotion_label_pro');

		$this->load->model('catalog/product');

		$this->load->model('tool/image');

		if (isset($this->request->post['product_id'])) {
			$data['product_id'] = $this->request->post['product_id'];
		} elseif (!empty($label_product_info)) {
			$data['product_id'] = $label_product_info['product_id'];
		} else {
			$data['product_id'] = 0;
		}

		if (isset($this->request->post['product'])) {
			$data['product'] = $this->request->post['product'];
		} elseif (!empty($label_product_info)) {
			$product_info = $this->model_catalog_product->getProduct($label_product_info['product_id']);

			if ($product_info) {
				$data['product'] = $product_info['name'];
			} else {
				$data['product'] = '';
			}
		} else {
			$data['product'] = '';
		}

		if (isset($this->request->post['label_id'])) {
			$data['label_id'] = $this->request->post['label_id'];
		} elseif (!empty($label_product_info)) {
			$data['label_id'] = $label_product_info['label_id'];
		} else {
			$data['label_id'] = 0;
		}

		if (isset($this->request->post['label'])) {
			$data['label'] = $this->request->post['label'];
		} elseif (!empty($label_product_info)) {
			$label_info = $this->model_catalog_promotion_label_pro->getLabel($label_product_info['label_id']);

			if ($label_info) {
				$data['label'] = $label_info['name'];
			} else {
				$data['label'] = '';
			}
		} else {
			$data['label'] = '';
		}

		if (isset($this->request->post['position'])) {
			$data['position'] = $this->request->post['position'];
		} elseif (!empty($label_product_info)) {
			$data['position'] = $label_product_info['position'];
		} else {
			$data['position'] = 'rb-tl';
		}		

		if (isset($this->request->post['date_start'])) {
			$data['date_start'] = $this->request->post['date_start'];
		} elseif (!empty($label_product_info)) {
			$data['date_start'] = ($label_product_info['date_start'] != '0000-00-00') ? $label_product_info['date_start'] : '';
		} else {
			$data['date_start'] = date('Y-m-d');
		}

		if (isset($this->request->post['date_end'])) {
			$data['date_end'] = $this->request->post['date_end'];
		} elseif (!empty($label_product_info)) {
			$data['date_end'] = ($label_product_info['date_end'] != '0000-00-00') ? $label_product_info['date_end'] : '';
		} else {
			$data['date_end'] = date("Y-m-d", time() + 3600*24);
		}

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('catalog/promotion_label_to_product_form', $data));
	}

	protected function validateForm() {
		if (!$this->user->hasPermission('modify', 'catalog/promotion_label_to_product')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->request->post['product_id']) {
			$this->error['product'] = $this->language->get('error_product');
		}
		
		if ($this->error && !isset($this->error['warning'])) {
			$this->error['warning'] = $this->language->get('error_warning');
		}

		return !$this->error;
	}

	protected function validateDelete() {
		if (!$this->user->hasPermission('modify', 'catalog/promotion_label_to_product')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}

}
