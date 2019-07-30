<?php
class ModelExtensionModulepricefilter extends Model
{
    public function getBrands($category_id)
    {
        $productsimplode = array();
        $query = $this->db->query('SELECT distinct(m.manufacturer_id) FROM '.DB_PREFIX.'product_to_category pc LEFT JOIN '.DB_PREFIX.'product p ON (p.product_id=pc.product_id) LEFT JOIN '.DB_PREFIX."manufacturer m ON (p.manufacturer_id=m.manufacturer_id) WHERE pc.category_id = '".(int) $category_id."'");

        foreach ($query->rows as $result) {
            $productsimplode[] = (int) $result['manufacturer_id'];
        }

        return $productsimplode;
    }

    public function getTotalProducts($brand_id, $category_id)
    {
        $query = $this->db->query('SELECT pc.product_id FROM '.DB_PREFIX.'product_to_category pc LEFT JOIN '.DB_PREFIX."product p ON (p.product_id=pc.product_id)  WHERE pc.category_id = '".(int) $category_id."' AND p.manufacturer_id = '".(int) $brand_id."'");

        return $query->num_rows;
    }
}
