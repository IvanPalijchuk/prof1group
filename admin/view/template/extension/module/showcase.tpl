<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-showcase" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i> <span class="hidden-sm"> <?php echo $button_save; ?></span></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil-square-o"></i>
        <?php echo $text_edit; ?>
        <?php if (!empty($name)) { ?>
        <?php echo '"'. $name .'"'; ?>
        <?php } ?>
        </h3>
        <?php if ($success) { ?>
        <div class="sc-apply text-success pull-right"><i class="fa fa-check"></i> <?php echo $success; ?></div>
        <?php } ?>
        <?php if ($error_name) { ?>
        <div class="text-danger pull-right"><?php echo $error_name; ?></div>
        <?php } ?>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-showcase" class="form-horizontal">
          <ul id="settingTab" class="nav nav-tabs" role="tablist">
            <li class="active"><a href="#scSetting" role="tab" data-toggle="tab"> <?php echo $tab_sc_setting; ?></a></li>
            <li><a href="#moduleSetting" role="tab" data-toggle="tab"> <?php echo $tab_module_setting; ?></a></li>
          </ul>
          <div class="tab-content">
            <div id="scSetting" class="tab-pane active">
              <div class="row">
                <div class="col-lg-6">
                  <div class="form-group">
                    <label class="col-sm-4 control-label"><?php echo $entry_title; ?></label>
                    <div class="col-sm-8">
                      <?php foreach ($languages as $language) { ?>
                      <div class="input-group"> <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
                        <input type="text" name="showcase[<?php echo $language['language_id']; ?>][title]" value="<?php echo isset($showcase[$language['language_id']]['title']) ? $showcase[$language['language_id']]['title'] : ''; ?>" class="form-control" />
                      </div>
                      <br />
                      <?php } ?>
                    </div>
                  </div>
                  <hr />
                  <div class="form-group">
                    <label class="col-sm-4 control-label"><?php echo $entry_items; ?></label>
                    <div class="col-sm-8">
                      <div class="radio">
                        <label>
                          <input type="radio" name="showcase[type]" value="tree" <?php echo empty($showcase['type']) || $showcase['type'] == 'tree' ? 'checked="checked"' : ''; ?> onchange="if($(this).prop('checked')) {$('#categories,#tree-categories').show();$('#brands').hide();}" />
                          <?php echo $text_categories; ?> </label>
                      </div>
                      <div class="radio">
                        <label>
                          <input type="radio" name="showcase[type]" value="current" <?php echo isset($showcase['type']) && $showcase['type'] == 'current' ? 'checked="checked"' : ''; ?> onchange="if($(this).prop('checked')) {$('#categories').show();$('#brands,#tree-categories').hide();}" />
                          <?php echo $text_current; ?> </label>
                      </div>
                      <div class="radio">
                        <label>
                          <input type="radio" name="showcase[type]" value="brands" <?php echo isset($showcase['type']) && $showcase['type'] == 'brands' ? 'checked="checked"' : ''; ?> onchange="if($(this).prop('checked')) {$('#categories').hide();$('#brands').show();}" />
                          <?php echo $text_brands; ?> </label>
                      </div>
                    </div>
                  </div>
                  <div id="categories" <?php echo isset($showcase['type']) && $showcase['type'] == 'brands' ? 'style="display:none;"' : ''; ?> class="sc-items">
                    <div id="tree-categories" <?php echo empty($showcase['type']) || $showcase['type'] == 'tree' ? '' : 'style="display:none;"'; ?>>
                      <hr />
                      <div class="form-group">
                        <label class="col-sm-4 control-label"><?php echo $entry_cat; ?></label>
                        <div class="col-sm-8">
                          <div class="radio">
                            <label>
                              <input type="radio" name="showcase[allcat]" value="1" <?php echo isset($showcase['allcat']) ? 'checked="checked"' : ''; ?> onchange="if($(this).prop('checked')) {$('#featured-categories').hide();}" />
                              <?php echo $text_allcat; ?> </label>
                          </div>
                          <div class="radio">
                            <label>
                              <input type="radio" name="showcase[allcat]" value="0" <?php echo empty($showcase['allcat']) ? 'checked="checked"' : ''; ?> onchange="if($(this).prop('checked')) {$('#featured-categories').show();}" />
                              <?php echo $text_fcat; ?> </label>
                          </div>
                        </div>
                      </div>
                      <div id="featured-categories" <?php echo !empty($showcase['allcat']) ? 'style="display:none;"' : ''; ?>>
                        <div class="form-group">
                          <div class="col-sm-8 col-sm-offset-4">
                            <input type="text" name="showcase[fcat]" value="" placeholder="<?php echo $text_fcat; ?>" id="input-fcat" class="form-control" />
                            <div id="showcase-fcat" class="well well-sm" style="height: 150px; overflow: auto; margin-bottom: 0;">
                              <?php foreach ($categories as $category) { ?>
                              <div id="showcase-fcat<?php echo $category['category_id']; ?>"><i class="fa fa-minus-circle"></i> <?php echo $category['name']; ?>
                                <input type="hidden" name="showcase[fcat][]" value="<?php echo $category['category_id']; ?>" />
                              </div>
                              <?php } ?>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                    <hr />
                    <div class="form-group">
                      <div class="col-sm-8 col-sm-offset-4">
                        <div class="checkbox">
                          <label>
                            <input type="checkbox" name="showcase[count_status]" value="1" <?php echo isset($showcase['count_status']) ? 'checked="checked"' : ''; ?> />
                            <?php echo $text_count; ?> </label>
                        </div>
                      </div>
                    </div>
                    <hr />
                  </div>
                  <div id="brands" <?php echo isset($showcase['type']) && $showcase['type'] == 'brands' ? '' : 'style="display:none;"'; ?> class="sc-items">
                    <hr />
                    <div class="form-group">
                      <label class="col-sm-4 control-label"><?php echo $entry_brands; ?></label>
                      <div class="col-sm-8">
                        <div class="radio">
                          <label>
                            <input type="radio" name="showcase[allbrands]" value="1" <?php echo isset($showcase['allbrands']) ? 'checked="checked"' : ''; ?> onchange="if($(this).prop('checked')) {$('#featured-brands').hide();}" />
                            <?php echo $text_allbrands; ?> </label>
                        </div>
                        <div class="radio">
                          <label>
                            <input type="radio" name="showcase[allbrands]" value="0" <?php echo empty($showcase['allbrands']) ? 'checked="checked"' : ''; ?> onchange="if($(this).prop('checked')) {$('#featured-brands').show();}" />
                            <?php echo $text_fbrands; ?> </label>
                        </div>
                      </div>
                    </div>
                    <div id="featured-brands" <?php echo !empty($showcase['allbrands']) ? 'style="display:none;"' : ''; ?>>
                      <div class="form-group">
                        <div class="col-sm-8 col-sm-offset-4">
                          <input type="text" name="showcase[fbrand]" value="" placeholder="<?php echo $text_fbrands; ?>" id="input-fbrand" class="form-control" />
                          <div id="showcase-fbrand" class="well well-sm" style="height: 150px; overflow: auto; margin-bottom: 0;">
                            <?php foreach ($brands as $brand) { ?>
                            <div id="showcase-fbrand<?php echo $brand['brand_id']; ?>"><i class="fa fa-minus-circle"></i> <?php echo $brand['name']; ?>
                              <input type="hidden" name="showcase[fbrand][]" value="<?php echo $brand['brand_id']; ?>" />
                            </div>
                            <?php } ?>
                          </div>
                        </div>
                      </div>
                    </div>
                    <hr />
                  </div>
                  <div class="form-group">
                    <label class="col-sm-4 control-label"><?php echo $entry_products_byitem; ?></label>
                    <div class="col-sm-8">
                      <div class="btn-group btn-group-justified" data-toggle="buttons">
                        <label class="btn btn-success">
                          <input type="radio" name="showcase[products_by_item]" value="1" <?php echo isset($showcase['products_by_item']) ? 'checked="checked"' : ''; ?> onchange="if($(this).prop('checked')) {$('#products-config').show();}" />
                          <?php echo $text_enabled; ?> </label>
                        <label class="btn btn-danger">
                          <input type="radio" name="showcase[products_by_item]" value="0" <?php echo empty($showcase['products_by_item']) ? 'checked="checked"' : ''; ?> onchange="if($(this).prop('checked')) {$('#products-config').hide();}" />
                          <?php echo $text_disabled; ?> </label>
                      </div>
                    </div>
                  </div>
                  <div id="products-config" <?php echo !empty($showcase['products_by_item']) ? '' : 'style="display:none;"' ; ?>>
                    <hr />
                    <div class="form-group">
                      <label class="col-sm-4 control-label"><?php echo $entry_sort_order; ?></label>
                      <div class="col-sm-8">
                        <select name="showcase[products_sort]" class="form-control">
                          <?php foreach ($sorts as $sort) { ?>
                          <?php if (isset($showcase['products_sort']) && $sort['value'] == $showcase['products_sort']) { ?>
                          <option value="<?php echo $sort['value']; ?>" selected="selected"><?php echo $sort['name']; ?></option>
                          <?php } else { ?>
                          <option value="<?php echo $sort['value']; ?>"><?php echo $sort['name']; ?></option>
                          <?php } ?>
                          <?php } ?>
                        </select>
                      </div>
                    </div>
                    <hr />
                    <div class="form-group">
                      <label class="col-sm-4 control-label"><?php echo $entry_products_limit; ?></label>
                      <div class="col-sm-8">
                        <input type="text" name="showcase[products_limit]" value="<?php echo isset($showcase['products_limit']) ? $showcase['products_limit'] : ''; ?>" class="form-control" />
                      </div>
                    </div>
                    <hr />
                    <div class="form-group">
                      <div class="col-sm-4 col-sm-offset-4">
                        <div class="checkbox">
                          <label>
                            <input type="checkbox" name="showcase[price]" value="1" <?php echo isset($showcase['price']) ? 'checked="checked"' : ''; ?> />
                            <?php echo $text_price; ?> </label>
                        </div>
                        <div class="checkbox">
                          <label>
                            <input type="checkbox" name="showcase[rating]" value="1" <?php echo isset($showcase['rating']) ? 'checked="checked"' : ''; ?> />
                            <?php echo $text_rating; ?> </label>
                        </div>
                      </div>
                      <div class="col-sm-4">
                        <div class="checkbox">
                          <label>
                            <input type="checkbox" name="showcase[cart]" value="1" <?php echo isset($showcase['cart']) ? 'checked="checked"' : ''; ?> />
                            <?php echo $text_cart; ?> </label>
                        </div>
                      </div>
                    </div>
                    <hr />
                    <div class="form-group">
                      <label class="col-sm-4 control-label"><?php echo $entry_cart; ?></label>
                      <div class="col-sm-4">
                        <input type="text" name="showcase[cart_icon]" value='<?php echo isset($showcase['cart_icon']) ? $showcase['cart_icon'] : '<i class="fa fa-shopping-cart"></i>'; ?>' class="form-control text-center" />
                      </div>
                      <div class="col-sm-4">
                        <input type="text" name="showcase[cart_class]" value="<?php echo !empty($showcase['cart_class']) ? $showcase['cart_class'] : 'btn btn-default btn-block'; ?>" class="form-control text-center" />
                      </div>
                    </div>
                  </div>
                </div>
                <div class="col-lg-6">
                  <div class="form-group">
                    <div class="col-sm-11 col-sm-offset-1">
                      <ul class="nav nav-tabs" role="tablist" style="margin-bottom: 10px;">
                        <li class="active"><a href="#items" data-toggle="tab"><?php echo $tab_items; ?></a></li>
                        <li><a href="#subitems" data-toggle="tab"><?php echo $tab_subitems; ?></a></li>
                      </ul>
                    </div>
                  </div>
                  <div class="tab-content">
                    <div role="tabpanel" class="tab-pane active" id="items">
                      <div class="form-group">
                        <label class="col-sm-4 control-label"><?php echo $entry_itemrow; ?></label>
                        <div class="col-sm-4">
                          <div class="input-group"> <span class="input-group-addon"><?php echo $text_xs; ?></span>
                            <input type="text" name="showcase[items_xs]" value="<?php echo !empty($showcase['items_xs']) ? $showcase['items_xs'] : '1'; ?>" class="form-control text-center" />
                          </div>
                        </div>
                        <div class="col-sm-4">
                          <div class="input-group"> <span class="input-group-addon"><?php echo $text_sm; ?></span>
                            <input type="text" name="showcase[items_sm]" value="<?php echo !empty($showcase['items_sm']) ? $showcase['items_sm'] : '2'; ?>" class="form-control text-center" />
                          </div>
                        </div>
                      </div>
                      <hr />
                      <div class="form-group">
                        <div class="col-sm-8 col-sm-offset-4">
                          <div class="row">
                            <div class="col-sm-6">
                              <div class="input-group"> <span class="input-group-addon"><?php echo $text_md; ?></span>
                                <input type="text" name="showcase[items_md]" value="<?php echo !empty($showcase['items_md']) ? $showcase['items_md'] : '3'; ?>" class="form-control text-center" />
                              </div>
                            </div>
                            <div class="col-sm-6">
                              <div class="input-group"> <span class="input-group-addon"><?php echo $text_lg; ?></span>
                                <input type="text" name="showcase[items_lg]" value="<?php echo !empty($showcase['items_lg']) ? $showcase['items_lg'] : '4'; ?>" class="form-control text-center" />
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                      <hr />
                      <div class="form-group">
                        <label class="col-sm-4 control-label"><?php echo $entry_margin; ?></label>
                        <div class="col-sm-4">
                          <input type="text" name="showcase[item_margin]" value="<?php echo !empty($showcase['item_margin']) ? $showcase['item_margin'] : '26'; ?>" class="form-control text-center" />
                        </div>
                      </div>
                      <hr />
                      <div class="form-group">
                        <label class="col-sm-4 control-label"><?php echo $entry_image; ?></label>
                        <div class="col-sm-8">
                          <div class="btn-group btn-group-justified" data-toggle="buttons">
                            <label class="btn btn-success">
                              <input type="radio" name="showcase[item_image]" value="1" <?php echo isset($showcase['item_image']) ? 'checked="checked"' : ''; ?> />
                              <?php echo $text_enabled; ?> </label>
                              <label class="btn btn-danger">
                                <input type="radio" name="showcase[item_image]" value="0" <?php echo empty($showcase['item_image']) ? 'checked="checked"' : ''; ?> />
                                <?php echo $text_disabled; ?> </label>
                          </div>
                        </div>
                      </div>
                      <hr />
                      <div class="form-group">
                        <label class="col-sm-4 control-label"><?php echo $entry_size; ?></label>
                        <div class="col-sm-4">
                          <input type="text" name="showcase[item_width]" value="<?php echo !empty($showcase['item_width']) ? $showcase['item_width'] : '200'; ?>" class="form-control text-center" />
                        </div>
                        <div class="col-sm-4">
                          <input type="text" name="showcase[item_height]" value="<?php echo !empty($showcase['item_height']) ? $showcase['item_height'] : '200'; ?>" class="form-control text-center" />
                        </div>
                      </div>
                      <hr />
                      <div class="form-group">
                        <label class="col-sm-4 control-label"><?php echo $entry_image_pos; ?></label>
                        <div class="col-sm-8">
                          <div class="btn-group btn-group-justified" data-toggle="buttons">
                            <label class="btn btn-success">
                              <input type="radio" name="showcase[item_img_pos]" value="left" <?php echo isset($showcase['item_img_pos']) && $showcase['item_img_pos'] == 'left' ? 'checked="checked"' : ''; ?> />
                              <?php echo $text_left; ?> </label>
                              <label class="btn btn-success">
                                <input type="radio" name="showcase[item_img_pos]" value="right" <?php echo isset($showcase['item_img_pos']) && $showcase['item_img_pos'] == 'right' ? 'checked="checked"' : ''; ?> />
                                <?php echo $text_right; ?> </label>
                              <label class="btn btn-success">
                                <input type="radio" name="showcase[item_img_pos]" value="top" <?php echo empty($showcase['item_img_pos']) || $showcase['item_img_pos'] == 'top' ? 'checked="checked"' : ''; ?> />
                                <?php echo $text_top; ?> </label>
                              <label class="btn btn-success">
                                <input type="radio" name="showcase[item_img_pos]" value="bottom" <?php echo isset($showcase['item_img_pos']) && $showcase['item_img_pos'] == 'bottom' ? 'checked="checked"' : ''; ?> />
                                <?php echo $text_bottom; ?> </label>
                          </div>
                        </div>
                      </div>
                      <hr />
                      <div class="form-group">
                        <div class="col-sm-4 col-sm-offset-4">
                          <div class="checkbox">
                            <label>
                              <input type="checkbox" name="showcase[item_heading]" value="1" <?php echo isset($showcase['item_heading']) ? 'checked="checked"' : ''; ?> />
                              <?php echo $text_heading; ?> </label>
                          </div>
                          <div class="checkbox">
                            <label>
                              <input type="checkbox" name="showcase[item_desc]" value="1" <?php echo isset($showcase['item_desc']) ? 'checked="checked"' : ''; ?> />
                              <?php echo $text_description; ?> </label>
                          </div>
                        </div>
                        <div class="col-sm-4">
                          <div class="checkbox">
                            <label>
                              <input type="checkbox" name="showcase[item_btn]" value="1" <?php echo isset($showcase['item_btn']) ? 'checked="checked"' : ''; ?> />
                              <?php echo $text_btn; ?> </label>
                          </div>
                        </div>
                      </div>
                      <hr />
                      <div class="form-group">
                        <label class="col-sm-4 control-label"><?php echo $entry_btn; ?></label>
                        <div class="col-sm-4">
                          <input type="text" name="showcase[item_btn_text]" value="<?php echo !empty($showcase['item_btn_text']) ? $showcase['item_btn_text'] : $text_more_btn; ?>" class="form-control text-center" />
                        </div>
                        <div class="col-sm-4">
                          <input type="text" name="showcase[btn_class]" value="<?php echo !empty($showcase['btn_class']) ? $showcase['btn_class'] : 'btn btn-default btn-block'; ?>" class="form-control text-center" />
                        </div>
                      </div>
                      <br />
                      <div class="form-group">
                        <div class="col-sm-8 col-sm-offset-4">
                          <h4><?php echo $entry_carousel; ?></h4>
                        </div>
                      </div>
                      <hr />
                      <div class="form-group">
                        <label class="col-sm-4 control-label"><?php echo $entry_items_carousel; ?></label>
                        <div class="col-sm-8">
                          <div class="btn-group btn-group-justified" data-toggle="buttons">
                            <label class="btn btn-success">
                              <input type="radio" name="showcase[items_carousel]" value="1" <?php echo isset($showcase['items_carousel']) ? 'checked="checked"' : ''; ?> />
                              <?php echo $text_enabled; ?> </label>
                              <label class="btn btn-danger">
                                <input type="radio" name="showcase[items_carousel]" value="0" <?php echo empty($showcase['items_carousel']) ? 'checked="checked"' : ''; ?> />
                                <?php echo $text_disabled; ?> </label>
                          </div>
                        </div>
                      </div>
                      <hr />
                      <div class="form-group">
                        <div class="col-sm-4 col-sm-offset-4">
                          <div class="checkbox">
                            <label>
                              <input type="checkbox" name="showcase[items_mousewheel]" value="1" <?php echo isset($showcase['items_mousewheel']) ? 'checked="checked"' : ''; ?> />
                              <?php echo $entry_mousewheel; ?> </label>
                          </div>
                          <div class="checkbox">
                            <label>
                              <input type="checkbox" name="showcase[items_drag]" value="1" <?php echo isset($showcase['items_drag']) ? 'checked="checked"' : ''; ?> />
                              <?php echo $entry_drag; ?> </label>
                          </div>
                        </div>
                        <div class="col-sm-4">
                          <div class="checkbox">
                            <label>
                              <input type="checkbox" name="showcase[items_dots]" value="1" <?php echo isset($showcase['items_dots']) ? 'checked="checked"' : ''; ?> />
                              <?php echo $entry_dots; ?> </label>
                          </div>
                          <div class="checkbox">
                            <label>
                              <input type="checkbox" name="showcase[items_nav]" value="1" <?php echo isset($showcase['items_nav']) ? 'checked="checked"' : ''; ?> />
                              <?php echo $entry_nav; ?> </label>
                          </div>
                        </div>
                      </div>
                      <hr />
                      <div class="form-group">
                        <label class="col-sm-4 control-label"><?php echo $entry_nav_text; ?></label>
                        <div class="col-sm-4">
                          <input type="text" name="showcase[items_prev_nav]" value='<?php echo !empty($showcase['items_prev_nav']) ? $showcase['items_prev_nav'] : '<i class="fa fa-chevron-left"></i>'; ?>' class="form-control text-center" />
                        </div>
                        <div class="col-sm-4">
                          <input type="text" name="showcase[items_next_nav]" value='<?php echo !empty($showcase['items_next_nav']) ? $showcase['items_next_nav'] : '<i class="fa fa-chevron-right"></i>'; ?>' class="form-control text-center" />
                        </div>
                      </div>
                      <hr />
                      <div class="form-group">
                        <label class="col-sm-4 control-label"><?php echo $entry_nav_speed; ?></label>
                        <div class="col-sm-4">
                          <input type="text" name="showcase[items_nav_speed]" value="<?php echo !empty($showcase['items_nav_speed']) ? $showcase['items_nav_speed'] : '200'; ?>" class="form-control text-center" />
                        </div>
                      </div>
                    </div>
                    <div role="tabpanel" class="tab-pane" id="subitems">
                      <div class="form-group">
                        <label class="col-sm-4 control-label"><?php echo $entry_subitems; ?></label>
                        <div class="col-sm-8">
                          <div class="btn-group btn-group-justified" data-toggle="buttons">
                            <label class="btn btn-success">
                              <input type="radio" name="showcase[subitems_status]" value="1" <?php echo isset($showcase['subitems_status']) ? 'checked="checked"' : ''; ?> />
                              <?php echo $text_enabled; ?> </label>
                              <label class="btn btn-danger">
                                <input type="radio" name="showcase[subitems_status]" value="0" <?php echo empty($showcase['subitems_status']) ? 'checked="checked"' : ''; ?> />
                                <?php echo $text_disabled; ?> </label>
                          </div>
                        </div>
                      </div>
                      <hr />
                      <div class="form-group">
                        <label class="col-sm-4 control-label"><?php echo $entry_subitems_limit; ?></label>
                        <div class="col-sm-4">
                          <input type="text" name="showcase[subitem_limit]" value="<?php echo isset($showcase['subitem_limit']) ? $showcase['subitem_limit'] : ''; ?>" class="form-control text-center" />
                        </div>
                      </div>
                      <hr />
                      <div class="form-group">
                        <label class="col-sm-4 control-label"><?php echo $entry_subitems_pos; ?></label>
                        <div class="col-sm-8">
                          <div class="btn-group btn-group-justified" data-toggle="buttons">
                            <label class="btn btn-success">
                              <input type="radio" name="showcase[subitems_pos]" value="inside" onchange="if($(this).prop('checked')) {$('#inside').show();$('#outside').hide();}" <?php echo isset($showcase['subitems_pos']) && $showcase['subitems_pos'] == 'inside' ? 'checked="checked"' : ''; ?> />
                              <?php echo $text_inside; ?> </label>
                              <label class="btn btn-success">
                                <input type="radio" name="showcase[subitems_pos]" value="outside" onchange="if($(this).prop('checked')) {$('#inside').hide();$('#outside').show();}" <?php echo empty($showcase['subitems_pos']) || $showcase['subitems_pos'] == 'outside' ? 'checked="checked"' : ''; ?> />
                                <?php echo $text_outside; ?> </label>
                          </div>
                        </div>
                      </div>
                      <hr />
                      <div id="inside" <?php echo isset($showcase['subitems_pos']) && $showcase['subitems_pos'] == 'inside' ? '' : 'style="display:none;"'; ?>>
                        <div class="form-group">
                          <label class="col-sm-4 control-label"><?php echo $entry_subitems_view; ?></label>
                          <div class="col-sm-8">
                            <div class="btn-group btn-group-justified" data-toggle="buttons">
                              <label class="btn btn-success">
                                <input type="radio" name="showcase[sublist]" value="1" onchange="if($(this).prop('checked')) {$('#subcolumn').hide();}" <?php echo isset($showcase['sublist']) ? 'checked="checked"' : ''; ?> />
                                <?php echo $text_list; ?> </label>
                                <label class="btn btn-success">
                                  <input type="radio" name="showcase[sublist]" value="0" onchange="if($(this).prop('checked')) {$('#subcolumn').show();}" <?php echo empty($showcase['sublist']) ? 'checked="checked"' : ''; ?> />
                                  <?php echo $text_column; ?> </label>
                            </div>
                          </div>
                        </div>
                        <div id="subcolumn" <?php echo !empty($showcase['sublist']) ? 'style="display:none;"' : ''; ?>>
                          <div class="form-group">
                            <label class="col-sm-4 control-label"><?php echo $entry_column; ?></label>
                            <div class="col-sm-4">
                              <input type="text" name="showcase[column]" value="<?php echo !empty($showcase['column']) ? $showcase['column'] : '2'; ?>" class="form-control text-center" />
                            </div>
                          </div>
                        </div>
                      </div>
                      <div id="outside" <?php echo empty($showcase['subitems_pos']) || $showcase['subitems_pos'] == 'outside' ? '' : 'style="display:none;"'; ?>>
                        <div class="form-group">
                          <label class="col-sm-4 control-label"><?php echo $entry_subitemrow; ?></label>
                          <div class="col-sm-4">
                            <div class="input-group"> <span class="input-group-addon"><?php echo $text_xs; ?></span>
                              <input type="text" name="showcase[subitems_xs]" value="<?php echo !empty($showcase['subitems_xs']) ? $showcase['subitems_xs'] : '1'; ?>" class="form-control text-center" />
                            </div>
                          </div>
                          <div class="col-sm-4">
                            <div class="input-group"> <span class="input-group-addon"><?php echo $text_sm; ?></span>
                              <input type="text" name="showcase[subitems_sm]" value="<?php echo !empty($showcase['subitems_sm']) ? $showcase['subitems_sm'] : '2'; ?>" class="form-control text-center" />
                            </div>
                          </div>
                        </div>
                        <hr />
                        <div class="form-group">
                          <div class="col-sm-8 col-sm-offset-4">
                            <div class="row">
                              <div class="col-sm-6">
                                <div class="input-group"> <span class="input-group-addon"><?php echo $text_md; ?></span>
                                  <input type="text" name="showcase[subitems_md]" value="<?php echo !empty($showcase['subitems_md']) ? $showcase['subitems_md'] : '3'; ?>" class="form-control text-center" />
                                </div>
                              </div>
                              <div class="col-sm-6">
                                <div class="input-group"> <span class="input-group-addon"><?php echo $text_lg; ?></span>
                                  <input type="text" name="showcase[subitems_lg]" value="<?php echo !empty($showcase['subitems_lg']) ? $showcase['subitems_lg'] : '4'; ?>" class="form-control text-center" />
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                        <hr />
                        <div class="form-group">
                          <label class="col-sm-4 control-label"><?php echo $entry_margin; ?></label>
                          <div class="col-sm-4">
                            <input type="text" name="showcase[subitem_margin]" value="<?php echo !empty($showcase['subitem_margin']) ? $showcase['subitem_margin'] : '26'; ?>" class="form-control text-center" />
                          </div>
                        </div>
                        <hr />
                        <div class="form-group">
                          <label class="col-sm-4 control-label"><?php echo $entry_image; ?></label>
                          <div class="col-sm-8">
                            <div class="btn-group btn-group-justified" data-toggle="buttons">
                              <label class="btn btn-success">
                                <input type="radio" name="showcase[subitem_image]" value="1" <?php echo isset($showcase['subitem_image']) ? 'checked="checked"' : ''; ?> />
                                <?php echo $text_enabled; ?> </label>
                                <label class="btn btn-danger">
                                  <input type="radio" name="showcase[subitem_image]" value="0" <?php echo empty($showcase['subitem_image']) ? 'checked="checked"' : ''; ?> />
                                  <?php echo $text_disabled; ?> </label>
                            </div>
                          </div>
                        </div>
                        <hr />
                        <div class="form-group">
                          <label class="col-sm-4 control-label"><?php echo $entry_size; ?></label>
                          <div class="col-sm-4">
                            <input type="text" name="showcase[subitem_width]" value="<?php echo !empty($showcase['subitem_width']) ? $showcase['subitem_width'] : '200'; ?>" class="form-control text-center" />
                          </div>
                          <div class="col-sm-4">
                            <input type="text" name="showcase[subitem_height]" value="<?php echo !empty($showcase['subitem_height']) ? $showcase['subitem_height'] : '200'; ?>" class="form-control text-center" />
                          </div>
                        </div>
                        <hr />
                        <div class="form-group">
                          <label class="col-sm-4 control-label"><?php echo $entry_image_pos; ?></label>
                          <div class="col-sm-8">
                            <div class="btn-group btn-group-justified" data-toggle="buttons">
                              <label class="btn btn-success">
                                <input type="radio" name="showcase[subitem_img_pos]" value="left" <?php echo isset($showcase['subitem_img_pos']) && $showcase['subitem_img_pos'] == 'left' ? 'checked="checked"' : ''; ?> />
                                <?php echo $text_left; ?> </label>
                                <label class="btn btn-success">
                                  <input type="radio" name="showcase[subitem_img_pos]" value="right" <?php echo isset($showcase['subitem_img_pos']) && $showcase['subitem_img_pos'] == 'right' ? 'checked="checked"' : ''; ?> />
                                  <?php echo $text_right; ?> </label>
                                <label class="btn btn-success">
                                  <input type="radio" name="showcase[subitem_img_pos]" value="top" <?php echo empty($showcase['subitem_img_pos']) || $showcase['subitem_img_pos'] == 'top' ? 'checked="checked"' : ''; ?> />
                                  <?php echo $text_top; ?> </label>
                                <label class="btn btn-success">
                                  <input type="radio" name="showcase[subitem_img_pos]" value="bottom" <?php echo isset($showcase['subitem_img_pos']) && $showcase['subitem_img_pos'] == 'bottom' ? 'checked="checked"' : ''; ?> />
                                  <?php echo $text_bottom; ?> </label>
                            </div>
                          </div>
                        </div>
                        <hr />
                        <div class="form-group">
                          <div class="col-sm-4 col-sm-offset-4">
                            <div class="checkbox">
                              <label>
                                <input type="checkbox" name="showcase[subitem_heading]" value="1" <?php echo isset($showcase['subitem_heading']) ? 'checked="checked"' : ''; ?> />
                                <?php echo $text_heading; ?> </label>
                            </div>
                            <div class="checkbox">
                              <label>
                                <input type="checkbox" name="showcase[subitem_desc]" value="1" <?php echo isset($showcase['subitem_desc']) ? 'checked="checked"' : ''; ?> />
                                <?php echo $text_description; ?> </label>
                            </div>
                          </div>
                          <div class="col-sm-4">
                            <div class="checkbox">
                              <label>
                                <input type="checkbox" name="showcase[subitem_btn]" value="1" <?php echo isset($showcase['subitem_btn']) ? 'checked="checked"' : ''; ?> />
                                <?php echo $text_btn; ?> </label>
                            </div>
                          </div>
                        </div>
                        <hr />
                        <div class="form-group">
                          <label class="col-sm-4 control-label"><?php echo $entry_btn; ?></label>
                          <div class="col-sm-4">
                            <input type="text" name="showcase[subitem_btn_text]" value="<?php echo !empty($showcase['subitem_btn_text']) ? $showcase['subitem_btn_text'] : $text_more_btn; ?>" class="form-control text-center" />
                          </div>
                          <div class="col-sm-4">
                            <input type="text" name="showcase[subbtn_class]" value="<?php echo !empty($showcase['subbtn_class']) ? $showcase['subbtn_class'] : 'btn btn-default btn-block'; ?>" class="form-control text-center" />
                          </div>
                        </div>
                        <hr />
                        <div class="form-group">
                          <div class="col-sm-8 col-sm-offset-4">
                            <div class="checkbox">
                              <label>
                                <input type="checkbox" name="showcase[description_status]" value="1" <?php echo isset($showcase['description_status']) ? 'checked="checked"' : ''; ?> />
                                <?php echo $entry_parent_desc; ?> </label>
                            </div>
                          </div>
                        </div>
                        <hr />
                        <div class="form-group">
                          <label class="col-sm-4 control-label"><?php echo $entry_desc_limit; ?></label>
                          <div class="col-sm-4">
                            <input type="text" name="showcase[description_limit]" value="<?php echo !empty($showcase['description_limit']) ? $showcase['description_limit'] : ''; ?>" class="form-control text-center" />
                          </div>
                        </div>
                        <br />
                        <div class="form-group">
                          <div class="col-sm-8 col-sm-offset-4">
                            <h4><?php echo $entry_carousel; ?></h4>
                          </div>
                        </div>
                        <hr />
                        <div class="form-group">
                          <label class="col-sm-4 control-label"><?php echo $entry_subitems_carousel; ?></label>
                          <div class="col-sm-8">
                            <div class="btn-group btn-group-justified" data-toggle="buttons">
                              <label class="btn btn-success">
                                <input type="radio" name="showcase[subitems_carousel]" value="1" <?php echo isset($showcase['subitems_carousel']) ? 'checked="checked"' : ''; ?> />
                                <?php echo $text_enabled; ?> </label>
                              <label class="btn btn-danger">
                                <input type="radio" name="showcase[subitems_carousel]" value="0" <?php echo empty($showcase['subitems_carousel']) ? 'checked="checked"' : ''; ?> />
                                <?php echo $text_disabled; ?> </label>
                            </div>
                          </div>
                        </div>
                        <hr />
                        <div class="form-group">
                          <div class="col-sm-4 col-sm-offset-4">
                            <div class="checkbox">
                              <label>
                                <input type="checkbox" name="showcase[subitems_mousewheel]" value="1" <?php echo isset($showcase['subitems_mousewheel']) ? 'checked="checked"' : ''; ?> />
                                <?php echo $entry_mousewheel; ?> </label>
                            </div>
                            <div class="checkbox">
                              <label>
                                <input type="checkbox" name="showcase[subitems_drag]" value="1" <?php echo isset($showcase['subitems_drag']) ? 'checked="checked"' : ''; ?> />
                                <?php echo $entry_drag; ?> </label>
                            </div>
                          </div>
                          <div class="col-sm-4">
                            <div class="checkbox">
                              <label>
                                <input type="checkbox" name="showcase[subitems_dots]" value="1" <?php echo isset($showcase['subitems_dots']) ? 'checked="checked"' : ''; ?> />
                                <?php echo $entry_dots; ?> </label>
                            </div>
                            <div class="checkbox">
                              <label>
                                <input type="checkbox" name="showcase[subitems_nav]" value="1" <?php echo isset($showcase['subitems_nav']) ? 'checked="checked"' : ''; ?> />
                                <?php echo $entry_nav; ?> </label>
                            </div>
                          </div>
                        </div>
                        <hr />
                        <div class="form-group">
                          <label class="col-sm-4 control-label"><?php echo $entry_nav_text; ?></label>
                          <div class="col-sm-4">
                            <input type="text" name="showcase[subitems_prev_nav]" value='<?php echo !empty($showcase['subitems_prev_nav']) ? $showcase['subitems_prev_nav'] : '<i class="fa fa-chevron-left"></i>'; ?>' class="form-control text-center" />
                          </div>
                          <div class="col-sm-4">
                            <input type="text" name="showcase[subitems_next_nav]" value='<?php echo !empty($showcase['subitems_next_nav']) ? $showcase['subitems_next_nav'] : '<i class="fa fa-chevron-right"></i>'; ?>' class="form-control text-center" />
                          </div>
                        </div>
                        <hr />
                        <div class="form-group">
                          <label class="col-sm-4 control-label"><?php echo $entry_nav_speed; ?></label>
                          <div class="col-sm-4">
                            <input type="text" name="showcase[subitems_nav_speed]" value="<?php echo !empty($showcase['subitems_nav_speed']) ? $showcase['subitems_nav_speed'] : '200'; ?>" class="form-control text-center" />
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div id="moduleSetting" class="tab-pane">
              <div class="row">
                <div class="col-lg-6">
                  <div class="form-group required">
                    <label class="col-sm-4 control-label" for="input-name"><?php echo $entry_name; ?></label>
                    <div class="col-sm-8">
                      <input type="text" name="name" value="<?php echo $name; ?>" id="input-name" class="form-control" />
                      <?php if ($error_name) { ?>
                      <div class="text-danger"><?php echo $error_name; ?></div>
                      <?php } ?>
                    </div>
                  </div>
                  <hr />
                  <div class="form-group">
                    <label class="col-sm-4 control-label"><?php echo $entry_status; ?></label>
                    <div class="col-sm-8">
                      <div class="btn-group btn-group-justified" data-toggle="buttons">
                        <label class="btn btn-success">
                          <input type="radio" name="status" value="1" <?php echo isset($status) ? 'checked="checked"' : ''; ?> />
                          <?php echo $text_enabled; ?> </label>
                        <label class="btn btn-danger">
                          <input type="radio" name="status" value="0" <?php echo empty($status) ? 'checked="checked"' : ''; ?> />
                          <?php echo $text_disabled; ?> </label>
                      </div>
                    </div>
                  </div>
                  <hr />
                  <div class="form-group">
                    <label class="col-sm-4 control-label"><?php echo $entry_sc_class; ?></label>
                    <div class="col-sm-8">
                      <input type="text" name="showcase[sc_class]" value="<?php echo !empty($showcase['sc_class']) ? $showcase['sc_class'] : 'showcase'; ?>" class="form-control" />
                    </div>
                  </div>
                  <hr />
                  <div class="form-group">
                    <label class="col-sm-4 control-label"><?php echo $entry_store; ?></label>
                    <div class="col-sm-8">
                      <div class="well well-sm" style="height: 150px; overflow: auto; margin-bottom: 0;">
                        <div class="checkbox">
                          <label>
                            <input type="checkbox" name="showcase[store_id][]" value="0" <?php echo isset($showcase['store_id']) && in_array(0, $showcase['store_id']) ? 'checked="checked" ' : ''; ?> />
                            <?php echo $default_store; ?> </label>
                        </div>
                        <?php foreach ($stores as $store) { ?>
                        <div class="checkbox">
                          <label>
                            <input type="checkbox" name="showcase[store_id][]" value="<?php echo $store['store_id']; ?>" <?php echo isset($showcase['store_id']) && in_array($store['store_id'], $showcase['store_id']) ? 'checked="checked" ' : ''; ?> />
                            <?php echo $store['name']; ?> </label>
                        </div>
                        <?php } ?>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="col-lg-6">
                  <div class="form-group">
                    <label class="col-sm-4 control-label"><?php echo $entry_location; ?></label>
                    <div class="col-sm-8">
                      <input type="text" name="showcase[fcid]" value="" placeholder="<?php echo $text_cat_autocomplete; ?>" class="form-control" />
                      <div id="showcase-location" class="well well-sm" style="height: 131px; overflow: auto; margin-bottom: 0;">
                        <div class="checkbox" style="border-bottom: 1px dashed #CCC; padding-bottom: 9px;">
                          <label>
                            <input type="checkbox" name="showcase[location]" value="1" <?php echo isset($showcase['location']) ? 'checked="checked"' : ''; ?> />
                            <?php echo $text_allcat; ?> </label>
                        </div>
                        <?php foreach ($locations as $location) { ?>
                        <div id="showcase-location<?php echo $location['category_id']; ?>"><i class="fa fa-minus-circle"></i> <?php echo $location['name']; ?>
                          <input type="hidden" name="showcase[fcid][]" value="<?php echo $location['category_id']; ?>" />
                        </div>
                        <?php } ?>
                      </div>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-4 control-label"><?php echo $entry_customers; ?></label>
                    <div class="col-sm-8">
                      <div class="well well-sm" style="height: 150px; overflow: auto; margin-bottom: 0;">
                        <div class="checkbox" style="border-bottom: 1px dashed #CCC; padding-bottom: 9px;">
                          <label>
                            <input type="checkbox" name="showcase[all_customers]" value="1" <?php echo isset($showcase['all_customers']) ? 'checked="checked"' : ''; ?> />
                            <?php echo $text_all_customers; ?> </label>
                        </div>
                        <?php foreach ($customer_groups as $customer_group) { ?>
                        <div class="checkbox">
                          <label>
                            <input type="checkbox" name="showcase[customer_group_id][]" value="<?php echo $customer_group['customer_group_id']; ?>" <?php echo isset($showcase['customer_group_id']) && in_array($customer_group['customer_group_id'], $showcase['customer_group_id']) ? 'checked="checked" ' : ''; ?> />
                            <?php echo $customer_group['name']; ?> </label>
                        </div>
                        <?php } ?>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <input type="hidden" name="apply" id="apply" value="0" />
        </form>
      </div>
    </div>
  </div>
