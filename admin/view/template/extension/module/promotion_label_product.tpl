<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-module_product_pro" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-module_product_pro" class="form-horizontal">
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
            <div class="col-sm-10">
              <input type="text" name="name" value="<?php echo $name; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name" class="form-control" />
              <?php if ($error_name) { ?>
              <div class="text-danger"><?php echo $error_name; ?></div>
              <?php } ?>
            </div>
          </div> 
          <div class="form-group required">
            <label class="col-sm-2 control-label"><?php echo $entry_name; ?></label>
            <div class="col-sm-10">
              <?php foreach ($languages as $language) { ?>
              <div class="input-group"><span class="input-group-addon"><img src="<?php echo version_compare(VERSION, '2.2.0', '>=') ? "language/{$language['code']}/{$language['code']}.png" : "view/image/flags/{$language['image']}"; ?>" title="<?php echo $language['name']; ?>" /></span>
                <input type="text" name="module_name[<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($module_name[$language['language_id']]) ? $module_name[$language['language_id']]['name'] : ''; ?>" placeholder="<?php echo $entry_module_name; ?>" class="form-control" />
              </div>
              <?php if (isset($error_module_name[$language['language_id']])) { ?>
              <div class="text-danger"><?php echo $error_module_name[$language['language_id']]; ?></div>
              <?php } ?>
              <?php } ?>
            </div>
          </div>     
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-product">Показывать товары с:</label>
            <div class="col-sm-10">
              <select name="show_product" class="form-control" id="show-product">
                <option>Выберите</option>
                <option value="category" <?php if($show_product == 'category') { ?>selected="selected"<?php } ?> >Категорий</option>
                <option value="manufacturer" <?php if($show_product == 'manufacturer') { ?>selected="selected"<?php } ?> >Производителей</option>
                <option value="latest" <?php if($show_product == 'latest') { ?>selected="selected"<?php } ?> >Последние</option>
                <option value="bestseller" <?php if($show_product == 'bestseller') { ?>selected="selected"<?php } ?> >Бестселлеры</option>
                <option value="special" <?php if($show_product == 'special') { ?>selected="selected"<?php } ?> >Товары со скидками</option>
                <option value="popular" <?php if($show_product == 'popular') { ?>selected="selected"<?php } ?> >Популярные</option>
                <option value="featured" <?php if($show_product == 'featured') { ?>selected="selected"<?php } ?> >Рекомендуемые</option>
              </select>
            </div>
          </div>        
          <div class="form-group" id="category">
            <label class="col-sm-2 control-label" for="input-category"><?php echo $entry_category; ?></label>
            <div class="col-sm-10">
              <input type="text" name="category" value="" placeholder="<?php echo $entry_category; ?>" id="input-category" class="form-control" />
              <div id="product-category" class="well well-sm" style="height: 150px; overflow: auto;">
                <?php foreach ($categories as $category) { ?>
                <div id="product-category<?php echo $category['category_id']; ?>"><i class="fa fa-minus-circle"></i> <?php echo $category['name']; ?>
                  <input type="hidden" name="category[]" value="<?php echo $category['category_id']; ?>" />
                </div>
                <?php } ?>
              </div>
            </div>
          </div>
          <div class="form-group" id="manufacturer">
            <label class="col-sm-2 control-label" for="input-manufacturer"><?php echo $entry_manufacturer; ?></label>
            <div class="col-sm-10">
              <input type="text" name="manufacturer" value="" placeholder="<?php echo $entry_manufacturer; ?>" id="input-manufacturer" class="form-control" />
              <div id="product-manufacturer" class="well well-sm" style="height: 150px; overflow: auto;">
                <?php foreach ($manufacturers as $manufacturer) { ?>
                <div id="product-manufacturer<?php echo $manufacturer['manufacturer_id']; ?>"><i class="fa fa-minus-circle"></i> <?php echo $manufacturer['name']; ?>
                  <input type="hidden" name="manufacturer[]" value="<?php echo $manufacturer['manufacturer_id']; ?>" />
                </div>
                <?php } ?>
              </div>
            </div>
          </div>
          <div class="form-group" id="featured">
            <label class="col-sm-2 control-label" for="input-featured"><?php echo $entry_featured; ?></label>
            <div class="col-sm-10">
              <input type="text" name="product" value="" placeholder="<?php echo $entry_featured; ?>" id="input-product" class="form-control" />
              <div id="product-product" class="well well-sm" style="height: 150px; overflow: auto;">
                <?php foreach ($products as $product) { ?>
                <div id="product-product<?php echo $product['product_id']; ?>"><i class="fa fa-minus-circle"></i> <?php echo $product['name']; ?>
                  <input type="hidden" name="product[]" value="<?php echo $product['product_id']; ?>" />
                </div>
                <?php } ?>
              </div>
            </div>
          </div>
           <div class="form-group">
            <label class="col-sm-2 control-label" for="input-sort-product">Сортировка:</label>
            <div class="col-sm-10">
              <select name="sort_product" class="form-control">
                <option value="p.sort_order-ASC" <?php if($sort_product == 'p.sort_order-ASC') { ?>selected="selected"<?php } ?> >По умолчанию</option>
                <option value="pd.name-ASC" <?php if($sort_product == 'pd.name-ASC') { ?>selected="selected"<?php } ?> >Название (А-Я)</option>
                <option value="pd.name-DESC" <?php if($sort_product == 'pd.name-DESC') { ?>selected="selected"<?php } ?> >Название (Я-А)</option>
                <option value="p.viewed" <?php if($sort_product == 'p.viewed') { ?>selected="selected"<?php } ?> >Просмотры</option>
                <option value="p.date_added-DESC" <?php if($sort_product == 'p.date_added-DESC') { ?>selected="selected"<?php } ?> >Последние</option>
                <option value="p.date_added-ASC" <?php if($sort_product == 'p.date_added-ASC') { ?>selected="selected"<?php } ?> >Старые</option>
                <option value="p.price-ASC" <?php if($sort_product == 'p.price-ASC') { ?>selected="selected"<?php } ?> >Цена (возраст.)</option>
                <option value="p.price-DESC" <?php if($sort_product == 'p.price-DESC') { ?>selected="selected"<?php } ?> >Цена (убыв.)</option>
                <option value="rating-DESC" <?php if($sort_product == 'rating-DESC') { ?>selected="selected"<?php } ?> >Рейтинг (высокий)</option>
                <option value="rating-ASC" <?php if($sort_product == 'rating-ASC') { ?>selected="selected"<?php } ?> >Рейтинг (низкий)</option>
                <option value="p.model-ASC" <?php if($sort_product == 'p.model-ASC') { ?>selected="selected"<?php } ?> >Модель (А-Я)</option>
                <option value="p.model-DESC" <?php if($sort_product == 'p.model-DESC') { ?>selected="selected"<?php } ?> >Модель (Я-А)</option>
              </select>
            </div>
          </div>   
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-limit"><?php echo $entry_limit; ?></label>
            <div class="col-sm-10">
              <input type="text" name="limit" value="<?php echo $limit; ?>" placeholder="<?php echo $entry_limit; ?>" id="input-limit" class="form-control" />
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-width"><?php echo $entry_width; ?></label>
            <div class="col-sm-10">
              <input type="text" name="width" value="<?php echo $width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-width" class="form-control" />
              <?php if ($error_width) { ?>
              <div class="text-danger"><?php echo $error_width; ?></div>
              <?php } ?>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-height"><?php echo $entry_height; ?></label>
            <div class="col-sm-10">
              <input type="text" name="height" value="<?php echo $height; ?>" placeholder="<?php echo $entry_height; ?>" id="input-height" class="form-control" />
              <?php if ($error_height) { ?>
              <div class="text-danger"><?php echo $error_height; ?></div>
              <?php } ?>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
            <div class="col-sm-10">
              <select name="status" id="input-status" class="form-control">
                <?php if ($status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
  <script type="text/javascript">
$(document).ready(function(){
  $("#category").hide();
  $("#manufacturer").hide();
  $("#featured").hide();
    $("#show-product").change(function(){
     if($("#show-product").val() == 'category'){
        $("#category").show();
        $("#manufacturer").hide();
        $("#featured").hide();
     }if($("#show-product").val() == 'manufacturer'){
        $("#manufacturer").show();
        $("#category").hide();
        $("#featured").hide();
     }if($("#show-product").val() == 'bestseller'){
        $("#manufacturer").hide();
        $("#category").hide();
        $("#featured").hide();
     }if($("#show-product").val() == 'special'){
        $("#manufacturer").hide();
        $("#category").hide();
        $("#featured").hide();
     }if($("#show-product").val() == 'popular'){
        $("#manufacturer").hide();
        $("#category").hide();
        $("#featured").hide();
     }if($("#show-product").val() == 'latest'){
        $("#manufacturer").hide();
        $("#category").hide();
        $("#featured").hide();
     }if($("#show-product").val() == 'featured'){
        $("#featured").show();
        $("#category").hide();
        $("#manufacturer").hide();
     }
    });

    if($("#show-product").val() == 'category'){
        $("#category").show();
        $("#manufacturer").hide();
        $("#featured").hide();
     }if($("#show-product").val() == 'manufacturer'){
        $("#manufacturer").show();
        $("#category").hide();
        $("#featured").hide();
     }if($("#show-product").val() == 'featured'){
        $("#featured").show();
        $("#category").hide();
        $("#manufacturer").hide();
     }if($("#show-product").val() == 'bestseller'){
        $("#featured").hide();
        $("#category").hide();
        $("#manufacturer").hide();
     }if($("#show-product").val() == 'latest'){
        $("#featured").hide();
        $("#category").hide();
        $("#manufacturer").hide();
     }if($("#show-product").val() == 'special'){
        $("#featured").hide();
        $("#category").hide();
        $("#manufacturer").hide();
     }if($("#show-product").val() == 'popular'){
        $("#featured").hide();
        $("#category").hide();
        $("#manufacturer").hide();
     }
});
  </script>

  <script type="text/javascript"><!--

$('input[name=\'category\']').autocomplete({
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
    $('input[name=\'category\']').val('');
    
    $('#product-category' + item['value']).remove();
    
    $('#product-category').append('<div id="product-category' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="category[]" value="' + item['value'] + '" /></div>');  
  }
});
  
$('#product-category').delegate('.fa-minus-circle', 'click', function() {
  $(this).parent().remove();
});

$('input[name=\'manufacturer\']').autocomplete({
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
    $('input[name=\'manufacturer\']').val('');
    
    $('#product-manufacturer' + item['value']).remove();
    
    $('#product-manufacturer').append('<div id="product-manufacturer' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="manufacturer[]" value="' + item['value'] + '" /></div>');  
  }
});
  
$('#product-manufacturer').delegate('.fa-minus-circle', 'click', function() {
  $(this).parent().remove();
});


$('input[name=\'product\']').autocomplete({
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						label: item['name'],
						value: item['product_id']
					}
				}));
			}
		});
	},
	select: function(item) {
		$('input[name=\'product\']').val('');
		
		$('#product-product' + item['value']).remove();
		
		$('#product-product').append('<div id="product-product' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="product[]" value="' + item['value'] + '" /></div>');	
	}
});
	
$('#product-product').delegate('.fa-minus-circle', 'click', function() {
	$(this).parent().remove();
});
//--></script>
</div>
<?php echo $footer; ?>