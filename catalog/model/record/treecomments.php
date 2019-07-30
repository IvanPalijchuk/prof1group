<?php
/* All rights reserved belong to the module, the module developers http://opencartadmin.com */
// https://opencartadmin.com © 2011-2019 All Rights Reserved
// Distribution, without the author's consent is prohibited
// Commercial license
class ModelRecordTreeComments extends Model
{
	public function getCommentsByMarkId($data = Array(), $mark = 'product_id', $settings_widget = array()) {
		if (!empty($data)) {

			if (SC_VERSION > 15) {
				$get_Customer_GroupId = 'getGroupId';
			} else {
				$get_Customer_GroupId = 'getCustomerGroupId';
			}
			$mark = $this->db->escape(strip_tags(html_entity_decode(str_replace('../', '', (string)$mark),  ENT_QUOTES, 'UTF-8')));

			if ($mark == 'product_id' || $mark == 'record_id') {
				if ($mark == 'product_id') {
					$prefix_table_main = 'review';
					$prefix_table_pr   = 'product';
					$p_price           = "p.price,";
				}
				if ($mark == 'record_id') {
					$prefix_table_main = 'comment';
					$prefix_table_pr   = 'record';
					$p_price           = "";
				}
			} else {
				return false;
			}
			if (!$this->registry->get('status_language')) {
				$sql_lang = " AND r.language_id = '" . (int) $this->config->get('config_language_id') . "'";
			} else {
				$sql_lang = "";
			}
			$settings_widget_hash = md5(serialize($settings_widget));
			if (isset($settings_widget['type_id']) && $settings_widget['type_id'] != '0') {
				$sql_type = " AND r.type_id = '" . (int) $settings_widget['type_id'] . "'";
			} else {
				$sql_type = "";
			}
			$mark_id    = $data[$mark];
			$start      = (int)$data['start'];
			$limit      = (int)$data['limit'];
			$cache_name = 'blog.comment.' . $this->db->escape($mark) . '.' . (int) $this->config->get('config_language_id') . "." . (int) $this->config->get('config_store_id') . "." . (int) $this->customer->$get_Customer_GroupId() . "." . $settings_widget_hash;
			$cdata      = $this->cache->get($cache_name);
			if (!isset($cdata[$mark_id])) {
				$sql_rf        = '';
				$sql_rf_select = "";
				$rf = $this->table_exists(DB_PREFIX . "review_fields"); {
					$sql_rf        = " LEFT JOIN " . DB_PREFIX . "review_fields r_f ON (r." . $this->db->escape($prefix_table_main) . "_id = r_f.review_id AND r_f.mark = '" . $this->db->escape($mark) . "' )";
					$sql_rf_select = "r_f.*,";
				}
				$sql_status         = " (" . implode($data['status'], ',') . ") ";
				$sql_product        = '';
				$sql_product_select = '';
				if (isset($this->request->get['product_id']) && $mark == 'product_id') {
					//$sql_product        = "LEFT JOIN " . DB_PREFIX . "order_product op ON (op.order_id = o.order_id AND op.product_id = '" . (int) $this->request->get['product_id'] . "')";
					//$sql_product_select = "op.product_id as buyproduct, ";

					$sql_product_select = "IF (r.customer_id > 0, (
SELECT o.order_id
FROM  `" . DB_PREFIX . "order` o
LEFT JOIN `" . DB_PREFIX . "order_product` op ON o.order_id = op.order_id
WHERE o.customer_id = r.customer_id AND op.product_id = '" . (int) $this->request->get['product_id'] . "' AND o.order_status_id IN " . $this->db->escape($sql_status) . "
LIMIT 1
), NULL) as buyproduct, ";


				}
				$sql = "
						SELECT
						p.". $this->db->escape($mark) . ",
						cu.avatar as avatar,

						IF (r.customer_id > 0, (
						SELECT o.order_id
						FROM  `" . DB_PREFIX . "order` o
						WHERE o.customer_id = r.customer_id AND o.order_status_id IN " . $this->db->escape($sql_status) . "
						LIMIT 1
						), NULL) as buy,

						" . $sql_product_select . "
						" . $sql_rf_select . "
						r.*,
						r." . $prefix_table_main . "_id as review_id, r." . $prefix_table_main . "_id as comment_id,
						p." . $mark . ", pd.name, " . $p_price . " p.image, r.date_added as date_added,
						r.date_added as date_added, r.date_added as date_available,
						(r.sorthex) as hsort

						FROM `" . DB_PREFIX . $prefix_table_main . "` r
						LEFT JOIN `" . DB_PREFIX . $prefix_table_pr . "` p ON (r." . $this->db->escape($mark) . " = p." . $this->db->escape($mark) . ")
						LEFT JOIN `" . DB_PREFIX . $prefix_table_pr . "_description` pd ON (p." . $this->db->escape($mark) . " = pd." . $this->db->escape($mark) . ")
						LEFT JOIN `" . DB_PREFIX . "customer` cu ON (r.customer_id = cu.customer_id)

						" . $sql_rf . "
						WHERE
						r." . $this->db->escape($mark) . " = '" . (int) $mark_id . "'
						AND p." . $this->db->escape($mark) . " = '" . (int) $mark_id . "'
						AND p.status = '1'
						AND r.status = '1'
						AND pd.language_id = '" . (int) $this->config->get('config_language_id') . "'
						" . $sql_lang . "
						" . $sql_type . "
				        GROUP by r." . $prefix_table_main . "_id
						";

				$query = $this->db->query($sql);

				if (!is_array($cdata)) {
					$cdata = array();
				}

				$cdata[$mark_id] = $query->rows;

				$this->cache->set($cache_name, $cdata);
				$res = $query->rows;
			} else {
				$res = $cdata[$mark_id];
			}
			return $res;
		} else {
			return false;
		}
	}

	public function getTotalCommentsByMarkId($mark_id, $mark = 'product_id', $settings_widget = array()) {
		$mark = $this->db->escape(strip_tags(html_entity_decode(str_replace('../', '', (string)$mark),  ENT_QUOTES, 'UTF-8')));

		if ($mark == 'product_id' || $mark == 'record_id') {
			if ($mark == 'product_id') {
				$prefix_table_main = 'review';
				$prefix_table_pr   = 'product';
			}
			if ($mark == 'record_id') {
				$prefix_table_main = 'comment';
				$prefix_table_pr   = 'record';
			}
		} else {
			return false;
		}
		if (!$this->registry->get('status_language')) {
			$sql_lang = " AND r.language_id = '" . (int) $this->config->get('config_language_id') . "'";
		} else {
			$sql_lang = "";
		}
		if (isset($settings_widget['type_id']) && $settings_widget['type_id'] != '0') {
			$sql_type = " AND r.type_id = '" . (int) $settings_widget['type_id'] . "'";
		} else {
			$sql_type = "";
		}
		$mark = $this->db->escape($mark);
		$sql   = "SELECT COUNT(*) AS total FROM " . DB_PREFIX . $prefix_table_main . " r
		LEFT JOIN " . DB_PREFIX . $prefix_table_pr . " p ON (r." . $mark . " = p." . $mark . ")
		LEFT JOIN " . DB_PREFIX . $prefix_table_pr . "_description pd ON (p." . $mark . " = pd." . $mark . ")
		WHERE
		r." . $mark . " = '" . (int) $mark_id . "'
		AND
		p." . $mark . " = '" . (int) $mark_id . "'
		AND p.status = '1'
		AND r.status = '1'
		AND pd.language_id = '" . (int) $this->config->get('config_language_id') . "' " . $sql_lang . $sql_type;
		$query = $this->db->query($sql);
		return $query->row['total'];
	}

	public function getRatesByMarkId($mark_id, $customer_id, $mark = 'product_id') {
		$mark = $this->db->escape(strip_tags(html_entity_decode(str_replace('../', '', (string)$mark),  ENT_QUOTES, 'UTF-8')));
		if ($mark == 'product_id' || $mark == 'record_id') {
			if ($mark == 'product_id') {
				$prefix_table_main = 'review';
				$prefix_table_pr   = 'product';
			}
			if ($mark == 'record_id') {
				$prefix_table_main = 'comment';
				$prefix_table_pr   = 'record';
			}
			$mark = $this->db->escape($mark);
		} else {
			return false;
		}
		$sql   = "
			SELECT
				rc.*,
				rc." . $prefix_table_main . "_id as cid,
				rc." . $prefix_table_main . "_id as review_id,
                IF ((SELECT urc.delta  FROM " . DB_PREFIX . "rate_" . $prefix_table_main . " urc WHERE urc.customer_id = '" . (int) $customer_id . "' AND urc." . $prefix_table_main . "_id = rc." . $prefix_table_main . "_id LIMIT 1)  < 0, -1 ,
                IF ((SELECT urc.delta  FROM " . DB_PREFIX . "rate_" . $prefix_table_main . " urc WHERE urc.customer_id = '" . (int) $customer_id . "' AND urc." . $prefix_table_main . "_id = rc." . $prefix_table_main . "_id LIMIT 1)  > 0, 1 ,  0 ) ) as customer_delta ,
      			COUNT(rc." . $prefix_table_main . "_id) as rate_count,
				SUM(rc.delta) as rate_delta,
				SUM(rc.delta > 0) as rate_delta_blog_plus,
				SUM(rc.delta < 0) as rate_delta_blog_minus
			   FROM
			     " . DB_PREFIX . "rate_" . $prefix_table_main . " rc
			   LEFT JOIN " . DB_PREFIX . $prefix_table_main . " c on (rc." . $prefix_table_main . "_id = c." . $prefix_table_main . "_id)
			   LEFT JOIN " . DB_PREFIX . $prefix_table_pr . " r on (r." . $mark . " = c." . $mark . ")
			   LEFT JOIN " . DB_PREFIX . $prefix_table_pr . "_description pd ON (r." . $mark . " = pd." . $mark . ")
			WHERE
				r." . $mark . "= " . (int) $mark_id . "
				AND r.status = '1'
				AND c.status = '1'
				AND pd.language_id = '" . (int) $this->config->get('config_language_id') . "'

			GROUP BY rc." . $prefix_table_main . "_id
			   ";
		$query = $this->db->query($sql);
		if (count($query->rows) > 0) {
			foreach ($query->rows as $rates) {
				$rate[$rates['cid']] = $rates;
			}
			return $rate;
		}
	}

	public function getRatesByCommentId($review_id, $mark = 'product_id', $all = false) {
		$mark = $this->db->escape(strip_tags(html_entity_decode(str_replace('../', '', (string)$mark),  ENT_QUOTES, 'UTF-8')));

		if ($mark == 'product_id' || $mark == 'record_id') {
			if ($mark == 'product_id') {
				$prefix_table_main = 'review';
				$prefix_table_pr   = 'product';
			}
			if ($mark == 'record_id') {
				$prefix_table_main = 'comment';
				$prefix_table_pr   = 'record';
			}
			$mark = $this->db->escape($mark);
		} else {
			return false;
		}
		if (!$all) {
			$group       = "GROUP BY rc." . $prefix_table_main . "_id";
			$sql_counter = ",
				rc." . $prefix_table_main . "_id as cid,
				rc." . $prefix_table_main . "_id as review_id,
				COUNT(rc." . $prefix_table_main . "_id) as rate_count,
				SUM(rc.delta) as rate_delta,
				SUM(rc.delta > 0) as rate_delta_blog_plus,
				SUM(rc.delta < 0) as rate_delta_blog_minus";
		} else {
			$group       = "";
			$sql_counter = "";
		}
		$sql   = "
			  SELECT
				rc.*
				" . $sql_counter . "
			   FROM
			     " . DB_PREFIX . "rate_" . $prefix_table_main . " rc
			   WHERE
			     rc." . $prefix_table_main . "_id= " . (int) $review_id . "
			    " . $group . "
			   ";
		$query = $this->db->query($sql);
		if (count($query->rows) > 0) {
			foreach ($query->rows as $rates) {
				if (!$all) {
					$rate[$rates['cid']] = $rates;
				} else {
					$rate[] = $rates;
				}
			}
		}
		return $query->rows;
	}

	public function addComment($mark_id, $data, $data_get, $mark = 'product_id') {
		$mark = $this->db->escape(strip_tags(html_entity_decode(str_replace('../', '', (string)$mark),  ENT_QUOTES, 'UTF-8')));

		if ($mark == 'product_id' || $mark == 'record_id') {
			if ($mark == 'product_id') {
				$prefix_table_main = 'review';
				$prefix_table_pr   = 'product';
			}
			if ($mark == 'record_id') {
				$prefix_table_main = 'comment';
				$prefix_table_pr   = 'record';
			}
			if (isset($data_get['parent'])) {
				$parent_id = (int)$data_get['parent'];
			} else {
				$parent_id = 0;
			}
			$mark = $this->db->escape($mark);
		} else {
			return false;
		}

		if (isset($data_get['cmswidget'])) {
			$ascp_widgets = $this->config->get('ascp_widgets');
			$cmswidget_settings = $ascp_widgets[(int)$data_get['cmswidget']];
		} else {
			$cmswidget_settings = array();
		}
		if (isset($cmswidget_settings['type_id'])) {
			if ($cmswidget_settings['type_id'] == 0) {
				$type_id = 1;
			} else {
				$type_id = (int)$cmswidget_settings['type_id'];
			}
		} else {
			$type_id = 1;
		}
		$sql   = "
		SELECT r.*, p.*, pp.sorthex as sorthex_parent
		FROM " . DB_PREFIX . $prefix_table_main . " r
		LEFT JOIN " . DB_PREFIX . $prefix_table_pr . " p ON (r." . $mark . " = p." . $mark . ")
		LEFT JOIN " . DB_PREFIX . $prefix_table_pr . "_description pd ON (p." . $mark . " = pd." . $mark . ")
		LEFT JOIN " . DB_PREFIX . $prefix_table_main . " pp ON (r.parent_id = pp." . $prefix_table_main . "_id)
		WHERE p." . $mark . " = '" . (int) $mark_id . "'
		AND r.parent_id = '" . (int) $parent_id . "'
		AND pd.language_id = '" . (int) $this->config->get('config_language_id') . "'
		ORDER BY r.sorthex DESC
		LIMIT 1";
		$query = $this->db->query($sql);
		if (count($query->rows) > 0) {
			foreach ($query->rows as $review) {
				$sorthex        = $review['sorthex'];
				$sorthex_parent = $review['sorthex_parent'];
				$sorthex        = substr($sorthex, strlen($sorthex_parent), 4);
			}
			$sorthex = $sorthex_parent . (str_pad(dechex($sortdec = hexdec($sorthex) + 1), 4, "0", STR_PAD_LEFT));
		} else {
			if ($parent_id == 0) {
				$sorthex = '0000';
			} else {
				$queryparent = $this->db->query("
				SELECT c.sorthex
				FROM " . DB_PREFIX . $prefix_table_main . " c
				WHERE c." . $prefix_table_main . "_id = '" . (int) $parent_id . "'
				ORDER BY c.sorthex DESC
				LIMIT 1");
				if (count($queryparent->rows) > 0) {
					foreach ($queryparent->rows as $parent) {
						$sorthex = $parent['sorthex'];
					}
					$sorthex = $sorthex . "0000";
				}
			}
		}
		if (!isset($data['text'])) {
			$data['text'] = '';
		}
		if (!$this->customer->getId()) {
			$customer_id = false;
		} else {
			$customer_id = (int)$this->customer->getId();
		}
		$sql = "INSERT INTO " . DB_PREFIX . $prefix_table_main . " SET
		author = '" . $this->db->escape(strip_tags(html_entity_decode(str_replace('../', '', (string)$data['name']),  ENT_QUOTES, 'UTF-8'))) . "',
		customer_id = '" . (int) $customer_id . "',
		" . $mark . " = '" . (int) $mark_id . "',
		sorthex   = '" . $this->db->escape($sorthex) . "',
		parent_id = '" . (int) $parent_id . "',
		text = '" . $this->db->escape(strip_tags(html_entity_decode(str_replace('../', '', (string)$this->db->escape($data['text'])))), ENT_COMPAT, 'UTF-8') . "',
		status = '" . (int) $data['status'] . "',
		language_id = '" . (int) $this->config->get('config_language_id') . "',
		type_id = '" . (int) $type_id . "',
		cmswidget = '" . (int) $this->request->post['cmswidget'] . "',
		rating = '" . (int) $data['rating'] . "',
		rating_mark = '" . (int) $data['rating_mark'] . "',
		date_added = NOW()";

		$this->db->query($sql);
		$review_id = $this->db->getLastId();
		$sql_add   = "";

		if (isset($data['af'])) {
			foreach ($data['af'] as $num => $value) {
                $num = $this->db->escape(strip_tags(html_entity_decode(str_replace('../', '', $num),  ENT_QUOTES, 'UTF-8')));
                $value = $this->db->escape(strip_tags(html_entity_decode(str_replace('../', '', $value),  ENT_QUOTES, 'UTF-8')));
				$data['af'][$num] = $value;
			}

			$af_bool = $this->table_exists(DB_PREFIX . "review_fields");
			if ($af_bool) {
				foreach ($data['af'] as $num => $value) {
					if ($value != '') {
						$sql_add .= " " . $this->db->escape(strip_tags(html_entity_decode(str_replace('../', '', (string)$num),  ENT_QUOTES, 'UTF-8'))) . " = '" . $this->db->escape(strip_tags(html_entity_decode(str_replace('../', '', (string)$value),  ENT_QUOTES, 'UTF-8'))) . "',";
					}
				}
				if ($sql_add != "") {
					$sql = "INSERT INTO " . DB_PREFIX . "review_fields SET " . $sql_add . " review_id='" . (int) $review_id . "', mark='" . $mark . "' ";
					$this->db->query($sql);
				}
			}
		}

		$this->cache->delete('product');
		$this->cache->delete('blog');
		$this->cache->delete('blog.comment');

		return $review_id;
	}

	public function checkRate($data = array(), $mark = 'product_id') {
		$mark = $this->db->escape(strip_tags(html_entity_decode(str_replace('../', '', (string)$mark),  ENT_QUOTES, 'UTF-8')));
		if ($data['customer_id']) {
			if ($mark == 'product_id' || $mark == 'record_id') {
				if ($mark == 'product_id') {
					$prefix_table_main = 'review';
					$prefix_table_pr   = 'product';
				}
				if ($mark == 'record_id') {
					$prefix_table_main = 'comment';
					$prefix_table_pr   = 'record';
				}
			} else {
			return false;
			}
			$sql   = "SELECT * FROM  " . DB_PREFIX . "rate_" . $prefix_table_main . " rc
		WHERE
		customer_id = '" . (int) $data['customer_id'] . "'
		AND
		" . $prefix_table_main . "_id = '" . (int) $data['comment_id'] . "'
		LIMIT 1";
			$query = $this->db->query($sql);
			return $query->rows;
		} else {
			return false;
		}
	}

	public function getCommentSelf($data = array(), $mark = 'product_id') {
		$mark = $this->db->escape(strip_tags(html_entity_decode(str_replace('../', '', (string)$mark),  ENT_QUOTES, 'UTF-8')));
		if ($data['customer_id']) {
			if ($mark == 'product_id' || $mark == 'record_id') {
				if ($mark == 'product_id') {
					$prefix_table_main = 'review';
					$prefix_table_pr   = 'product';
				}
				if ($mark == 'record_id') {
					$prefix_table_main = 'comment';
					$prefix_table_pr   = 'record';
				}
			} else {
				return false;
			}
			$sql   = "SELECT * FROM  " . DB_PREFIX . $prefix_table_main . " c
			WHERE
			c.customer_id = '" . (int) $data['customer_id'] . "'
			AND
			" . $prefix_table_main . "_id = '" . (int) $data['comment_id'] . "'
			";
			$query = $this->db->query($sql);
			return $query->rows;
		} else {
			return false;
		}
	}

	public function getCategory($category_id, $mark = 'product_id') {
		$mark = $this->db->escape(strip_tags(html_entity_decode(str_replace('../', '', (string)$mark),  ENT_QUOTES, 'UTF-8')));
		if ($mark == 'product_id' || $mark == 'record_id') {
			if ($mark == 'product_id') {
				$prefix_table_main = 'category';
				$prefix_table_pr   = 'category_id';
			}
			if ($mark == 'record_id') {
				$prefix_table_main = 'blog';
				$prefix_table_pr   = 'blog_id';
			}
		} else {
			return false;
		}
        $category_id = (int)$category_id;
		$cache_file ='blog.category.' . $mark . '.'.(int)$this->config->get('config_language_id').'.'.(int)$this->config->get('config_store_id').'.cati';

		$row = $this->cache->get($cache_file);
		if (!isset($row[$category_id])) {

			$query = $this->db->query("
			SELECT DISTINCT * FROM " . DB_PREFIX . $prefix_table_main . " c
			LEFT JOIN " . DB_PREFIX . $prefix_table_main . "_description cd ON (c." . $prefix_table_pr . " = cd." . $prefix_table_pr . ")
			LEFT JOIN " . DB_PREFIX . $prefix_table_main . "_to_store c2s ON (c." . $prefix_table_pr . " = c2s." . $prefix_table_pr . ")
			WHERE
			c." . $prefix_table_pr . " = '" . (int) $category_id . "'
			AND
			cd.language_id = '" . (int) $this->config->get('config_language_id') . "'
			AND
			c2s.store_id = '" . (int) $this->config->get('config_store_id') . "'
			AND
			c.status = '1'
			");

			if (!is_array($row)) {
				$row = array();
			}

			if (!is_array($row)) {
				$row = array();
			}
			$row[$category_id] = $query->row;
			$this->cache->set($cache_file, $row[$category_id]);
		}
		return $row[$category_id];
	}

	public function checkRateNum($data = array(), $mark = 'product_id') {
		$mark = $this->db->escape(strip_tags(html_entity_decode(str_replace('../', '', (string)$mark),  ENT_QUOTES, 'UTF-8')));
		if ($mark == 'product_id' || $mark == 'record_id') {
			if ($mark == 'product_id') {
				$prefix_table_main = 'review';
				$prefix_table_pr   = 'product';
			}
			if ($mark == 'record_id') {
				$prefix_table_main = 'comment';
				$prefix_table_pr   = 'record';
			}
		} else {
			return false;
		}
		$sql               = "SELECT *,
        COUNT(c." . $prefix_table_pr . "_id) as rating_num
		FROM  " . DB_PREFIX . $prefix_table_main . " c
		LEFT JOIN " . DB_PREFIX . "rate_" . $prefix_table_main . " rc ON (rc." . $prefix_table_main . "_id = c." . $prefix_table_main . "_id)
		WHERE
		rc.customer_id = '" . (int) $data['customer_id'] . "'
		AND
		c." . $prefix_table_pr . "_id = '" . (int) $data[$prefix_table_pr . '_id'] . "'
		GROUP BY c." . $prefix_table_pr . "_id
		LIMIT 1";
		$query             = $this->db->query($sql);
		$query->row['sql'] = $sql;
		return $query->row;
	}

	public function getMarkbyComment($data = array(), $mark = 'product_id') {
		$mark = $this->db->escape(strip_tags(html_entity_decode(str_replace('../', '', (string)$mark),  ENT_QUOTES, 'UTF-8')));
		if ($mark == 'product_id' || $mark == 'record_id') {
			if ($mark == 'product_id') {
				$prefix_table_main = 'review';
				$prefix_table_pr   = 'product';
			} else {
				$prefix_table_main = 'comment';
				$prefix_table_pr   = 'record';
				$mark              = 'record_id';
			}
		} else {
			return false;
		}
		$sql               = "SELECT c." . $mark . " as " . $mark . ", c." . $mark . " as product_id
		FROM  " . DB_PREFIX . $prefix_table_main . " c
		WHERE
		c." . $prefix_table_main . "_id = '" . (int) $data['comment_id'] . "'
		LIMIT 1";
		$query             = $this->db->query($sql);
		$query->row['sql'] = $sql;
		return $query->row;
	}

	public function addRate($data = array(), $mark = 'product_id') {
		$mark = $this->db->escape(strip_tags(html_entity_decode(str_replace('../', '', (string)$mark),  ENT_QUOTES, 'UTF-8')));
		if ($mark == 'product_id' || $mark == 'record_id') {
			if ($mark == 'product_id') {
				$prefix_table_main = 'review';
				$prefix_table_pr   = 'product';
			}
			if ($mark == 'record_id') {
				$prefix_table_main = 'comment';
				$prefix_table_pr   = 'record';
			}
		} else {
			return false;
		}
		$sql   = "INSERT INTO " . DB_PREFIX . "rate_" . $prefix_table_main . " SET
		customer_id = '" . (int) $data['customer_id'] . "',
		" . $prefix_table_main . "_id = '" . (int) $data['comment_id'] . "',
		delta = '" . (int) $data['delta'] . "' ";
		$query = $this->db->query($sql);
		$this->cache->delete('product');
		$this->cache->delete('blog');
		return $sql;
	}

	public function getAverageRating($mark_id, $mark = 'product_id', $settings_widget = array()) {
		$mark = $this->db->escape(strip_tags(html_entity_decode(str_replace('../', '', (string)$mark),  ENT_QUOTES, 'UTF-8')));
		if ($mark == 'product_id' || $mark == 'record_id') {
			if ($mark == 'product_id') {
				$prefix_table_main = 'review';
				$prefix_table_pr   = 'product';
			}
			if ($mark == 'record_id') {
				$prefix_table_main = 'comment';
				$prefix_table_pr   = 'record';
			}
		} else {
			return false;
		}
		if (!$this->registry->get('status_language')) {
			$sql_lang = " AND language_id = '" . (int) $this->config->get('config_language_id') . "'";
		} else {
			$sql_lang = "";
		}
		if (isset($settings_widget['type_id']) && $settings_widget['type_id'] != '0') {
			$sql_type = " AND r.type_id = '" . (int) $settings_widget['type_id'] . "'";
		} else {
			$sql_type = "";
		}
		$query = $this->db->query("SELECT AVG(rating) AS total FROM " . DB_PREFIX . $prefix_table_main . "
		WHERE status = '1' AND rating_mark = '0' AND " . $mark . " = '" . (int) $mark_id . "'
		" . $sql_lang . "
		" . $sql_type . "
		GROUP BY " . $mark . "");
		if (isset($query->row['total'])) {
			return round($query->row['total']);
		} else {
			return 0;
		}
	}

	public function getTotalComments($mark = 'product_id', $settings_widget = array()) {
		$mark = $this->db->escape(strip_tags(html_entity_decode(str_replace('../', '', (string)$mark),  ENT_QUOTES, 'UTF-8')));

		if ($mark == 'product_id' || $mark == 'record_id') {
			if ($mark == 'product_id') {
				$prefix_table_main = 'review';
				$prefix_table_pr   = 'product';
			}
			if ($mark == 'record_id') {
				$prefix_table_main = 'comment';
				$prefix_table_pr   = 'record';
			}
		} else {
			return false;
		}
		if (!$this->registry->get('status_language')) {
			$sql_lang = " AND language_id = '" . (int) $this->config->get('config_language_id') . "'";
		} else {
			$sql_lang = "";
		}
		if (isset($settings_widget['type_id']) && $settings_widget['type_id'] != '0') {
			$sql_type = " AND r.type_id = '" . (int) $settings_widget['type_id'] . "'";
		} else {
			$sql_type = "";
		}
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . $prefix_table_main . " r
		LEFT JOIN " . DB_PREFIX . $prefix_table_pr . " p ON (r." . $mark . " = p." . $mark . ")
		WHERE p.date_available <= NOW() AND p.status = '1' AND r.status = '1' " . $sql_lang . $sql_type);
		return $query->row['total'];
	}

	public function table_exists($tableName) {
		$like   = addcslashes($tableName, '%_\\');
		$result = $this->db->query("SHOW TABLES LIKE '" . $this->db->escape($like) . "';");
		$found  = $result->num_rows > 0;
		return $found;
	}
	public function field_exists($tableName, $field) {
		$r = $this->db->query("SELECT `" . $this->db->escape($field) . "` FROM `" . DB_PREFIX . $this->db->escape($tableName) . "` WHERE 0");
		return $r;
	}
}