<?php
/* All rights reserved belong to the module, the module developers http://opencartadmin.com */
// https://opencartadmin.com © 2011-2019 All Rights Reserved
// Distribution, without the author's consent is prohibited
// Commercial license
class ControllerAgooLatestLatest extends Controller
{
	private $error = array();
	protected $data;
	protected $widget_type = 'latest';

	public function css($data) {
		$this->data = $data;
        $widget_tpl_content = '';
        $widget_tpl_flag = false;
        $widget_css_content = '';
        $widget_css_flag = false;
        $this->widget_type = str_replace('..', '', $this->widget_type);

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
			$widget_css_file = DIR_TEMPLATE . $this->seocmslib->theme_folder . '/template/agootemplates/stylesheet/'.$this->widget_type.'/'.$this->widget_type.'.css';
			$widget_css_flag = true;
		} else {
			if (file_exists(DIR_TEMPLATE .'default/template/agootemplates/stylesheet/'.$this->widget_type.'/'.$this->widget_type.'.css')) {
				$widget_css_file = DIR_TEMPLATE .'default/template/agootemplates/stylesheet/'.$this->widget_type.'/'.$this->widget_type.'.css';
				$widget_css_flag = true;
			}
		}
        if ($widget_css_flag) {
        	$widget_css_content = file_get_contents(str_replace('..', '', $widget_css_file));
        }

        $css_content = $widget_tpl_content.$widget_css_content;

		return $css_content;
	}




}
