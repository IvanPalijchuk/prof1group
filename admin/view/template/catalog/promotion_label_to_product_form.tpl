<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-label-product" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_form; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-label-product" class="form-horizontal">
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-product"><?php echo $entry_product; ?></label>
            <div class="col-sm-10">
              <input type="text" name="product" value="<?php echo $product ?>" placeholder="<?php echo $entry_product; ?>" id="input-product" class="form-control" />
              <input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />
              <?php if ($error_product) { ?>
                <div class="text-danger"><?php echo $error_product; ?></div>
              <?php } ?>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-label"><?php echo $entry_label; ?></label>
            <div class="col-sm-10">
              <input type="text" name="label" value="<?php echo $label; ?>" placeholder="<?php echo $entry_label; ?>" id="input-label" class="form-control" />
              <input type="hidden" name="label_id" value="<?php echo $label_id; ?>" />
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-date-start"><?php echo $entry_position; ?></label>
            <div class="col-sm-3">
              <select name="position" class="form-control">
                <option value="rb-tl" <?php if($position == 'rb-tl') { ?>selected="selected"<?php } ?> >Вверху слева</option>
                <option value="rb-tr" <?php if($position == 'rb-tr') { ?>selected="selected"<?php } ?> >Вверху справа</option>
                <option value="rb-bl" <?php if($position == 'rb-bl') { ?>selected="selected"<?php } ?> >Внизу слева</option>
                <option value="rb-br" <?php if($position == 'rb-br') { ?>selected="selected"<?php } ?> >Внизу справа</option>
              </select>
            </div>  
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-date-start"><?php echo $entry_date_start; ?></label>
            <div class="col-sm-3">
              <div class="input-group date">
                <input type="text" name="date_start" value="<?php echo $date_start; ?>" placeholder="<?php echo $entry_date_start; ?>" data-date-format="YYYY-MM-DD" id="input-date-start" class="form-control" />
                <span class="input-group-btn">
                  <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                </span></div>
            </div>
          </div>  
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-date-start"><?php echo $entry_date_end; ?></label>
            <div class="col-sm-3">
              <div class="input-group date">
                <input type="text" name="date_end" value="<?php echo $date_end; ?>" placeholder="<?php echo $entry_date_end; ?>" data-date-format="YYYY-MM-DD" id="input-date-end" class="form-control" />
                <span class="input-group-btn">
                  <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                </span></div>
            </div>
          </div>        
            
        </form>
      </div>
    </div>
  </div>
<style type="text/css">
.image {
  width: 182px;
  height: 182px;
  position: relative;
  border: 1px solid #d1d1d1;
  margin: 0 auto 20px auto;
}
.image .rb-tl {
  position: absolute;
  top: 0px;
  left: 0px;
}
.image .rb-tr {
  position: absolute;
  top: 0px;
  right: 0px;
}
.image .rb-bl {
  position: absolute;
  bottom: 0px;
  left: 0px;
}
.image .rb-br {
  position: absolute;
  bottom: 0px;
  right: 0px;
}
</style>  
<script type="text/javascript"><!--
$('.date').datetimepicker({
  pickTime: false
});

$('.time').datetimepicker({
  pickDate: false
});

$('.datetime').datetimepicker({
  pickDate: true,
  pickTime: true
});
//--></script>   
<script type="text/javascript"><!--
// Product
$('input[name=\'product\']').autocomplete({
  'source': function(request, response) {
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
  'select': function(item) {
    $('input[name=\'product\']').val(item['label']);
    $('input[name=\'product_id\']').val(item['value']);
  } 
});
//Label
$('input[name=\'label\']').autocomplete({
  'source': function(request, response) {
    $.ajax({
      url: 'index.php?route=catalog/promotion_label_pro/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
      dataType: 'json',     
      success: function(json) {

        json.unshift({
          label_id: 0,
          name: '<?php echo $text_none; ?>'
        });
        
        response($.map(json, function(item) {
          return {
            label: item['name'],
            value: item['label_id']
          }
        }));
      }
    });
  },
  'select': function(item) {
    $('input[name=\'label\']').val(item['label']);
    $('input[name=\'label_id\']').val(item['value']);
  } 
});
</script>
</div>
<?php echo $footer; ?> 