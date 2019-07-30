<?php
/* All rights reserved belong to the module, the module developers https://opencartadmin.com */
// https://opencartadmin.com © 2011-2019 All Rights Reserved
// Distribution, without the author's consent is prohibited
// Commercial license
class ControllerRecordRecord extends Controller
{
	private $error = array();
	private $code;
	protected $data;
	protected $url_link_ssl = false;

	public function __construct($registry) {
		parent::__construct($registry);
		if (version_compare(phpversion(), '5.3.0', '<') == true) {
			exit('PHP5.3+ Required');
		}

		$this->seocmslib->cont('record/addrewrite');
		$this->controller_record_addrewrite->add_construct($this->registry);

		if (SC_VERSION > 15) {
			$get_Customer_GroupId = 'getGroupId';
		} else {

			$get_Customer_GroupId = 'getCustomerGroupId';
		}
		if ($this->customer->isLogged()) {
			$this->customer_group_id = $this->customer->$get_Customer_GroupId();
			$this->customer_id = $this->customer->getId();
		} else {
			$this->customer_group_id = $this->config->get('config_customer_group_id');
			$this->customer_id = false;
		}

		if (!$this->config->get('ascp_customer_group_id')) {
			$this->data['settings_general'] = $this->config->get('ascp_settings');
		} else {
			$this->data['settings_general'] = Array();
		}
		if ($this->config->get('ascp_settings') != '') {
			$this->data['settings_general'] = $this->config->get('ascp_settings');
		} else {
			$this->data['settings_general'] = Array();
		}

		if ((isset($this->data['settings_general']['seocms_url_secure']) && $this->data['settings_general']['seocms_url_secure'] == 'https' && $this->data['settings_general']['seocms_url_secure'] != 'http') || ((isset($_SERVER['HTTPS']) && (strtolower($_SERVER['HTTPS']) == 'on' || $_SERVER['HTTPS'] == '1')) || (!empty($_SERVER['HTTP_X_FORWARDED_PROTO']) && (strtolower($_SERVER['HTTP_X_FORWARDED_PROTO']) == 'https') || (!empty($_SERVER['HTTP_X_FORWARDED_SSL']) && strtolower($_SERVER['HTTP_X_FORWARDED_SSL']) == 'on')))) {
			$this->url_link_ssl = true;
		} else {
			if (SC_VERSION < 20) {
				$this->url_link_ssl = 'NONSSL';
			} else {
				$this->url_link_ssl = false;
			}
		}

		if (!$this->config->get('ascp_customer_groups')) {
			$this->seocmslib->cont('record/customer');
			$this->data = $this->controller_record_customer->customer_groups($this->data);
			$this->config->set('ascp_customer_groups', $this->data['customer_groups']);
		} else {
			$this->data['customer_groups'] = $this->config->get('ascp_customer_groups');
		}
		if (!$this->config->get('config_image_thumb_width')) {
			$this->config->set('config_image_thumb_width', '100');
		}
		if (!$this->config->get('config_image_thumb_height')) {
			$this->config->set('config_image_thumb_height', '200');
		}
	}

	public function index() {
		$this->config->set('blog_work', true);

		$this->load->model('record/blog');
		$this->load->model('record/path');
        $this->load->model('record/record');

		$this->language->load('seocms/record');
		$this->language->load('seocms/blog');

        $this->seocmslib->cont('module/blog');
		require_once(DIR_SYSTEM . 'helper/utf8blog.php');

		if (file_exists(DIR_APPLICATION . 'view/javascript/jquery/tabs.js')) {
			$this->document->addScript('catalog/view/javascript/jquery/tabs.js');
		} else {
			if (file_exists(DIR_APPLICATION . 'view/javascript/blog/tabs/tabs.js')) {
				$this->document->addScript('catalog/view/javascript/blog/tabs/tabs.js');
			}
		}

		if (isset($this->data['settings_general']['reviews_widget_status']) && $this->data['settings_general']['reviews_widget_status']) {
			$this->document->addScript('catalog/view/javascript/blog/blog.comment.js');
		}

		if ((isset($this->request->get['sc_ajax']) && $this->request->get['sc_ajax'] == 2) || (isset($this->request->post['sc_ajax']) && $this->request->post['sc_ajax'] == 2)) {
			$this->data['ajax'] = true;
		} else {
			$this->data['ajax'] = false;
		}

		$this->data['breadcrumbs'] = array();
		$this->data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home', '', $this->url_link_ssl),
			'separator' => false
		);
		if ($this->config->get('ascp_settings') != '') {
			$this->data['settings_general'] = $this->config->get('ascp_settings');
		} else {
			$this->data['settings_general'] = Array();
		}
		if (!isset($this->data['settings_general']['colorbox_theme'])) {
			$this->data['settings_general']['colorbox_theme'] = 0;
		}

		$this->data = $this->controller_module_blog->ColorboxLoader($this->data['settings_general']['colorbox_theme'], $this->data);
		$http_image = getHttpImage($this);

		if (isset($this->request->get['record_id'])) {
			$record_id = $this->request->get['record_id'];
			$blog_path = $this->model_record_path->pathbyrecord($record_id);
			$this->request->get['blog_id'] = $blog_path['path'];
		} else {
			$record_id = false;
		}

		if (isset($blog_path['path'])) {
			$path = '';
			$path_array = explode('_', $blog_path['path']);
			$blog_id = end($path_array);
		} else {
			$blog_id = 0;
		}

		if (isset($this->request->get['blog_id'])) {
			$path = '';
			$path_array = explode('_', $this->request->get['blog_id']);
			foreach ($path_array as $path_id) {
				if (!$path) {
					$path = $path_id;
				} else {
					$path .= '_' . $path_id;
				}

				$blog_info = $this->model_record_blog->getBlog($path_id);

				if ($blog_info) {

					if (isset($blog_info['design']) && $blog_info['design'] != '') {
						$this->data['blog_design'] = unserialize($blog_info['design']);
					} else {
						$this->data['blog_design'] = Array();
					}

					if (isset($this->data['blog_design']['blog_short_path_category']) && $this->data['blog_design']['blog_short_path_category'] == 1) {
						unset($this->data['breadcrumbs']);
						$this->data['breadcrumbs'][] = array(
							'text' => $this->language->get('text_home'),
							'href' => $this->url->link('common/home', '', $this->url_link_ssl),
							'separator' => false
						);
					}

					if (isset($blog_info['name']) && $blog_info['name'] != '') {
						$this->data['breadcrumbs'][] = array(
							'text' => $blog_info['name'],
							'href' => $this->url->link('record/blog', 'blog_id=' . $path, $this->url_link_ssl),
							'separator' => $this->language->get('text_separator')
						);
					}
				}
			}
		} else {
			$path = '';
		}

		$blog_info = $this->model_record_blog->getBlog($blog_id, false);
		if (isset($blog_info['design']) && $blog_info['design'] != '') {
			$this->data['blog_design'] = unserialize($blog_info['design']);
		} else {
			$this->data['blog_design'] = Array();
		}

		$sort_data = array(
			'rating',
			'comments',
			'popular',
			'latest',
			'sort'
		);

