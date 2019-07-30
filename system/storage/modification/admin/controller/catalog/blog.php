<?php
/* All rights reserved belong to the module, the module developers http://opencartadmin.com */
// https://opencartadmin.com © 2011-2019 All Rights Reserved
// Distribution, without the author's consent is prohibited
// Commercial license
if (!class_exists('ControllerCatalogBlog', false)) {
class ControllerCatalogBlog extends Controller
{
	private $error = array();
	protected $data;

	public function __construct($registry) {
		parent::__construct($registry);
		$sc_ver = VERSION;
		if (!defined('SC_VERSION')) define('SC_VERSION', (int)substr(str_replace('.','',$sc_ver), 0,2));
		require_once(DIR_SYSTEM . 'helper/seocmsprofunc.php');

		if (!class_exists('agooCache', false)) {
			$Cache = $this->registry->get('cache');
			$this->registry->set('cache_old', $Cache);
			loadlibrary('agoo/cache');
			$jcCache = new agooCache($this->registry);
			$jcCache->agooconstruct();
			$this->registry->set('cache', $jcCache);
		}
	}

	public function index() {
		$this->config->set("blog_work", true);
        $this->data['ascp_settings'] = $this->config->get('ascp_settings');
		$this->language->load('module/blog');
		$this->data['oc_version'] = str_pad(str_replace(".", "", VERSION), 7, "0");
		$this->load->model('setting/setting');
		$this->data['blog_version'] = '*'; $this->data['blog_version_model'] = '';
		$settings_admin = $this->model_setting_setting->getSetting('ascp_version', 'ascp_version');
		foreach ($settings_admin as $key => $value) { $this->data['blog_version'] = $value; }
		$settings_admin_model = $this->model_setting_setting->getSetting('ascp_version_model', 'ascp_version_model');
		foreach ($settings_admin_model as $key => $value) {	$this->data['blog_version_model'] = $value;	}
		$this->data['blog_version'] = $this->data['blog_version'] . ' ' . $this->data['blog_version_model'];
		$this->data['tab_general']  = $this->language->get('tab_general');
		$this->data['tab_list']     = $this->language->get('tab_list');
        if (SC_VERSION > 23) {
	        $template_engine = $this->config->get('template_engine');
    	    $this->config->set('template_engine', 'template');
        }

		if (SC_VERSION > 23) {
			$this->config->set('template_engine', $template_engine);
	    }
        if ($this->config->get('asc_cnt_cnt')!='fec00258b41bb6fb92a7feb8ccb0bed9') {
        //$this->model_setting_setting->editSetting('ascp_version_model', Array('ascp_version_model'=>$this->language->get('blog_version_model')." &copy;"));
        } if (!isset($this->data['ascp_settings']['blogs_widget_status']) || !$this->data['ascp_settings']['blogs_widget_status']) { $this->getCatch(); return;}

      $this->config->set("blog_work", true);
		$this->getList();
	}
//**********************************************************************************************************************************************************************************
	public function insert() {
		$this->config->set("blog_work", false);
		$this->cache->delete('blog');
		$this->config->set("blog_work", true);
        if (SC_VERSION > 23) {
        	$this->data['token_name'] = 'user_token';
        } else {
        	$this->data['token_name'] = 'token';
        }
        $this->data['token'] = $this->session->data[$this->data['token_name']];
		$this->language->load('seocms/catalog/blog');
		$this->document->setTitle($this->language->get('heading_title'));
		$this->load->model('catalog/blog');
		$this->cache->delete('blog');
		$this->cache->delete('record');
		$this->cache->delete('blogsrecord');
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			foreach ($this->request->post['blog_description'] as $language_id => $value) {
				if ($value['description'] == '&lt;p&gt;&lt;br&gt;&lt;/p&gt;') {
					$this->request->post['blog_description'][$language_id]['description'] = '';
				}
			}

			$this->model_catalog_blog->addBlog($this->request->post);
			$this->session->data['success'] = $this->language->get('text_success');
           if (!isset($this->request->post['button_apply']) || !$this->request->post['button_apply']) {
				if (SC_VERSION < 20) {
					$this->redirect($this->url->link('catalog/blog', $this->data['token_name'].'=' . $this->session->data[$this->data['token_name']]));
				} else {

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
			
					$this->response->redirect($this->url->link('catalog/blog', $this->data['token_name'].'=' . $this->session->data[$this->data['token_name']]));
				}
			}
		}
		$this->getForm();
	}
//**********************************************************************************************************************************************************************************
	public function update() {

		$this->config->set("blog_work", true);
		$this->cache->delete('blog');

        if (SC_VERSION > 23) {
        	$this->data['token_name'] = 'user_token';
        } else {
        	$this->data['token_name'] = 'token';
        }
        $this->data['token'] = $this->session->data[$this->data['token_name']];
		$this->language->load('seocms/catalog/blog');

		$this->document->setTitle($this->language->get('heading_title'));
		$this->load->model('catalog/blog');
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			foreach ($this->request->post['blog_description'] as $language_id => $value) {
				if ($value['description'] == '&lt;p&gt;&lt;br&gt;&lt;/p&gt;') {
					$this->request->post['blog_description'][$language_id]['description'] = '';
				}
			}
			$this->model_catalog_blog->editBlog($this->request->get['blog_id'], $this->request->post);
			$this->session->data['success'] = $this->language->get('text_success');
			if (!isset($this->request->post['button_apply']) || !$this->request->post['button_apply']) {
				if (SC_VERSION < 20) {
					$this->redirect($this->url->link('catalog/blog', $this->data['token_name'].'=' . $this->session->data[$this->data['token_name']]));
				} else {

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
			
					$this->response->redirect($this->url->link('catalog/blog', $this->data['token_name'].'=' . $this->session->data[$this->data['token_name']]));
				}
			}
		}
		$this->getForm();
	}
