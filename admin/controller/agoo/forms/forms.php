<?php
/* All rights reserved belong to the module, the module developers http://opencartadmin.com */
// https://opencartadmin.com © 2011-2019 All Rights Reserved
// Distribution, without the author's consent is prohibited
// Commercial license
class ControllerAgooFormsForms extends Controller
{
	private $error = array();
	protected  $data;

	public function index($data)
	{
		$this->data = $data;
		$this->config->set("blog_work", true);

		if (SC_VERSION > 23) {
			$this->data['forms_template'] = 'agoo/treecomments/treecomments';
		} else {
			$this->data['forms_template'] = 'agoo/treecomments/treecomments.tpl';
		}

       	$this->language->load('agoo/forms/forms');

$anchor_tab_bootstrap_remove=<<<EOF
if ($('a[href=\'#tab-review\']').closest('li').length) {
	$('a[href=\'#tab-review\']').closest('li').remove();
} else { $('a[href=\'#tab-review\']').remove(); }
$('#tab-review').remove();
$('#cmswidget-'+cmswidget).remove();
tabs = $('.nav-tabs').children().length;
$('.nav-tabs').append('<li><a data-toggle=\'tab\' href=\'#tab-html-'+cmswidget+'\'>'+heading_title+'</a></li>');
$('#content .tab-content:first').append($(data).html());
if (tabs == 0 || $('.nav-tabs').children().filter('.active').length == 0) $('a[href$=\'#tab-html-'+cmswidget+'\']').click();
EOF;

$anchor_tab_bootstrap=<<<EOF
$('#cmswidget-'+cmswidget).remove();
tabs = $('.nav-tabs').children().length;
$('.nav-tabs').append('<li><a data-toggle=\'tab\' href=\'#tab-html-'+cmswidget+'\'>'+heading_title+'</a></li>');
$('#content .tab-content:first').append($(data).html());
if (tabs == 0 || $('.nav-tabs').children().filter('.active').length == 0) $('a[href$=\'#tab-html-'+cmswidget+'\']').click();
EOF;



$anchor_pills_bootstrap_remove=<<<EOF
if ($('a[href=\'#tab-review\']').closest('li').length) {
	$('a[href=\'#tab-review\']').closest('li').remove();
} else { $('a[href=\'#tab-review\']').remove(); }
$('#tab-review').remove();
$('#cmswidget-'+cmswidget).remove();
tabs = $('.nav-pills').children().length;
$('.nav-pills').append('<li><a data-toggle=\'tab\' href=\'#tab-html-'+cmswidget+'\'>'+heading_title+'</a></li>');
$('#content .tab-content:first').append($(data).html());
if (tabs == 0 || $('.nav-pills').children().filter('.active').length == 0) $('a[href$=\'#tab-html-'+cmswidget+'\']').click();
EOF;

$anchor_pills_bootstrap=<<<EOF
$('#cmswidget-'+cmswidget).remove();
tabs = $('.nav-pills').children().length;
$('.nav-pills').append('<li><a data-toggle=\'tab\' href=\'#tab-html-'+cmswidget+'\'>'+heading_title+'</a></li>');
$('#content .tab-content:first').append($(data).html());
if (tabs == 0 || $('.nav-pills').children().filter('.active').length == 0) $('a[href$=\'#tab-html-'+cmswidget+'\']').click();
EOF;



$anchor_tab_custom=<<<EOF
$('#cmswidget-'+cmswidget).remove();
tabs = $('#tabs').children().length;
$('#tabs').append('<a data-toggle=\'tab\' href=\'#tab-html-'+cmswidget+'\'>'+heading_title+'</a>');
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


$anchor_tab_custom_remove=<<<EOF
if ($('a[href=\'#tab-review\']').closest('li').length) {
	$('a[href=\'#tab-review\']').closest('li').remove();
} else { $('a[href=\'#tab-review\']').remove(); }
$('#tab-review').remove();
$('#cmswidget-'+cmswidget).remove();
tabs = $('#tabs').children().length;
$('#tabs').append('<a data-toggle=\'tab\' href=\'#tab-html-'+cmswidget+'\'>'+heading_title+'</a>');
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


$anchor_tab_default=<<<EOF
tab_select[cmswidget] = '#tab-review';
$('#cmswidget-'+cmswidget).remove();
$(tab_select[cmswidget]).html($(data).html());
EOF;




if (SC_VERSION > 15) {
	//$anchor_tab = $anchor_tab_bootstrap;
	$anchor_tab = '';

} else {
	$anchor_tab = '';
}


if (SC_VERSION > 15) {
$box_begin =<<<EOF
<div id="tab-html-{CMSWIDGET}" class="tab-pane">
	<div class="box" style="display: block">
		<div class="box-content bordernone">
EOF;
} else {
$box_begin =<<<EOF
<div id="tab-html-{CMSWIDGET}" class="tab-content tab-pane">
	<div class="box" style="display: block">
		<div class="box-content bordernone">
EOF;
}


$box_end =<<<EOF
		</div>
	</div>
</div>
EOF;

		if (isset($this->data['id']) && !isset($this->data['ascp_widgets'][$this->data['id']]['anchor'])) {
			$this->data['ascp_widgets'][$this->data['id']]['anchor'] = $anchor_tab;
			$this->data['ascp_widgets'][$this->data['id']]['box_begin'] = $box_begin;
			$this->data['ascp_widgets'][$this->data['id']]['box_end'] = $box_end;
		}

        if (!isset($this->data['id'])) {
         $this->data['id'] = false;
        }

        $this->data['fields_info'] = $this->getFields();

		$this->data['ascp_settings'] = $this->config->get('ascp_settings');
		$this->data['config_language_id'] = $this->config->get('config_language_id');

		if (isset($this->data['ascp_settings']['comment_type'])) {
			$this->data['comment_type'] = $this->data['ascp_settings']['comment_type'];
		} else {
			$this->data['comment_type'] = array();
		}

		$this->data['comment_type'][0] = array(	'type_id' => '0',
					 							'title' => array ( $this->config->get('config_language_id') => $this->language->get('text_all_type_id'))
					 							);


		if (isset($this->data['id']) && !isset($this->data['ascp_widgets'][$this->data['id']]['anchor'])) {
			$this->data['ascp_widgets'][$this->data['id']]['anchor'] = $anchor_tab;
		}

		if (isset($this->data['id']) && !isset($this->data['ascp_widgets'][$this->data['id']]['stat_a_class'])) {
			$this->data['ascp_widgets'][$this->data['id']]['stat_a_class'] = 'button_html_stat button btn btn-primary';
		}

		$this->data['block_width_templates'] = array(
		$this->language->get('entry_block_width_templates_2') => '49%',
		$this->language->get('entry_block_width_templates_3') => '32%',
		$this->language->get('entry_block_width_templates_4') => '24%',
		$this->language->get('entry_block_width_templates_5') => '19%',
		$this->language->get('entry_value_templates_clear') => ""
		);

		if (isset($this->data['id']) && !isset($this->data['ascp_widgets'][$this->data['id']]['modal_a_class'])) {
			$this->data['ascp_widgets'][$this->data['id']]['modal_a_class'] = 'button_html_modal button btn btn-primary';
		}

		if (isset($this->data['id']) && !isset($this->data['ascp_widgets'][$this->data['id']]['modal_cbmobile_width_browser'])) {
			$this->data['ascp_widgets'][$this->data['id']]['modal_cbmobile_width_browser'] = '800';
		}


		if (isset($this->data['ascp_widgets'][$this->data['id']]['modal_cbmobile_width_browser'])) {
        	$this->data['ascp_widgets'][$this->data['id']]['modal_cbmobile_width_browser'] = str_replace('px' , '', $this->data['ascp_widgets'][$this->data['id']]['modal_cbmobile_width_browser']);
        	$this->data['ascp_widgets'][$this->data['id']]['modal_cbmobile_width_browser'] = str_replace('%' , '', $this->data['ascp_widgets'][$this->data['id']]['modal_cbmobile_width_browser']);
        }


		if (isset($this->data['id']) && !isset($this->data['ascp_widgets'][$this->data['id']]['modal_cb_width'])) {
			$this->data['ascp_widgets'][$this->data['id']]['modal_cb_width'] = '50%';
		}

		if (isset($this->data['id']) && !isset($this->data['ascp_widgets'][$this->data['id']]['modal_cb_height'])) {
			$this->data['ascp_widgets'][$this->data['id']]['modal_cb_height'] = '50%';
		}

		if (isset($this->data['id']) && !isset($this->data['ascp_widgets'][$this->data['id']]['modal_cb_maxwidth'])) {
			$this->data['ascp_widgets'][$this->data['id']]['modal_cb_maxwidth'] = '100%';
		}
		if (isset($this->data['id']) && !isset($this->data['ascp_widgets'][$this->data['id']]['modal_cb_maxheight'])) {
			$this->data['ascp_widgets'][$this->data['id']]['modal_cb_maxheight'] = '100%';
		}

		if (isset($this->data['id']) && !isset($this->data['ascp_widgets'][$this->data['id']]['modal_cbmobile_width'])) {
			$this->data['ascp_widgets'][$this->data['id']]['modal_cbmobile_width'] = '90%';
		}

		if (isset($this->data['id']) && !isset($this->data['ascp_widgets'][$this->data['id']]['modal_cbmobile_height'])) {
			$this->data['ascp_widgets'][$this->data['id']]['modal_cbmobile_height'] = '90%';
		}

		if (isset($this->data['id']) && !isset($this->data['ascp_widgets'][$this->data['id']]['modal_cbmobile_maxwidth'])) {
			$this->data['ascp_widgets'][$this->data['id']]['modal_cbmobile_maxwidth'] = '100%';
		}

		if (isset($this->data['id']) && !isset($this->data['ascp_widgets'][$this->data['id']]['modal_cbmobile_maxheight'])) {
			$this->data['ascp_widgets'][$this->data['id']]['modal_cbmobile_maxheight'] = '100%';
		}

		if (isset($this->data['id']) && !isset($this->data['ascp_widgets'][$this->data['id']]['modal_cb_fixed'])) {
			$this->data['ascp_widgets'][$this->data['id']]['modal_cb_fixed'] = '0';
		}
		if (isset($this->data['id']) && !isset($this->data['ascp_widgets'][$this->data['id']]['modal_cb_reposition'])) {
			$this->data['ascp_widgets'][$this->data['id']]['modal_cb_reposition'] = '1';
		}
		if (isset($this->data['id']) && !isset($this->data['ascp_widgets'][$this->data['id']]['modal_cb_scrolling'])) {
			$this->data['ascp_widgets'][$this->data['id']]['modal_cb_scrolling'] = '1';
		}
		if (isset($this->data['id']) && !isset($this->data['ascp_widgets'][$this->data['id']]['modal_cb_title'])) {
			$this->data['ascp_widgets'][$this->data['id']]['modal_cb_title'] = '1';
		}

		if (isset($this->data['id']) && !isset($this->data['ascp_widgets'][$this->data['id']]['modal_cb_opacity'])) {
			$this->data['ascp_widgets'][$this->data['id']]['modal_cb_opacity'] = '0.3';
		}

		if (isset($this->data['id']) && !isset($this->data['ascp_widgets'][$this->data['id']]['name_status'])) {
			$this->data['ascp_widgets'][$this->data['id']]['name_status'] = true;
		}

		if (isset($this->data['id']) && !isset($this->data['ascp_widgets'][$this->data['id']]['number_comments'])) {
			$this->data['ascp_widgets'][$this->data['id']]['number_comments'] = 0;
		}

		if (isset($this->data['id']) && !isset($this->data['ascp_widgets'][$this->data['id']]['status_now'])) {
			$this->data['ascp_widgets'][$this->data['id']]['status_now'] = false;
		}
		if (isset($this->data['id']) && !isset($this->data['ascp_widgets'][$this->data['id']]['karma'])) {
			$this->data['ascp_widgets'][$this->data['id']]['karma'] = false;
		}
		if (isset($this->data['id']) && !isset($this->data['ascp_widgets'][$this->data['id']]['rating'])) {
			$this->data['ascp_widgets'][$this->data['id']]['rating'] = false;
		}
		if (isset($this->data['id']) && !isset($this->data['ascp_widgets'][$this->data['id']]['signer'])) {
			$this->data['ascp_widgets'][$this->data['id']]['signer'] = false;
		}
		if (isset($this->data['id']) && !isset($this->data['ascp_widgets'][$this->data['id']]['view_captcha'])) {
			$this->data['ascp_widgets'][$this->data['id']]['view_captcha'] = false;
		}
		if (isset($this->data['id']) && !isset($this->data['ascp_widgets'][$this->data['id']]['stat_status'])) {
			$this->data['ascp_widgets'][$this->data['id']]['stat_status'] = false;
		}
		if (isset($this->data['id']) && !isset($this->data['ascp_widgets'][$this->data['id']]['modal_status'])) {
			$this->data['ascp_widgets'][$this->data['id']]['modal_status'] = true;
		}
		if (isset($this->data['id']) && !isset($this->data['ascp_widgets'][$this->data['id']]['template'])) {
			$this->data['ascp_widgets'][$this->data['id']]['template'] = 'modal.tpl';
		}

		if (isset($this->data['id']) && !isset($this->data['ascp_widgets'][$this->data['id']]['blog_template_comment'])) {
			$this->data['ascp_widgets'][$this->data['id']]['blog_template_comment'] = 'modal.tpl';
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

$this->language->get('entry_anchor_templates_tab') =>$anchor_tab_default,

$this->language->get('entry_anchor_templates_tab_custom') =>$anchor_tab_custom,
$this->language->get('entry_anchor_templates_tab_custom_remove') =>$anchor_tab_custom_remove,

$this->language->get('entry_anchor_templates_tab_bootstrap') =>$anchor_tab_bootstrap,
$this->language->get('entry_anchor_templates_tab_bootstrap_remove') =>$anchor_tab_bootstrap_remove,

$this->language->get('entry_anchor_templates_pills_bootstrap') =>$anchor_pills_bootstrap,
$this->language->get('entry_anchor_templates_pills_bootstrap_remove') =>$anchor_pills_bootstrap_remove,


$this->language->get('entry_anchor_templates_clear') => ""
);

if (SC_VERSION > 15) {
$this->data['ascp_widgets'][$this->data['id']]['box_begin_templates'] = array(

$this->language->get('entry_box_begin_templates_tab') => $box_begin,
$this->language->get('entry_box_begin_templates_empty') => '<div>',
$this->language->get('entry_anchor_templates_clear') => ""
);
} else {

$this->data['ascp_widgets'][$this->data['id']]['box_begin_templates'] = array(
$this->language->get('entry_box_begin_templates_tab') => $box_begin,
$this->language->get('entry_box_begin_templates_empty') => '<div>',
$this->language->get('entry_anchor_templates_clear') => ""
);

}


$this->data['ascp_widgets'][$this->data['id']]['box_end_templates'] = array(
$this->language->get('entry_box_end_templates_tab') => $box_end,
$this->language->get('entry_box_end_templates_empty') => '</div>',
$this->language->get('entry_anchor_templates_clear') => ""
);

        return $this->data;
	}

	private function getFields() {
			$fields       = array();
			$this->load->model('catalog/fields');
			$fields  = $this->model_catalog_fields->getFieldsDesc();
            return $fields;
	}
}
