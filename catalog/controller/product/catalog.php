<?php
class ControllerProductCatalog extends Controller {
	public function index() {
			$this->load->language('product/category');
			$this->load->model('catalog/category');
			$this->load->model('tool/image');
			

			$data['content_top'] = $this->load->controller('common/content_top');
			$data['breadcrumbs'] = array();
			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_home'),
				'href' => $this->url->link('common/home')
			);
			$data['breadcrumbs'][] = array(
				'text' => 'Каталог',
				'href' => $this->url->link('product/catalog')
			);
			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');
			$this->response->setOutput($this->load->view('product/catalog', $data));
		//} else {
			// $data['breadcrumbs'][] = array(
			// 	'text' => $this->language->get('text_error'),
			// 	'href' => $this->url->link('product/category', $url)
			// );

			// $this->document->setTitle($this->language->get('text_error'));

			// $data['heading_title'] = $this->language->get('text_error');

			// $data['text_error'] = $this->language->get('text_error');

			// $data['button_continue'] = $this->language->get('button_continue');

			// $data['continue'] = $this->url->link('common/home');

			// $this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');

			// $data['column_left'] = $this->load->controller('common/column_left');
			// $data['column_right'] = $this->load->controller('common/column_right');
			// $data['content_top'] = $this->load->controller('common/content_top');
			// $data['content_bottom'] = $this->load->controller('common/content_bottom');
			// $data['footer'] = $this->load->controller('common/footer');
			// $data['header'] = $this->load->controller('common/header');

			// $this->response->setOutput($this->load->view('error/not_found', $data));
		//}
	}
}
