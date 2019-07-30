<?php
/* All rights reserved belong to the module, the module developers http://opencartadmin.com */
// https://opencartadmin.com © 2011-2019 All Rights Reserved
// Distribution, without the author's consent is prohibited
// Commercial license
class ControllerAgooTreecommentsTreecomments extends Controller
{
	private $error = array();
	protected $data;
	protected $widget_type = 'treecomments';

	public function index($data)
	{
		$this->data = $data;

		return $this->data;
	}

	public function css($data) {
		$this->data = $data;
        $widget_tpl_content = '';
        $widget_tpl_flag = false;
        $widget_css_content = '';
        $widget_css_flag = false;

		$ascp_widgets = $this->config->get('ascp_widgets');
		if (!empty($ascp_widgets)) {
	        foreach ($ascp_widgets as $ascp_widget_id => $ascp_widget) {

		        if ($ascp_widget['type'] = 'treecomments' && isset($ascp_widget['stat_color_main']) && $ascp_widget['stat_color_background'] != '') {
		           	$this->data['css_compile'][$ascp_widget_id]['stat_color_background'] = $ascp_widget['stat_color_background'];
		        }

		        if ($ascp_widget['type'] = 'treecomments' && isset($ascp_widget['stat_color_main']) && $ascp_widget['stat_color_main'] != '') {
		           	$this->data['css_compile'][$ascp_widget_id]['stat_color_main'] = $ascp_widget['stat_color_main'];
		        }

		        if ($ascp_widget['type'] = 'treecomments' && isset($ascp_widget['stat_color_two']) && $ascp_widget['stat_color_two'] != '') {
		           	$this->data['css_compile'][$ascp_widget_id]['stat_color_two'] = $ascp_widget['stat_color_two'];
		        }

		        if ($ascp_widget['type'] = 'treecomments' && isset($ascp_widget['stat_color_three']) && $ascp_widget['stat_color_three'] != '') {
		           	$this->data['css_compile'][$ascp_widget_id]['stat_color_three'] = $ascp_widget['stat_color_three'];
		        }

		        if ($ascp_widget['type'] = 'treecomments' && isset($ascp_widget['stat_color_four']) && $ascp_widget['stat_color_four'] != '') {
		           	$this->data['css_compile'][$ascp_widget_id]['stat_color_four'] = $ascp_widget['stat_color_four'];
		        }

		        if ($ascp_widget['type'] = 'treecomments' && isset($ascp_widget['stat_color_five']) && $ascp_widget['stat_color_five'] != '') {
		           	$this->data['css_compile'][$ascp_widget_id]['stat_color_five'] = $ascp_widget['stat_color_five'];
		        }
		        if ($ascp_widget['type'] = 'treecomments' && isset($ascp_widget['bbwidth']) && $ascp_widget['bbwidth'] != '') {
		           	$this->data['css_compile'][$ascp_widget_id]['bbwidth'] = $ascp_widget['bbwidth'];
		        }

	        }
        }


        $template = 'agootemplates/stylesheet/'.$this->widget_type.'/'.$this->widget_type.'css';
        $this->template = $this->seocmslib->template($template);
        if ($this->template != '') {
			$widget_tpl_flag = true;
		} else {
			$widget_tpl_flag = false;
		}


		if ($widget_tpl_flag) {
			if (SC_VERSION < 20) {
				$widget_tpl_content = $this->render();
			} else {
				if (SC_VERSION > 23) {
				    $template_engine = $this->config->get('template_engine');
				    $this->config->set('template_engine', 'template');
				}
				$widget_tpl_content = $this->load->view($this->template, $this->data);
				if (SC_VERSION > 23) {
					$this->config->set('template_engine', $template_engine);
				}
			}
		}


		if (file_exists(DIR_TEMPLATE . $this->seocmslib->theme_folder . '/template/agootemplates/stylesheet/'.$this->widget_type.'/'.$this->widget_type.'.css')) {
			$widget_css_file = DIR_TEMPLATE . $this->seocmslib->theme_folder  . '/template/agootemplates/stylesheet/'.$this->widget_type.'/'.$this->widget_type.'.css';
			$widget_css_flag = true;
		} else {
			if (file_exists(DIR_TEMPLATE .'default/template/agootemplates/stylesheet/'.$this->widget_type.'/'.$this->widget_type.'.css')) {
				$widget_css_file = DIR_TEMPLATE .'default/template/agootemplates/stylesheet/'.$this->widget_type.'/'.$this->widget_type.'.css';
				$widget_css_flag = true;
			}
		}


        if ($widget_css_flag) {
        	$widget_css_content = file_get_contents($widget_css_file);
        }

        $css_content = $widget_tpl_content.$widget_css_content;

		return $css_content;
	}



}
