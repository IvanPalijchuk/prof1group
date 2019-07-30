<?php
/* All rights reserved belong to the module, the module developers http://opencartadmin.com */
// https://opencartadmin.com © 2011-2019 All Rights Reserved
// Distribution, without the author's consent is prohibited
// Commercial license
class ControllerAgooReviewsReviews extends Controller
{
	private $error = array();
	protected  $data;

	public function index($data) {
		$this->data = $data;
		$this->config->set("blog_work", true);

		if (SC_VERSION > 23) {
			$this->data['reviews_template'] = 'agoo/reviews/reviews';
		} else {
			$this->data['reviews_template'] = 'agoo/reviews/reviews.tpl';
		}

       	$this->language->load('agoo/reviews/reviews');
        $this->data['categories'] = array();

		if (isset($this->data['id'])) {

        	$this->load->model('catalog/category');
			$this->load->model('catalog/blog');
	        if ($this->table_exists(DB_PREFIX . "blog")) {
				$r = $this->db->query("DESCRIBE  `" . DB_PREFIX . "blog` `design`");
				if ($r->num_rows == 1) {
	               	$this->data['categories'] = $this->model_catalog_blog->getCategories(0);
				}
			}
			$this->data['cat'] = $this->model_catalog_category->getCategories(0);
		}


        if (!isset($this->data['id'])) {
         $this->data['id'] = false;
        }
		if (isset($this->data['id']) && !isset($this->data['ascp_widgets'][$this->data['id']]['anchor'])) {
			$this->data['ascp_widgets'][$this->data['id']]['anchor'] = '';
		}

		if (isset($this->data['id']) && !isset($this->data['ascp_widgets'][$this->data['id']]['admin_name'])) {
			$this->data['ascp_widgets'][$this->data['id']]['admin_name'] = 'admin';
		}
		if (isset($this->data['id']) && !isset($this->data['ascp_widgets'][$this->data['id']]['admin_color'])) {
			$this->data['ascp_widgets'][$this->data['id']]['admin_color'] = '#FCFCFC';
		}

		if (isset($this->data['id']) && !isset($this->data['ascp_widgets'][$this->data['id']]['date_status'])) {
			$this->data['ascp_widgets'][$this->data['id']]['date_status'] = true;
		}

		$this->data['block_width_templates'] = array(
		$this->language->get('entry_block_width_templates_2') => '49%',
		$this->language->get('entry_block_width_templates_3') => '32%',
		$this->language->get('entry_block_width_templates_4') => '24%',
		$this->language->get('entry_block_width_templates_5') => '19%',
		$this->language->get('entry_value_templates_clear') => ""
		);
 		if (isset($this->data['id']) && !isset($this->data['ascp_widgets'][$this->data['id']]['reviews_a_class'])) {
			$this->data['ascp_widgets'][$this->data['id']]['reviews_a_class'] = 'button_reviews button btn btn-primary';
		}

        $this->data['admins'][$this->data['id']] = array();
		if (!empty($this->data['ascp_widgets'][$this->data['id']]['admins'])) {

	        if (file_exists(DIR_APPLICATION.'model/sale/customer.php')) {
	        	$this->load->model('sale/customer');
				$model_customer = 'model_sale_customer';
			} else {
				$this->load->model('customer/customer');
				$model_customer = 'model_customer_customer';
			}

			foreach ($this->data['ascp_widgets'][$this->data['id']]['admins'] as $admin_id) {
				$admin_info = $this->$model_customer->getCustomer($admin_id);
				if ($admin_info) {
					$this->data['admins'][$this->data['id']][] = array(
						'customer_id' => $admin_info['customer_id'],
						'name' =>  strip_tags(html_entity_decode($admin_info['firstname'], ENT_QUOTES, 'UTF-8')).' '.strip_tags(html_entity_decode($admin_info['lastname'], ENT_QUOTES, 'UTF-8'))
					);
				}
			}
		}



$this->data['ascp_widgets'][$this->data['id']]['anchor_templates'] = array(

$this->language->get('entry_anchor_templates_html') => "$('#cmswidget-'+cmswidget).remove();
$('".$this->language->get('text_anchor_templates_selector')."').html(data);",

$this->language->get('entry_anchor_templates_prepend') => "$('#cmswidget-'+cmswidget).remove();
$('".$this->language->get('text_anchor_templates_selector')."').prepend(data);",

$this->language->get('entry_anchor_templates_append') => "$('#cmswidget-'+cmswidget).remove();
$('".$this->language->get('text_anchor_templates_selector')."').append(data);",

$this->language->get('entry_anchor_templates_before') => "$('#cmswidget-'+cmswidget).remove();
$('".$this->language->get('text_anchor_templates_selector')."').before(data);",

$this->language->get('entry_anchor_templates_after') => "$('#cmswidget-'+cmswidget).remove();
$('".$this->language->get('text_anchor_templates_selector')."').after(data);",

$this->language->get('entry_anchor_templates_clear') => ""
);

if (SC_VERSION > 15) {
$this->data['ascp_widgets'][$this->data['id']]['box_begin_templates'] = array(
$this->language->get('entry_box_begin_templates_empty') => '<div>',
$this->language->get('entry_anchor_templates_clear') => ""
);
} else {
$this->data['ascp_widgets'][$this->data['id']]['box_begin_templates'] = array(
$this->language->get('entry_box_begin_templates_empty') => '<div>',
$this->language->get('entry_anchor_templates_clear') => ""
);

}

if (SC_VERSION > 15) {
$this->data['ascp_widgets'][$this->data['id']]['box_end_templates'] = array(
$this->language->get('entry_box_end_templates_empty') => '</div>',
$this->language->get('entry_anchor_templates_clear') => ""
);
} else {
$this->data['ascp_widgets'][$this->data['id']]['box_end_templates'] = array(
$this->language->get('entry_box_end_templates_empty') => '</div>',
$this->language->get('entry_anchor_templates_clear') => ""
);

}
        return $this->data;
	}


