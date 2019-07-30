<h3><?php echo $heading_title; ?></h3>
<div class="row">
  <?php foreach ($products as $product) { ?>
  <div class="product-layout col-lg-3 col-md-3 col-sm-6 col-xs-12">

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
			
    <div class="product-thumb transition">
      
                <div class="image">
                <?php if($product['labels']) { ?>
                <?php foreach ($product['labels'] as $label) { ?>
                <div class="<?php echo $label['position']; ?>"><img src="<?php echo HTTP_SERVER.'image/'.$label['image']; ?>"></div>
                <?php } ?>
                <?php } ?>
                <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" class="img-responsive" /></a></div>
      <div class="caption">
        <h4><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
        <p><?php echo $product['description']; ?></p>
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
        <?php } ?>
        <?php if ($product['price']) { ?>
        <p class="price">
          <?php if (!$product['special']) { ?>
          <?php echo $product['price']; ?>
          <?php } else { ?>
          <span class="price-new"><?php echo $product['special']; ?></span> <span class="price-old"><?php echo $product['price']; ?></span>
          <?php } ?>
          <?php if ($product['tax']) { ?>
          <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
          <?php } ?>
        </p>
        <?php } ?>
      </div>
      <div class="button-group">
        <button type="button" onclick="cart.add('<?php echo $product['product_id']; ?>');" 
							<?php
					        if ($product['quantity']>0) echo "><i class='fa fa-shopping-cart'></i> <span class='hidden-xs hidden-sm hidden-md'>$button_cart</span></button>";
					        else echo "disabled><i class='fa fa-ban' aria-hidden='true'></i> <span class='hidden-xs hidden-sm hidden-md'>$button_not</span></button>";
					        ?>
		      
        <button type="button" data-toggle="tooltip" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-heart"></i></button>
        <button type="button" data-toggle="tooltip" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-exchange"></i></button>
      </div>
    </div>
  </div>
  <?php } ?>
</div>
