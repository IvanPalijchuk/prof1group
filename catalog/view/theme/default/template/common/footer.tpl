<div class="container">
<div class="row">
<div class="nomer nomtri col xs-12 col-sm-12 col-md-12">

        <ul>
           <li><a href="<?php echo $contact; ?>"><i class="fa fa-phone1"><img src="/catalog/view/theme/default/image/mobile1.jpg"></i></a> 
            <a href="tel:(044)392-84-49"><span class="hidden-xs hidden-sm hidden-md">(  0  4  4  )    3  9  2  -  8   4  -  4  9 </span></a></li>
          <li><a href="<?php echo $contact; ?>"><i class="fa fa-phone1"><img src="/catalog/view/theme/default/image/Ikonka-MTS.png"></i></a> <a href="tel:+380668393660"><span class="hidden-xs hidden-sm hidden-md">(   0  6  6  )    8  3  9  -  3  6  -  6  0</span></a></li> 
          <li><a href="<?php echo $contact; ?>"><i class="fa fa-phone1"><img src="/catalog/view/theme/default/image/life.png"></i></a><a href="tel:+380933254690"><span class="hidden-xs hidden-sm hidden-md"> (  0  9  3  )    3  2  5  -  4  6  -   9  0</span></a></li>
          <li><a href="<?php echo $contact; ?>"><i class="fa fa-phone1"><img src="/catalog/view/theme/default/image/67696743.png"></i></a> <a href="tel:+380676595979"><span class="hidden-xs hidden-sm hidden-md"> (  0  6  7  )    6  5  9   -   5   9   -   7  9 </span></a></li>
          <li><a href="<?php echo $contact; ?>"><i class="fa fa-phone1">опт</i></a> <a href="tel:(044)392-84-50"><span class="hidden-xs hidden-sm hidden-md"> (   0  4   4   )      3   9   2   -   8   4  -  5  0</span></a></li>
          <?php if(!empty($h_work)){ ?>
         <li><span style="float: right; font-size: 10px;color:black;font-weight: inherit;letter-spacing:normal;"><?php echo $h_work; ?></span></li>
         <?php } ?>
        </ul>        
      </div>
</div></div>



<footer>
  <div class="container">
    <div class="row">
      <?php if ($informations) { ?>
      <div class="col-sm-3">
        <p class="title_h5"><?php echo $text_information; ?></p>
        <ul class="list-unstyled">
          <?php foreach ($informations as $information) { ?>
          <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
          <?php } ?>
        </ul>
      </div>
      <?php } ?>
      <!--<div class="col-sm-3">
        <h5><?php echo $text_service; ?></h5>
        <ul class="list-unstyled">
          <li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
          <li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
          <li><a href="<?php //echo $sitemap; ?>"><?php //echo $text_sitemap; ?></a></li>
        </ul>
      </div>-->
      <div class="col-sm-3">
        <p class="title_h5"><?php echo $text_discounts; ?></p>
        <ul class="list-unstyled">
          <li><a href="index.php?route=information/information&information_id=12"><?php echo $text_discount; ?></a></li>
          <li><a href="index.php?route=information/information&information_id=16"><?php echo $text_special; ?></a></li>
          <!--<li><a href="<?php echo $special; ?>"><?php echo $text_special; ?></a></li>-->
          <li><a href="/sales"><?php echo $text_sales; ?></a></li>
        </ul>
      </div>
      <div class="col-sm-3">
        <p class="title_h5"><?php echo $text_account; ?></p>
        <ul class="list-unstyled">
          <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
          <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
          <li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
          <li><a href="<?php //echo $newsletter; ?>"><?php //echo $text_newsletter; ?></a></li>
        </ul>
      </div>
      <div class="col-sm-3">
        <p class="title_h5"><?php echo $text_extra; ?></p>
        <ul class="list-unstyled">
          <li><a href="index.php?route=information/information&information_id=4"><?php echo $text_about; ?></a></li>
          <li><a href="index.php?route=information/contact"><?php echo $text_contact; ?></a></li>
        </ul>
      </div>
    </div>
    <hr>
    <div class="row">
      <?php if(isset($adress_store)&&!empty($adress_store)){ ?>
        <?php foreach($adress_store as $store){ ?>
        <div class="col-sm-6 col-md-3 col-lg-3">
          <p class="title_h5"><?php echo $store['name']; ?></p>
          <?php if(isset($store['adress']) && !empty($store['adress'])){ ?>
          <ul class="list-unstyled">
            <?php foreach($store['adress'] as $adr){ ?>
              <li><p><?php echo $adr; ?></p></li>
            <?php } ?>
          </ul>
          <?php } ?>
        </div> 
        <?php } ?>
      <?php } ?> 
      <?php if(isset($f_work)&&!empty($f_work)){ ?>
      <div class="col-xs-12">
         <p class="time__work"><?php echo $f_work; ?></p>
      </div>
      <?php } ?>
    </div>
    <hr>
    <p class="powered"><?php echo $powered; ?></p>
  </div>
</footer>

<!--
OpenCart is open source software and you are free to remove the powered by OpenCart if you want, but its generally accepted practise to make a small donation.
Please donate via PayPal to donate@opencart.com
//-->

<!-- Theme created by Welford Media for OpenCart 2.0 www.welfordmedia.co.uk -->

</body></html>