	public function settings($data) {
		$this->data = $data;
		$this->config->set("blog_work", true);

       	$this->language->load('agoo/reviews/reviews');

		if (!isset($this->data['ascp_settings']['reviews_widget_status'])) {
			$this->data['ascp_settings']['reviews_widget_status'] = true;
		}
		if (!isset($this->data['ascp_settings']['wysibbuploader_key_imageshack'])) {
			$this->data['ascp_settings']['wysibbuploader_key_imageshack'] = '';
		}

		if (!isset($this->data['ascp_settings']['wysibbuploader_maxwidth'])) {
			$this->data['ascp_settings']['wysibbuploader_maxwidth'] = '';
		}

		if (!isset($this->data['ascp_settings']['wysibbuploader_maxheight'])) {
			$this->data['ascp_settings']['wysibbuploader_maxheight'] = '';
		}


        $this->data['entry_wysibbuploader_posturl'] = $this->language->get('entry_wysibbuploader_posturl');
        $this->data['entry_wysibbuploader_key_imageshack'] = $this->language->get('entry_wysibbuploader_key_imageshack');
        $this->data['entry_wysibbuploader_maxwidth'] = $this->language->get('entry_wysibbuploader_maxwidth');
        $this->data['entry_wysibbuploader_maxheight'] = $this->language->get('entry_wysibbuploader_maxheight');

		$this->data['header'] 	= '';
		$this->data['menu'] 	= '';
		$this->data['footer'] 	= '';
		$this->data['column_left'] 	= '';


        $this->data['language'] = $this->language;

		if (SC_VERSION > 23) {
			$this->template = 'agoo/reviews/settings';
		} else {
			$this->template = 'agoo/reviews/settings.tpl';
		}

        if (SC_VERSION < 20) {
			$html = $this->render();
		} else {
			$html = $this->load->view($this->template, $this->data);
		}

        $this->data['widgets']['reviews']['code'] = 'reviews';
        $this->data['widgets']['reviews']['name'] = $this->language->get('text_widget_reviews_settings');
        $this->data['widgets']['reviews']['order'] = $this->language->get('order_reviews');
        $this->data['widgets']['reviews']['html'] = $html;

	    return $this->data;

	}