//**********************************************************************************************************************************************************************************
	public function delete() {
        if (SC_VERSION > 23) {
        	$this->data['token_name'] = 'user_token';
        } else {
        	$this->data['token_name'] = 'token';
        }
        $this->data['token'] = $this->session->data[$this->data['token_name']];

		$this->config->set("blog_work", false);
		$this->cache->delete('blog');
		 $this->config->set("blog_work", true);


		$this->language->load('seocms/catalog/blog');
		$this->document->setTitle($this->language->get('heading_title'));
		$this->load->model('catalog/blog');
		$this->cache->delete('blog');
		$this->cache->delete('record');
		$this->cache->delete('blogsrecord');
		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $blog_id) {
				$this->model_catalog_blog->deleteBlog($blog_id);
			}
			$this->session->data['success'] = $this->language->get('text_success');
			if (SC_VERSION < 20) {
				$this->redirect($this->url->link('catalog/blog', $this->data['token_name'].'=' . $this->session->data[$this->data['token_name']]));
			} else {

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
			
				$this->response->redirect($this->url->link('catalog/blog', $this->data['token_name'].'=' . $this->session->data[$this->data['token_name']]));
			}
		}
		$this->getList();
	}
//**********************************************************************************************************************************************************************************

	public function copy() {
		$this->config->set("blog_work", true);
        if (SC_VERSION > 23) {
        	$this->data['token_name'] = 'user_token';
        } else {
        	$this->data['token_name'] = 'token';
        }
        $this->data['token'] = $this->session->data[$this->data['token_name']];
		$this->language->load('seocms/catalog/blog');
		$this->document->setTitle($this->language->get('heading_title'));
		$this->load->model('catalog/blog');
		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $blog_id) {
				$this->model_catalog_blog->copyBlog($blog_id);
			}
			$this->session->data['success'] = $this->language->get('text_success');
			$url                            = '';
			if (isset($this->request->get['filter_name'])) {
				$url .= '&filter_name=' . $this->request->get['filter_name'];
			}
			if (isset($this->request->get['filter_blog'])) {
				$url .= '&filter_blog=' . $this->request->get['filter_blog'];
			}
			if (isset($this->request->get['filter_price'])) {
				$url .= '&filter_price=' . $this->request->get['filter_price'];
			}
			if (isset($this->request->get['filter_quantity'])) {
				$url .= '&filter_quantity=' . $this->request->get['filter_quantity'];
			}
			if (isset($this->request->get['filter_status'])) {
				$url .= '&filter_status=' . $this->request->get['filter_status'];
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
			if (SC_VERSION < 20) {
				$this->redirect($this->url->link('catalog/blog', $this->data['token_name'].'=' . $this->session->data[$this->data['token_name']]));
			} else {

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
			
				$this->response->redirect($this->url->link('catalog/blog', $this->data['token_name'].'=' . $this->session->data[$this->data['token_name']]));
			}
		}
		$this->getList();
	}



	private function getList() {

        if (SC_VERSION > 23) {
	        $template_engine = $this->config->get('template_engine');
    	    $this->config->set('template_engine', 'template');
        }

        if (SC_VERSION > 23) {
        	$this->data['token_name'] = 'user_token';
        } else {
        	$this->data['token_name'] = 'token';
        }
        $this->data['token'] = $this->session->data[$this->data['token_name']];


		if (file_exists(DIR_APPLICATION . 'view/stylesheet/seocmspro.css')) {
			$this->document->addStyle('view/stylesheet/seocmspro.css');
		}
		if (file_exists(DIR_APPLICATION . 'view/javascript/blog/seocmspro.js')) {
			$this->document->addScript('view/javascript/blog/seocmspro.js');
		}
		$this->load->model('catalog/blog');
		$this->language->load('seocms/catalog/blog');
		$this->data['heading_title']    = $this->language->get('heading_title');
		$this->data['url_back']         = $this->url->link('module/blog', $this->data['token_name'].'=' . $this->session->data[$this->data['token_name']]);
		$this->data['url_back_text']    = $this->language->get('url_back_text');
		$this->data['url_modules']      = $this->url->link('extension/module', $this->data['token_name'].'=' . $this->session->data[$this->data['token_name']]);
		$this->data['url_options']      = $this->url->link('module/blog', $this->data['token_name'].'=' . $this->session->data[$this->data['token_name']]);
		$this->data['url_schemes']      = $this->url->link('module/blog/schemes', $this->data['token_name'].'=' . $this->session->data[$this->data['token_name']]);
		$this->data['url_widgets']      = $this->url->link('module/blog/widgets', $this->data['token_name'].'=' . $this->session->data[$this->data['token_name']]);
		$this->data['url_modules_text'] = $this->language->get('url_modules_text');
		$this->document->setTitle($this->language->get('heading_title'));

		if (isset($this->request->get['filter_name'])) {
			$filter_name = $this->request->get['filter_name'];
		} else {
			$filter_name = null;
		}
		if (isset($this->request->get['filter_blog'])) {
			$filter_blog = $this->request->get['filter_blog'];
		} else {
			$filter_blog = null;
		}
		if (isset($this->request->get['filter_status'])) {
			$filter_status = $this->request->get['filter_status'];
		} else {
			$filter_status = null;
		}
		if (isset($this->request->get['filter_date'])) {
			$filter_date = $this->request->get['filter_date'];
		} else {
			$filter_date = null;
		}
		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'p.blog_id';
		}
		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'DESC';
		}
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}
		$url = '';
		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . $this->request->get['filter_name'];
		}
		if (isset($this->request->get['filter_blog'])) {
			$url .= '&filter_blog=' . $this->request->get['filter_blog'];
		}
		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}
		if (isset($this->request->get['filter_date'])) {
			$url .= '&filter_date=' . $this->request->get['filter_date'];
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

		$this->data['heading_title']     = $this->language->get('heading_title');
		$this->data['text_no_results']   = $this->language->get('text_no_results');
		$this->data['column_name']       = $this->language->get('column_name');
		$this->data['column_sort_order'] = $this->language->get('column_sort_order');
		$this->data['column_action']     = $this->language->get('column_action');
		$this->data['button_insert']     = $this->language->get('button_insert');
		$this->data['button_delete']     = $this->language->get('button_delete');
		$this->data['url_blog']          = $this->url->link('catalog/blog', $this->data['token_name'].'=' . $this->session->data[$this->data['token_name']]);
		$this->data['url_record']        = $this->url->link('catalog/record', $this->data['token_name'].'=' . $this->session->data[$this->data['token_name']]);
		$this->data['url_comment']       = $this->url->link('catalog/comment', $this->data['token_name'].'=' . $this->session->data[$this->data['token_name']]);
		$this->data['url_blog_text']     = $this->language->get('url_blog_text');
		$this->data['url_record_text']   = $this->language->get('url_record_text');
		$this->data['url_comment_text']  = $this->language->get('url_comment_text');
		$this->data['url_create_text']   = $this->language->get('url_create_text');
		$this->data['button_copy']        = $this->language->get('button_copy');
        $this->data['column_status']      = $this->language->get('column_status');
		$this->data['insert']        = $this->url->link('catalog/blog/insert', $this->data['token_name'].'=' . $this->session->data[$this->data['token_name']] . $url);
		$this->data['copy']          = $this->url->link('catalog/blog/copy', $this->data['token_name'].'=' . $this->session->data[$this->data['token_name']] . $url);
		$this->data['delete']        = $this->url->link('catalog/blog/delete', $this->data['token_name'].'=' . $this->session->data[$this->data['token_name']] . $url);
   		$this->data['url_switchstatus']   = str_replace('&amp;','&',$this->url->link('catalog/blog/switchstatus', $this->data['token_name'].'=' . $this->session->data[$this->data['token_name']]));

		$this->data['breadcrumbs']   = array();
		$this->data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home', $this->data['token_name'].'=' . $this->session->data[$this->data['token_name']]),
			'separator' => false
		);
		$this->data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('catalog/blog', $this->data['token_name'].'=' . $this->session->data[$this->data['token_name']]),
			'separator' => ' :: '
		);
		$this->data['insert']        = $this->url->link('catalog/blog/insert', $this->data['token_name'].'=' . $this->session->data[$this->data['token_name']]);
		$this->data['delete']        = $this->url->link('catalog/blog/delete', $this->data['token_name'].'=' . $this->session->data[$this->data['token_name']]);
		$this->data['categories']    = array();
		$results                     = $this->model_catalog_blog->getCategories(0);
		$this->load->model('tool/image');
		$no_image = '';
		if (file_exists(DIR_IMAGE . 'no_image.jpg')) {
			$no_image = 'no_image.jpg';
		}
		if (file_exists(DIR_IMAGE . 'no_image.png')) {
			$no_image = 'no_image.png';
		}
		foreach ($results as $result) {
			$action   = array();
			$action[] = array(
				'text' => $this->language->get('text_edit'),
				'href' => $this->url->link('catalog/blog/update', $this->data['token_name'].'=' . $this->session->data[$this->data['token_name']] . '&blog_id=' . $result['blog_id'])
			);
			if (isset($result['image']) && $result['image'] != '' && file_exists(DIR_IMAGE . $result['image'])) {
				$image = $this->model_tool_image->resize($result['image'], 40, 40);
			} else {
				$image = $this->model_tool_image->resize($no_image, 40, 40);
			}


			$this->data['categories'][] = array(
				'blog_id' => $result['blog_id'],
				'url' => HTTPS_CATALOG . 'index.php?route=record/blog&blog_id=' . $result['blog_id'],
				'name' => $result['name'],
				'image' => $image,
				'status' => ($result['status'] ? $this->language->get('text_enabled') : $this->language->get('text_disabled')),
				'sort_order' => $result['sort_order'],
				'selected' => isset($this->request->post['selected']) && in_array($result['blog_id'], $this->request->post['selected']),
				'action' => $action
			);
		}

		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}

        $this->cont('agooa/adminmenu');
        $this->data['agoo_menu'] = $this->controller_agooa_adminmenu->index();
        $this->data['agoo_header'] = $this->controller_agooa_adminmenu->admin_header($this->data);


		if (SC_VERSION > 23) {
			$this->template         = 'catalog/blog_list';
		} else {
			$this->template         = 'catalog/blog_list.tpl';
		}

		$this->children         = array(
			'common/header',
			'common/footer'
		);
		$this->data['registry'] = $this->registry;
		$this->data['language'] = $this->language;
		$this->data['config']   = $this->config;
		if (SC_VERSION < 20) {
			$this->data['column_left'] = '';
			$html                      = $this->render();
		} else {
			if (SC_VERSION > 23) {
				$this->config->set('template_engine', $template_engine);
	        }
			$this->data['header']      = $this->load->controller('common/header');
			$this->data['footer']      = $this->load->controller('common/footer');
			$this->data['column_left'] = $this->load->controller('common/column_left');

            if (SC_VERSION > 23) {
	            $this->config->set('template_engine', 'template');
	        }
			$html = $this->load->view($this->template, $this->data);
		}
		$this->response->setOutput($html);
	}


	public function switchstatus() {
        $this->config->set("blog_work", true);
        if ($this->validateDelete()) {

			if (isset($this->request->get['id'])) {
				$id = (int)$this->request->get['id'];
			} else {
				$id = false;
			}
            $status = false;
            if ($id) {
	            $this->load->model('catalog/blog');
            	$status =  $this->model_catalog_blog->switchstatus($id);
            }

            if ($status) {
            	$html = $this->language->get('text_enabled');
            } else {
             	$html = $this->language->get('text_disabled');
            }

		} else {
			$html = $this->language->get('error_permission');
        }

		$this->response->setOutput($html);
		$this->config->set("blog_work", false);

	}


