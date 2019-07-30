<?php
/* All rights reserved belong to the module, the module developers http://opencartadmin.com */
// https://opencartadmin.com © 2011-2019 All Rights Reserved
// Distribution, without the author's consent is prohibited
// Commercial license
class ControllerAgoosReviews extends Controller
{
	private $error = array();
	protected  $data;

	public function script_reviews()
	{
     $this->config->set("blog_work", true);
     $layout_route = 'record/record';

     if ($this->validate()) {
       $post = false;
		if ($this->request->server['REQUEST_METHOD'] == 'POST' && $this->validate()) {
			if (isset($this->request->post['layout_route'])) {
				$layout_route = $this->request->post['layout_route'];
				$post = true;
			}
		}

      	$layout_id = $this->get_layout_id_by_route($layout_route);
      	$layout_name = $this->get_layout_name_by_route($layout_route);
       	$this->language->load('module/blog');
        $this->load->model('localisation/language');
        $this->load->model('setting/store');
        $this->load->model('setting/setting');

		$languages = $this->model_localisation_language->getLanguages();
		$stores = $this->model_setting_store->getStores();

		$store_info = $this->model_setting_setting->getSetting('config', 0);
        if (isset($store_info['config_email'])) {
        	$this->data['config_email'] = $store_info['config_email'];
        } else {
          	$this->data['config_email'] = '';
        }

		$ascp_widgets        = $this->model_setting_setting->getSetting('ascp_widgets');
  		if (isset( $ascp_widgets['ascp_widgets'])) {
		 $this->data['ascp_widgets'] = $ascp_widgets['ascp_widgets'];
		} else {
		 $this->data['ascp_widgets'] = Array();
		}
        if ($this->data['ascp_widgets'] == false) {
	        $this->data['ascp_widgets'] = Array();
        }


         $found= false;
         $found_double = false;
         $found_hook = array();

         if (!is_array($this->data['ascp_widgets'])) {
	         $this->data['ascp_widgets'] = array();
         }

         foreach ($this->data['ascp_widgets'] as $num => $val) {

			foreach ($languages as $language) {

				  //$title_list_latest = $this->language->get('text_reviews_for_module').$layout_name;
				  $title_list_latest = $this->language->get('text_reviews_for_module');
		          if (isset($val['title_list_latest']) && $val['title_list_latest'][$language['language_id']]==$title_list_latest) {
			           $id_new = $found_hook[$num] = $num;
			    	    //$found_double= true;
			    	    //$found= true;

		  	    	    $found_double= false;
			    	    $found= false;
		          }
			}

		    if (isset($val['type']) && $val['type']=='treecomments' && !$post) {
	    		$id_new = $found_hook[$num] = $num;
	    	    //$found_double= true;
	    	    //$found= true;

  	    	    $found_double= false;
	    	    $found= false;

	        }

         }
if (SC_VERSION > 15) {
if ($layout_route == 'record/record') {
$anchor=<<<EOF
$('#cmswidget-'+cmswidget).remove();
tabs = $('.nav-tabs').children().length;
$('.nav-tabs').append('<li><a data-toggle=\'tab\' href=\'#tab-html-'+cmswidget+'\'>'+heading_title+'</a></li>');
$('#content .tab-content:first').append($(data).html());
if (tabs == 0 || $('.nav-tabs').children().filter('.active').length == 0) $('a[href$=\'#tab-html-'+cmswidget+'\']').click();
EOF;
} else {
$anchor=<<<EOF
tab_select[cmswidget] = '#tab-review';
$('#cmswidget-'+cmswidget).remove();
$(tab_select[cmswidget]).html($(data).html());
EOF;
}

} else {
if ($layout_route == 'record/record') {
$anchor=<<<EOF
$('#cmswidget-'+cmswidget).remove();
tabs = $('#tabs').children().length;
$('#tabs').append('<li><a data-toggle=\'tab\' href=\'#tab-html-'+cmswidget+'\'>'+heading_title+'</a></li>');
$('#tabs').after($(data).html());
$('#tabs a').each(function() {
   var obj = $(this);
   $(obj.attr('href')).hide();
   $(obj).unbind( 'click' );
});
$('#tabs a').tabs();
if (tabs == 0 || ($('.nav-tabs').children().filter('.active').length == 0 && $('#tabs').children().filter('.selected').length == 0)) {
setTimeout(function(){ $('a[href$=\'#tab-html-'+cmswidget+'\']').click();  }, 1000);
}
EOF;
} else {
$anchor=<<<EOF
tab_select[cmswidget] = '#tab-review';
$('#cmswidget-'+cmswidget).remove();
$(tab_select[cmswidget]).html($(data).html());
EOF;
}

}


$box_begin=<<<EOF
<div id="tab-html-{CMSWIDGET}" class="tab-pane">
	<div class="box" style="display: block">
		<div class="box-content bordernone">
EOF;

$box_end=<<<EOF
		</div>
	</div>
</div>
EOF;


         if (!$found || $post) {
         if(!$found_double) {
		  $ar = Array(
		   'remove' => '',
           'type' => 'treecomments',
            'template' => '',
            'blog_template_comment' => '',
            'langfile' => '',
            'anchor' => $anchor,
            'cached' => '1',
            'number_comments' => '20',
            'status' => '1',
            'status_reg' => '0',
            'status_now' => '1',
            'karma' => '1',
            'karma_reg' => '0',
            'rating_num' => '',
            'avatar_status' => '1',
            'avatar_width' => '50',
            'avatar_height' => '50',
            'buyer_status' => '1',
            'comments_email' => $this->data['config_email'],
            'admin_name' => 'admin',
            'admin_color' => '#fafafa',
            'order' => 'sort',
            'order_ad' => 'desc',
            'comment_must' => '1',
            'rating' => '1',
            'rating_must' => '0',
            'visual_rating' => '1',
            'fields_view' => '1',
            'view_captcha' => '1',
            'signer' => '1',
            'visual_editor' => '1',
            'bbwidth' => '160',
            'record' => '',
            'recordid' => '',
            'handler' => '',
            'box_begin' => $box_begin,
            'box_end' => $box_end,
            'doc_ready' => '1',
            'ajax' => '0',
            'reserved' => '',
           'store' => Array ('0' => '0'),
           'customer_groups' => Array
                (
                    '0' =>  $this->config->get('config_customer_group_id'),
                    '1' => '-1',
                    '2' => '-2',
                    '3' => '-3'
                )
        	);


		foreach ($stores as $num => $store) {
		 $ar['store'][] = $store['store_id'];
		}

		foreach ($languages as $language) {
			//$title_list_latest = $this->language->get('text_reviews_for_module').$layout_name;
			$title_list_latest = $this->language->get('text_reviews_for_module');
			$ar['title_list_latest'][$language['language_id']] = $title_list_latest;
		}

       	 $ascp_widgets['ascp_widgets'] = $this->data['ascp_widgets'];

      	 $id_new = 1;

	      	 foreach($ascp_widgets['ascp_widgets'] as $id => $massa) {
	           if ($id_new!=$id) {
	             if (!isset($ascp_widgets['ascp_widgets'][$id_new])) {
	                break;
	             }
	           }
	           $id_new++;
	      	 }

          $ascp_widgets['ascp_widgets'][$id_new] = $ar;

       	  $this->model_setting_setting->editSetting('ascp_widgets', $ascp_widgets);
        }
       }


		$blog_module        = $this->model_setting_setting->getSetting('blog_module');
        if (isset($blog_module['blog_module'])) {
		 $this->data['blog_module'] = $blog_module['blog_module'];
		} else {
		 $this->data['blog_module']  = Array();
		}
        if ($this->data['blog_module'] == false) {
	        $this->data['blog_module'] = Array();
        }


		$ascp_widgets        = $this->model_setting_setting->getSetting('ascp_widgets');
        if (isset($ascp_widgets['ascp_widgets'])) {
		 $this->data['ascp_widgets'] = $ascp_widgets['ascp_widgets'];
		} else {
		 $this->data['ascp_widgets']  = Array();
		}
        if ($this->data['ascp_widgets'] == false) {
	        $this->data['ascp_widgets'] = Array();
        }

         $found_hook= Array();
         foreach ($this->data['ascp_widgets'] as $num => $val) {
          if (isset($val['type']) && $val['type']=='treecomments') {
           $found_hook[$num] = $num;
          }
         }

         if ($post) $found_hook[$id_new] = $id_new;

         $found= false;
         $found_scheme = '';
         foreach ($this->data['blog_module'] as $num => $val) {
          if (isset($val['what']) && isset($found_hook[$val['what']])) {

          foreach ($val['layout_id'] as $number => $lay_id ) {
           	if ($lay_id == $layout_id) {
           		$found= true;
           		$found_scheme = $num;
           	}
           }
          }
         }



        $ar = Array();
        if (!$found && !empty($found_hook)) {
           $ar = Array(
		   'url_template' => '0',
           'url' => '',
           'position' => 'content_bottom',
           'status' => '1',
           'sort_order' => '0',
           'what' => $found_hook[$id_new],
           'layout_id' => Array('0'=> $layout_id)
        	);

       	 $blog_module['blog_module'] = $this->data['blog_module'];

      	 $id_new = 1;
      	 foreach($blog_module['blog_module'] as $id => $massa) {
	             if (!isset($blog_module['blog_module'][$id_new])) {
	                break;
	             }
           $id_new++;
      	 }

         $blog_module['blog_module'][$id_new] = $ar;

       	 $this->model_setting_setting->editSetting('blog_module', $blog_module);
        }



      if ($this->request->server['REQUEST_METHOD'] == 'POST' && $this->validate()) {
   			$html = $this->language->get('ok_create_tables');
			$this->response->setOutput($html);
		}
	 }
	}

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