	public function widget_scripts($data) {
		$this->data = $data;
		$this->config->set("blog_work", true);
       	$this->language->load('agoo/reviews/reviews');

		$this->data['header'] 	= '';
		$this->data['menu'] 	= '';
		$this->data['footer'] 	= '';
		$this->data['column_left'] 	= '';
        $this->data['language'] = $this->language;

		if (SC_VERSION > 23) {
			$this->template = 'agoo/reviews/widget_scripts';
		} else {
			$this->template = 'agoo/reviews/widget_scripts.tpl';
		}

        if (SC_VERSION < 20) {
			$html = $this->render();
		} else {
			$html = $this->load->view($this->template, $this->data);
		}

        $this->data['widget_scripts']['reviews'] = $html;

	    return $this->data;

	}

	public function widget_services($data) {
		$this->data = $data;
		$this->config->set("blog_work", true);
       	$this->language->load('agoo/reviews/reviews');

		$this->data['header'] 	= '';
		$this->data['menu'] 	= '';
		$this->data['footer'] 	= '';
		$this->data['column_left'] 	= '';
        $this->data['language'] = $this->language;

		if (SC_VERSION > 23) {
			$this->template = 'agoo/reviews/widget_services';
		} else {
			$this->template = 'agoo/reviews/widget_services.tpl';
		}

        if (SC_VERSION < 20) {
			$html = $this->render();
		} else {
			$html = $this->load->view($this->template, $this->data);
		}
        $this->data['widget_services']['reviews'] = $html;

	    return $this->data;
	}


