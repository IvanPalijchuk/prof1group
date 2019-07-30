<?php echo $header; ?><?php echo $column_left; ?>

<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
      <div class="panel-body">
		<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
           <fieldset>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><?php echo $entry_display_multiple_prices; ?></label>
                  <div class="col-sm-10">
                    <label class="radio-inline">
                      <?php if ($cgp_display_multiple_prices) { ?>
                      <input type="radio" name="cgp_display_multiple_prices" value="1" checked="checked" />
                      <?php echo $text_yes; ?>
                      <?php } else { ?>
                      <input type="radio" name="cgp_display_multiple_prices" value="1" />
                      <?php echo $text_yes; ?>
                      <?php } ?>
                    </label>
                    <label class="radio-inline">
                      <?php if (!$cgp_display_multiple_prices) { ?>
                      <input type="radio" name="cgp_display_multiple_prices" value="0" checked="checked" />
                      <?php echo $text_no; ?>
                      <?php } else { ?>
                      <input type="radio" name="cgp_display_multiple_prices" value="0" />
                      <?php echo $text_no; ?>
                      <?php } ?>
                    </label>
                  </div>
                </div>
                <div class="form-group">
					<div class="table-responsive">
						<table class="table table-bordered table-hover">
						  <thead>
							<tr>
							  <td class="text-left"><?php echo $entry_customer_group_name; ?></td>
							  <td class="text-left"><?php echo $entry_show_as_reference_on_product_page; ?></td>
							  <td class="text-left"><?php echo $entry_sort_order; ?></td>
							  <td class="text-left"><?php echo $entry_use_custom_style; ?></td>
							  <td class="text-left"><?php echo $entry_text_color; ?></td>
							  <td class="text-left"><?php echo $entry_apply_style_to; ?></td>
							</tr>
						  </thead>
						  <tbody>							
							<?php
								$row = -1;
								foreach($cgp_customer_group_settings as $customer_group_settings) {
								$row++;
							?>
							<tr>
							  <td class="text-center">
								<?php echo $customer_group_settings['name']; ?>
								<input type="hidden" name="cgp_customer_group_settings[<?php echo $row; ?>][customer_group_id]" value="<?php echo $customer_group_settings['customer_group_id']; ?>"/>
							  </td>
							  <td class="text-center">
								<input type="checkbox" name="cgp_customer_group_settings[<?php echo $row; ?>][show_as_reference_on_product_page]" value="1" <?php echo $customer_group_settings['show_as_reference_on_product_page'] ? 'checked="checked"' : ''; ?> >
							  </td>
							  <td class="text-center">
								<input type="text" name="cgp_customer_group_settings[<?php echo $row; ?>][sort_order]" value="<?php echo $customer_group_settings['sort_order']; ?>" size="1" class="form-control" />
							  </td>
							  <td class="text-center">
								<input type="checkbox" name="cgp_customer_group_settings[<?php echo $row; ?>][use_custom_style]" value="1" <?php echo $customer_group_settings['use_custom_style'] ? 'checked="checked"' : ''; ?> >
							  </td>
							  <td class="text-center">
								<input type="text" name="cgp_customer_group_settings[<?php echo $row; ?>][text_color]" value="<?php echo $customer_group_settings['text_color']; ?>" readonly="true" id="color-input<?php echo $row; ?>" class="color-input form-control" />
							  </td>
							  <td class="text-center">
								<input type="checkbox" name="cgp_customer_group_settings[<?php echo $row; ?>][apply_style_to_name]" value="1" <?php echo $customer_group_settings['apply_style_to_name'] ? 'checked="checked"' : ''; ?> ><?php echo $text_name; ?>
								<input type="checkbox" name="cgp_customer_group_settings[<?php echo $row; ?>][apply_style_to_text]" value="1" <?php echo $customer_group_settings['apply_style_to_text'] ? 'checked="checked"' : ''; ?> ><?php echo $text_price; ?>
							  </td>
							</tr>
							<?php } ?>
						  </tbody>
						</table>
				    </div>
                </div>
          </fieldset>
        </form>
      </div>
    </div>
  </div>
</div>
<link rel="stylesheet" href="view/stylesheet/colorpicker/colorpicker.css" type="text/css" />
<script type="text/javascript" src="view/javascript/colorpicker/colorpicker.js"></script>
<script type="text/javascript" src="view/javascript/colorpicker/eye.js"></script>
<script type="text/javascript" src="view/javascript/colorpicker/utils.js"></script>
<script type="text/javascript" src="view/javascript/colorpicker/layout.js?ver=1.0.2"></script>
<script type="text/javascript" src="view/javascript/colorpicker/misc.js"></script>
<script type="text/javascript">
	colorPickerise($('.color-input'));
</script>
<style>
	.hidden
	{
		display: none !important;
	}
	
	.width-auto
	{
		width: auto;
	}
</style>

<?php echo $footer; ?>