<script type="text/javascript"><!--
$('.sc-apply').delay(5000).fadeOut(300);
$('input[name=\'showcase[fcat]\']').autocomplete({
  source: function(request, response) {
    $.ajax({
      url: 'index.php?route=catalog/category/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
      dataType: 'json',
      success: function(json) {
        response($.map(json, function(item) {
          return {
            label: item['name'],
            value: item['category_id']
          }
        }));
      }
    });
  },
  select: function(item) {
    $('input[name=\'showcase[fcat]\']').val('');
    
    $('#showcase-fcat' + item['value']).remove();
    
    $('#showcase-fcat').append('<div id="showcase-fcat' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="showcase[fcat][]" value="' + item['value'] + '" /></div>');  
  }
});
  
$('#showcase-fcat').delegate('.fa-minus-circle', 'click', function() {
  $(this).parent().remove();
});

$('input[name=\'showcase[fbrand]\']').autocomplete({
  source: function(request, response) {
    $.ajax({
      url: 'index.php?route=catalog/manufacturer/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
      dataType: 'json',
      success: function(json) {
        response($.map(json, function(item) {
          return {
            label: item['name'],
            value: item['manufacturer_id']
          }
        }));
      }
    });
  },
  select: function(item) {
    $('input[name=\'showcase[fbrand]\']').val('');
    
    $('#showcase-fbrand' + item['value']).remove();
    
    $('#showcase-fbrand').append('<div id="showcase-fbrand' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="showcase[fbrand][]" value="' + item['value'] + '" /></div>');  
  }
});

$('#showcase-fbrand').delegate('.fa-minus-circle', 'click', function() {
  $(this).parent().remove();
});

$('input[name=\'showcase[fcid]\']').autocomplete({
  source: function(request, response) {
    $.ajax({
      url: 'index.php?route=catalog/category/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
      dataType: 'json',
      success: function(json) {
        response($.map(json, function(item) {
          return {
            label: item['name'],
            value: item['category_id']
          }
        }));
      }
    });
  },
  select: function(item) {
    $('input[name=\'showcase[fcid]\']').val('');
    
    $('#showcase-location' + item['value']).remove();
    
    $('#showcase-location').append('<div id="showcase-location' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="showcase[fcid][]" value="' + item['value'] + '" /></div>');
  }
});

$('#showcase-location').delegate('.fa-minus-circle', 'click', function() {
  $(this).parent().remove();
});

$('label.btn input').each(function() {
  if ($(this).prop('checked')) {
    $(this).parent('.btn').addClass('active');
  };
});
//--></script>
</div>
<?php echo $footer; ?>