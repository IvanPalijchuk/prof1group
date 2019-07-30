<p class="title_h3"><?php echo $heading_title; ?></p> 
<div class="row">
  <?php foreach ($products as $product) { ?>
  <div class="product-layout col-lg-3 col-md-3 col-sm-6 col-xs-12">
    <div class="product-thumb transition">
      <div class="image"><?php if($product['sales'] == '1'){ ?><div class="rb-br"><img src="https://prof1group.ua/image/catalog/label/ribbon-sale.png"></div><?php } ?><a href="<?php echo $product['href']; ?>"><img id="image_f_<?php echo $product['product_id']; ?>" src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" class="img-responsive" /></a></div>
      <div class="caption">
                <!--витягуємо при наявності інші варіанти кольорів-->
                <?php if(isset($product['product_color_related'])&&!empty($product['product_color_related'])){ ?>  
                  <div class="product-color-l">
                    <?php foreach($product['product_color_related'] as $prc){ ?>
                      <div class="product-color__item">
                        <div class="product-color__choice">
                          <img src="<?php echo $prc['image']; ?>" data-nextproduct="<?php echo $prc['product_id']; ?>" data-id="<?php echo $product['product_id']; ?>" onclick="VariantF(this)">
                        </div>
                      </div>
                    <?php } ?>
                  </div>
                <?php } ?>
                <!--витягуємо при наявності інші варіанти кольорів-->                            
                <p class="title_h4 name_ptoduct_category" style="height: 100px;"><a href="<?php echo $product['href']; ?>" id="name_f_<?php echo $product['product_id']; ?>"><?php echo $product['name']; ?></a></p>                  
                
                <?php if ($product['price']) { ?>
                <p class="price" style="text-align: right;">
                  <?php if (!$product['special']) { ?>
                  <span id="price_f_<?php echo $product['product_id']; ?>" style="font-size: 20px;background-color: #eaeaea;font-weight: bold;"><?php echo $product['price']; ?></span>
                  <?php } else { ?>
                  <span style="font-size: 14px;color: red;padding-right: 20px;" class="price-old"><?php echo $product['price']; ?></span> <span id="price_f_<?php echo $product['product_id']; ?>" style="font-size: 20px;background-color: #eaeaea;font-weight: bold;" class="price-new"><?php echo $product['special']; ?></span> 
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
      <div class="button-group" id="butt_f_<?php echo $product['product_id']; ?>">
        <button type="button" onclick="cart.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-shopping-cart"></i> <span class="hidden-xs hidden-sm hidden-md"><?php echo $button_cart; ?></span></button>
        <button type="button" data-toggle="tooltip" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-heart"></i></button>
        <button type="button" data-toggle="tooltip" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-exchange"></i></button>
      </div>
    </div>
  </div>
  <?php } ?>
</div>
<script>
  $('.product-color-l').slick({
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
  function VariantF(e){
    var product_id_f = $(e).data('id');
    var next_product_f = $(e).data('nextproduct');
    var product_now_f = $("input[name='product_now_f_"+product_id_f+"']").val();
    //var data= ['product_id':next_product];
    $.ajax({
      url: 'index.php?route=product/category/AjaxNextProduct&product_id='+next_product_f,
      type: 'post',
      dataType: 'json',
      success: function(json) {
        $("#image_f_"+product_id_f).attr("src",json['image']);
        $("#price_f_"+product_id_f).text(json['price']);
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
          $("#sales_f_"+product_id_f).css('display', 'block');
        }else{
          $("#sales_f_"+product_id_f).css('display', 'none');
        }
        //console.log(json);
        //var text = '<button type="button" <?php if ($product['quantity'] == 0) { echo "disabled"; }?> onclick="cart.add("'+pr_id+'", "1");"><i class="fa fa-shopping-cart"></i> <span class="hidden-xs hidden-sm hidden-md">Купить</span></button><button type="button" data-toggle="tooltip" title="" onclick="wishlist.add("'+json['product_id']+'");"><i class="fa fa-heart"></i></button><button type="button" data-toggle="tooltip" title="" onclick="compare.add("'+json['product_id']+'");"><i class="fa fa-exchange"></i></button>';
        $('#butt_f_'+product_id_f).empty();
        $('#butt_f_'+product_id_f).append(text);
      }
    });
  }
  //JS функція яка повертає через AJAX запит нові параметри товара в залежності від вибраного варіанта
</script>