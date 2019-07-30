<?php
/* All rights reserved belong to the module, the module developers http://opencartadmin.com */
// https://opencartadmin.com © 2011-2019 All Rights Reserved
// Distribution, without the author's consent is prohibited
// Commercial license
class ControllerConvertorShopStore extends Controller
{
	private $error = array();
	protected $data;
	protected $blog_description;
	public function index()
	{

		$this->config->set("blog_work", true);

		$this->language->load('module/blog');
		$this->data['oc_version'] = str_pad(str_replace(".", "", VERSION), 7, "0");
		$this->load->model('setting/setting');
		$this->data['blog_version']       = '*';
		$this->data['blog_version_model'] = '';
		$settings_admin                   = $this->model_setting_setting->getSetting('ascp_version', 'ascp_version');
		foreach ($settings_admin as $key => $value) {
			$this->data['blog_version'] = $value;
		}
		$settings_admin_model = $this->model_setting_setting->getSetting('ascp_version_model', 'ascp_version_model');
		foreach ($settings_admin_model as $key => $value) {
			$this->data['blog_version_model'] = $value;
		}

		$this->data['blog_version'] = $this->data['blog_version'] . ' ' . $this->data['blog_version_model'];

		$this->load->language('seocms/convertor/shopstore');

		$this->data['tab_general']      = $this->language->get('tab_general');
		$this->data['tab_list']         = $this->language->get('tab_list');
		$this->data['url_modules_text'] = $this->language->get('url_modules_text');

		if (file_exists(DIR_APPLICATION . 'view/stylesheet/seocmspro.css')) {
			$this->document->addStyle('view/stylesheet/seocmspro.css');
		}
		if (file_exists(DIR_APPLICATION . 'view/javascript/blog/seocmspro.js')) {
			$this->document->addScript('view/javascript/blog/seocmspro.js');
		}

		$this->data['url_modules']      = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['url_options']      = $this->url->link('module/blog', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['url_schemes']      = $this->url->link('module/blog/schemes', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['url_widgets']      = $this->url->link('module/blog/widgets', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['url_back']         = $this->url->link('module/blog', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['url_back_text']    = $this->language->get('url_back_text');
		$this->data['url_blog']         = $this->url->link('catalog/blog', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['url_convertor']     = $this->url->link('convertor/shopstore', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['url_convert_shopstore'] = $this->url->link('convertor/shopstore/convert_shopstore', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['url_comment']      = $this->url->link('catalog/comment', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['url_record']       = $this->url->link('catalog/record', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['url_blog_text']    = $this->language->get('url_blog_text');
		$this->data['url_sitemap_text'] = $this->language->get('url_sitemap_text');
		$this->data['url_comment_text'] = $this->language->get('url_comment_text');
		$this->data['url_create_text']  = $this->language->get('url_create_text');
		$this->data['url_record_text']  = $this->language->get('url_record_text');

		$this->data['text_loading']  = $this->language->get('text_loading');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {



            $this->config->set("blog_work", false);
            $this->cache->delete('blog');
            $this->data['blog_description'] = $this->blog_description = $this->request->post['blog_description'];
            $this->convert();
			$this->session->data['success'] = $this->language->get('text_success');

			if (SC_VERSION < 20) {
				//$this->redirect($this->url->link('extension/feed', 'token=' . $this->session->data['token'], 'SSL'));
			} else {
				//$this->response->redirect($this->url->link('extension/feed', 'token=' . $this->session->data['token'], 'SSL'));
			}
		}
        if (isset($this->request->post['blog_description'])) {
        	$this->data['blog_description'] = $this->request->post['blog_description'];
        }

		if (isset($this->request->post['ascp_settings_sitemap'])) {
			$this->data['ascp_settings_sitemap'] = $this->request->post['ascp_settings_sitemap'];
		} else {
			$this->data['ascp_settings_sitemap'] = $this->config->get('ascp_settings_sitemap');
		}

		$this->data['heading_title']   = $this->language->get('heading_title');
		$this->data['text_enabled']    = $this->language->get('text_enabled');
		$this->data['text_disabled']   = $this->language->get('text_disabled');
		$this->data['entry_status']    = $this->language->get('entry_status');
		$this->data['entry_language_status']    = $this->language->get('entry_language_status');
		$this->data['entry_file_sitemap']    = $this->language->get('entry_file_sitemap');

		$this->data['button_save']     = $this->language->get('button_save');
		$this->data['button_cancel']   = $this->language->get('button_cancel');
		$this->data['tab_general']     = $this->language->get('tab_general');

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
		$this->data['breadcrumbs']   = array();
		$this->data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => false
		);
		$this->data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('convertor/shopstore', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);
		$this->data['action']        = $this->url->link('convertor/shopstore', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['cancel']        = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');

        $this->cont('agooa/adminmenu');
        $this->data['agoo_menu'] = $this->controller_agooa_adminmenu->index();


		if (!isset($this->data['ascp_settings_sitemap']['google_sitemap_blog_file_sitemap']) || $this->data['ascp_settings_sitemap']['google_sitemap_blog_file_sitemap']=='') {
			$this->data['ascp_settings_sitemap']['google_sitemap_blog_file_sitemap'] = 'sitemap.xml';
		}


		$this->load->model('catalog/blog');
		//$this->data['categories'] = $this->model_catalog_blog->getCategories(0);

        $this->data['categories'] = array();

        $this->load->model('localisation/language');
		$this->data['languages'] = $this->model_localisation_language->getLanguages();
		foreach ($this->data['languages'] as $code => $language) {
			if (!isset($language['image'])) {
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

		if (isset($this->error['name'])) {
			$this->data['error_name'] = $this->error['name'];
		} else {
			$this->data['error_name'] = array();
		}

		$this->template          = 'convertor/shopstore.tpl';
		$this->children          = array(
			'common/header',
			'common/footer'
		);
		$this->data['registry']  = $this->registry;
		$this->data['language']  = $this->language;
		$this->data['config']    = $this->config;
		if (SC_VERSION < 20) {
			$this->data['column_left'] = '';
			$html                      = $this->render();
		} else {
			$this->data['header']      = $this->load->controller('common/header');
			$this->data['footer']      = $this->load->controller('common/footer');
			$this->data['column_left'] = $this->load->controller('common/column_left');
			$html                      = $this->load->view($this->template, $this->data);
		}



		$this->response->setOutput($html);
	}

    private function checkMyBlog() {
		$r = $this->db->query("DESCRIBE " . DB_PREFIX . "blog `index_page`");

		if ($r->num_rows == 0) {
			return false;
		} else {
			return true;
		}
    }


	private function validateForm() {
		$this->config->set("blog_work", true);
		if (!$this->user->hasPermission('modify', 'catalog/blog')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		foreach ($this->request->post['blog_description'] as $language_id => $value) {
			if ((utf8_strlen($value['name']) < 2) || (utf8_strlen($value['name']) > 255)) {
				$this->error['name'][$language_id] = $this->language->get('error_name');
			}
		}

        if ($this->checkMyBlog()) {
        	//$this->error['warning'] = $this->language->get('error_once_convert');
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

	private function convert()
	{

		$all_shopstore = $this->loadAllshopstore();


		foreach ($all_shopstore as $shopstore_id) {

			$shopstore = $this->loadshopstore($shopstore_id);

			if (!$this->checkRecord($shopstore)) {
				$this->addRecord($shopstore);
			}
		}

		$this->deleteTableBlog();
		$this->createTableBlog();
		$blog_id = $this->insertBlog($this->data['blog_description']);
		$this->recordToBlog($blog_id);

	}

	private function recordToBlog($blog_id)
	{
		$this->db->query("UPDATE " . DB_PREFIX . "record SET blog_main = '" . (int) $blog_id . "'
		WHERE blog_main = '99999'");

		$this->db->query("UPDATE " . DB_PREFIX . "record_to_blog SET blog_id = '" . (int) $blog_id . "'
		WHERE blog_id = '99999'");
	}


	private function insertBlog($blog_description) {
	    $this->load->model('catalog/blog');

	    $data['parent_id'] = 0;
	    $data['sort_order'] = 0;
	    $data['index_page'] = array('index' ,'follow');
	    $data['status'] = 1;
	    $data['blog_design'] = array('block_records_width' => '24%', 'records_more' => '1', 'title_position' => 'after');

	    foreach ($blog_description as $language_id => $value) {
	          $data['blog_description'][$language_id]['name'] = $blog_description[$language_id]['name'];
		      $data['blog_description'][$language_id]['meta_title'] = '';
		      $data['blog_description'][$language_id]['meta_h1'] = '';
		      $data['blog_description'][$language_id]['meta_keyword'] = '';
		      $data['blog_description'][$language_id]['meta_description'] = '';
		      $data['blog_description'][$language_id]['description'] = '';
		      if ($language_id == $this->config->get('config_language_id')) {
		      	$data['keyword'][$language_id] = 'blog-news';
		      } else {
		      	$data['keyword'][$language_id] = '';
		      }
	    }

		if (file_exists(DIR_APPLICATION.'model/sale/customer_group.php')) {
        	$this->load->model('sale/customer_group');
			$model_customer = 'model_sale_customer_group';
		} else {
			$this->load->model('customer/customer_group');
			$model_customer = 'model_customer_customer_group';
		}
		$this->data['customer_groups'] = $this->$model_customer->getCustomerGroups();

	    array_push($this->data['customer_groups'], array( 'customer_group_id' => -1 ));
	    array_push($this->data['customer_groups'], array( 'customer_group_id' => -2 ));
	    array_push($this->data['customer_groups'], array( 'customer_group_id' => -3 ));

		foreach ($this->data['customer_groups'] as $number =>  $c_g) {
			$data['customer_groups_blog'][$number] = $c_g['customer_group_id'];
	    }

   		$this->load->model('setting/store');
		$stores = $this->model_setting_store->getStores();
        $stores = array('0' => array('store_id' => '0'));
        foreach ($stores as $store) {
        	$data['blog_store'][$store['store_id']] = $store['store_id'];
        }

      	$blog_id = $this->model_catalog_blog->addBlog($data);

	  	return $blog_id;

	}




	private function deleteTableBlog() {
   		$query = $this->db->query("DROP TABLE " . DB_PREFIX . "blog");
   		$query = $this->db->query("DROP TABLE " . DB_PREFIX . "blog_description");
   		$query = $this->db->query("DROP TABLE " . DB_PREFIX . "blog_product");
   		$query = $this->db->query("DROP TABLE " . DB_PREFIX . "blog_to_layout");
   		$query = $this->db->query("DROP TABLE " . DB_PREFIX . "blog_to_store");
	}

	private function createTableBlog()
	{
        $agoo_widget = 'latest';
        if (file_exists(DIR_APPLICATION . "controller/agoo/".$agoo_widget."/".$agoo_widget.".php")) {
	    		$this->control('agoo/'.$agoo_widget.'/'.$agoo_widget);
	    		$controller_agoo = 'controller_agoo_'.$agoo_widget.'_'.$agoo_widget;

	         	if (method_exists($this->registry->get($controller_agoo), 'createTables'))
	         	$this->$controller_agoo->createTables($this->data);
        }
	}

	public function control($cont)
	{
		$file = DIR_APPLICATION . 'controller/' . $cont . '.php';
		$class = 'Controller' . preg_replace('/[^a-zA-Z0-9]/', '', $cont);
            if (function_exists('modification')) {
        		$file = modification($file);
        	}
		if (file_exists($file)) {
			include_once($file);
			$this->registry->set('controller_' . str_replace('/', '_', $cont), new $class($this->registry));
		} else {
			trigger_error('Error: Could not load controller ' . $cont . '!');
			exit();
		}
	}

	private function loadAllshopstore()
	{
         $all_shopstore = array();
         $query = $this->db->query("SELECT blog_id FROM " . DB_PREFIX . "blog");
         foreach ($query->rows as $num => $shopstore) {
         	$all_shopstore[$shopstore['blog_id']] = $shopstore['blog_id'];
         }

		return $all_shopstore;

	}

	private function loadshopstore($shopstore_id)
	{

		if (file_exists(DIR_APPLICATION.'model/sale/customer_group.php')) {
        	$this->load->model('sale/customer_group');
			$model_customer = 'model_sale_customer_group';
		} else {
			$this->load->model('customer/customer_group');
			$model_customer = 'model_customer_customer_group';
		}
		$this->data['customer_groups'] = $this->$model_customer->getCustomerGroups();

	    array_push($this->data['customer_groups'], array( 'customer_group_id' => -1 ));
	    array_push($this->data['customer_groups'], array( 'customer_group_id' => -2 ));
	    array_push($this->data['customer_groups'], array( 'customer_group_id' => -3 ));


      $query = $this->db->query("SELECT *,
      (SELECT keyword FROM " . DB_PREFIX . "url_alias WHERE query = 'blog_id=" . (int)$shopstore_id . "') AS keyword
      FROM " . DB_PREFIX . "blog n
      LEFT JOIN " . DB_PREFIX . "blog_description nd ON (n.blog_id = nd.blog_id)
      WHERE
      n.blog_id = '".$shopstore_id."'
      ");


      foreach ($query->rows as $num => $shopstore) {

	      	if	(!isset($shopstore['title'])) {
	      		return false;
	      	}

	        $my_shopstore['record_description'] [$shopstore['language_id']]['name'] = $shopstore['title'];
	        $my_shopstore['record_description'] [$shopstore['language_id']]['meta_description'] = $shopstore['meta_description'];
	        $my_shopstore['record_description'] [$shopstore['language_id']]['meta_keyword'] = $shopstore['meta_keyword'];
	        $my_shopstore['record_description'] [$shopstore['language_id']]['description'] = $shopstore['description'];

	        if ($shopstore['language_id'] == $this->config->get('config_language_id')) {
	         	$my_shopstore['keyword'][$shopstore['language_id']] = $shopstore['keyword'];
	        } else {
	        	$my_shopstore['keyword'][$shopstore['language_id']] = '';
	        }


            $my_shopstore['image'] = $shopstore['image'];
            $my_shopstore['status']= $shopstore['status'];
            $my_shopstore['date_available'] = $shopstore['date_available'];
            $my_shopstore['date_added'] = $shopstore['date_added'].'  00:00:00';
            $my_shopstore['date_end'] = '2030-11-11  00:00:00';
            $my_shopstore['index_page'] = Array(0 => 'index', 1 => 'follow');
			$my_shopstore['viewed'] = 0;
            $my_shopstore['author'] = '';
			$my_shopstore['customer_id'] = 0;
			$my_shopstore['sort_order'] = $shopstore['sort_order'];
			$my_shopstore['comment'] = Array(
								            'status' => 0,
								            'status_reg' => 0,
								            'status_now' => 1,
								            'rating' => 1,
								            'signer' => 1,
								            'order' => 'sort',
								            'order_ad' => 'desc',
								            'rating_num' => ''
								        );

			$my_shopstore['blog_main'] = 99999;
   			$my_shopstore['record_blog'] = Array(
										      1 => 99999
                                            );

			foreach ($this->data['customer_groups'] as $number =>  $c_g) {
				$my_shopstore['customer_groups_record'][$number] = $c_g['customer_group_id'];
	        }

      }


	 $this->data['shopstore_product'] = $this->getSSproduct($shopstore_id);
	 $this->data['shopstore_layout'] = $this->getSSlayout($shopstore_id);
	 $this->data['shopstore_store'] = $this->getSSstore($shopstore_id);

	 foreach ($this->data['shopstore_product'] as $number =>  $n_s) {
		$my_shopstore['product_related'][$number] = $n_s['product_id'];
     }

	 foreach ($this->data['shopstore_layout'] as $number =>  $n_s) {
		$my_shopstore['record_layout'][$n_s['store_id']] = $n_s['layout_id'];
     }

	 foreach ($this->data['shopstore_store'] as $number =>  $n_s) {
		$my_shopstore['record_store'][$number] = $n_s['store_id'];
     }
     $my_shopstore['record_tag'] = array();
     $my_shopstore['shopstore_id'] =  (int)$shopstore_id;

	  return $my_shopstore;
	}

	private function getSSproduct($shopstore_id)
	{
      $query = $this->db->query("SELECT *
      FROM " . DB_PREFIX . "blog_product bp
      WHERE
      bp.blog_id = '".$shopstore_id."'
      ");

      return $query->rows;

	}

	private function getSSlayout($shopstore_id)
	{
      $query = $this->db->query("SELECT *
      FROM " . DB_PREFIX . "blog_to_layout bp
      WHERE
      bp.blog_id = '".$shopstore_id."'
      ");

      return $query->rows;

	}

	private function getSSstore($shopstore_id)
	{
      $query = $this->db->query("SELECT *
      FROM " . DB_PREFIX . "blog_to_store bp
      WHERE
      bp.blog_id = '".$shopstore_id."'
      ");

      return $query->rows;
	}

	private function checkRecord($shopstore)
	{
        $flag = false;

        if (!isset($shopstore['record_description'])) {
        	return true;
        }
		foreach ($shopstore['record_description'] as $language_id => $optional) {

			$sql= "
			SELECT DISTINCT * FROM " . DB_PREFIX . "record p
			LEFT JOIN " . DB_PREFIX . "record_description pd ON (p.record_id = pd.record_id)
			WHERE
			LCASE(pd.name) LIKE '" . $this->db->escape(utf8_strtolower($optional['name'])) . "'
			AND
			pd.language_id = '" . (int)$language_id . "'";


			$query = $this->db->query($sql);

			if ($query->row) {

				$flag = true;
				return $flag;
			}

	    }

		return $flag;
	}

	private function addRecord($shopstore)
	{
      $this->load->model('catalog/record');
      $this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'blog_id=" . (int)$shopstore['shopstore_id'] . "'");
      $record_id =  $this->model_catalog_record->addRecord($shopstore);
	  return $record_id;
	}

	private function validate()
	{
		if (!$this->user->hasPermission('modify', 'module/blog')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

	public function convert_shopstore() {

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate() && $this->request->post['category_shopstore_id']!='') {
            $html = '';
	     	$category_shopstore_id = $this->request->post['category_shopstore_id'];

			if ($category_shopstore_id) {



			} else {
       	    	$html = $this->language->get('error_create_file');
			}

	    } else {
	    	$html = $this->language->get('error_permission');
	    }

   	    $this->response->setOutput($html);

	}

/***************************************/
	public function cont($cont)
	{
		$file  = DIR_CATALOG . 'controller/' . $cont . '.php';
		if (file_exists($file)) {
     		$this->cont_loading($cont, $file);
     		return true;
		} else {
			$file  = DIR_APPLICATION . 'controller/' . $cont . '.php';
            if (file_exists($file)) {
             	$this->cont_loading($cont, $file);
             	return true;
            } else {
				trigger_error('Error: Could not load controller ' . $cont . '!');
            	return false;
			}
		}
	}
	private function cont_loading ($cont, $file)
	{
			$class = 'Controller' . preg_replace('/[^a-zA-Z0-9]/', '', $cont);
			include_once($file);
			$this->registry->set('controller_' . str_replace('/', '_', $cont), new $class($this->registry));
	}
/***************************************/

}
require_once(DIR_SYSTEM . 'helper/seocmsprofunc.php');