	public function createTables($data)
	{

$sql[26] = "
CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "fields` (
  `field_id` int(11) NOT NULL AUTO_INCREMENT,
  `field_name` varchar(255) COLLATE utf8_general_ci NOT NULL,
  `field_image` varchar(255) COLLATE utf8_general_ci DEFAULT NULL,
  `field_type` varchar(255) COLLATE utf8_general_ci DEFAULT NULL,
  `field_must` tinyint(1) NOT NULL DEFAULT '0',
  `field_order` int(11) NOT NULL DEFAULT '0',
  `field_status` tinyint(1) NOT NULL DEFAULT '1',
  `field_public` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`field_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1 ;
";

$sql[27] = "
CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "fields_description` (
  `field_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `field_description` text COLLATE utf8_general_ci NOT NULL,
  `field_error` text COLLATE utf8_general_ci NOT NULL,
  `field_value` text COLLATE utf8_general_ci NOT NULL,
  KEY (`field_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1 ;
";

$sql[4] = "
CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "comment` (
  `comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `record_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `author` varchar(64) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `text` text COLLATE utf8_general_ci NOT NULL,
  `rating` int(1) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`comment_id`),
  KEY `record_id` (`record_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1 ;
";

$sql[20] = "
CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "rate_comment` (
  `comment_id` int(11) unsigned NOT NULL,
  `customer_id` int(11) unsigned NOT NULL,
  `delta` float(9,3) DEFAULT '0.000',
  KEY `comment_id` (`comment_id`),
  KEY `customer_id` (`customer_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8  COLLATE=utf8_general_ci;
";

$sql[23] = "
CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "rate_review` (
  `review_id` int(11) unsigned NOT NULL,
  `customer_id` int(11) unsigned NOT NULL,
  `delta` float(9,3) DEFAULT '0.000',
  KEY `review_id` (`review_id`),
  KEY `customer_id` (`customer_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8  COLLATE=utf8_general_ci;
";

$sql[25] = "
CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "review_fields` (
	 `review_id` int(11) NOT NULL,
	  KEY `review_id` (`review_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;";

		foreach ($sql as $qsql) {
			$query = $this->db->query($qsql);
		}

		$r = $this->db->query("DESCRIBE " . DB_PREFIX . "fields_description `field`");
		if ($r->num_rows == 0) {
			$msql = "ALTER TABLE `" . DB_PREFIX . "fields_description` ADD `field` LONGTEXT CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL AFTER `field_value`";
			$query = $this->db->query($msql);
		}

		$r = $this->db->query("DESCRIBE " . DB_PREFIX . "fields `field_public`");
		if ($r->num_rows == 0) {
			$msql = "ALTER TABLE `" . DB_PREFIX . "fields` ADD `field_public` tinyint(1) NOT NULL DEFAULT '1' AFTER `field_status`";
			$query = $this->db->query($msql);
		}

		$r = $this->db->query("DESCRIBE " . DB_PREFIX . "review `cmswidget`");
		if ($r->num_rows == 0) {
			$msql = "ALTER TABLE `" . DB_PREFIX . "review` ADD `cmswidget` INT(11) NOT NULL AFTER `status` ";
			$query = $this->db->query($msql);
		}
		$r = $this->db->query("DESCRIBE " . DB_PREFIX . "comment `cmswidget`");
		if ($r->num_rows == 0) {
			$msql = "ALTER TABLE `" . DB_PREFIX . "comment` ADD `cmswidget` INT(11) NOT NULL AFTER `status` ";
			$query = $this->db->query($msql);
		}

		$r = $this->db->query("DESCRIBE `" . DB_PREFIX . "review` `language_id`");
		if ($r->num_rows == 0) {
			$msql = "ALTER TABLE `" . DB_PREFIX . "review` ADD `language_id` INT(11) NOT NULL DEFAULT '".$this->config->get('config_language_id')."' AFTER `status` ";
			$query = $this->db->query($msql);
		}
		$r = $this->db->query("DESCRIBE `" . DB_PREFIX . "comment` `language_id`");
		if ($r->num_rows == 0) {
			$msql = "ALTER TABLE `" . DB_PREFIX . "comment` ADD `language_id` INT(11) NOT NULL DEFAULT '".$this->config->get('config_language_id')."' AFTER `status` ";
			$query = $this->db->query($msql);
		}

		$r = $this->db->query("DESCRIBE " . DB_PREFIX . "customer `avatar`");
		if ($r->num_rows == 0) {
			$msql = "ALTER TABLE `" . DB_PREFIX . "customer` ADD `avatar` VARCHAR( 255 ) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL AFTER `lastname`";
			$query = $this->db->query($msql);
		}

		$r = $this->db->query("DESCRIBE " . DB_PREFIX . "review_fields `review_id`");
		if ($r->num_rows == 0) {
			$msql = "ALTER TABLE `" . DB_PREFIX . "review_fields` ADD `review_id` INT( 11 )  NOT NULL ";
			$query = $this->db->query($msql);
		}
		$r = $this->db->query("DESCRIBE " . DB_PREFIX . "review_fields `mark`");
		if ($r->num_rows == 0) {
			$msql = "ALTER TABLE `" . DB_PREFIX . "review_fields` ADD `mark` VARCHAR( 255 ) CHARACTER SET ascii COLLATE ascii_bin NOT NULL AFTER `review_id`";
			$query = $this->db->query($msql);
		}

		$r = $this->db->query("DESCRIBE " . DB_PREFIX . "review_fields `product_id`");
		if ($r->num_rows == 0) {
			$msql = "ALTER TABLE `" . DB_PREFIX . "review_fields` ADD `product_id` INT( 11 ) NOT NULL FIRST";
			$query = $this->db->query($msql);
		}


		$r = $this->db->query("SHOW KEYS FROM `" . DB_PREFIX . "review_fields`  WHERE Key_name ='PRIMARY'");
		if ($r->num_rows != 0) {
			$msql = "ALTER TABLE `" . DB_PREFIX . "review_fields`  DROP PRIMARY KEY ";
			$query = $this->db->query($msql);
		}

		$r = $this->db->query("SHOW KEYS FROM `" . DB_PREFIX . "review_fields` WHERE Key_name ='review_id'");
		if ($r->num_rows == 0) {
			$msql = "ALTER TABLE `" . DB_PREFIX . "review_fields`  ADD INDEX (`review_id`)";
			$query = $this->db->query($msql);
		}


		$r = $this->db->query("SHOW KEYS FROM `" . DB_PREFIX . "review_fields` WHERE Key_name ='product_id'");
		if ($r->num_rows == 0) {
			$msql = "ALTER TABLE `" . DB_PREFIX . "review_fields` ADD INDEX (`product_id`)";
			$query = $this->db->query($msql);
		}

		$msql = "UPDATE `" . DB_PREFIX . "review_fields` SET `mark`='product_id' WHERE `mark`=''";
		$query = $this->db->query($msql);


		$r = $this->db->query("DESCRIBE " . DB_PREFIX . "comment `sorthex`");
		if ($r->num_rows == 0) {
			$msql = "ALTER TABLE `" . DB_PREFIX . "comment` ADD `sorthex` VARCHAR( 255 ) CHARACTER SET ascii COLLATE ascii_bin NOT NULL AFTER `rating`";
			$query = $this->db->query($msql);
		}

		$r = $this->db->query("DESCRIBE " . DB_PREFIX . "rate_comment `rate_id`");
		if ($r->num_rows == 0) {
			$msql = "ALTER TABLE `" . DB_PREFIX . "rate_comment` ADD `rate_id` int(11) AUTO_INCREMENT PRIMARY KEY";
			$query = $this->db->query($msql);
		}

		$r = $this->db->query("DESCRIBE " . DB_PREFIX . "rate_review `rate_id`");
		if ($r->num_rows == 0) {
			$msql = "ALTER TABLE `" . DB_PREFIX . "rate_review` ADD `rate_id` int(11) AUTO_INCREMENT PRIMARY KEY";
			$query = $this->db->query($msql);
		}


		$r = $this->db->query("DESCRIBE " . DB_PREFIX . "review `sorthex`");
		if ($r->num_rows == 0) {
			$msql = "ALTER TABLE `" . DB_PREFIX . "review` ADD `sorthex` INT(11) NOT NULL AFTER `product_id`";
			$query = $this->db->query($msql);
		}
		$r = $this->db->query("DESCRIBE " . DB_PREFIX . "comment `parent_id`");
		if ($r->num_rows == 0) {
			$msql = "ALTER TABLE `" . DB_PREFIX . "comment` ADD `parent_id` INT(11) NOT NULL AFTER `record_id`";
			$query = $this->db->query($msql);
		}
		$r = $this->db->query("DESCRIBE  " . DB_PREFIX . "review `parent_id`");
		if ($r->num_rows == 0) {
			$msql = "ALTER TABLE `" . DB_PREFIX . "review` ADD `parent_id` INT(11) NOT NULL AFTER `product_id`";
			$query = $this->db->query($msql);
		}
		$r = $this->db->query("DESCRIBE  " . DB_PREFIX . "review `rating_mark`");
		if ($r->num_rows == 0) {
			$msql = "ALTER TABLE `" . DB_PREFIX . "review` ADD `rating_mark` tinyint(1)  NOT NULL DEFAULT '0' AFTER `rating`";
			$query = $this->db->query($msql);
		}

		$r = $this->db->query("DESCRIBE  " . DB_PREFIX . "comment `rating_mark`");
		if ($r->num_rows == 0) {
			$msql = "ALTER TABLE `" . DB_PREFIX . "comment` ADD `rating_mark` tinyint(1)  NOT NULL DEFAULT '0' AFTER `rating`";
			$query = $this->db->query($msql);
		}


		$r = $this->db->query("DESCRIBE  " . DB_PREFIX . "comment `rating_mark`");
		if ($r->num_rows == 1) {
			foreach ($r->rows as $trow) {
				if ($trow['Key'] == ' ' || $trow['Key'] == '') {
					$msql = "ALTER TABLE `" . DB_PREFIX . "comment` ADD INDEX `rating_mark` (`rating_mark`)";
					$query = $this->db->query($msql);
				}
			}
		}

		$r = $this->db->query("DESCRIBE  " . DB_PREFIX . "comment `customer_id`");
		if ($r->num_rows == 1) {
			foreach ($r->rows as $trow) {
				if ($trow['Key'] == ' ' || $trow['Key'] == '') {
					$msql = "ALTER TABLE `" . DB_PREFIX . "comment` ADD INDEX `customer_id` (`customer_id`)";
					$query = $this->db->query($msql);
				}
			}
		}

		$r = $this->db->query("DESCRIBE  " . DB_PREFIX . "review `customer_id`");
		if ($r->num_rows == 1) {
			foreach ($r->rows as $trow) {
				if ($trow['Key'] == ' ' || $trow['Key'] == '' ) {
					$msql = "ALTER TABLE `" . DB_PREFIX . "review` ADD INDEX `customer_id` (`customer_id`)";
					$query = $this->db->query($msql);
				}
			}
		}

		$r = $this->db->query("DESCRIBE  " . DB_PREFIX . "review `rating_mark`");
		if ($r->num_rows == 1) {
			foreach ($r->rows as $trow) {
				if ($trow['Key'] == ' ' || $trow['Key'] == '') {
					$msql = "ALTER TABLE `" . DB_PREFIX . "review` ADD INDEX `rating_mark` (`rating_mark`)";
					$query = $this->db->query($msql);
				}
			}
		}
		$r = $this->db->query("DESCRIBE  " . DB_PREFIX . "comment `rating`");
		if ($r->num_rows == 1) {
			foreach ($r->rows as $trow) {
				if ($trow['Key'] == '' || $trow['Key'] == ' ') {
					$msql = "ALTER TABLE `" . DB_PREFIX . "comment` ADD INDEX `rating` (`rating`)";
					$query = $this->db->query($msql);
				}
			}
		}
		$r = $this->db->query("DESCRIBE  " . DB_PREFIX . "review `rating`");
		if ($r->num_rows == 1) {
			foreach ($r->rows as $trow) {
				if ($trow['Key'] == '' || $trow['Key'] == ' ') {
					$msql = "ALTER TABLE `" . DB_PREFIX . "review` ADD INDEX `rating` (`rating`)";
					$query = $this->db->query($msql);
				}
			}
		}

		$r = $this->db->query("DESCRIBE " . DB_PREFIX . "comment `text`");
		if ($r->num_rows > 0) {
			$msql = "ALTER TABLE `" . DB_PREFIX . "comment` CHANGE `text` `text` TEXT CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL";
			$query = $this->db->query($msql);
		}
		$r = $this->db->query("DESCRIBE " . DB_PREFIX . "comment `author`");
		if ($r->num_rows > 0) {
			$msql = "ALTER TABLE `" . DB_PREFIX . "comment` CHANGE `author` `author` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL";
			$query = $this->db->query($msql);
		}


		$r = $this->db->query("DESCRIBE `" . DB_PREFIX . "comment` `type_id`");
		if ($r->num_rows == 0) {
			$msql = "ALTER TABLE `" . DB_PREFIX . "comment` ADD `type_id` INT(11) NOT NULL DEFAULT '1' AFTER `language_id`";
			$query = $this->db->query($msql);
		}
		$r = $this->db->query("SHOW KEYS FROM `" . DB_PREFIX . "comment` WHERE Key_name ='type_id'");
		if ($r->num_rows == 0) {
			$msql = "ALTER TABLE `" . DB_PREFIX . "comment`  ADD INDEX (`type_id`)";
			$query = $this->db->query($msql);
		}

		$r = $this->db->query("DESCRIBE `" . DB_PREFIX . "review` `type_id`");
		if ($r->num_rows == 0) {
			$msql = "ALTER TABLE `" . DB_PREFIX . "review` ADD `type_id` INT(11) NOT NULL DEFAULT '1' AFTER `language_id`";
			$query = $this->db->query($msql);
		}

		$r = $this->db->query("SHOW KEYS FROM `" . DB_PREFIX . "review` WHERE Key_name ='type_id'");
		if ($r->num_rows == 0) {
			$msql = "ALTER TABLE `" . DB_PREFIX . "review`  ADD INDEX (`type_id`)";
			$query = $this->db->query($msql);
		}


		//$this->script_reviews();
        //$this->cont('agoos/reviews');
      	//$this->controller_agoos_reviews->script_reviews();

        return $data;

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
            } else {
				trigger_error('Error: Could not load controller ' . $cont . '!');
				exit();
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

	public function control($cont)
	{
		$file = DIR_APPLICATION . 'controller/' . $cont . '.php';
		$class = 'Controller' . preg_replace('/[^a-zA-Z0-9]/', '', $cont);
		if (file_exists($file)) {
			include_once($file);
			$this->registry->set('controller_' . str_replace('/', '_', $cont), new $class($this->registry));
		} else {
			trigger_error('Error: Could not load controller ' . $cont . '!');
			exit();
		}
	}
/***************************************/


	private function table_exists($tableName)
	{
		$found= false;
		$like   = addcslashes($tableName, '%_\\');
		$result = $this->db->query("SHOW TABLES LIKE '" . $this->db->escape($like) . "';");
		$found  = $result->num_rows > 0;
		return $found;
	}

	private function validate()
	{
		$this->language->load('module/blog');
		if (!$this->user->hasPermission('modify', 'module/blog')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		if (isset($this->request->post['ascp_widgets'])) {
			foreach ($this->request->post['ascp_widgets'] as $num => $value) {
				if (isset($value['addfields']) && !empty($value['addfields'])) {
					foreach ($value['addfields'] as $num_add => $value_add) {
						if ($value_add['field_name'] == '') {
							$this->error['warning'] = $this->language->get('error_addfields_name');
						} else {
							if (!preg_match('/^[a-z][a-z0-9-_]{3,30}$/i', $value_add['field_name'])) {
								$this->error['warning'] = $this->language->get('error_addfields_name');
							}
						}
					}
				}
			}
		}
		if (!$this->error) {
			return true;
		} else {
			$this->request->post = array();
			return false;
		}
	}

	private function get_layout_id_by_route($route) {
		if (!isset($found_layout_id)) {

				$msql = "SELECT * FROM `" . DB_PREFIX . "layout_route` WHERE `route`='".$route."';";
				$query = $this->db->query($msql);

				if (count($query->rows) <= 0) {
                   return false;
				} else {
					$found_layout_id = $query->row['layout_id'];
				}

		}
        return $found_layout_id;
	}

	private function get_layout_name_by_route($route) {
		if (!isset($found_layout_name)) {

				$msql = "SELECT * FROM `" . DB_PREFIX . "layout_route` lr
				LEFT JOIN `" . DB_PREFIX . "layout` l ON (lr.layout_id = l.layout_id)
				WHERE lr.route='".$route."';";
				$query = $this->db->query($msql);

				if (count($query->rows) <= 0) {
                   return false;
				} else {
					$found_layout_name = $query->row['name'];
				}

		}
        return $found_layout_name;
	}

}