		$sort = 'p.sort_order';
		if (isset($this->data['blog_design']['order']) && in_array($this->data['blog_design']['order'], $sort_data)) {
			if ($this->data['blog_design']['order'] == 'rating') {
				$sort = 'rating';
			}
			if ($this->data['blog_design']['order'] == 'comments') {
				$sort = 'comments';
			}
			if ($this->data['blog_design']['order'] == 'latest') {
				$sort = 'p.date_available';
			}
			if ($this->data['blog_design']['order'] == 'sort') {
				$sort = 'p.sort_order';
			}
			if ($this->data['blog_design']['order'] == 'popular') {
				$sort = 'p.viewed';
			}
		}
		$order = 'DESC';
		if (isset($this->data['blog_design']['order_ad'])) {
			if (strtoupper($this->data['blog_design']['order_ad']) == 'ASC') {
				$order = 'ASC';
			}
			if (strtoupper($this->data['blog_design']['order']) == 'DESC') {
				$order = 'DESC';
			}
		}

		$data = array(
			'filter_blog_id' => $blog_id,
			'sort' => $sort,
			'order' => $order
		);

		if (!isset($this->data['blog_design']['next_status']) || (isset($this->data['blog_design']['next_status']) && $this->data['blog_design']['next_status'])) {
			$result_prevnext_records = $this->model_record_record->getRecords($data);
			if ($result_prevnext_records) {
				$previousKey = false;
				$nextKey = false;
				$next_flag = false;
				$this->data['record_previous']['url'] = '';
				$this->data['record_previous']['name'] = '';
				$this->data['record_next']['url'] = '';
				$this->data['record_next']['name'] = '';
				if (!empty($result_prevnext_records)) {
					foreach ($result_prevnext_records as $num => $rec) {
						if ($next_flag) {
							$this->data['record_next']['url'] = $this->url->link('record/record', '&record_id=' . $result_prevnext_records[$num]['record_id'], $this->url_link_ssl);
							$this->data['record_next']['name'] = $result_prevnext_records[$num]['name'];
							$next_flag = false;
						}
						if ($rec['record_id'] == $record_id) {
							$next_flag = true;
							if ($previousKey) {
								if (isset($result_prevnext_records[$previousKey])) {
									$this->data['record_previous']['url'] = $this->url->link('record/record', '&record_id=' . $result_prevnext_records[$previousKey]['record_id'], $this->url_link_ssl);
									$this->data['record_previous']['name'] = $result_prevnext_records[$previousKey]['name'];
								}
							}
						}
						$previousKey = $num;
					}
				}
			}
		}
		if (isset($this->request->get['filter_name']) || isset($this->request->get['filter_tag'])) {
			$url = '';
			if (isset($this->request->get['filter_name'])) {
				$url .= '&filter_name=' . $this->request->get['filter_name'];
			}
			if (isset($this->request->get['filter_tag'])) {
				$url .= '&filter_tag=' . $this->request->get['filter_tag'];
			}
			if (isset($this->request->get['filter_description'])) {
				$url .= '&filter_description=' . $this->request->get['filter_description'];
			}
			if (isset($this->request->get['filter_blog_id'])) {
				$url .= '&filter_blog_id=' . $this->request->get['filter_blog_id'];
			}
			$this->data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_search'),
				'href' => $this->url->link('record/blog', $url, $this->url_link_ssl),
				'separator' => $this->language->get('text_separator')
			);
		}

		// check seo
		if (isset($this->request->get['record_id']) && $this->request->get['record_id'] == (int) $this->request->get['record_id']) {
			$record_id = (int) $this->request->get['record_id'];
		} else {
			$record_id = false;
			return 'False get parameter record_id=';
		}

		$this->load->model('record/record');
		$record_info = $this->model_record_record->getRecord($record_id);

		if ($record_info) {
			$url = '';
			if (isset($this->request->get['blog_id'])) {
				$url .= '&blog_id=' . $this->request->get['blog_id'];
			}
			if (isset($this->request->get['filter_name'])) {
				$url .= '&filter_name=' . $this->request->get['filter_name'];
			}
			if (isset($this->request->get['filter_tag'])) {
				$url .= '&filter_tag=' . $this->request->get['filter_tag'];
			}
			if (isset($this->request->get['filter_description'])) {
				$url .= '&filter_description=' . $this->request->get['filter_description'];
			}
			if (isset($this->request->get['filter_blog_id'])) {
				$url .= '&filter_blog_id=' . $this->request->get['filter_blog_id'];
			}
			$this->data['breadcrumbs'][] = array(
				'text' => $record_info['name'],
				'href' => $this->url->link('record/record', '&record_id=' . $this->request->get['record_id'], $this->url_link_ssl),
				'separator' => $this->language->get('text_separator')
			);
			$this->data['text_welcome'] = sprintf($this->language->get('text_welcome'), $this->url->link('account/login', '', $this->url_link_ssl), $this->url->link('account/register', '', $this->url_link_ssl));
			$this->data['text_select'] = $this->language->get('text_select');
			$this->data['text_or'] = $this->language->get('text_or');
			$this->data['text_write'] = $this->language->get('text_write');
			$this->data['text_note'] = $this->language->get('text_note');
			$this->data['text_share'] = $this->language->get('text_share');
			$this->data['text_wait'] = $this->language->get('text_wait');
			$this->data['text_tags'] = $this->language->get('text_tags');
			$this->data['text_viewed'] = $this->language->get('text_viewed');
			$this->data['entry_name'] = $this->language->get('entry_name');
			$this->data['entry_comment'] = $this->language->get('entry_comment');
			$this->data['entry_rating'] = $this->language->get('entry_rating');
			$this->data['entry_good'] = $this->language->get('entry_good');
			$this->data['entry_bad'] = $this->language->get('entry_bad');
			$this->data['entry_captcha'] = $this->language->get('entry_captcha');
			$this->data['entry_captcha_title'] = $this->language->get('entry_captcha_title');
			$this->data['entry_captcha_update'] = $this->language->get('entry_captcha_update');
			$this->data['button_cart'] = $this->language->get('button_cart');
			$this->data['button_wishlist'] = $this->language->get('button_wishlist');
			$this->data['button_compare'] = $this->language->get('button_compare');
			$this->data['button_upload'] = $this->language->get('button_upload');
			$this->data['button_write'] = $this->language->get('button_write');
			$this->data['tab_description'] = $this->language->get('tab_description');
			$this->data['tab_attribute'] = $this->language->get('tab_attribute');
			$this->data['tab_advertising'] = $this->language->get('tab_advertising');
			$this->data['tab_comment'] = $this->language->get('tab_comment');
			$this->data['tab_images'] = $this->language->get('tab_images');
			$this->data['tab_related'] = $this->language->get('tab_related');
			$this->data['tab_product_related'] = $this->language->get('tab_product_related');
			$this->data['text_author'] = $this->language->get('text_author');
			$this->data['text_comments'] = $this->language->get('text_comments');
			$this->data['record_id'] = $this->request->get['record_id'];

			if (isset($this->data['settings_general']['reviews_widget_status']) && $this->data['settings_general']['reviews_widget_status']) {
				$this->load->model('record/comment');
				$this->data['comment_count'] = $this->model_record_comment->getTotalCommentsByRecordId($this->request->get['record_id']);
			}
			$this->load->model('tool/image');
			if ($record_info['image']) {
				$this->data['popup'] = $http_image . $record_info['image'];
			} else {
				$this->data['popup'] = '';
			}
			if ($record_info['image']) {
				if (isset($this->data['blog_design']['image_adaptive_resize']) && $this->data['blog_design']['image_adaptive_resize']) {
					$image_adaptive_resize = $this->data['blog_design']['image_adaptive_resize'];
				} else {
					$image_adaptive_resize = false;
				}
				if (isset($this->data['blog_design']['thumb_image']['width']) && $this->data['blog_design']['thumb_image']['width'] != '') {
					$width = $this->data['blog_design']['thumb_image']['width'];
				} else {
					if ($this->config->get('config_image_thumb_width') != '') {
						$width = $this->config->get('config_image_thumb_width');
					} else {
						$width = 100;
					}
				}
				if (isset($this->data['blog_design']['thumb_image']['height']) && $this->data['blog_design']['thumb_image']['height'] != '') {
					$height = $this->data['blog_design']['thumb_image']['height'];
				} else {
					if ($this->config->get('config_image_thumb_height') != '') {
						$height = $this->config->get('config_image_thumb_height');
					} else {
						$height = 200;
					}
				}
				$this->data['thumb'] = $this->seocmslib->resizeme($record_info['image'], $width, $height, $image_adaptive_resize);
				$this->data['thumb_dim']['width'] = $width;
				$this->data['thumb_dim']['height'] = $height;
			} else {
				$this->data['thumb'] = '';
				$this->data['thumb_dim']['width'] = '';
				$this->data['thumb_dim']['height'] = '';
			}
			$this->data['href'] = $this->url->link('record/record', 'record_id=' . $this->request->get['record_id'], $this->url_link_ssl);

			if (isset($this->data['settings_general']['blog_search']) && $this->data['settings_general']['blog_search']) {
				$this->data['blog_search']['href'] = $this->data['settings_general']['blog_search'];
			} else {
				$this->data['blog_search']['href'] = false;
			}

			if ($this->data['thumb']) {
				$this->document->addLink($this->data['thumb'], 'image_src');
			}

			$this->data['images'] = array();
			if (!isset($this->data['blog_design']['images']))
				$this->data['blog_design']['images'] = array();
			if (!isset($this->data['blog_design']['product_image']))
				$this->data['blog_design']['product_image'] = $this->data['blog_design']['images'];
			if (!isset($this->data['blog_design']['gallery_image']))
				$this->data['blog_design']['gallery_image'] = $this->data['blog_design']['product_image'];
			$this->data['images'] = $this->getRecordImages($this->request->get['record_id'], $this->data['blog_design']);
			if (isset($this->data['settings_general']['box_share']) && $this->data['settings_general']['box_share'] != '') {
				$this->data['box_share'] = html_entity_decode($this->data['settings_general']['box_share']);
			} else {
				$this->data['box_share'] = '';
			}
			$this->data['options'] = array();

			if (isset($this->data['settings_general']['reviews_widget_status']) && $this->data['settings_general']['reviews_widget_status']) {

				$this->data['text_comments'] = sprintf($this->language->get('text_comments'), (int) $record_info['comments']);
				$this->data['comments'] = (int) $record_info['comments'];
				$record_comment = @unserialize($record_info['comment']);
				$this->data['record_comment'] = $record_comment;
				if (!isset($record_comment['status'])) {
					$record_comment['status'] = false;
				}
				$this->data['comment_status'] = $record_comment['status'];

				if ($this->customer->isLogged()) {
					$this->data['text_login'] = $this->customer->getFirstName() . " " . $this->customer->getLastName();
					$this->data['captcha_status'] = false;
					$this->data['customer_id'] = $this->customer->getId();
				} else {
					$this->data['text_login'] = $this->language->get('text_anonymus');
					$this->data['captcha_status'] = true;
					$this->data['customer_id'] = false;
					$this->data['signer_code'] = 'customer_id';
					$this->language->load('account/login');
					$this->data['text_new_customer'] = $this->language->get('text_new_customer');
					$this->data['text_register'] = $this->language->get('text_register');
					$this->data['text_register_account'] = $this->language->get('text_register_account');
					$this->data['text_returning_customer'] = $this->language->get('text_returning_customer');
					$this->data['text_i_am_returning_customer'] = $this->language->get('text_i_am_returning_customer');
					$this->data['text_forgotten'] = $this->language->get('text_forgotten');
					$this->data['entry_email'] = $this->language->get('entry_email');
					$this->data['entry_password'] = $this->language->get('entry_password');
					$this->data['button_continue'] = $this->language->get('button_continue');
					$this->data['button_login'] = $this->language->get('button_login');
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
					if (isset($this->request->post['email'])) {
						$this->data['email'] = $this->request->post['email'];
					} else {
						$this->data['email'] = '';
					}
					if (isset($this->request->post['password'])) {
						$this->data['password'] = $this->request->post['password'];
					} else {
						$this->data['password'] = '';
					}
					$this->data['action'] = $this->url->link('account/login', '', $this->url_link_ssl);
					$this->data['register'] = $this->url->link('account/register', '', $this->url_link_ssl);
					$this->data['forgotten'] = $this->url->link('account/forgotten', '', $this->url_link_ssl);
					if (isset($this->request->post['redirect']) && (strpos($this->request->post['redirect'], $this->config->get('config_url')) !== false || strpos($this->request->post['redirect'], $this->config->get('config_ssl')) !== false)) {
						$this->data['redirect'] = $this->request->post['redirect'];
					} elseif (isset($this->session->data['redirect'])) {
						$this->data['redirect'] = $this->session->data['redirect'];
						unset($this->session->data['redirect']);
					} else {
						$this->data['redirect'] = $this->data['href'];
					}
				}
				$this->language->load('seocms/signer');
				$this->data['pointer'] = 'record_id';
				$this->load->model('agoo/signer/signer');
				if (isset($_COOKIE['email_subscribe_record_id']) && isset($this->data['pointer'])) {
					$email_subscribe = unserialize(base64_decode($_COOKIE['email_subscribe_' . $this->data['pointer']]));
					if (isset($email_subscribe[$this->data['record_id']])) {
						$email_subscribe = $email_subscribe[$this->data['record_id']];
					} else {
						$email_subscribe = '';
					}
				} else {
					$email_subscribe = false;
				}
				$this->data['signer_status'] = $this->model_agoo_signer_signer->getStatus($this->request->get['record_id'], $this->data['customer_id'], 'record_id', $email_subscribe);

			} else {
				$this->data['comment_status'] = false;
			}

			$this->data['viewed'] = $record_info['viewed'];
			$this->data['date_created'] = $record_info['date_added'];
			$this->data['date_modified'] = $record_info['date_modified'];

			if (!isset($record_info['date_available'])) {
				$this->data['date'] = $this->data['date_available'] = $record_info['date_available'] = $record_info['date_added'];
			} else {
				$this->data['date'] = $this->data['date_available'] = $record_info['date_available'];
			}
			$this->data['author'] = $record_info['author'];
			$this->data['author_search_link'] = $this->url->link('record/blog', 'blog_id=' . $this->data['blog_search']['href'] . '&filter_author=' . $this->data['author'], $this->url_link_ssl);
			$this->data['author_customer_id'] = $record_info['customer_id'];
			if (isset($this->data['settings_general']['format_date'])) {
			} else {
				$this->data['settings_general']['format_date'] = $this->language->get('text_date');
			}
			if (isset($this->data['settings_general']['format_hours'])) {
			} else {
				$this->data['settings_general']['format_hours'] = $this->language->get('text_hours');
			}
			if (isset($this->data['settings_general']['format_time']) && $this->data['settings_general']['format_time'] && date($this->data['settings_general']['format_date']) == date($this->data['settings_general']['format_date'], strtotime($record_info['date_available']))) {
				$date_str = $this->language->get('text_today');
			} else {
				$date_str = agoodate($this, $this->data['settings_general']['format_date'], strtotime($record_info['date_available']));
			}
			$date_available = $date_str . (agoodate($this, $this->data['settings_general']['format_hours'], strtotime($record_info['date_available'])));
			if (!isset($this->data['blog_design']['view_date'])) {
				$this->data['blog_design']['view_date'] = 1;
			}
			if (!isset($this->data['blog_design']['view_share'])) {
				$this->data['blog_design']['view_share'] = 1;
			}
			if (!isset($this->data['blog_design']['view_viewed'])) {
				$this->data['blog_design']['view_viewed'] = 1;
			}

			if (isset($this->data['settings_general']['reviews_widget_status']) && $this->data['settings_general']['reviews_widget_status']) {

				if (!isset($this->data['blog_design']['view_rating'])) {
					$this->data['blog_design']['view_rating'] = 1;
				}
				if (!isset($this->data['blog_design']['view_comments'])) {
					$this->data['blog_design']['view_comments'] = 1;
				}
				if (isset($this->data['blog_design']['view_captcha']) && !$this->data['blog_design']['view_captcha']) {
					$this->data['captcha_status'] = false;
				}
				$this->data['rating'] = (int) $record_info['rating'];
			}

			$date_added = $date_available;
			$this->data['date_added'] = $date_added;

			$this->data['description'] = html_entity_decode($record_info['description'], ENT_QUOTES, 'UTF-8');

			if (isset($record_info['sdescription'])) {
				$this->data['sdescription'] = html_entity_decode($record_info['sdescription'], ENT_QUOTES, 'UTF-8');
			} else {
				$this->data['sdescription'] = '';
			}

			$this->data['attribute_groups'] = $this->model_record_record->getRecordAttributes($this->request->get['record_id']);
			$this->data['products'] = array();

			$this->load->model('catalog/product');
			$this->language->load('product/product');

			$this->data['text_related'] = $this->language->get('text_related');
			$this->data['text_tax'] = $this->language->get('text_tax');

			$results = $this->model_record_record->getProductRelated($this->request->get['record_id'], 'product_id');


			if (isset($this->data['blog_design']['image_product_adaptive_resize']) && $this->data['blog_design']['image_product_adaptive_resize']) {
				$image_product_adaptive_resize = $this->data['blog_design']['image_product_adaptive_resize'];
			} else {
				$image_product_adaptive_resize = false;
			}

			if (isset($this->data['blog_design']['product_image']['width']) && $this->data['blog_design']['product_image']['width'] != '') {
				$width = $this->data['blog_design']['product_image']['width'];
			} else {
				if (!$this->config->get('config_image_related_width') || $this->config->get('config_image_related_width') == '') {
					if (SC_VERSION > 22) {
						$this->config->set('config_image_related_width', $this->config->get($this->config->get('config_theme') . '_image_related_width'));
					} else {
						$this->config->set('config_image_related_width', '200');
					}
				}
				$this->data['blog_design']['product_image']['width'] = $width = $this->config->get('config_image_related_width');
			}

			if (isset($this->data['blog_design']['product_image']['height']) && $this->data['blog_design']['product_image']['height'] != '') {
				$height = $this->data['blog_design']['product_image']['height'];
			} else {
				if (!$this->config->get('config_image_related_height') || $this->config->get('config_image_related_height') == '') {
					if (SC_VERSION > 22) {
						$this->config->set('config_image_related_height', $this->config->get($this->config->get('config_theme') . '_image_related_height'));
					} else {
						$this->config->set('config_image_related_height', '300');
					}
				}
				$this->data['blog_design']['product_image']['height'] = $height = $this->config->get('config_image_related_height');
			}

			if (SC_VERSION > 14 && count($results) > 0 && isset($this->data['settings_general']['related_theme']) && $this->data['settings_general']['related_theme']) {

				if (isset($this->data['settings_general']['related_owl_status']) && $this->data['settings_general']['related_owl_status']) {
					$this->document->addStyle('catalog/view/javascript/jquery/owl-carousel/owl.carousel.css');
					$this->document->addStyle('catalog/view/javascript/jquery/owl-carousel/owl.transitions.css');
					$this->document->addScript('catalog/view/javascript/jquery/owl-carousel/owl.carousel.min.js');
				}


				foreach ($results as $result) {
					$products_related_setting['product'][] = $this->data['products'][] = $result['product_id'];
				}

				if ($image_product_adaptive_resize) {
					$settings_general_blog_resize = $this->data['settings_general']['blog_resize'];
					$this->data['settings_general']['blog_resize'] = true;
					$this->config->set('ascp_settings', $this->data['settings_general']);
				}

				$products_related_setting['position'] = '';
				$products_related_setting['limit'] = 999;
				$products_related_setting['width'] = $width;
				$products_related_setting['height'] = $height;

				if (SC_VERSION < 23) {
					$str_controller_featured = 'controller_module_featured';
					$str_controller_featured_path = 'module/featured';
				} else {
					$str_controller_featured = 'controller_extension_module_featured';
					$str_controller_featured_path = 'extension/module/featured';
				}

				$this->seocmslib->cont($str_controller_featured_path);

				if (isset($this->data['settings_general']['related_theme_title'][$this->config->get('config_language_id')])) {
					$this->load->setreplacedata(array(
						$str_controller_featured_path . '.tpl' => array(
							'heading_title' => $this->data['settings_general']['related_theme_title'][$this->config->get('config_language_id')]
						)
					));
				}

				if (SC_VERSION < 23) {
					$str_controller_featured = 'controller_module_featured';
				} else {
					$str_controller_featured = 'controller_extension_module_featured';
				}

                if (SC_VERSION < 20) {
                    $products_related_setting['product'] = implode(',',$products_related_setting['product']);
                    $products_related_setting['image_width'] = $products_related_setting['width'];
                    $products_related_setting['image_height'] = $products_related_setting['height'];

					if (isset($this->data['settings_general']['related_theme_title'][$this->config->get('config_language_id')]) && $this->data['settings_general']['related_theme_title'][$this->config->get('config_language_id')] != '') {
						$products_related_setting['heading_title'] = $this->data['settings_general']['related_theme_title'][$this->config->get('config_language_id')];
					}


                    $this->config->set('featured_product', $products_related_setting['product']);
                	$this->data['html_products_related'] = $this->getChild('module/featured', $products_related_setting);
                } else {
					$this->data['html_products_related'] = $this->$str_controller_featured->index($products_related_setting);
				}


				if ($image_product_adaptive_resize) {
					$this->data['settings_general']['blog_resize'] = $settings_general_blog_resize;
					$this->config->set('ascp_settings', $this->data['settings_general']);
				}

				reset($results);
			}

			$this->data['records'] = array();
			$results = $this->model_record_record->getRecordRelated($this->request->get['record_id']);
			if (isset($this->data['blog_design']['image_record_adaptive_resize']) && $this->data['blog_design']['image_record_adaptive_resize']) {
				$image_record_adaptive_resize = $this->data['blog_design']['image_record_adaptive_resize'];
			} else {
				$image_record_adaptive_resize = false;
			}
			foreach ($results as $result) {
				if ($result['image']) {
					if (isset($this->data['blog_design']['record_image']['width']) && $this->data['blog_design']['record_image']['width'] != '') {
						$width = $this->data['blog_design']['record_image']['width'];
					} else {
						$this->data['blog_design']['record_image']['width'] = $width = $this->config->get('config_image_related_width');
					}
					if (isset($this->data['blog_design']['record_image']['height']) && $this->data['blog_design']['record_image']['height'] != '') {
						$height = $this->data['blog_design']['record_image']['height'];
					} else {
						$this->data['blog_design']['record_image']['height'] = $height = $this->config->get('config_image_related_height');
					}
					$image = $this->seocmslib->resizeme($result['image'], $width, $height, $image_record_adaptive_resize);
				} else {
					$image = false;
				}

				if (isset($this->data['settings_general']['reviews_widget_status']) && $this->data['settings_general']['reviews_widget_status']) {

					if ($result['comment']) {
						$rating = (int) $result['rating'];
					} else {
						$rating = false;
					}
					$record_comment_info = @unserialize($result['comment']);

				}

				if ($this->config->get('config_product_description_length')) {
					$how = $this->config->get('config_product_description_length');
				} else {
					$how = 100;
				}
				$rdescription = utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $how);
				unset($result['description']);

				if (isset($this->data['settings_general']['reviews_widget_status']) && $this->data['settings_general']['reviews_widget_status']) {
					if (!isset($record_comment_info['status'])) {
						$record_comment_info['status'] = false;
					}
					$array_comment_status = $record_comment_info['status'];
					$array_comments = sprintf($this->language->get('text_comments'), (int) $result['comments']);
				} else {
					$array_comment_status = false;
					$array_comments = false;
					$rating = false;
					$this->data['comment_status'] = false;
				}

				$this->data['records'][] = array(
					'record_id' => $result['record_id'],
					'thumb' => $image,
					'name' => $result['name'],
					'description' => $rdescription . '..',
					'author' => $result['author'],
					'customer_id' => $result['customer_id'],
					'viewed' => $result['viewed'],
					'rating' => $rating,
					'comment_status' => $array_comment_status,
					'comments' => $array_comments,
					'href' => $this->url->link('record/record', 'record_id=' . $result['record_id'], $this->url_link_ssl)
				);
			}

			$this->data['tags'] = array();
			if (isset($this->data['settings_general']['blog_search']) && $this->data['settings_general']['blog_search']) {
				$this->data['blog_search']['href'] = $this->data['settings_general']['blog_search'];
			} else {
				$this->data['blog_search']['href'] = false;
			}
			$results = $this->model_record_record->getRecordTags($this->request->get['record_id']);
			foreach ($results as $result) {
				$this->data['tags'][] = array(
					'tag' => trim($result['tag']),
					'href' => $this->url->link('record/blog', 'blog_id=' . $this->data['blog_search']['href'] . '&filter_tag=' . $result['tag'], $this->url_link_ssl)
				);
			}
			$this->model_record_record->updateViewed($this->request->get['record_id']);
			if (isset($this->data['blog_design']['blog_template_record']) && $this->data['blog_design']['blog_template_record'] != '') {
				$template = $this->data['blog_design']['blog_template_record'];
			} else {
				$template = 'record.tpl';
			}
			if (isset($this->request->get['template_modal']) && $this->request->get['template_modal'] != '') {
				$template = $this->request->get['template_modal'];
			}

			if ((isset($this->request->get['cmswidget']) && $this->request->get['cmswidget'] != '') || (isset($this->request->post['cmswidget']) && $this->request->post['cmswidget'] != '')) {
				if (isset($this->request->get['cmswidget'])) {
					$this->data['cmswidget'] = (int) $this->request->get['cmswidget'];
				} else {
					$this->data['cmswidget'] = (int) $this->request->post['cmswidget'];
				}
				$this->data['ascp_widgets'] = $this->config->get('ascp_widgets');
				$this->data['settings_widget'] = $this->data['ascp_widgets'][$this->data['cmswidget']];

			}

			$this->data['product_tags'] = false;
			$tags_scripts = '';
			if (SC_VERSION > 15) {
				if (isset($record_info['tag_product']) && $record_info['tag_product'] != '' && isset($this->data['settings_general']['tags_widget_status']) && $this->data['settings_general']['tags_widget_status']) {

					$this->request->get['route'] = 'product/search';

					if ($record_info['tag_search'] == 1) {
						$token_tags = 'tag';
					}

					if ($record_info['tag_search'] == 2) {
						$token_tags = 'search';
						$this->request->get['description'] = 'true';
					} else {
						$token_tags = 'tag';
					}

					$this->request->get[$token_tags] = trim($record_info['tag_product']);
                    /*
					$this->registry->set('returnResponseSetOutput', true);
					$this->load->controller('product/search');
					$this->data['product_tags'] = $this->registry->get('returnResponseSetOutput');
					$this->registry->set('returnResponseSetOutput', false);
                    */

					$sc_layout_id = $this->registry->get('sc_layout_id');
					$this->registry->set('sc_layout_id', false);
					$this->load->controller('product/search');
					$this->registry->set('sc_layout_id', $sc_layout_id);

                    $this->data['product_tags'] = $this->response->getOutput();

					// здесь обработать
					if ($this->data['product_tags'] != '') {

						loadlibrary('parser/simple_html_dom');

						$html_dom = new simple_html_dom();
						$html_dom->load($this->data['product_tags'], true, false, DEFAULT_TARGET_CHARSET, true);


						if (isset($this->data['settings_general']['tags_widget_status_scripts']) && $this->data['settings_general']['tags_widget_status_scripts']) {
							$html_dom_s = $html_dom->find('script');
							if ($html_dom_s) {
								foreach ($html_dom_s as $nm => $b) {
									$tags_scripts .= $b->outertext;
								}
							}
						}

						foreach ($this->data['settings_general']['tags_widget_type'] as $id => $type) {
							if (trim($type['number']) != '') {
								$number = (int) $type['number'];
							}

							$html_dom_p = $html_dom->find($this->data['settings_general']['tags_widget_content'] . ' ' . $type['title']);

							if ($html_dom_p) {
								foreach ($html_dom_p as $nm => $a) {
									if (trim($type['number']) != '') {
										if ($nm == $number) {
											$a->outertext = '';
										}
									} else {
										$a->outertext = '';
									}
								}
							}
						}

						$html_dom_found = $html_dom->find($this->data['settings_general']['tags_widget_content'], 0);

						unset($html_dom);
						$this->data['product_tags'] = $html_dom_found->innertext . $tags_scripts;
						unset($html_dom_found);
					}
					$this->request->get['route'] = 'record/record';

					//unset($this->request->get[$token_tags]);

					if ($token_tags == 'search') {
						unset($this->request->get['description']);
					}
				}
			}
			$this->document->removeSCLink($this->url->link('product/search', '', $this->url_link_ssl));
			$this->document->addLink($this->url->link('record/record', 'record_id=' . $this->request->get['record_id'], $this->url_link_ssl), 'canonical');

			if (isset($record_info['meta_title']) && $record_info['meta_title'] != '') {
				$this->document->setTitle($record_info['meta_title']);
			} else {
				$this->document->setTitle($record_info['name']);
			}
			if (isset($record_info['meta_h1']) && $record_info['meta_h1'] != '') {
				$this->data['heading_title'] = $record_info['meta_h1'];
			} else {
				$this->data['heading_title'] = $record_info['name'];
			}
			$this->data['name'] = $record_info['name'];
			$this->document->setDescription($record_info['meta_description']);
			$this->document->setKeywords($record_info['meta_keyword']);


			if ($record_info['meta_description'] != '') {
				$this->data['meta_description'] = strip_tags($record_info['meta_description']);
			} else {
				$this->data['meta_description'] = htmlspecialchars(trim(utf8_substr(strip_tags(html_entity_decode($this->data['description'], ENT_QUOTES, 'UTF-8')), 0, 300)), ENT_QUOTES, 'UTF-8');
			}

			if (method_exists($this->document, 'setOgImage') && $this->data['thumb'] != '') {
				$this->document->setOgImage($this->data['thumb']);
			} else {
				if (method_exists($this->document, 'setSCOgImage') && $this->data['thumb'] != '') {
					$this->document->setSCOgImage($this->data['thumb']);
				}
			}
			if (method_exists($this->document, 'setSCOgTitle')) {
				$this->document->setSCOgTitle($this->document->getTitle());
			}
			if (method_exists($this->document, 'setSCOgDescription')) {
				$this->document->setSCOgDescription($this->document->getDescription());
			}
			if (method_exists($this->document, 'setSCOgUrl')) {
				$this->document->setSCOgUrl($this->data['href']);
			}
			if (method_exists($this->document, 'setSCOgType')) {
				$this->document->setSCOgType('website');
			}

			if (isset($record_info['index_page']) && $record_info['index_page'] != '') {
				$this->data['robots'] = $record_info['index_page'];
			} else {
				$this->data['robots'] = '';
			}

			if (method_exists($this->document, 'setRobots') && $this->data['robots'] != '') {
				$this->document->setRobots($this->data['robots']);
			} else {
				if (method_exists($this->document, 'setSCRobots') && $this->data['robots'] != '') {
					$this->document->setSCRobots($this->data['robots']);
				}
			}

            $template_info = pathinfo($template);
            $template = $template_info['filename'];
            $this_template = $this->seocmslib->template('agootemplates/record/' . $template);

			$this->data['settings_blog'] = $this->data['blog_design'];
			$this->children = array();
			if ($this->data['ajax']) {
				$this->data['header'] = '';
				$this->data['column_left'] = '';
				$this->data['column_right'] = '';
				$this->data['content_top'] = '';
				$this->data['content_bottom'] = '';
				$this->data['footer'] = '';

				if (isset($this->data['settings_widget']['positions']) && $this->data['settings_widget']['positions'] != '') {
					foreach ($this->data['settings_widget']['positions'] as $num => $position) {
						if (SC_VERSION > 15) {
							$this->data[$position] = $this->load->controller('common/' . $position);
						} else {
							array_push($this->children, 'common/' . $position);
						}
					}
				}

			} else {
				if (SC_VERSION < 20) {

					$this->children = array(
						'common/footer',
						'common/header'
					);

					foreach ($this->data['settings_general']['position_type'] as $position_type_type => $position_type_name) {
						$filecon = DIR_APPLICATION . 'controller/' . (string) $position_type_name['controller'] . '.php';
						if (is_file($filecon)) {
							array_unshift($this->children, $position_type_name['controller']);
						}
					}

				} else {
					/*
					$this->data['column_left']    = $this->load->controller('common/column_left');
					$this->data['column_right']   = $this->load->controller('common/column_right');
					$this->data['content_top']    = $this->load->controller('common/content_top');
					$this->data['content_bottom'] = $this->load->controller('common/content_bottom');
					*/

					foreach ($this->data['settings_general']['position_type'] as $position_type_type => $position_type_name) {
						$filecon = DIR_APPLICATION . 'controller/' . (string) $position_type_name['controller'] . '.php';
						if (is_file($filecon)) {
							$this->data[$position_type_name['name']] = $this->load->controller($position_type_name['controller']);
						}
					}

					$this->data['footer'] = $this->load->controller('common/footer');
					$this->data['header'] = $this->load->controller('common/header');
				}
			}

			if (is_string($this->config->get('config_logo')) && is_file(DIR_IMAGE . $this->config->get('config_logo'))) {
				$this->data['publisher_logo'] = $this->model_tool_image->resize($this->config->get('config_logo'), 100, 100);
				$this->data['publisher_logo_dim']['width'] = '100';
				$this->data['publisher_logo_dim']['height'] = '100';
			} else {
				if ($record_info['image']) {
					$this->data['publisher_logo'] = $this->data['thumb'];
					$this->data['publisher_logo_dim'] = $this->data['thumb_dim']['width'];
					$this->data['publisher_logo_dim'] = $this->data['thumb_dim']['height'];
				} else {
					$this->data['publisher_logo'] = '';
					$this->data['publisher_logo_dim'] = '';
					$this->data['publisher_logo_dim'] = '';
				}
			}


			$this->data['language'] = $this->language;
			$this->data['config'] = $this->config;

			$this->data['theme'] = $this->seocmslib->theme_folder;
			$this->config->set("blog_work", false);
			$this->data['theme_stars'] = $this->getThemeStars('image/blogstars-1.png');
			$this->template = $this_template;


			$this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . '/1.1 200 OK');

			if (SC_VERSION < 20) {
				$html = $this->render();
				$this->response->setOutput($html);
			} else {
				$html = $this->load->view($this->template, $this->data);
				$this->response->setOutput($html);
				return $html;
			}

		} else {


			$url = '';
			if (isset($this->request->get['blog_id'])) {
			}
			if (isset($this->request->get['filter_name'])) {
				$url .= '&filter_name=' . $this->request->get['filter_name'];
			}
			if (isset($this->request->get['filter_tag'])) {
				$url .= '&filter_tag=' . $this->request->get['filter_tag'];
			}
			if (isset($this->request->get['filter_description'])) {
				$url .= '&filter_description=' . $this->request->get['filter_description'];
			}
			if (isset($this->request->get['filter_blog_id'])) {
				$url .= '&filter_blog_id=' . $this->request->get['filter_blog_id'];
			}
			$this->data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_error'),
				'href' => $this->url->link('record/record', $url . '&record_id=' . $record_id, $this->url_link_ssl),
				'separator' => $this->language->get('text_separator')
			);
			$this->document->setTitle($this->language->get('text_error'));
			$this->data['heading_title'] = $this->language->get('text_error');
			$this->data['text_error'] = $this->language->get('text_error');
			$this->data['button_continue'] = $this->language->get('button_continue');
			$this->data['continue'] = $this->url->link('common/home', '', $this->url_link_ssl);

			$this_template = $this->seocmslib->template('error/not_found');



			if (SC_VERSION < 20) {
				$this->children = array(
					'common/footer',
					'common/header'
				);

				foreach ($this->data['settings_general']['position_type'] as $position_type_type => $position_type_name) {
					array_unshift($this->children, $position_type_name['controller']);
				}
			}
			$this->data['language'] = $this->language;

			if (SC_VERSION > 15) {
				/*
				$this->data['column_left']    = $this->load->controller('common/column_left');
				$this->data['column_right']   = $this->load->controller('common/column_right');
				$this->data['content_top']    = $this->load->controller('common/content_top');
				$this->data['content_bottom'] = $this->load->controller('common/content_bottom');
				*/

				foreach ($this->data['settings_general']['position_type'] as $position_type_type => $position_type_name) {
					$this->data[$position_type_name['name']] = $this->load->controller($position_type_name['controller']);
				}

				$this->data['footer'] = $this->load->controller('common/footer');
				$this->data['header'] = $this->load->controller('common/header');
			}

			if (!isset($this->request->post['ajax_file'])) {
				$this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . '/1.1 404 Not Found');
			}

			$this->config->set("blog_work", false);
			$this->template = $this_template;


			if (!isset($this->request->get['ajax_file'])) {
				if (SC_VERSION < 20) {
					$html = $this->render();
					$this->response->setOutput($html);
				} else {
					$html = $this->load->view($this->template, $this->data);
					$this->response->setOutput($html);
					return $html;
				}

			}
		}
	}
	private function getRecordImages($record_id, $settings) {
		$images = array();

		if (SC_VERSION > 21) {
			$directory = $this->config->get('config_theme');
		} else {
			$directory = 'config';
		}

		if (!$this->config->get($directory . '_image_additional_width')) {
			$this->config->set($directory . '_image_additional_width', '120');
		}

		if (!$this->config->get($directory . '_image_additional_height')) {
			$this->config->set($directory . '_image_additional_height', '200');
		}

		if (!isset($settings['gallery_image']['width']) || $settings['gallery_image']['width'] == '') {
			$settings['gallery_image']['width'] = $this->config->get($directory . '_image_additional_width');
		}
		if (!isset($settings['gallery_image']['height']) || $settings['gallery_image']['height'] == '') {
			$settings['gallery_image']['height'] = $this->config->get($directory . '_image_additional_height');
		}

		$width = $settings['gallery_image']['width'];
		$height = $settings['gallery_image']['height'];
		if (isset($settings['images_adaptive_resize']) && $settings['images_adaptive_resize']) {
			$images_adaptive_resize = $settings['images_adaptive_resize'];
		} else {
			$images_adaptive_resize = false;
		}
		if (isset($settings['images_number']) && $settings['images_number'] != '' && (isset($settings['images_number_hide']) && !$settings['images_number_hide'])) {
			$images_number = $settings['images_number'];
		} else {
			$images_number = false;
		}
		$results = $this->model_record_record->getRecordImages($record_id, $images_number);
		foreach ($results as $res) {
			$image_options = unserialize(base64_decode($res['options']));
			if (isset($image_options['title'][$this->config->get('config_language_id')])) {
				$image_title = html_entity_decode($image_options['title'][$this->config->get('config_language_id')], ENT_QUOTES, 'UTF-8');
			} else {
				$image_title = getHttpImage($this) . $res['image'];
			}
			if (isset($image_options['description'][$this->config->get('config_language_id')])) {
				$image_description = $description = html_entity_decode($image_options['description'][$this->config->get('config_language_id')], ENT_QUOTES, 'UTF-8');
				;
			} else {
				$image_description = '';
			}
			if (isset($image_options['url'][$this->config->get('config_language_id')])) {
				$image_url = $image_options['url'][$this->config->get('config_language_id')];
			} else {
				$image_url = '';
			}
			$images[] = array(
				'popup' => getHttpImage($this) . $res['image'],
				'title' => $image_title,
				'description' => $image_description,
				'url' => $image_url,
				'options' => $image_options,
				'thumb' => $this->seocmslib->resizeme($res['image'], $width, $height, $images_adaptive_resize)
			);
		}
		return $images;
	}

	public function getAllProducts() {

		$sql = "SELECT p.product_id FROM " . DB_PREFIX . "product p WHERE  p.status = '1' AND p.date_available <= NOW() ";

		$product_data = array();

		$query = $this->db->query($sql);

		foreach ($query->rows as $result) {
			$product_data[$result['product_id']] = $this->getProduct($result['product_id']);
		}

		return $product_data;
	}


	private function xds_load_settings($data) {
		if ($this->config->get('config_theme') == 'coloring') {
			$this->load->model('setting/setting');
			$coloring = array();
			$coloring = $this->model_setting_setting->getSetting('coloring', $this->config->get('config_store_id'));
			$language_id = $this->config->get('config_language_id');

			$data['disable_cart_button'] = false;
			if (isset($coloring['t1_disable_cart_button'])) {
				$data['disable_cart_button'] = $coloring['t1_disable_cart_button'];
			}
			$data['disable_cart_button_text'] = '';
			if (isset($coloring['t1_disable_cart_button_text'])) {
				$data['disable_cart_button_text'] = $coloring['t1_disable_cart_button_text'][$language_id];
			}

			$data['on_off_qview'] = false;
			if (isset($coloring['t1_on_off_qview'])) {
				$data['on_off_qview'] = $coloring['t1_on_off_qview'];
			}

			$data['on_off_fastorder'] = false;
			if (isset($coloring['t1_on_off_fastorder'])) {
				$data['on_off_fastorder'] = $coloring['t1_on_off_fastorder'];
			}

			$data['second_button'] = false;
			if (isset($coloring['t1_second_button'])) {
				$data['second_button'] = $coloring['t1_second_button'];
			}

			$this->load->language('coloring/coloring');
			$data['qview_text'] = $this->language->get('qview_text');
			$data['fastorder_text'] = $this->language->get('fastorder_text');

			$this->document->addScript('catalog/view/theme/coloring/assets/owl-carousel/owl.carousel.min.js');
			$this->document->addStyle('catalog/view/theme/coloring/assets/owl-carousel/owl.carousel.css');
			$this->document->addStyle('catalog/view/theme/coloring/assets/owl-carousel/owl.theme.css');

			$this->document->addScript('catalog/view/javascript/jquery/datetimepicker/moment.js');
			$this->document->addScript('catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.js');
			$this->document->addStyle('catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.css');
		}
		$this->data = $data;
		return $this->data;
	}


	private function xds_load_products($result) {
		$xds_qview = '';
		$xds_fastorder = '';

		if ($this->config->get('config_theme') == 'coloring') {
			$xds_qview = "index.php?route=extension/module/xds_qview&product_id=" . $result['product_id'];
			$xds_fastorder = "index.php?route=extension/module/xds_fastorder&product_id=" . $result['product_id'];
		}
		return $xds_qview;
		return $xds_fastorder;
	}



	private function mm2_load_settings($data) {
		$this->data = $data;

		if ($this->seocmslib->theme_folder == 'moneymaker2') {
			/*mmr*/
			$this->load->language('module/moneymaker2');
			$this->data['moneymaker2_text_old_price'] = $this->language->get('text_old_price');
			$this->data['moneymaker2_modules_quickorder_enabled'] = $this->config->get('moneymaker2_modules_quickorder_enabled');
			if ($this->data['moneymaker2_modules_quickorder_enabled']) {
				$this->data['moneymaker2_modules_quickorder_display_catalog'] = $this->config->get('moneymaker2_modules_quickorder_display_catalog');
				$this->data['moneymaker2_modules_quickorder_button_title'] = $this->config->get('moneymaker2_modules_quickorder_button_title');
				$this->data['moneymaker2_modules_quickorder_button_title'] = $this->data['moneymaker2_modules_quickorder_button_title'][$this->config->get('config_language_id')];
			}
			$this->data['moneymaker2_common_buy_hide'] = $this->config->get('moneymaker2_common_buy_hide');
			$this->data['moneymaker2_common_wishlist_hide'] = $this->config->get('moneymaker2_common_wishlist_hide');
			$this->data['moneymaker2_common_wishlist_caption'] = $this->config->get('moneymaker2_common_wishlist_caption');
			$this->data['moneymaker2_common_compare_hide'] = $this->config->get('moneymaker2_common_compare_hide');
			$this->data['moneymaker2_common_compare_caption'] = $this->config->get('moneymaker2_common_compare_caption');
			$this->data['moneymaker2_common_cart_outofstock_disabled'] = $this->config->get('moneymaker2_common_cart_outofstock_disabled');
			$this->data['moneymaker2_common_price_detached'] = $this->config->get('moneymaker2_common_price_detached');
			$this->data['moneymaker2_stickers_mode'] = $this->config->get('moneymaker2_modules_stickers_mode');
			$this->data['moneymaker2_stickers_size_catalog'] = $this->config->get('moneymaker2_modules_stickers_size_catalog');
			/*mmr*/
		}

		return $this->data;
	}


	private function mm2_load_products($data, $result) {
		$this->data = $data;

		if ($this->seocmslib->theme_folder == 'moneymaker2') {
			/*mmr*/
			if ($this->data['special']) {
				if ($this->config->get('moneymaker2_modules_stickers_specials_enabled')) {
					$moneymaker2_modules_stickers_specials_caption = $this->config->get('moneymaker2_modules_stickers_specials_caption');
					$moneymaker2_modules_stickers_specials_discount = $this->config->get('moneymaker2_modules_stickers_specials_discount') ? ($this->config->get('moneymaker2_modules_stickers_specials_discount_mode') ? "-" . round(100 - (($result['special'] / $result['price']) * 100)) . "%" : "-" . $this->currency->format((($result['special']) - ($result['price'])) * (-1))) : '';
					$this->data['moneymaker2_stickers'][] = array(
						'type' => 'special',
						'icon' => $this->config->get('moneymaker2_modules_stickers_specials_icon'),
						'caption' => $this->config->get('moneymaker2_modules_stickers_specials_discount') ? "<b>" . $moneymaker2_modules_stickers_specials_discount . "</b> " . $moneymaker2_modules_stickers_specials_caption[$this->config->get('config_language_id')] : $moneymaker2_modules_stickers_specials_caption[$this->config->get('config_language_id')]
					);
				}
			}
			if ($result['viewed']) {
				if ($this->config->get('moneymaker2_modules_stickers_popular_enabled')) {
					if ($result['viewed'] >= $this->config->get('moneymaker2_modules_stickers_popular_limit')) {
						$moneymaker2_modules_stickers_popular_caption = $this->config->get('moneymaker2_modules_stickers_popular_caption');
						$this->data['moneymaker2_stickers'][] = array(
							'type' => 'popular',
							'icon' => $this->config->get('moneymaker2_modules_stickers_popular_icon'),
							'caption' => $moneymaker2_modules_stickers_popular_caption[$this->config->get('config_language_id')]
						);
					}
				}
			}
			if ($result['rating']) {
				if ($this->config->get('moneymaker2_modules_stickers_rated_enabled')) {
					if ($result['rating'] >= $this->config->get('moneymaker2_modules_stickers_rated_limit')) {
						$moneymaker2_modules_stickers_rated_caption = $this->config->get('moneymaker2_modules_stickers_rated_caption');
						$this->data['moneymaker2_stickers'][] = array(
							'type' => 'rated',
							'icon' => $this->config->get('moneymaker2_modules_stickers_rated_icon'),
							'caption' => $moneymaker2_modules_stickers_rated_caption[$this->config->get('config_language_id')]
						);
					}
				}
			}
			if ($result['date_available']) {
				if ($this->config->get('moneymaker2_modules_stickers_new_enabled')) {
					if ((round((strtotime(date("Y-m-d")) - strtotime($result['date_available'])) / 86400)) <= $this->config->get('moneymaker2_modules_stickers_new_limit')) {
						$moneymaker2_modules_stickers_new_caption = $this->config->get('moneymaker2_modules_stickers_new_caption');
						$this->data['moneymaker2_stickers'][] = array(
							'type' => 'new',
							'icon' => $this->config->get('moneymaker2_modules_stickers_new_icon'),
							'caption' => $moneymaker2_modules_stickers_new_caption[$this->config->get('config_language_id')]
						);
					}
				}
			}
			if (isset($result[$this->config->get('moneymaker2_modules_stickers_custom1_field')]) && $result[$this->config->get('moneymaker2_modules_stickers_custom1_field')]) {
				if ($this->config->get('moneymaker2_modules_stickers_custom1_enabled')) {
					$moneymaker2_modules_stickers_custom1_caption = $this->config->get('moneymaker2_modules_stickers_custom1_caption');
					$this->data['moneymaker2_stickers'][] = array(
						'type' => 'custom1',
						'icon' => $this->config->get('moneymaker2_modules_stickers_custom1_icon'),
						'caption' => $moneymaker2_modules_stickers_custom1_caption[$this->config->get('config_language_id')]
					);
				}
			}
			if (isset($result[$this->config->get('moneymaker2_modules_stickers_custom2_field')]) && $result[$this->config->get('moneymaker2_modules_stickers_custom2_field')]) {
				if ($this->config->get('moneymaker2_modules_stickers_custom2_enabled')) {
					$moneymaker2_modules_stickers_custom2_caption = $this->config->get('moneymaker2_modules_stickers_custom2_caption');
					$this->data['moneymaker2_stickers'][] = array(
						'type' => 'custom2',
						'icon' => $this->config->get('moneymaker2_modules_stickers_custom2_icon'),
						'caption' => $moneymaker2_modules_stickers_custom2_caption[$this->config->get('config_language_id')]
					);
				}
			}
			/*mmr*/
		}



		return $this->data;
	}

	public function getThemeStars($file) {
		$themefile = false;
		if (file_exists(DIR_TEMPLATE . $this->seocmslib->theme_folder . '/' . $file)) {
			$themefile = $this->seocmslib->theme_folder;
		} else {
			if (file_exists(DIR_TEMPLATE . 'default/' . $file)) {
				$themefile = 'default';
			}
		}
		return $themefile;
	}

}
