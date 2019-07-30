<?php echo $header; ?>
<?php
  echo "<script type=\"application/ld+json\">";
      echo "{";
      echo "\"@context\": \"http://schema.org/\",";
      echo "\"@type\": \"BreadcrumbList\",";
      echo "\"itemListElement\": [";
      $i = 1;
      foreach($products as $product){
          echo "{";
              echo "\"@type\": \"ListItem\",";
              echo "\"position\": \"".$i."\",";
              echo "\"item\": {";
                  echo "\"@id\": \"".$product['href']."\",";
                  $name = str_replace('\x07', '', $product['name']);
                  $name = str_replace('\x07', '', $name);
                  $name = str_replace("\x07", '', $name);
                  $name = str_replace(array('/', '\\'), '', $name);                  
                  echo "\"name\": \"".$name."\",";
                  echo "\"image\": \"".$product['thumb']."\"";
              echo "}";
          if($i == count($products)){
              echo "}";
          }else{
              echo "},";
          }
          $i++;
      }
      echo "]";
      echo "}";
  echo "</script>";
  ?>
<div class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
      <h1><?php echo $heading_title; ?></h1>
      <?php if ($thumb || $description) { ?>
      <div class="row">
        <?php if ($thumb) { ?>
        <div class="col-sm-2"><img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" class="img-thumbnail" /></div>
        <?php } ?>
        <?php if ($description) { ?>
        <div class="col-sm-10"><?php echo $description; ?></div>
        <?php } ?>
      </div>
      <hr>
      <?php } ?>
      <?php if ($categories) { ?>
      <h3><?php echo $text_refine; ?></h3>
      <?php if (count($categories) <= 5) { ?>
      <div class="row">
        <div class="col-sm-3">
          <ul>
            <?php foreach ($categories as $category) { ?>
            <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
            <?php } ?>
          </ul>
        </div>
      </div>
      <?php } else { ?>
      <div class="row">
        <?php foreach (array_chunk($categories, ceil(count($categories) / 4)) as $categories) { ?>
        <div class="col-sm-3">
          <ul>
            <?php foreach ($categories as $category) { ?>
            <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
            <?php } ?>
          </ul>
        </div>
        <?php } ?>
      </div>
      <?php } ?>
      <?php } ?>
      <?php if ($products) { ?>
      <div class="row">
        <div class="col-md-2 col-sm-6 hidden-xs">
          <div class="btn-group btn-group-sm">
            <button type="button" id="list-view" class="btn btn-default" data-toggle="tooltip" title="<?php echo $button_list; ?>"><i class="fa fa-th-list"></i></button>
            <button type="button" id="grid-view" class="btn btn-default" data-toggle="tooltip" title="<?php echo $button_grid; ?>"><i class="fa fa-th"></i></button>
          </div>
        </div>
        <div class="col-md-3 col-sm-6">
          <div class="form-group">
            <a href="<?php echo $compare; ?>" id="compare-total" class="btn btn-link"><?php echo $text_compare; ?></a>
          </div>
        </div>
        <div class="col-md-4 col-xs-6">
          <div class="form-group input-group input-group-sm">
            <label class="input-group-addon" for="input-sort"><?php echo $text_sort; ?></label>
            <select id="input-sort" class="form-control" onchange="location = this.value;">
              <?php foreach ($sorts as $sorts) { ?>
              <?php if ($sorts['value'] == $sort . '-' . $order) { ?>
              <option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
              <?php } else { ?>
              <option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
              <?php } ?>
              <?php } ?>
            </select>
          </div>
        </div>
        <div class="col-md-3 col-xs-6">
          <div class="form-group input-group input-group-sm">
            <label class="input-group-addon" for="input-limit"><?php echo $text_limit; ?></label>
            <select id="input-limit" class="form-control" onchange="location = this.value;">
              <?php foreach ($limits as $limits) { ?>
              <?php if ($limits['value'] == $limit) { ?>
              <option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
              <?php } else { ?>
              <option value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
              <?php } ?>
              <?php } ?>
            </select>
          </div>
        </div>
      </div>
      <div class="row">
        <?php foreach ($products as $product) { ?>
        <div class="product-layout product-list col-xs-12">

				<!-- Label For Specials -->
				<?php if($label_for_specials_status && $product['special'] && $product['discount_card'] == '0'){ ?>
					<?php
						if($product['dc_special_percent'] && $label_for_specials_label_type == 'percent'){
							echo '<div class="dc-label-for-specials">-' . $product['dc_special_percent'] . '%</div>';
						} else if($product['dc_special_amount'] && $label_for_specials_label_type == 'amount'){
							echo '<div class="dc-label-for-specials">-' . $product['dc_special_amount'] . '</div>';
						} else if($product['dc_special_text']) {
							echo '<div class="dc-label-for-specials">' . $product['dc_special_text'] . '</div>';
						}
					?>
				<?php } ?>
				<!-- Label For Specials -->
			
          <div class="product-thumb <?php if ($product['quantity'] == 0) { echo " ara-absent"; }?>">
            <input type="hidden" name="product_val" value="<?php echo $product['product_id']; ?>">
            <input type="hidden" name="product_now_<?php echo $product['product_id']; ?>" value="<?php echo $product['product_id']; ?>">
            
                <div class="image">
                <?php if($product['labels']) { ?>
                <?php foreach ($product['labels'] as $label) { ?>
                <div class="<?php echo $label['position']; ?>"><img src="<?php echo HTTP_SERVER.'image/'.$label['image']; ?>"></div>
                <?php } ?>
                <?php } ?>
                <?php if($product['sales'] == '1'){ ?><div class="rb-br"><img src="https://prof1group.ua/image/catalog/label/ribbon-sale.png"></div><?php } ?><a href="<?php echo $product['href']; ?>"><img id="image_<?php echo $product['product_id']; ?>" src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" class="img-responsive" /></a></div>
            <div>
              <div class="caption">
                <!--витягуємо при наявності інші варіанти кольорів-->
                <?php if(isset($product['product_color_related'])&&!empty($product['product_color_related'])){ ?>  
                <input type="hidden" name="product_val" value="<?php echo $product['product_id']; ?>">
                <input type="hidden" name="product_now_<?php echo $product['product_id']; ?>" value="<?php echo $product['product_id']; ?>">
                  <div class="product-color">
                    <?php foreach($product['product_color_related'] as $prc){ ?>
                      <div class="product-color__item">
                        <div class="product-color__choice">
                          <img src="<?php echo $prc['image']; ?>" data-nextproduct="<?php echo $prc['product_id']; ?>" data-id="<?php echo $product['product_id']; ?>" onclick="Variant(this)">
                        </div>
                      </div>
                    <?php } ?>
                  </div>
                <?php } ?>
                <!--витягуємо при наявності інші варіанти кольорів-->                            
                <p class="title_h4 name_ptoduct_category" style="height: 100px;"><a href="<?php echo $product['href']; ?>" id="name_<?php echo $product['product_id']; ?>"><?php echo $product['name']; ?></a></p>                 
                <?php if ($product['price']) { ?>
                <p class="price" style="text-align: right;">
                  <?php if (!$product['special']) { ?>
                  <span id="price_<?php echo $product['product_id']; ?>" style="font-size: 20px;background-color: #eaeaea;font-weight: bold;"><?php echo $product['price']; ?></span>
                  <?php } else { ?>
                  <span style="font-size: 14px;color: red;padding-right: 20px;" class="price-old"><?php echo $product['price']; ?></span> <span id="price_<?php echo $product['product_id']; ?>" style="font-size: 20px;background-color: #eaeaea;font-weight: bold;" class="price-new"><?php echo $product['special']; ?></span> 
                  <?php } ?>
                  <?php if ($product['tax']) { ?>
                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
                  <?php } ?>
                </p>
                <?php } ?>
                <?php if ($product['rating']) { ?>
                <div class="rating">
                  <?php for ($i = 1; $i <= 5; $i++) { ?>
                  <?php if ($product['rating'] < $i) { ?>
                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
                  <?php } else { ?>
                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
                  <?php } ?>
                  <?php } ?>
                </div>
                <?php } else{ ?>
                  <span class="fa fa-stack"></span>
                <?php } ?>
              </div>
              <div class="button-group" id="butt_<?php echo $product['product_id']; ?>">
                <button type="button" <?php if ($product['quantity'] == 0) { echo "disabled"; }?> onclick="cart.add('<?php echo $product['product_id']; ?>', '<?php echo $product['minimum']; ?>');" 
							<?php
					        if ($product['quantity']>0) echo "><i class='fa fa-shopping-cart'></i> <span class='hidden-xs hidden-sm hidden-md'>$button_cart</span></button>";
					        else echo "disabled><i class='fa fa-ban' aria-hidden='true'></i> <span class='hidden-xs hidden-sm hidden-md'>$button_not</span></button>";
					        ?>
			
                <button type="button" data-toggle="tooltip" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-heart"></i></button>
                <button type="button" data-toggle="tooltip" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-exchange"></i></button>
              </div>
            </div>
          </div>
        </div>
        <?php } ?>
      </div>
      <div class="row">
        <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
        <div class="col-sm-6 text-right"><?php echo $results; ?></div>
      </div>
      <?php } ?>
      <?php if (!$categories && !$products) { ?>
      <p><?php echo $text_empty; ?></p>
      <div class="buttons">
        <div class="pull-right"><a href="<?php echo $continue; ?>" class="btn btn-primary"><?php echo $button_continue; ?></a></div>
      </div>
      <?php } ?>
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<script>
  $('.product-color').slick({
    swipeToSlide:false,
    slidesToShow: 5,
    slidesToScroll: 1,
    draggable:true,
    infinite: false,
    arrows: true,
     responsive: [
      {
        breakpoint: 992,
        settings: {
          slidesToShow: 4
          //slidesToScroll: 2
        }
      }
    ]
  });
  //JS функція яка повертає через AJAX запит нові параметри товара в залежності від вибраного варіанта
  function Variant(e){
    var product_id = $(e).data('id');
    var next_product = $(e).data('nextproduct');
    var product_now = $("input[name='product_now_"+product_id+"']").val();
    //var data= ['product_id':next_product];
    $.ajax({
      url: 'index.php?route=product/category/AjaxNextProduct&product_id='+next_product,
      type: 'post',
      dataType: 'json',
      success: function(json) {
        $("#image_"+product_id).attr("src",json['image']);
        $("#price_"+product_id).text(json['price']);
        var pr_id = json['product_id'].replace(/\s/g, '');
        var text = '';
        text += '<button type="button" ';
        tmp = 'onclick="cart.add('+pr_id+', 1)">';
        text += tmp.replace(/\s/g, '');
        text += '<i class="fa fa-shopping-cart"></i> <span class="hidden-xs hidden-sm hidden-md"><?php echo $button_cart; ?></span></button>';
        text += '<button type="button" data-toggle="tooltip" title="" '
        tmp = 'onclick="wishlist.add('+pr_id+');">';
        text += tmp.replace(/\s/g, '');
        text += '<i class="fa fa-heart"></i></button><button type="button" data-toggle="tooltip" title="" ';
        tmp = 'onclick="compare.add('+pr_id+');">';
        text += tmp.replace(/\s/g, '');
        text += '<i class="fa fa-exchange"></i></button>';
        if(json['sales'] == 1){
          $("#sales_"+product_id).css('display', 'block');
        }else{
          $("#sales_"+product_id).css('display', 'none');
        }
        //console.log(json);
        //var text = '<button type="button" <?php if ($product['quantity'] == 0) { echo "disabled"; }?> onclick="cart.add("'+pr_id+'", "1");"><i class="fa fa-shopping-cart"></i> <span class="hidden-xs hidden-sm hidden-md">Купить</span></button><button type="button" data-toggle="tooltip" title="" onclick="wishlist.add("'+json['product_id']+'");"><i class="fa fa-heart"></i></button><button type="button" data-toggle="tooltip" title="" onclick="compare.add("'+json['product_id']+'");"><i class="fa fa-exchange"></i></button>';
        $('#butt_'+product_id).empty();
        $('#butt_'+product_id).append(text);
      }
    });
  }
  //JS функція яка повертає через AJAX запит нові параметри товара в залежності від вибраного варіанта
</script>
<?php echo $footer; ?>
