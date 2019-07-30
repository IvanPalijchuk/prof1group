<?php
class ControllerExtensionModulePricefilter extends Controller
{
    public function index()
    {
        $this->load->language('extension/module/pricefilter');
        $data['heading_title'] = $this->language->get('heading_title');
        $data['button_filter'] = $this->language->get('button_filter');
        $separator = $this->language->get('text_separator');
        $text_to = $this->language->get('text_to');
        /**** OST Start -- this is used to apply price filter on category page ***/
        if (isset($this->request->get['route']) && $this->request->get['route'] == 'product/category' && isset($this->request->get['path'])) {
            if (isset($this->request->get['path'])) {
                $parts = explode('_', (string) $this->request->get['path']);
            } else {
                $parts = array();
            }
            $category_id = end($parts);

            $this->load->model('catalog/category');
            $this->load->model('catalog/product');
            $category_info = $this->model_catalog_category->getCategory($category_id);
            if ($category_info) {
                $url = '';
                if (isset($this->request->get['filter'])) {
                    $url .= '&filter='.$this->request->get['filter'];
                }
                if (isset($this->request->get['sort'])) {
                    $url .= '&sort='.$this->request->get['sort'];
                }
                if (isset($this->request->get['order'])) {
                    $url .= '&order='.$this->request->get['order'];
                }
                if (isset($this->request->get['limit'])) {
                    $url .= '&limit='.$this->request->get['limit'];
                }
                $data['action'] = str_replace('&amp;', '&', $this->url->link('product/category', 'path='.$this->request->get['path'].$url));
                $category_filter = array('filter_category_id' => $category_id);
                $category_filterstep = array('filter_category_id' => $category_id);
            }
            /**** OST End -- this is used to apply price filter on category page ***/
        } elseif (isset($this->request->get['route']) && $this->request->get['route'] == 'product/search' && (isset($this->request->get['search']) || isset($this->request->get['tag']))) {
            /**** OST Start -- this is used to apply price filter on search page ***/
                if (isset($this->request->get['search'])) {
                    $search = $this->request->get['search'];
                } else {
                    $search = '';
                }
            if (isset($this->request->get['tag'])) {
                $tag = $this->request->get['tag'];
            } elseif (isset($this->request->get['search'])) {
                $tag = $this->request->get['search'];
            } else {
                $tag = '';
            }
            if ($search or $tag) {
                if (isset($this->request->get['description'])) {
                    $description = $this->request->get['description'];
                } else {
                    $description = '';
                }
                if (isset($this->request->get['category_id'])) {
                    $category_id = $this->request->get['category_id'];
                } else {
                    $category_id = 0;
                }
                if (isset($this->request->get['sub_category'])) {
                    $sub_category = $this->request->get['sub_category'];
                } else {
                    $sub_category = '';
                }
                $category_filter = array(
                        'filter_name' => $search,
                        'filter_tag' => $tag,
                        'filter_description' => $description,
                        'filter_category_id' => $category_id,
                        'filter_sub_category' => $sub_category,
                    );
                $category_filterstep = $category_filter;
                $url = '';
                if (isset($this->request->get['search'])) {
                    $url .= '&search='.urlencode(html_entity_decode($this->request->get['search'], ENT_QUOTES, 'UTF-8'));
                }
                if (isset($this->request->get['tag'])) {
                    $url .= '&tag='.urlencode(html_entity_decode($this->request->get['tag'], ENT_QUOTES, 'UTF-8'));
                }
                if (isset($this->request->get['description'])) {
                    $url .= '&description='.$this->request->get['description'];
                }
                if (isset($this->request->get['category_id'])) {
                    $url .= '&category_id='.$this->request->get['category_id'];
                }
                if (isset($this->request->get['sub_category'])) {
                    $url .= '&sub_category='.$this->request->get['sub_category'];
                }
                if (isset($this->request->get['sort'])) {
                    $url .= '&sort='.$this->request->get['sort'];
                }
                if (isset($this->request->get['order'])) {
                    $url .= '&order='.$this->request->get['order'];
                }
                if (isset($this->request->get['page'])) {
                    $url .= '&page='.$this->request->get['page'];
                }
                if (isset($this->request->get['limit'])) {
                    $url .= '&limit='.$this->request->get['limit'];
                }
                $data['action'] = str_replace('&amp;', '&', $this->url->link('product/search', $url));
            }
                /**** OST End -- this is used to apply price filter on search page ***/
        } elseif (isset($this->request->get['route']) && $this->request->get['route'] == 'product/special') {
            /**** OST Start -- this is used to apply price filter on special page ***/
                $url = '';
            if (isset($this->request->get['sort'])) {
                $url .= '&sort='.$this->request->get['sort'];
            }
            if (isset($this->request->get['order'])) {
                $url .= '&order='.$this->request->get['order'];
            }
            if (isset($this->request->get['page'])) {
                $url .= '&page='.$this->request->get['page'];
            }
            if (isset($this->request->get['limit'])) {
                $url .= '&limit='.$this->request->get['limit'];
            }
            $data['action'] = str_replace('&amp;', '&', $this->url->link('product/special', $url));
            $filter_data = array();
        } elseif (isset($this->request->get['route']) && $this->request->get['route'] == 'product/manufacturer/info') {
            /**** OST Start -- this is used to apply price filter on manufacture page page ***/
                $url = '';
            if (isset($this->request->get['manufacturer_id'])) {
                $url .= '&manufacturer_id='.$this->request->get['manufacturer_id'];
                $manufacturer_id = $this->request->get['manufacturer_id'];
            }
            if (isset($this->request->get['sort'])) {
                $url .= '&sort='.$this->request->get['sort'];
            }
            if (isset($this->request->get['order'])) {
                $url .= '&order='.$this->request->get['order'];
            }
            if (isset($this->request->get['page'])) {
                $url .= '&page='.$this->request->get['page'];
            }
            if (isset($this->request->get['limit'])) {
                $url .= '&limit='.$this->request->get['limit'];
            }
            $data['action'] = str_replace('&amp;', '&', $this->url->link('product/manufacturer/info', $url));

            $filter_data = array('filter_manufacturer_id' => $manufacturer_id);
        } else {
            $url = '';
            if (isset($this->request->get['search'])) {
                $url .= '&search='.urlencode(html_entity_decode($this->request->get['search'], ENT_QUOTES, 'UTF-8'));
            }
            if (isset($this->request->get['tag'])) {
                $url .= '&tag='.urlencode(html_entity_decode($this->request->get['tag'], ENT_QUOTES, 'UTF-8'));
            }
            if (isset($this->request->get['description'])) {
                $url .= '&description='.$this->request->get['description'];
            }

            if (isset($this->request->get['category_id'])) {
                $url .= '&category_id='.$this->request->get['category_id'];
            }
            if (isset($this->request->get['sub_category'])) {
                $url .= '&sub_category='.$this->request->get['sub_category'];
            }
            if (isset($this->request->get['sort'])) {
                $url .= '&sort='.$this->request->get['sort'];
            }
            if (isset($this->request->get['order'])) {
                $url .= '&order='.$this->request->get['order'];
            }
            if (isset($this->request->get['page'])) {
                $url .= '&page='.$this->request->get['page'];
            }
            if (isset($this->request->get['limit'])) {
                $url .= '&limit='.$this->request->get['limit'];
            }
            $data['action'] = str_replace('&amp;', '&', $this->url->link('product/search', $url));
            $category_filter = array();
            $category_filterstep = array();
        }
                /* OST Start -- This code is used to all section to get the price filter request **/
                if (isset($this->request->get['pricefilter'])) {
                    $data['price_filters'] = explode(',', $this->request->get['pricefilter']);
                } else {
                    $data['price_filters'] = array();
                }
                /* OST End -- This code is used to all section to get the price filter request **/

            /* OST Start - Price filter start for the left side display automatica and manually */
            $data['pricefilters'] = array();
        $step = $this->config->get('pricefilterstep');
        if (isset($this->request->get['route']) && $this->request->get['route'] == 'product/special') {
            $categoryproducts = $this->model_catalog_product->getProductSpecials($filter_data);
            $categoryproductsstep = $this->model_catalog_product->getProductSpecials($filter_data);
                    //print_r($categoryproductsstep);
                    if ($this->config->get('pricefilter_mode') && !empty($step)) {
                        $pricerandarray = array('0.00');
                        foreach ($categoryproductsstep as $categoryproduct) {
                            array_push($pricerandarray, $categoryproduct['price'], $categoryproduct['special']);
                        }
                        $priceranges = array();
                        $maxprice = max($pricerandarray);
                        $steps = ceil($maxprice / $step);
                        for ($i = 1; $i <= $steps; ++$i) {
                            if ($i == 1) {
                                $start = ($i - 1) * $step;
                                $end = $i * $step;
                                array_push($priceranges, $start.'-'.$end);
                            } else {
                                $start = ($i - 1) * $step + 1;
                                $end = $i * $step;
                                array_push($priceranges, $start.'-'.$end);
                            }
                        }
                        foreach ($priceranges as $pricerange) {
                            $pricerange = explode('-', $pricerange);
                            $total = 0;
                            foreach ($categoryproducts as $categoryproduct) {
                                if (!empty($categoryproduct['special'])) {
                                    $filterprice = $categoryproduct['special'];
                                } else {
                                    $filterprice = $categoryproduct['price'];
                                }

                                if ($filterprice >= $pricerange[0] && $filterprice <= $pricerange[1]) {
                                    ++$total;
                                }
                            }
                            if ($pricerange[0] == 0) {
                                $label = $text_to.' '.$this->currency->format($pricerange[1], $this->session->data['currency']);
                            } else {
                                $label = $this->currency->format($pricerange[0], $this->session->data['currency']).' '.$separator.' '.$this->currency->format($pricerange[1], $this->session->data['currency']);
                            }
                            $data['pricefilters'][] = array(
                                    'pricefilter' => $pricerange[0].'-'.$pricerange[1],
                                    'label' => $label,
                                    'total' => $total,
                                    );
                        }
                    } else {
                        $priceranges = $this->config->get('pricefilter');
                        foreach ($priceranges as $pricerange) {
                            $total = 0;
                            foreach ($categoryproducts as $categoryproduct) {
                                if (!empty($categoryproduct['special'])) {
                                    $filterprice = $categoryproduct['special'];
                                } else {
                                    $filterprice = $categoryproduct['price'];
                                }

                                if ($filterprice >= $pricerange['startprice'] && $filterprice <= $pricerange['endprice']) {
                                    ++$total;
                                }
                            }
                            if ($pricerange['startprice'] == 0) {
                                $label = $text_to.' '.$this->currency->format($pricerange['endprice'], $this->session->data['currency']);
                            } else {
                                $label = $this->currency->format($pricerange['startprice'], $this->session->data['currency']).' '.$separator.' '.$this->currency->format($pricerange['endprice'], $this->session->data['currency']);
                            }
                            $data['pricefilters'][] = array(
                                        'pricefilter' => $pricerange['startprice'].'-'.$pricerange['endprice'],
                                        'label' => $label,
                                        'total' => $total,
                                        );
                        }
                    }
        } elseif ($this->request->get['route'] == 'product/search' || $this->request->get['route'] == 'product/category') {
            $this->load->model('catalog/manufacturer');
            $this->load->model('extension/module/pricefilter');
            $categoryproducts = $this->model_catalog_product->getProducts($category_filter);
            $categoryproductsstep = $this->model_catalog_product->getProducts($category_filterstep);
            if ($this->config->get('pricefilter_mode') && !empty($step)) {
                /* OST Start -- This code is used to get the price filter values dynamically for the category nd search page */
                            //$step=$this->config->get('pricefilterstep');
                            $pricerandarray = array('0.00');
                foreach ($categoryproductsstep as $categoryproduct) {
                    array_push($pricerandarray, $categoryproduct['price'], $categoryproduct['special']);
                }

                $priceranges = array();
                $maxprice = max($pricerandarray);
                $steps = ceil($maxprice / $step);
                for ($i = 1; $i <= $steps; ++$i) {
                    if ($i == 1) {
                        $start = ($i - 1) * $step;
                        $end = $i * $step;
                        array_push($priceranges, $start.'-'.$end);
                    } else {
                        $start = ($i - 1) * $step + 1;
                        $end = $i * $step;
                        array_push($priceranges, $start.'-'.$end);
                    }
                }
                foreach ($priceranges as $pricerange) {
                    $pricerange = explode('-', $pricerange);
                    $total = 0;
                    foreach ($categoryproducts as $categoryproduct) {
                        if (!empty($categoryproduct['special'])) {
                            $filterprice = $categoryproduct['special'];
                        } else {
                            $filterprice = $categoryproduct['price'];
                        }
                        if ($filterprice >= $pricerange[0] && $filterprice <= $pricerange[1]) {
                            ++$total;
                        }
                    }
                    if ($pricerange[0] == 0) {
                        $label = $text_to.' '.$this->currency->format($pricerange[1], $this->session->data['currency']);
                    } else {
                        $label = $this->currency->format($pricerange[0], $this->session->data['currency']).' '.$separator.' '.$this->currency->format($pricerange[1], $this->session->data['currency']);
                    }
                    $data['pricefilters'][] = array(
                                            'pricefilter' => $pricerange[0].'-'.$pricerange[1],
                                            'label' => $label,
                                            'total' => $total,
                                            );
                }
            } else {
                $priceranges = $this->config->get('pricefilter');
                foreach ($priceranges as $pricerange) {
                    $total = 0;
                    foreach ($categoryproducts as $categoryproduct) {
                        if (!empty($categoryproduct['special'])) {
                            $filterprice = $categoryproduct['special'];
                        } else {
                            $filterprice = $categoryproduct['price'];
                        }
                        if ($filterprice >= $pricerange['startprice'] && $filterprice <= $pricerange['endprice']) {
                            ++$total;
                        }
                    }
                    if ($pricerange['startprice'] == 0) {
                        $label = $text_to.' '.$this->currency->format($pricerange['endprice'], $this->session->data['currency']);
                    } else {
                        $label = $this->currency->format($pricerange['startprice'], $this->session->data['currency']).' '.$separator.' '.$this->currency->format($pricerange['endprice'], $this->session->data['currency']);
                    }
                    $data['pricefilters'][] = array(
                                            'pricefilter' => $pricerange['startprice'].'-'.$pricerange['endprice'],
                                            'label' => $label,
                                            'total' => $total,
                                            );
                }
            }
        } elseif ($this->request->get['route'] == 'product/manufacturer/info') {
            $this->load->model('catalog/manufacturer');
            $this->load->model('extension/module/pricefilter');
            $categoryproducts = $this->model_catalog_product->getProducts($filter_data);
            $categoryproductsstep = $this->model_catalog_product->getProducts($filter_data);
            if ($this->config->get('pricefilter_mode') && !empty($step)) {
                /* OST Start -- This code is used to get the price filter values dynamically for the category nd search page */
                            //$step=$this->config->get('pricefilterstep');
                            $pricerandarray = array('0.00');
                foreach ($categoryproductsstep as $categoryproduct) {
                    array_push($pricerandarray, $categoryproduct['price'], $categoryproduct['special']);
                }

                $priceranges = array();
                $maxprice = max($pricerandarray);
                $steps = ceil($maxprice / $step);
                for ($i = 1; $i <= $steps; ++$i) {
                    if ($i == 1) {
                        $start = ($i - 1) * $step;
                        $end = $i * $step;
                        array_push($priceranges, $start.'-'.$end);
                    } else {
                        $start = ($i - 1) * $step + 1;
                        $end = $i * $step;
                        array_push($priceranges, $start.'-'.$end);
                    }
                }
                foreach ($priceranges as $pricerange) {
                    $pricerange = explode('-', $pricerange);
                    $total = 0;
                    foreach ($categoryproducts as $categoryproduct) {
                        if (!empty($categoryproduct['special'])) {
                            $filterprice = $categoryproduct['special'];
                        } else {
                            $filterprice = $categoryproduct['price'];
                        }
                        if ($filterprice >= $pricerange[0] && $filterprice <= $pricerange[1]) {
                            ++$total;
                        }
                    }
                    if ($pricerange[0] == 0) {
                        $label = $text_to.' '.$this->currency->format($pricerange[1], $this->session->data['currency']);
                    } else {
                        $label = $this->currency->format($pricerange[0], $this->session->data['currency']).' '.$separator.' '.$this->currency->format($pricerange[1], $this->session->data['currency']);
                    }
                    $data['pricefilters'][] = array(
                                            'pricefilter' => $pricerange[0].'-'.$pricerange[1],
                                            'label' => $label,
                                            'total' => $total,
                                            );
                }
            } else {
                $priceranges = $this->config->get('pricefilter');
                foreach ($priceranges as $pricerange) {
                    $total = 0;
                    foreach ($categoryproducts as $categoryproduct) {
                        if (!empty($categoryproduct['special'])) {
                            $filterprice = $categoryproduct['special'];
                        } else {
                            $filterprice = $categoryproduct['price'];
                        }
                        if ($filterprice >= $pricerange['startprice'] && $filterprice <= $pricerange['endprice']) {
                            ++$total;
                        }
                    }
                    if ($pricerange['startprice'] == 0) {
                        $label = $text_to.' '.$this->currency->format($pricerange['endprice'], $this->session->data['currency']);
                    } else {
                        $label = $this->currency->format($pricerange['startprice'], $this->session->data['currency']).' '.$separator.' '.$this->currency->format($pricerange['endprice'], $this->session->data['currency']);
                    }
                    $data['pricefilters'][] = array(
                                            'pricefilter' => $pricerange['startprice'].'-'.$pricerange['endprice'],
                                            'label' => $label,
                                            'total' => $total,
                                            );
                }
            }
        }
        if (!empty($data['pricefilters'])) {
            if (file_exists(DIR_TEMPLATE.$this->config->get('config_template').'/template/module/pricefilter.tpl')) {
                return $this->load->view($this->config->get('config_template').'/template/module/pricefilter.tpl', $data);
            } else {
                return $this->load->view('extension/module/pricefilter.tpl', $data);
            }
        }
    }
}
