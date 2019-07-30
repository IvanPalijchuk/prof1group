<?php
/* All rights reserved belong to the module, the module developers http://opencartadmin.com */
// https://opencartadmin.com © 2011-2019 All Rights Reserved
// Distribution, without the author's consent is prohibited
// Commercial license
class ControllerAgooBlogsBlogs extends Controller
{
	private $error = array();
	protected  $data;

	public function index($data) {
		$this->data = $data;
		$this->config->set("blog_work", true);

       	$this->language->load('agoo/blogs/blogs');

		if (SC_VERSION > 23) {
			$this->data['blogs_template'] = 'agoo/blogs/blogs';
		} else {
			$this->data['blogs_template'] = 'agoo/blogs/blogs.tpl';
		}

        $this->load->model('catalog/blog');
        $this->load->model('catalog/record');
		if (isset($this->data['id']))	{

			$this->data['categories'] = $this->model_catalog_blog->getCategories(0);

			if (isset($this->request->post['record_blog'])) {
				$this->data['record_blog'] = $this->request->post['record_blog'];
			} elseif (isset($this->request->get['record_id'])) {
				$this->data['record_blog'] = $this->model_catalog_record->getRecordCategories($this->request->get['record_id']);
			} else {
				$this->data['record_blog'] = array();
			}
		}

        if (!isset($this->data['id'])) {
         $this->data['id'] = false;
        }

		if (isset($this->data['id']) && !isset($this->data['ascp_widgets'][$this->data['id']]['anchor'])) {
			$this->data['ascp_widgets'][$this->data['id']]['anchor'] = '';
		}

		if (isset($this->data['id']) && !isset($this->data['ascp_widgets'][$this->data['id']]['description_status'])) {
			$this->data['ascp_widgets'][$this->data['id']]['description_status'] = false;
		}

		if (isset($this->data['id']) && !isset($this->data['ascp_widgets'][$this->data['id']]['order_ad'])) {
			$this->data['ascp_widgets'][$this->data['id']]['order_ad'] = 'asc';
		}


if (SC_VERSION > 15) {
$this->data['ascp_widgets'][$this->data['id']]['anchor_templates'] = array(

$this->language->get('entry_anchor_templates_menu') => "$('#cmswidget-'+cmswidget).remove();
$('#menu ul:first').append(data);",

$this->language->get('entry_anchor_templates_menu_1') => "$('#cmswidget-'+cmswidget).remove();
$('#menu ul:first > li:nth-child(1)').after(data);",


$this->language->get('entry_anchor_templates_footer') => "$('#cmswidget-'+cmswidget).remove();
$(data).find('div, li, a').removeClass();
$('footer .row ul:first').append(data);",

$this->language->get('entry_anchor_templates_footer_1') => "$('#cmswidget-'+cmswidget).remove();
$(data).find('div, li, a').removeClass();
$('footer .row > div:nth-child(2) > ul:first > li:nth-child(2)').after(data);",

$this->language->get('entry_anchor_templates_sitemap') => "$('#cmswidget-'+cmswidget).remove();
$(data).find('div, ul, li, a').removeClass();
$('#content > .row > div:nth-child(2) > ul').after(data);",

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
} else {

$this->data['ascp_widgets'][$this->data['id']]['anchor_templates'] = array(

$this->language->get('entry_anchor_templates_menu') => "$('#cmswidget-'+cmswidget).remove();
$('#menu ul:first').append(data);",

$this->language->get('entry_anchor_templates_menu_1') => "$('#cmswidget-'+cmswidget).remove();
$('#menu ul:first > li:nth-child(1)').after(data);",


$this->language->get('entry_anchor_templates_footer') => "$('#cmswidget-'+cmswidget).remove();
$(data).find('div, li, a').removeClass();
$('#footer .column ul:first').append(data);",

$this->language->get('entry_anchor_templates_footer_1') => "$('#cmswidget-'+cmswidget).remove();
$(data).find('div, li, a').removeClass();
$('#footer .column:nth-child(2) > ul:first > li:nth-child(2)').after(data);",

$this->language->get('entry_anchor_templates_sitemap') => "$('#cmswidget-'+cmswidget).remove();
$(data).find('div, ul, li, a').removeClass();
$('.sitemap-info > .right > ul:first').append(data);",

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

}


$this->data['ascp_widgets'][$this->data['id']]['box_begin_templates'] = array(
$this->language->get('entry_box_begin_templates_empty') => '<div>',
$this->language->get('entry_anchor_templates_clear') => ""
);

$this->data['ascp_widgets'][$this->data['id']]['box_end_templates'] = array(
$this->language->get('entry_box_end_templates_empty') => '</div>',
$this->language->get('entry_anchor_templates_clear') => ""
);
        return $this->data;
	}

	public function settings($data) {
		$this->data = $data;
		$this->config->set("blog_work", true);

       	$this->language->load('agoo/blogs/blogs');

		$this->data['header'] 	= '';
		$this->data['menu'] 	= '';
		$this->data['footer'] 	= '';
		$this->data['column_left'] 	= '';


        $this->data['language'] = $this->language;

		if (!isset($this->data['ascp_settings']['blogs_widget_status'])) {
			$this->data['ascp_settings']['blogs_widget_status'] = true;
		}

		if (SC_VERSION > 23) {
			$this->template = 'agoo/blogs/settings';
		} else {
			$this->template = 'agoo/blogs/settings.tpl';
		}


        if (SC_VERSION < 20) {
			$html = $this->render();
		} else {
			$html = $this->load->view($this->template, $this->data);
		}

        $this->data['widgets']['blogs']['code'] = 'blogs';
        $this->data['widgets']['blogs']['name'] = $this->language->get('text_widget_blogs_settings');
        $this->data['widgets']['blogs']['order'] = $this->language->get('order_blogs');
        $this->data['widgets']['blogs']['html'] = $html;

	    return $this->data;

	}


}