//**********************************************************************************************************************************************************************************

	private function get_access ($data)	{
		$this->config->set("blog_work", true);

		$this->data = $data;


        if (file_exists(DIR_APPLICATION.'model/sale/customer_group.php')) {
        	$this->load->model('sale/customer_group');
			$model_customer = 'model_sale_customer_group';
		} else {
			$this->load->model('customer/customer_group');
			$model_customer = 'model_customer_customer_group';
		}
		$this->data['customer_groups'] = $this->$model_customer->getCustomerGroups();



	    array_push($this->data['customer_groups'], array( 'customer_group_id' => -1,  'name' => $this->language->get('text_group_reg') ));
	    array_push($this->data['customer_groups'], array( 'customer_group_id' => -2,  'name' => $this->language->get('text_group_order') ));
	    array_push($this->data['customer_groups'], array( 'customer_group_id' => -3,  'name' => $this->language->get('text_group_order_this')));

	    $this->data['customer_groups_blog'] = $this->data['customer_groups'];

	    if ($this->data['blog_id']) {
		    $this->data['blog_access'] = $this->model_catalog_blog->getBlogAccess($this->data['blog_id']);
	    }

	    return $this->data;
	}
//**********************************************************************************************************************************************************************************

	public function blog_access() {
		$this->config->set("blog_work", true);

		if (!$this->validateDelete()) {
		 return;
		}

		if (isset($this->request->get['group'])) {
			$group = $this->request->get['group'];
		} else {
			$group = false;
		}

    	if (isset($this->request->get['blog_id'])) {
			$blog_id = $this->request->get['blog_id'];
		} else {
			$blog_id = false;
		}

    	if (isset($this->request->get['ch']) && $this->request->get['ch']=='1') {
			$check = $this->request->get['ch'];
		} else {
			$check = false;
		}

		$this->load->model('catalog/record');
		$results = $this->model_catalog_record->getRecordsByBlogId($blog_id);

		foreach ($results as $num => $record) {
          $this->model_catalog_record->setRecordAccessGroup($record['record_id'] ,$group, $check);
		}

        /*
        echo $group." -> ".$blog_id;
        print_r($results);
         */
	    //return $group;

	}

