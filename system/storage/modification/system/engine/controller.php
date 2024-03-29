<?php
abstract class Controller {
	protected $registry;


			protected function setDataLang(&$data, $field_name)
			{
				$data[$field_name] = $this->language->get($field_name);
			}
			
			protected function setData(&$data, $field_name, $default_value)
			{
				$data[$field_name] = $this->getData($field_name, $default_value);
			}
			
			protected function getData($field_name, $default_value)
			{
				if (isset($this->request->post[$field_name]))
				{
					return $this->request->post[$field_name];
				}
				elseif ($this->config->has($field_name))
				{ 
					return $this->config->get($field_name);
				}
				
				return $default_value;
			}			
	
			protected function getDataImage($field_name, $width, $height)
			{
				if (isset($this->request->post[$field_name]) && file_exists(DIR_IMAGE . $this->request->post[$field_name]))
				{
					return $this->model_tool_image->resize($this->request->post[$field_name], $width, $height);
				}
				elseif ($this->config->has($field_name))
				{ 
					return $this->model_tool_image->resize($this->config->get($field_name), $width, $height);
				}
				else
				{
					return $this->model_tool_image->resize('no_image.jpg', $width, $height);
				}
			}
			
	public function __construct($registry) {
		$this->registry = $registry;
	}

	public function __get($key) {
		return $this->registry->get($key);
	}

	public function __set($key, $value) {
		$this->registry->set($key, $value);
	}
}