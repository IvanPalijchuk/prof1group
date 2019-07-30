<div id="sс-<?php echo $module; ?>" class="sc-main <?php echo $sc_class; ?>">
  <?php if ($title) { ?>
  <div class="sc-heading">
    <h3><?php echo $title; ?></h3>
  </div>
  <?php } ?>
  <div class="<?php echo $items_carousel ? 'sc-carousel sc-theme' : 'sc-grid'; ?>">
    <?php foreach ($items as $item) { ?>
    <div class="item-container<?php echo $item['subitems'] ? ' parent-item' : ''; ?>">
      <div class="item-wrapper img-<?php echo $item_img_pos; ?>">
        <?php if ($item_heading && $item_img_pos == 'bottom') { ?>
        <div class="item-heading">
          <a href="<?php echo $item['href']; ?>">
            <?php echo $item['name']; ?>
            <?php if ($count_status && $item['count']) { ?>
            <span class="item-count"><?php echo $item['count']; ?></span>
            <?php } ?>
          </a>
        </div>
        <?php } ?>
        <?php if ($item_image) { ?>
        <div class="item-image">
          <a href="<?php echo $item['href']; ?>">
            <img src="<?php echo $item['thumb']; ?>" alt="<?php echo $item['name']; ?>">
          </a>
        </div>
        <?php } ?>
        <?php if ($item_heading && $item_img_pos !== 'bottom' || $item_desc || $item_btn) { ?>
        <div class="info-wrapper">
          <div class="item-info">
            <?php if ($item_heading && $item_img_pos !== 'bottom') { ?>
            <div class="item-heading">
              <a href="<?php echo $item['href']; ?>">
                <?php echo $item['name']; ?>
                <?php if ($count_status && $item['count']) { ?>
                <span class="item-count"><?php echo $item['count']; ?></span>
                <?php } ?>
              </a>
            </div>
            <?php } ?>
            <?php if ($item_desc && $item['item_sd']) { ?>
            <div class="item-description"><?php echo $item['item_sd']; ?></div>
            <?php } ?>
          </div>
          <?php if ($item_btn) { ?>
          <div class="item-btn">
            <a class="<?php echo $btn_class; ?>" href="<?php echo $item['href']; ?>"><?php echo $item_btn_text; ?></a>
          </div>
          <?php } ?>
        </div>
        <?php } ?>
        <?php if ($subitems_status && $item['subitems']) { ?>
        <div class="sc-child">
          <div class="sc-child-wrapper">
            <div class="sc-parent-info">
              <?php if ($description_status && $item['description']) { ?>
              <div class="sc-parent-title"> <a href="<?php echo $item['href']; ?>"><?php echo $item['name']; ?></a> </div>
              <div class="sc-parent-desc"><?php echo $item['description']; ?></div>
              <?php } ?>
            </div>
            <div class="<?php echo $subitems_carousel ? 'sc-carousel sc-theme' : 'subitem-wrapper'; ?>">
              <?php foreach ($item['subitems'] as $subitem) { ?>
              <div class="item-container">
                <div class="item-wrapper img-<?php echo $subitem_img_pos; ?>">
                  <?php if ($subitem_heading && $subitem_img_pos == 'bottom') { ?>
                  <div class="item-heading">
                    <a href="<?php echo $subitem['href']; ?>">
                      <?php echo $subitem['name']; ?>
                      <?php if ($count_status && $subitem['count']) { ?>
                      <span class="item-count"><?php echo $subitem['count']; ?></span>
                      <?php } ?>
                    </a>
                  </div>
                  <?php } ?>
                  <?php if ($subitem_image) { ?>
                  <div class="item-image">
                    <a href="<?php echo $subitem['href']; ?>">
                      <img src="<?php echo $subitem['thumb']; ?>" alt="<?php echo $subitem['name']; ?>">
                    </a>
                  </div>
                  <?php } ?>
                  <?php if ($subitem_heading && $subitem_img_pos !== 'bottom' || $subitem_desc || $subitem_btn) { ?>
                  <div class="info-wrapper">
                    <div class="item-info">
                      <?php if ($subitem_heading && $subitem_img_pos !== 'bottom') { ?>
                      <div class="item-heading">
                        <a href="<?php echo $subitem['href']; ?>">
                          <?php echo $subitem['name']; ?>
                          <?php if ($count_status && $subitem['count']) { ?>
                          <span class="item-count"><?php echo $subitem['count']; ?></span>
                          <?php } ?>
                        </a>
                      </div>
                      <?php } ?>
                      <?php if ($subitem_desc && $subitem['description']) { ?>
                      <div class="item-description"><?php echo $subitem['description']; ?></div>
                      <?php } ?>
                      <?php if ($products_by_item) { ?>
                      <?php if ($rating && $subitem['rating']) { ?>
                      <div class="rating">
                        <?php for ($i = 1; $i <= 5; $i++) { ?>
                        <?php if ($subitem['rating'] < $i) { ?>
                        <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
                        <?php } else { ?>
                        <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
                        <?php } ?>
                        <?php } ?>
                      </div>
                      <?php } ?>
                      <?php if ($price && $subitem['price']) { ?>
                      <p class="price">
                        <?php if (!$subitem['special']) { ?>
                        <?php echo $subitem['price']; ?>
                        <?php } else { ?>
                        <span class="price-new"><?php echo $subitem['special']; ?></span> <span class="price-old"><?php echo $subitem['price']; ?></span>
                        <?php } ?>
                      </p>
                      <?php } ?>
                      <?php } ?>
                    </div>
                    <?php if ($products_by_item && $cart) { ?>
                    <div class="item-btn">
                      <a class="<?php echo $cart_class; ?>" onclick="cart.add('<?php echo $subitem['product_id']; ?>');"><?php echo $cart_icon; ?>&nbsp; <span class="hidden-xs"><?php echo $button_cart; ?></span></a>
                    </div>
                    <?php } ?>
                    <?php if ($subitem_btn) { ?>
                    <div class="item-btn">
                      <a class="<?php echo $subbtn_class; ?>" href="<?php echo $subitem['href']; ?>"><?php echo $subitem_btn_text; ?></a>
                    </div>
                    <?php } ?>
                  </div>
                  <?php } ?>
                </div>
              </div>
              <?php } ?>
            </div>
          </div>
        </div>
        <?php } ?>
      </div>
    </div>
    <?php } ?>
  </div>