//**********************************************************************************************************************************************************************************
	private function getForm() {
		$this->config->set("blog_work", true);

        if (SC_VERSION > 23) {
	        $template_engine = $this->config->get('template_engine');
    	    $this->config->set('template_engine', 'template');
        }

        if (SC_VERSION > 23) {
        	$this->data['token_name'] = 'user_token';
        } else {
        	$this->data['token_name'] = 'token';
        }
        $this->data['token'] = $this->session->data[$this->data['token_name']];

        $this->data['ascp_settings'] = $this->config->get('ascp_settings');

		if (file_exists(DIR_APPLICATION . 'view/stylesheet/seocmspro.css')) {
			$this->document->addStyle('view/stylesheet/seocmspro.css');
		}
		if (file_exists(DIR_APPLICATION . 'view/javascript/jquery/tabs.js')) {
			$this->document->addScript('view/javascript/jquery/tabs.js');
		} else {
			if (file_exists(DIR_APPLICATION . 'view/javascript/blog/tabs/tabs.js')) {
				$this->document->addScript('view/javascript/blog/tabs/tabs.js');
			}
		}
		if (file_exists(DIR_APPLICATION . 'view/javascript/blog/seocmspro.js')) {
			$this->document->addScript('view/javascript/blog/seocmspro.js');
		}
		$no_image = 'no_image.jpg';
		if (file_exists(DIR_IMAGE . 'no_image.jpg')) {
			$no_image = 'no_image.jpg';
		}
		if (file_exists(DIR_IMAGE . 'no_image.png')) {
			$no_image = 'no_image.png';
		}
		$this->language->load('module/blog');
		$this->language->load('seocms/catalog/blog');



		$this->data['blog_version'] = '*.*';
		$this->data['oc_version']   = str_pad(str_replace(".", "", VERSION), 7, "0");
		$this->load->model('setting/setting');
		$settings_admin = $this->model_setting_setting->getSetting('ascp_version', 'ascp_version');
		foreach ($settings_admin as $key => $value) {
			$this->data['blog_version'] = $value;
		}

		$this->data['url_modules']                = $this->url->link('extension/module', $this->data['token_name'].'=' . $this->session->data[$this->data['token_name']]);
		$this->data['url_options']                = $this->url->link('module/blog', $this->data['token_name'].'=' . $this->session->data[$this->data['token_name']]);
		$this->data['url_schemes']                = $this->url->link('module/blog/schemes', $this->data['token_name'].'=' . $this->session->data[$this->data['token_name']]);
		$this->data['url_widgets']                = $this->url->link('module/blog/widgets', $this->data['token_name'].'=' . $this->session->data[$this->data['token_name']]);
		$this->data['url_modules_text']           = $this->language->get('url_modules_text');
		$this->data['url_back_text']              = $this->language->get('url_back_text');
		$this->data['text_none']                  = $this->language->get('text_none');
		$this->data['text_default']               = $this->language->get('text_default');
		$this->data['text_image_manager']         = $this->language->get('text_image_manager');
		$this->data['text_browse']                = $this->language->get('text_browse');
		$this->data['text_clear']                 = $this->language->get('text_clear');
		$this->data['text_enabled']               = $this->language->get('text_enabled');
		$this->data['text_disabled']              = $this->language->get('text_disabled');
		$this->data['text_percent']               = $this->language->get('text_percent');
		$this->data['text_amount']                = $this->language->get('text_amount');
		$this->data['text_yes']                   = $this->language->get('text_yes');
		$this->data['text_no']                    = $this->language->get('text_no');
		$this->data['entry_name']                 = $this->language->get('entry_name');
		$this->data['entry_customer_group']       = $this->language->get('entry_customer_group');
		$this->data['entry_short_path']           = $this->language->get('entry_short_path');
		$this->data['entry_meta_keyword']         = $this->language->get('entry_meta_keyword');
		$this->data['entry_meta_description']     = $this->language->get('entry_meta_description');
		$this->data['entry_description']          = $this->language->get('entry_description');
		$this->data['entry_store']                = $this->language->get('entry_store');
		$this->data['entry_keyword']              = $this->language->get('entry_keyword');
		$this->data['entry_parent']               = $this->language->get('entry_parent');
		$this->data['entry_image']                = $this->language->get('entry_image');
		$this->data['entry_top']                  = $this->language->get('entry_top');
		$this->data['entry_column']               = $this->language->get('entry_column');
		$this->data['entry_sort_order']           = $this->language->get('entry_sort_order');
		$this->data['entry_status']               = $this->language->get('entry_status');
		$this->data['entry_layout']               = $this->language->get('entry_layout');
		$this->data['button_save']                = $this->language->get('button_save');
		$this->data['button_apply']               = $this->language->get('button_apply');
		$this->data['button_cancel']              = $this->language->get('button_cancel');
		$this->data['tab_gen']                    = $this->language->get('tab_gen');
		$this->data['tab_data']                   = $this->language->get('tab_data');
		$this->data['tab_design']                 = $this->language->get('tab_design');
		$this->data['tab_options']                = $this->language->get('tab_options');
		$this->data['url_blog_text']              = $this->language->get('url_blog_text');
		$this->data['url_record_text']            = $this->language->get('url_record_text');
		$this->data['url_comment_text']           = $this->language->get('url_comment_text');
		$this->data['url_create_text']            = $this->language->get('url_create_text');
		$this->data['entry_what']                 = $this->language->get('entry_what');
		$this->data['entry_small_dim']            = $this->language->get('entry_small_dim');
		$this->data['entry_big_dim']              = $this->language->get('entry_big_dim');
		$this->data['entry_blog_num_comments']    = $this->language->get('entry_blog_num_comments');
		$this->data['entry_blog_num_records']     = $this->language->get('entry_blog_num_records');
		$this->data['entry_blog_num_desc']        = $this->language->get('entry_blog_num_desc');
		$this->data['entry_blog_num_desc_words']  = $this->language->get('entry_blog_num_desc_words');
		$this->data['entry_blog_num_desc_pred']   = $this->language->get('entry_blog_num_desc_pred');
		$this->data['entry_blog_template']        = $this->language->get('entry_blog_template');
		$this->data['entry_blog_template_record'] = $this->language->get('entry_blog_template_record');
		$this->data['entry_devider']              = $this->language->get('entry_devider');
		$this->data['tab_general']                = $this->language->get('tab_general');
		$this->data['tab_list']                   = $this->language->get('tab_list');
		$this->data['url_blog_text']              = $this->language->get('url_blog_text');
		$this->data['url_record_text']            = $this->language->get('url_record_text');
		$this->data['url_comment_text']           = $this->language->get('url_comment_text');
		$this->data['url_create_text']            = $this->language->get('url_create_text');

		$this->data['url_back']                   = $this->url->link('module/blog', $this->data['token_name'].'=' . $this->session->data[$this->data['token_name']]);
		$this->data['url_blog']                   = $this->url->link('catalog/blog', $this->data['token_name'].'=' . $this->session->data[$this->data['token_name']]);
		$this->data['url_record']                 = $this->url->link('catalog/record', $this->data['token_name'].'=' . $this->session->data[$this->data['token_name']]);
		$this->data['url_comment']                = $this->url->link('catalog/comment', $this->data['token_name'].'=' . $this->session->data[$this->data['token_name']]);
		$this->data['url_blog']                   = $this->url->link('catalog/blog', $this->data['token_name'].'=' . $this->session->data[$this->data['token_name']]);
		$this->data['url_record']                 = $this->url->link('catalog/record', $this->data['token_name'].'=' . $this->session->data[$this->data['token_name']]);
		$this->data['url_comment']                = $this->url->link('catalog/comment', $this->data['token_name'].'=' . $this->session->data[$this->data['token_name']]);

		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}
		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		if (isset($this->error['name'])) {
			$this->data['error_name'] = $this->error['name'];
		} else {
			$this->data['error_name'] = array();
		}
		if (isset($this->error['keyword'])) {
			$this->data['error_keyword'] = $this->error['keyword'];
		} else {
			$this->data['error_keyword'] = array();
		}



		$this->data['breadcrumbs']   = array();
		$this->data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home', $this->data['token_name'].'=' . $this->session->data[$this->data['token_name']]),
			'separator' => false
		);
		$this->data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('catalog/blog', $this->data['token_name'].'=' . $this->session->data[$this->data['token_name']]),
			'separator' => ' :: '
		);



		if (!isset($this->request->get['blog_id'])) {
			$this->data['action'] = $this->url->link('catalog/blog/insert', $this->data['token_name'].'=' . $this->session->data[$this->data['token_name']]);
		} else {
			$this->data['action'] = $this->url->link('catalog/blog/update', $this->data['token_name'].'=' . $this->session->data[$this->data['token_name']] . '&blog_id=' . $this->request->get['blog_id']);
		}

		if (!isset($this->request->get['blog_id'])) {
			$this->data['blog_id'] = false;
		} else {
			$this->data['blog_id'] = $this->request->get['blog_id'];
		}

		$this->data = $this->get_access($this->data);


		$this->data['cancel'] = $this->url->link('catalog/blog', $this->data['token_name'].'=' . $this->session->data[$this->data['token_name']]);
		$this->data['token']  = $this->session->data[$this->data['token_name']];
		if (isset($this->request->get['blog_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$blog_info = $this->model_catalog_blog->getBlog($this->request->get['blog_id']);
			$this->data['keyword'] = $this->model_catalog_blog->getBlogKeywords($this->request->get['blog_id']);
		}

		if ((!isset($blog_info) || empty($blog_info)) && $this->data['blog_id']) {
			$blog_info = $this->model_catalog_blog->getBlog($this->request->get['blog_id']);
		}


		if ((!isset($this->data['keyword']) || $this->data['keyword']=='') && $this->data['blog_id']) {
			$this->data['keyword'] = $this->model_catalog_blog->getBlogKeywords($this->request->get['blog_id']);
		}


		$this->load->model('localisation/language');

		$this->data['languages'] = $this->model_localisation_language->getLanguages();

		foreach ($this->data['languages'] as $code => $language) {
			if (!isset($language['image']) || SC_VERSION > 21) {
            	$this->data['languages'][$code]['image'] = "language/".$code."/".$code.".png";
				if (!file_exists(DIR_APPLICATION.$this->data['languages'][$code]['image'])) {
					$this->data['languages'][$code]['image'] = "view/image/flags/".$language['image'];
				}
			} else {
                $this->data['languages'][$code]['image'] = "view/image/flags/".$language['image'];
				if (!file_exists(DIR_APPLICATION.$this->data['languages'][$code]['image'])) {
					$this->data['languages'][$code]['image'] = "language/".$code."/".$code.".png";
				}
			}

			if (!file_exists(DIR_APPLICATION.$this->data['languages'][$code]['image'])) {
				$this->data['languages'][$code]['image'] = "view/image/seocms/sc_1x1.png";
			}
		}

		if (isset($this->request->post['blog_description'])) {
			$this->data['blog_description'] = $this->request->post['blog_description'];
		} elseif (isset($this->request->get['blog_id'])) {
			$this->data['blog_description'] = $this->model_catalog_blog->getBlogDescriptions($this->request->get['blog_id']);
		} else {
			$this->data['blog_description'] = array();
		}
        if (isset($this->data['ascp_settings']['blogs_widget_status']) && $this->data['ascp_settings']['blogs_widget_status']) {
			$categories = $this->model_catalog_blog->getCategories(0);
			if (!empty($blog_info)) {
				foreach ($categories as $key => $blog) {
					if ($blog['blog_id'] == $blog_info['blog_id']) {
						unset($categories[$key]);
					}
				}
			}
			$this->data['categories'] = $categories;
		} else {
			$this->data['categories'] = Array();
		}

		if (isset($this->request->post['parent_id'])) {
			$this->data['parent_id'] = $this->request->post['parent_id'];
		} elseif (!empty($blog_info)) {
			$this->data['parent_id'] = $blog_info['parent_id'];
		} else {
			$this->data['parent_id'] = 0;
		}
		$this->load->model('setting/store');
		$this->data['stores'] = $this->model_setting_store->getStores();
		if (isset($this->request->post['blog_store'])) {
			$this->data['blog_store'] = $this->request->post['blog_store'];
		} elseif (isset($this->request->get['blog_id'])) {
			$this->data['blog_store'] = $this->model_catalog_blog->getBlogStores($this->request->get['blog_id']);
		} else {
			$this->data['blog_store'] = array(
				0
			);
		}
		if (isset($this->request->post['keyword'])) {
			$this->data['keyword'] = $this->request->post['keyword'];
		} elseif (!empty($this->data['keyword'])) {
			$this->data['keyword'] = $this->data['keyword'];
		} else {
			$this->data['keyword'] = '';
		}
		if (isset($this->request->post['image'])) {
			$this->data['image'] = $this->request->post['image'];
		} elseif (!empty($blog_info)) {
			$this->data['image'] = $blog_info['image'];
		} else {
			$this->data['image'] = '';
		}
		$this->load->model('tool/image');
		if (!empty($blog_info) && $blog_info['image'] && file_exists(DIR_IMAGE . $blog_info['image'])) {
			$this->data['thumb'] = $this->model_tool_image->resize($blog_info['image'], 100, 100);
		} else {
			$this->data['thumb'] = $this->model_tool_image->resize($no_image, 100, 100);
		}
		$this->data['no_image'] = $this->model_tool_image->resize($no_image, 100, 100);

		if (isset($this->request->post['sort_order'])) {
			$this->data['sort_order'] = $this->request->post['sort_order'];
		} elseif (!empty($blog_info)) {
			$this->data['sort_order'] = $blog_info['sort_order'];
		} else {
			$this->data['sort_order'] = '';
		}
		if (isset($this->request->post['status'])) {
			$this->data['status'] = $this->request->post['status'];
		} elseif (!empty($blog_info)) {
			$this->data['status'] = $blog_info['status'];
		} else {
			$this->data['status'] = 1;
		}

		if (isset($this->request->post['category_status'])) {
			$this->data['category_status'] = $this->request->post['category_status'];
		} elseif (!empty($blog_info) && isset($blog_info['category_status'])) {
			$this->data['category_status'] = $blog_info['category_status'];
		} else {
			$this->data['category_status'] = 1;
		}
		if (isset($this->request->post['view_date'])) {
			$this->data['view_date'] = $this->request->post['view_date'];
		} elseif (!empty($blog_info) && isset($blog_info['view_date'])) {
			$this->data['view_date'] = $blog_info['view_date'];
		} else {
			$this->data['view_date'] = 1;
		}

        if (file_exists(DIR_APPLICATION.'model/sale/customer_group.php')) {
        	$this->load->model('sale/customer_group');
			$model_customer = 'model_sale_customer_group';
		} else {
			$this->load->model('customer/customer_group');
			$model_customer = 'model_customer_customer_group';
		}
		$this->data['customer_groups'] = $this->$model_customer->getCustomerGroups();



		if (isset($this->request->post['customer_group_id'])) {
			$this->data['customer_group_id'] = $this->request->post['customer_group_id'];
		} elseif (!empty($blog_info) && isset($blog_info['customer_group_id'])) {
			$this->data['customer_group_id'] = $blog_info['customer_group_id'];
		} else {
			$this->data['customer_group_id'] = (int) $this->config->get('config_customer_group_id');
		}
		if (isset($this->request->post['blog_design'])) {
			$this->data['blog_design'] = $this->request->post['blog_design'];
		} elseif (!empty($blog_info)) {
			if (isset($blog_info['design']))
				$this->data['blog_design'] = unserialize($blog_info['design']);
			else
				$this->data['blog_design'] = Array();
		} else {
			$this->data['blog_design'] = Array();
		}



		if (!isset($this->data['blog_design']['blog_short_path'])) {
			$this->data['blog_design']['blog_short_path'] = true;
		}

		if (!isset($this->data['blog_design']['visual_editor'])) {
			$this->data['blog_design']['visual_editor'] = true;
		}
		if (!isset($this->data['blog_design']['category_status'])) {
			$this->data['blog_design']['category_status'] = false;
		}
		if (!isset($this->data['blog_design']['view_date'])) {
			$this->data['blog_design']['view_date'] = true;
		}
		if (!isset($this->data['blog_design']['view_captcha'])) {
			$this->data['blog_design']['view_captcha'] = true;
		}
		if (!isset($this->data['blog_design']['next_status'])) {
			$this->data['blog_design']['next_status'] = true;
		}
		if (!isset($this->data['blog_design']['status_pagination'])) {
			$this->data['blog_design']['status_pagination'] = true;
		}
		if (!isset($this->data['blog_design']['order'])) {
			$this->data['blog_design']['order'] = 'latest';
		}

		if (!isset($this->data['blog_design']['view_share'])) {
			$this->data['blog_design']['view_share'] = true;
		}
		if (!isset($this->data['blog_design']['view_viewed'])) {
			$this->data['blog_design']['view_viewed'] = true;
		}
		if (!isset($this->data['blog_design']['view_rating'])) {
			$this->data['blog_design']['view_rating'] = true;
		}
		if (!isset($this->data['blog_design']['view_comments'])) {
			$this->data['blog_design']['view_comments'] = true;
		}

		if (!isset($this->data['blog_design']['title_status'])) {
			$this->data['blog_design']['title_status'] = true;
		}
		if (!isset($this->data['blog_design']['image_adaptive_resize'])) {
			$this->data['blog_design']['image_adaptive_resize'] = false;
		}
		if (!isset($this->data['blog_design']['image_status'])) {
			$this->data['blog_design']['image_status'] = true;
		}
		if (!isset($this->data['blog_design']['image_category_adaptive_resize'])) {
			$this->data['blog_design']['image_category_adaptive_resize'] = false;
		}

		if (!isset($this->data['blog_design']['image_gallery_status'])) {
			$this->data['blog_design']['image_gallery_status'] = true;
		}
		if (!isset($this->data['blog_design']['image_product_status'])) {
			$this->data['blog_design']['image_product_status'] = true;
		}

		if (!isset($this->data['blog_design']['images_number_hide'])) {
			$this->data['blog_design']['images_number_hide'] = true;
		}

		if (!isset($this->data['blog_design']['image_record_status'])) {
			$this->data['blog_design']['image_record_status'] = true;
		}

		if (!isset($this->data['blog_design']['image_gallery_adaptive_resize'])) {
			$this->data['blog_design']['image_gallery_adaptive_resize'] = false;
		}

		if (!isset($this->data['blog_design']['image_record_adaptive_resize'])) {
			$this->data['blog_design']['image_record_adaptive_resize'] = false;
		}
		if (!isset($this->data['blog_design']['thumb_view'])) {
			$this->data['blog_design']['thumb_view'] = true;
		}

		if (!isset($this->data['blog_design']['records_more'])) {
			$this->data['blog_design']['records_more'] = true;
		}

		if (!isset($this->data['blog_design']['sub_categories_status'])) {
			$this->data['blog_design']['sub_categories_status'] = true;
		}
		if (!isset($this->data['blog_design']['thumb_image']['width'])) {
			$this->data['blog_design']['thumb_image']['width'] = 300;
		}
		if (!isset($this->data['blog_design']['thumb_image']['height'])) {
			$this->data['blog_design']['thumb_image']['height'] = 300;
		}
		if (!isset($this->data['blog_design']['images_adaptive_resize'])) {
			$this->data['blog_design']['images_adaptive_resize'] = true;
		}



		if (isset($this->request->post['index_page'])) {
			$this->data['index_page'] = $this->request->post['index_page'];
		} elseif (!empty($blog_info)) {
			if (isset($blog_info['index_page'])) {
				$this->data['index_page'] =  explode(',',$blog_info['index_page']);
			} else {
				$this->data['index_page'] = Array();
			}

		} else {
			$this->data['index_page'][] = 'index';
			$this->data['index_page'][] = 'follow';
		}
        if (isset($this->request->get['blog_id'])) {
			$this->data['blog_layout'] = $this->model_catalog_blog->getBlogLayouts($this->request->get['blog_id']);
		} else {
			$this->data['blog_layout'] = false;
		}

		$this->load->model('design/layout');
		$this->data['layouts'] = $this->model_design_layout->getLayouts();

		if (!isset($blog_info['name']))  $blog_info['name'] = '';
		$this->data['heading_title'] = $this->language->get('heading_title') . ' :: ' . $blog_info['name'];


        $this->cont('agooa/adminmenu');
        $this->data['agoo_menu'] = $this->controller_agooa_adminmenu->index();
        $this->data['agoo_header'] = $this->controller_agooa_adminmenu->admin_header($this->data);


		if (SC_VERSION > 23) {
			$this->template        = 'catalog/blog_form';
		} else {
			$this->template        = 'catalog/blog_form.tpl';
		}

		$this->children        = array(
			'common/header',
			'common/footer'
		);

		$this->data['registry']                      = $this->registry;
		$this->data['language']                      = $this->language;
		$this->data['config']                        = $this->config;
		$this->data['block_records_width_templates'] = array(
			$this->language->get('entry_block_records_width_templates_2') => '49%',
			$this->language->get('entry_block_records_width_templates_3') => '32%',
			$this->language->get('entry_block_records_width_templates_4') => '24%',
			$this->language->get('entry_block_records_width_templates_5') => '19%',
			$this->language->get('entry_value_templates_clear') => ""
		);

		if (SC_VERSION < 20) {
			$this->data['column_left'] = '';
			$html                      = $this->render();
		} else {
			if (SC_VERSION > 23) {
				$this->config->set('template_engine', $template_engine);
	        }

			$this->data['header']      = $this->load->controller('common/header');
			$this->data['footer']      = $this->load->controller('common/footer');
			$this->data['column_left'] = $this->load->controller('common/column_left');
	        if (SC_VERSION > 23) {
	            $this->config->set('template_engine', 'template');
	        }

			$html                      = $this->load->view($this->template, $this->data);
		}
		$this->response->setOutput($html);
	}
//**********************************************************************************************************************************************************************************
	private function validateForm()	{
		$this->config->set("blog_work", true);

		if (!$this->user->hasPermission('modify', 'catalog/blog')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

        $handle = fopen(DIR_APPLICATION.'controller/module/blog.php', "r");
		$section = fread($handle, 6027);
		fclose($handle);
	    /*
	    if (md5($section)!='9713dee56f8d471a50030a2f7e201b98') {
        	$this->language->load('module/blog');
        	$this->load->model('setting/setting');
        	$this->model_setting_setting->editSetting('ascp_version_model', Array('ascp_version_model'=>$this->language->get('blog_version_model')." &copy;"));
			$this->model_setting_setting->editSetting('asc_cnt', Array('asc_cnt_cnt'=>md5('(c)')));
        } else {
        	$this->language->load('module/blog');
        	$this->load->model('setting/setting');
        	$rev_knil= $this->language->get('text_rev_knil');
        	$this->model_setting_setting->editSetting('ascp_version_model', Array('ascp_version_model'=>$this->language->get('blog_version_model')));
			$this->model_setting_setting->editSetting('asc_cnt', Array('asc_cnt_cnt'=>md5($rev_knil)));
        }
        */

        $seo_url = array();
		foreach ($this->request->post['keyword'] as $language_id => $value) {
			if (isset($seo_url[$value])) {
             $this->error['keyword'][$language_id] = $this->language->get('error_keyword');
			}
	       if ($value!='') {
	          	$seo_url[$value] = $language_id;
	       }
		}

		foreach ($this->request->post['blog_description'] as $language_id => $value) {
			if ((utf8_strlen($value['name']) < 2) || (utf8_strlen($value['name']) > 255)) {
				$this->error['name'][$language_id] = $this->language->get('error_name');
			}
		}

		if ($this->error && !isset($this->error['warning'])) {
			$this->error['warning'] = $this->language->get('error_warning');
		}
		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

	private function getCatch() {
    	$this->load->model('catalog/record');
    	$catch_model = $this->model_catalog_record->getCatchBlog();
     	if (empty($catch_model)) {
     		$this->insert();
     	} else {
            $this->request->get['blog_id'] = $catch_model['blog_id'];
     		$this->update();
     	}
	}

//**********************************************************************************************************************************************************************************
	private function validateDelete() {
		$this->config->set("blog_work", true);
		if (!$this->user->hasPermission('modify', 'catalog/blog')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}
//**********************************************************************************************************************************************************************************
	public function cont($cont) {
		$file  = DIR_CATALOG . 'controller/' . $cont . '.php';
		if (file_exists($file)) {
           $this->cont_loading($cont, $file);
		} else {
			$file  = DIR_APPLICATION . 'controller/' . $cont . '.php';
            if (file_exists($file)) {
             	$this->cont_loading($cont, $file);
            } else {
				trigger_error('Error: Could not load controller ' . $cont . '!');
				exit();
			}
		}
	}
//**********************************************************************************************************************************************************************************
	private function cont_loading ($cont, $file) {
			$class = 'Controller' . preg_replace('/[^a-zA-Z0-9]/', '', $cont);
			include_once($file);
			$this->registry->set('controller_' . str_replace('/', '_', $cont), new $class($this->registry));
	}
}
}