<?php
class ControllerExtensionModulePricefilter extends Controller
{
    private $error = array();

    public function index()
    {
        $this->load->language('extension/module/pricefilter');

        $this->document->setTitle($this->language->get('heading_title'));

        $this->load->model('setting/setting');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            $this->model_setting_setting->editSetting('pricefilter', $this->request->post);

            $this->session->data['success'] = $this->language->get('text_success');

            $this->response->redirect($this->url->link('extension/extension', 'token='.$this->session->data['token'], true));
        }

        $data['heading_title'] = $this->language->get('heading_title');

        $data['text_edit'] = $this->language->get('text_edit');
        $data['text_pricefilteraddbutton'] = $this->language->get('text_pricefilteraddbutton');
        $data['text_pricefiltermode'] = $this->language->get('text_pricefiltermode');
        $data['text_pricefilterstep'] = $this->language->get('text_pricefilterstep');
        $data['text_enabled'] = $this->language->get('text_enabled');
        $data['text_disabled'] = $this->language->get('text_disabled');

        $data['entry_status'] = $this->language->get('entry_status');
        $data['entry_startprice'] = $this->language->get('entry_startprice');
        $data['entry_endprice'] = $this->language->get('entry_endprice');
        $data['entry_order'] = $this->language->get('entry_order');

        $data['button_save'] = $this->language->get('button_save');
        $data['button_cancel'] = $this->language->get('button_cancel');
        $data['button_remove'] = $this->language->get('button_remove');
        if (isset($this->error['warning'])) {
            $data['error_warning'] = $this->error['warning'];
        } else {
            $data['error_warning'] = '';
        }

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/dashboard', 'token='.$this->session->data['token'], true),
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_module'),
            'href' => $this->url->link('extension/extension', 'token='.$this->session->data['token'], true),
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('extension/module/pricefilter', 'token='.$this->session->data['token'], true),
        );

        $data['action'] = $this->url->link('extension/module/pricefilter', 'token='.$this->session->data['token'], true);

        $data['cancel'] = $this->url->link('extension/extension', 'token='.$this->session->data['token'], true);

        if (isset($this->request->post['pricefilter_status'])) {
            $data['pricefilter_status'] = $this->request->post['pricefilter_status'];
        } else {
            $data['pricefilter_status'] = $this->config->get('pricefilter_status');
        }

        if (isset($this->request->post['pricefilter_mode'])) {
            $data['pricefilter_mode'] = $this->request->post['pricefilter_mode'];
        } else {
            $data['pricefilter_mode'] = $this->config->get('pricefilter_mode');
        }

        if (isset($this->request->post['pricefilterstep'])) {
            $data['pricefilterstep'] = $this->request->post['pricefilterstep'];
        } else {
            $data['pricefilterstep'] = $this->config->get('pricefilterstep');
        }

        $pricefilter = $this->config->get('pricefilter');

        if (!empty($pricefilter)) {
            $data['pricefilters'] = $this->config->get('pricefilter');
        } else {
            $data['pricefilters'] = '';
        }

        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('extension/module/pricefilter.tpl', $data));
    }

    protected function validate()
    {
        if (!$this->user->hasPermission('modify', 'extension/module/pricefilter')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        return !$this->error;
    }
}