</div>
<script type="text/javascript"><!--
<?php if ($items_carousel) { ?>
  var itemscarousel = $('#sс-<?php echo $module; ?> > .sc-carousel');
  itemscarousel.sccCarousel({
      margin: <?php echo $item_margin; ?>,
      nav: <?php echo $items_nav; ?>,
      navText: ['<?php echo $items_prev_nav; ?>', '<?php echo $items_next_nav; ?>'],
      navSpeed: <?php echo $items_nav_speed; ?>,
      dots: <?php echo $items_dots; ?>,
      mouseDrag: <?php echo $items_drag; ?>,
      slideBy: 2,
      responsive: {0:{items:<?php echo $items_xs; ?>}, 768:{items:<?php echo $items_sm; ?>}, 992:{items:<?php echo $items_md; ?>}, 1200:{ items:<?php echo $items_lg; ?>}},
      onRefreshed : function(event) {
          var cw = itemscarousel.width();
          var scitem = $('#sс-<?php echo $module; ?> > .sc-carousel').find('.scc-stage').children();
          var itemscount = event.item.count;
          var size = event.page.size;

          if (itemscount < size) {
              scitem.parent().width(cw+<?php echo $item_margin; ?> + 'px');
              scitem.width(((cw+<?php echo $item_margin; ?>)-(itemscount*<?php echo $item_margin; ?>))/itemscount + 'px');
          }

          <?php if ($item_img_pos == 'top' || $item_img_pos == 'bottom') { ?>
              var iteminfo = scitem.find('.item-info').not('.sc-child .item-info');
          <?php } else { ?>
              var iteminfo = scitem.find('.item-wrapper').not('.sc-child .item-wrapper');
          <?php } ?>

          iteminfo.height('auto');
          var imh = 0;
          $(iteminfo).each(function() {
              imh = Math.max(imh, $(this).height());
          }).height(imh);

          <?php if ($item_img_pos == 'bottom') { ?>
              var heading = scitem.find('.item-heading').not('.sc-child .item-heading');
              heading.height('auto');
              var hmh = 0;
              $(heading).each(function() {
                  hmh = Math.max(hmh, $(this).height());
              }).height(hmh);
          <?php } ?>
      }
  });

  <?php if ($items_mousewheel) { ?>
    itemscarousel.on('mousewheel', '.scc-stage', function(e) {
      if (e.deltaY>0) {
        $(this).trigger('next.scc');
      } else {
        $(this).trigger('prev.scc');
      }
      e.preventDefault();
    });
  <?php } ?>

  <?php if ($subitems_status) { ?>
  <?php if ($subitems_carousel) { ?>
    $('#sс-<?php echo $module; ?>').append('<div class="sc-subitems-row"></div>');
    $('#sс-<?php echo $module; ?> .parent-item').each(function(i) {
      $(this).addClass('sc-toggle-'+(i+1)).find('.sc-child').addClass('sc-target-'+(i+1));
      $(this).find('a').not('.sc-child a, .item-btn a').attr('onclick','return false');
      var target = $('#sс-<?php echo $module; ?> .sc-target-'+(i+1));
      var subcarousel = $('#sс-<?php echo $module; ?> .sc-target-'+(i+1) + ' .sc-carousel');
      target.appendTo('#sс-<?php echo $module; ?> .sc-subitems-row');

      $('#sс-<?php echo $module; ?> .sc-toggle-'+(i+1)).find('a').not('.item-btn a').on('click', function() {
        if ($(subcarousel).is(':hidden')) {
            target.show();
            subcarousel.trigger('refresh.scc.carousel');
            target.hide();
        }
        $('#sс-<?php echo $module; ?> .sc-target-'+(i+1)).toggleClass('sc-target-open').animate({'opacity': 'toggle', 'height': 'toggle'}, 300).siblings('.sc-target-open').removeClass('sc-target-open').animate({'opacity': 'toggle', 'height': 'toggle'}, 300);
        $(this).closest('.item-wrapper').toggleClass('sc-toggle-active').closest('.scc-item').siblings().find('.sc-toggle-active').toggleClass('sc-toggle-active');
      });

      subcarousel.sccCarousel({
          margin: <?php echo $subitem_margin; ?>,
          nav: <?php echo $subitems_nav; ?>,
          navText: ['<?php echo $subitems_prev_nav; ?>', '<?php echo $subitems_next_nav; ?>'],
          navSpeed: <?php echo $subitems_nav_speed; ?>,
          dots: <?php echo $subitems_dots; ?>,
          slideBy: 2,
          mouseDrag: <?php echo $subitems_drag; ?>,
          responsive: {0:{items:<?php echo $subitems_xs; ?>}, 768:{items:<?php echo $subitems_sm; ?>}, 992:{items:<?php echo $subitems_md; ?>}, 1200:{ items:<?php echo $subitems_lg; ?>}},
          onRefreshed: function(event) {
            var cw = subcarousel.width();
            var scsubitem = subcarousel.find('.scc-stage').children();
            var subitemscount = event.item.count;
            var size = event.page.size;

            if (subitemscount < size) {
                scsubitem.parent().width(cw+<?php echo $subitem_margin; ?> + 'px');
                scsubitem.width(((cw+<?php echo $subitem_margin; ?>)-(subitemscount*<?php echo $subitem_margin; ?>))/subitemscount + 'px');
            }

            <?php if ($subitem_img_pos == 'top' || $subitem_img_pos == 'bottom') { ?>
              var subinfo = scsubitem.find('.item-info');
            <?php } else { ?>
              var subinfo = scsubitem.find('.item-wrapper');
            <?php } ?>

            subinfo.height('auto');
            var smh = 0;
            $(subinfo).each(function() {
                smh = Math.max(smh, $(this).height());
            }).height(smh);

            <?php if ($subitem_img_pos == 'bottom') { ?>
              var heading = scsubitem.find('.item-heading');
              heading.height('auto');
              var shmh = 0;
              $(heading).each(function() {
                shmh = Math.max(shmh, $(this).height());
              }).height(shmh);
            <?php } ?>
          }
      });

      <?php if ($subitems_mousewheel) { ?>
        subcarousel.on('mousewheel', '.scc-stage', function(e) {
          if (e.deltaY>0) {
            $(this).trigger('next.scc');
          } else {
            $(this).trigger('prev.scc');
          }
          e.preventDefault();
        });
      <?php } ?>
    });
  <?php } else { ?>
    $('#sс-<?php echo $module; ?>').append('<div class="sc-subitems-row"></div>');
    function dimension(){
      var subrow = $('#sс-<?php echo $module; ?> .sc-child');
      var subitems = subrow.find('.subitem-wrapper').children('.item-container');
      var subitem_count = <?php echo $subitems_lg; ?>;

      subrow.find('.subitem-wrapper').css('margin-right','-<?php echo $subitem_margin; ?>px');
      subitems.css('margin-right','<?php echo $subitem_margin; ?>px');

      var subrow_width = $('#sс-<?php echo $module; ?>').width()-1 + <?php echo $subitem_margin; ?>;
      var subitem_width = 0;

      if ($(window).width() < 768) {
        subitem_width = Math.floor(subrow_width/<?php echo $subitems_xs; ?> - <?php echo $subitem_margin; ?>);
        subitem_count = <?php echo $subitems_xs; ?>;
      }
      if ($(window).width() >= 768 && $(window).width() < 992) {
        subitem_width = Math.floor(subrow_width/<?php echo $subitems_sm; ?> - <?php echo $subitem_margin; ?>);
        subitem_count = <?php echo $subitems_sm; ?>;
      }
      if ($(window).width() >= 992 && $(window).width() < 1200) {
        subitem_width = Math.floor(subrow_width/<?php echo $subitems_md; ?> - <?php echo $subitem_margin; ?>);
        subitem_count = <?php echo $subitems_md; ?>;
      }
      if ($(window).width() >= 1200) {
        subitem_width = Math.floor(subrow_width/<?php echo $subitems_lg; ?> - <?php echo $subitem_margin; ?>);
        subitem_count = <?php echo $subitems_lg; ?>;
      }

      subitems.width(subitem_width);

      $(subrow).each(function() {
        var subiteminrow = $(this).find('.subitem-wrapper').children('.item-container');
        for (var i = 0; i < subiteminrow.length; i+=subitem_count) {
          var childrow = subiteminrow.slice(i, i+subitem_count);

          <?php if ($subitem_img_pos == 'top' || $subitem_img_pos == 'bottom') { ?>
            var subinfo = childrow.find('.item-info');
          <?php } else { ?>
            var subinfo = childrow.find('.item-wrapper');
          <?php } ?>

          // Centering items
          var ml = 0;
          childrow.css('margin-left', ml);
          if (childrow.length < subitem_count) {
            ml = (subrow_width - (subitem_width+<?php echo $subitem_margin; ?>)*childrow.length)/2;
          }
          childrow.first().css('margin-left', ml);

          if ($(this).is(':hidden')) {$(this).addClass('hidden-subrow').show();}
          subinfo.height('auto');

          var subiteminfo = 0;
          $(subinfo).each(function() {
            subiteminfo = Math.max(subiteminfo, $(this).height());
          }).height(subiteminfo);

          <?php if ($subitem_img_pos == 'bottom') { ?>
            var subheading = subiteminrow.find('.item-heading');
            subheading.height('auto');
            var subitemheading = 0;
            $(subheading).each(function() {
              subitemheading = Math.max(subitemheading, $(this).height());
            }).height(subitemheading);
          <?php } ?>
          if ($(this).is('.hidden-subrow')) {$(this).removeClass('hidden-subrow').hide();}
        }
      });
    }
    dimension();
    $(window).resize(dimension);

    $('#sс-<?php echo $module; ?> .parent-item').each(function(i) {
      $(this).addClass('sc-toggle-'+(i+1)).find('.sc-child').addClass('sc-target-'+(i+1));
      $(this).find('a').not('.sc-child a, .item-btn a').attr('onclick','return false');

      var target = $('#sс-<?php echo $module; ?> .sc-target-'+(i+1));
      target.appendTo('#sс-<?php echo $module; ?> .sc-subitems-row');

      $('#sс-<?php echo $module; ?> .sc-toggle-'+(i+1)).find('a').not('.item-btn a').on('click', function() {
        $('#sс-<?php echo $module; ?> .sc-target-'+(i+1)).toggleClass('sc-target-open').animate({'opacity': 'toggle', 'height': 'toggle'}, 300).siblings('.sc-target-open').removeClass('sc-target-open').animate({'opacity': 'toggle', 'height': 'toggle'}, 300);
        $(this).closest('.item-wrapper').toggleClass('sc-toggle-active').closest('.scc-item').siblings().find('.sc-toggle-active').toggleClass('sc-toggle-active');
      });
    });
  <?php } ?>
  <?php } ?>
<?php } else { ?>
  var subrow = $('#sс-<?php echo $module; ?> .sc-child');
  var subitems = subrow.find('.subitem-wrapper').children('.item-container');
  var item_count = <?php echo $items_lg; ?>;
  var subitem_count = <?php echo $subitems_lg; ?>;

  $('#sс-<?php echo $module; ?> .sc-grid').children().css('margin-right','<?php echo $item_margin; ?>px');
  subrow.find('.subitem-wrapper').css('margin-right','-<?php echo $subitem_margin; ?>px');
  subitems.css('margin-right','<?php echo $subitem_margin; ?>px');

  function dimension(){
    $('#sс-<?php echo $module; ?> .sc-grid').each(function() {
      var row_width = $(this).parent().width()-1 + <?php echo $item_margin; ?>;
      var subrow_width = $(this).parent().width()-1 + <?php echo $subitem_margin; ?>;
      var item_width = 0;
      var subitem_width = 0;

      if ($(window).width() < 768) {
        item_width = Math.floor(row_width/<?php echo $items_xs; ?> - <?php echo $item_margin; ?>);
        subitem_width = Math.floor(subrow_width/<?php echo $subitems_xs; ?> - <?php echo $subitem_margin; ?>);
        item_count = <?php echo $items_xs; ?>;
        subitem_count = <?php echo $subitems_xs; ?>;
      }
      if ($(window).width() >= 768 && $(window).width() < 992) {
        item_width = Math.floor(row_width/<?php echo $items_sm; ?> - <?php echo $item_margin; ?>);
        subitem_width = Math.floor(subrow_width/<?php echo $subitems_sm; ?> - <?php echo $subitem_margin; ?>);
        item_count = <?php echo $items_sm; ?>;
        subitem_count = <?php echo $subitems_sm; ?>;
      }
      if ($(window).width() >= 992 && $(window).width() < 1200) {
        item_width = Math.floor(row_width/<?php echo $items_md; ?> - <?php echo $item_margin; ?>);
        subitem_width = Math.floor(subrow_width/<?php echo $subitems_md; ?> - <?php echo $subitem_margin; ?>);
        item_count = <?php echo $items_md; ?>;
        subitem_count = <?php echo $subitems_md; ?>;
      }
      if ($(window).width() >= 1200) {
        item_width = Math.floor(row_width/<?php echo $items_lg; ?> - <?php echo $item_margin; ?>);
        subitem_width = Math.floor(subrow_width/<?php echo $subitems_lg; ?> - <?php echo $subitem_margin; ?>);
        item_count = <?php echo $items_lg; ?>;
        subitem_count = <?php echo $subitems_lg; ?>;
      }

      if ($(this).children().is('.item-container')) {
        var items = $(this).children();
      } else {
        var items = $(this).find('.sc-items-row').children();
      }
      var subitems = $(this).find('.subitem-wrapper').children('.item-container');

      items.width(item_width);
      subitems.width(subitem_width);

      for (var i = 0; i < items.length; i+=item_count) {
        var row = items.slice(i, i+item_count);
        if (row.first().parent().is('.sc-items-row')) {
          row.unwrap();
        }
        row.wrapAll('<div class="sc-items-row"></div>');
        $(this).find('.sc-items-row').css('margin-right','-<?php echo $item_margin; ?>px').detach(':empty');

        if (!row.first().parent('.sc-items-row').next().is('.sc-subitems-row')) {
          row.first().parent('.sc-items-row').after('<div class="sc-subitems-row"></div>');
        }

        <?php if ($item_img_pos == 'top' || $item_img_pos == 'bottom') { ?>
            var info = row.find('.item-info').not('.sc-child .item-info');
        <?php } else { ?>
            var info = row.find('.item-wrapper').not('.sc-child .item-wrapper');
        <?php } ?>

        if (row.length < item_count) {
          row.width(Math.floor(row_width/row.length - <?php echo $item_margin; ?>));
        }

        $(this).show();
        info.height('auto');

        var iteminfo = 0;
        $(info).each(function() {
            iteminfo = Math.max(iteminfo, $(this).height());
        }).height(iteminfo);

        <?php if ($item_img_pos == 'bottom') { ?>
            var heading = items.find('.item-heading').not('.sc-child .item-heading');
            heading.height('auto');
            var itemheading = 0;
            $(heading).each(function() {
                itemheading = Math.max(itemheading, $(this).height());
            }).height(itemheading);
        <?php } ?>
      }

      $(this).find('.sc-child').each(function() {
        var subiteminrow = $(this).find('.subitem-wrapper').children('.item-container');
        for (var i = 0; i < subiteminrow.length; i+=subitem_count) {
          var childrow = subiteminrow.slice(i, i+subitem_count);

          <?php if ($subitem_img_pos == 'top' || $subitem_img_pos == 'bottom') { ?>
            var subinfo = childrow.find('.item-info');
          <?php } else { ?>
            var subinfo = childrow.find('.item-wrapper');
          <?php } ?>

          // Centering items
          var ml = 0;
          childrow.css('margin-left', ml);
          if (childrow.length < subitem_count) {
            ml = (subrow_width - (subitem_width+<?php echo $subitem_margin; ?>)*childrow.length)/2;
          }
          childrow.first().css('margin-left', ml);

          // if (childrow.length < subitem_count) {
          //   childrow.width(Math.floor(subrow_width/childrow.length - <?php echo $subitem_margin; ?>));
          // }

          if ($(this).is(':hidden')) {$(this).addClass('hidden-subrow').show();}
          subinfo.height('auto');

          var subiteminfo = 0;
          $(subinfo).each(function() {
            subiteminfo = Math.max(subiteminfo, $(this).height());
          }).height(subiteminfo);

          <?php if ($subitem_img_pos == 'bottom') { ?>
            var subheading = subiteminrow.find('.item-heading');
            subheading.height('auto');
            var subitemheading = 0;
            $(subheading).each(function() {
              subitemheading = Math.max(subitemheading, $(this).height());
            }).height(subitemheading);
          <?php } ?>
          if ($(this).is('.hidden-subrow')) {$(this).removeClass('hidden-subrow').hide();}
        }
      });
    });

    $('#sс-<?php echo $module; ?> .sc-grid').find('.parent-item').each(function(i) {
      var target = $('#sс-<?php echo $module; ?> .sc-target-'+(i+1));
      var subrow = $(this).parent().next();
      target.appendTo(subrow);
    });
  }
  dimension();
  $(window).resize(dimension);

  $('#sс-<?php echo $module; ?> .parent-item').each(function(i) {
    $(this).addClass('sc-toggle-'+(i+1)).find('.sc-child').addClass('sc-target-'+(i+1));
    $(this).find('a').not('.sc-child a, .item-btn a').attr('onclick','return false');
    var target = $('#sс-<?php echo $module; ?> .sc-target-'+(i+1));
    var subrow = $(this).parent().next();
    target.appendTo(subrow);

    $('#sс-<?php echo $module; ?> .sc-toggle-'+(i+1)).find('a').not('.item-btn a').on('click', function() {
      <?php if ($subitems_status && $subitems_carousel) { ?>
        if ($(subcarousel).is(':hidden')) {
            target.show();
            subcarousel.trigger('refresh.scc.carousel');
            target.hide();
        }
      <?php } ?>
      $('#sс-<?php echo $module; ?> .sc-target-'+(i+1)).toggleClass('sc-target-open').animate({'opacity': 'toggle', 'height': 'toggle'}, 300).siblings('.sc-target-open').removeClass('sc-target-open').animate({'opacity': 'toggle', 'height': 'toggle'}, 300);
      $(this).closest('.item-wrapper').toggleClass('sc-toggle-active').parent().siblings().find('.sc-toggle-active').toggleClass('sc-toggle-active');
    });

    <?php if ($subitems_status && $subitems_carousel) { ?>
      var subcarousel = $('#sс-<?php echo $module; ?> .sc-target-'+(i+1) + ' .sc-carousel');
      subcarousel.sccCarousel({
          margin: <?php echo $subitem_margin; ?>,
          nav: <?php echo $subitems_nav; ?>,
          navText: ['<?php echo $subitems_prev_nav; ?>', '<?php echo $subitems_next_nav; ?>'],
          navSpeed: <?php echo $subitems_nav_speed; ?>,
          dots: <?php echo $subitems_dots; ?>,
          slideBy: 2,
          mouseDrag: <?php echo $subitems_drag; ?>,
          responsive: {0:{items:<?php echo $subitems_xs; ?>}, 768:{items:<?php echo $subitems_sm; ?>}, 992:{items:<?php echo $subitems_md; ?>}, 1200:{ items:<?php echo $subitems_lg; ?>}},
          onRefreshed: function(event) {
            var cw = subcarousel.width();
            var scsubitem = subcarousel.find('.scc-stage').children();
            var subitemscount = event.item.count;
            var size = event.page.size;

            if (subitemscount < size) {
                scsubitem.parent().width(cw+<?php echo $subitem_margin; ?> + 'px');
                scsubitem.width(((cw+<?php echo $subitem_margin; ?>)-(subitemscount*<?php echo $subitem_margin; ?>))/subitemscount + 'px');
            }

            <?php if ($subitem_img_pos == 'top' || $subitem_img_pos == 'bottom') { ?>
              var subinfo = scsubitem.find('.item-info');
            <?php } else { ?>
              var subinfo = scsubitem.find('.item-wrapper');
            <?php } ?>

            subinfo.height('auto');
            var imh = 0;
            $(subinfo).each(function() {
                imh = Math.max(imh, $(this).height());
            }).height(imh);

            <?php if ($subitem_img_pos == 'bottom') { ?>
              var heading = scsubitem.find('.item-heading');
              heading.height('auto');
              var hmh = 0;
              $(heading).each(function() {
                hmh = Math.max(hmh, $(this).height());
              }).height(hmh);
            <?php } ?>
          }
      });

      <?php if ($subitems_mousewheel) { ?>
      subcarousel.on('mousewheel', '.scc-stage', function(e) {
        if (e.deltaY>0) {
          $(this).trigger('next.scc');
        } else {
          $(this).trigger('prev.scc');
        }
        e.preventDefault();
      });
      <?php } ?>
    <?php } ?>
  });
<?php } ?>
//--></script>