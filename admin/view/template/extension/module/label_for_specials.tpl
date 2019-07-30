<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-label-for-specials" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
		<button id="apply" data-toggle="tooltip" data-loading-text="<i class='fa fa-spin fa-cog'></i>" title="" class="btn btn-success" data-original-title="<?php echo $button_save_stay; ?>"><i class="fa fa-save"></i></button>
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
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-label-for-specials" class="form-horizontal">
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-label_for_specials_status"><?php echo $entry_status; ?></label>
            <div class="col-sm-10">
              <select name="label_for_specials_status" id="input-label_for_specials_status" class="form-control">
                <?php if ($label_for_specials_status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-label_for_specials_label_type"><?php echo $entry_label_type; ?></label>
            <div class="col-sm-10">
              <select name="label_for_specials_label_type" id="input-label_for_specials_label_type" class="form-control">
                <option value="percent" <?php echo $label_for_specials_label_type == 'percent' ? 'selected="selected"' : ''; ?>><?php echo $text_percent; ?></option>
                <option value="amount" <?php echo $label_for_specials_label_type == 'amount' ? 'selected="selected"' : ''; ?>><?php echo $text_amount; ?></option>
                <option value="text" <?php echo $label_for_specials_label_type == 'text' ? 'selected="selected"' : ''; ?>><?php echo $text_text; ?></option>
              </select>
			  <div class="dc-custom-text" style="display:none">
              <?php foreach ($languages as $language) { ?>
				<img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?>
                <input type="text" name="label_for_specials_label_text[<?php echo $language['language_id']; ?>]" placeholder="<?php echo $text_text; ?>" value="<?php echo isset($label_for_specials_label_text[$language['language_id']]) ? $label_for_specials_label_text[$language['language_id']] : ''; ?>" class="form-control" />
              <?php } ?>
			  </div>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_label_position; ?></label>
            <div class="col-sm-10">
			  <select name="label_for_specials_label_style[position]" class="form-control">
                <option value="top-left" <?php echo isset($label_for_specials_label_style['position']) && $label_for_specials_label_style['position'] == 'top-left' ? 'selected="selected"' : ''; ?>><?php echo $text_top_left; ?></option>
                <option value="top-right" <?php echo isset($label_for_specials_label_style['position']) && $label_for_specials_label_style['position'] == 'top-right' ? 'selected="selected"' : ''; ?>><?php echo $text_top_right; ?></option>
                <option value="bottom-left" <?php echo isset($label_for_specials_label_style['position']) && $label_for_specials_label_style['position'] == 'bottom-left' ? 'selected="selected"' : ''; ?>><?php echo $text_bottom_left; ?></option>
                <option value="bottom-right" <?php echo isset($label_for_specials_label_style['position']) && $label_for_specials_label_style['position'] == 'bottom-right' ? 'selected="selected"' : ''; ?>><?php echo $text_bottom_right; ?></option>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_label_width; ?></label>
            <div class="col-sm-10">
              <input type="text" name="label_for_specials_label_style[width]" placeholder="<?php echo $entry_label_width; ?>" value="<?php echo isset($label_for_specials_label_style['width']) ? $label_for_specials_label_style['width'] : ''; ?>" class="form-control" />
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_label_height; ?></label>
            <div class="col-sm-10">
              <input type="text" name="label_for_specials_label_style[height]" placeholder="<?php echo $entry_label_height; ?>" value="<?php echo isset($label_for_specials_label_style['height']) ? $label_for_specials_label_style['height'] : ''; ?>" class="form-control" />
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_label_background_color; ?></label>
            <div class="col-sm-10">
              <input type="color" name="label_for_specials_label_style[background_color]" placeholder="<?php echo $entry_label_background_color; ?>" value="<?php echo isset($label_for_specials_label_style['background_color']) ? $label_for_specials_label_style['background_color'] : ''; ?>" class="form-control" />
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_label_text_color; ?></label>
            <div class="col-sm-10">
              <input type="color" name="label_for_specials_label_style[text_color]" placeholder="<?php echo $entry_label_text_color; ?>" value="<?php echo isset($label_for_specials_label_style['text_color']) ? $label_for_specials_label_style['text_color'] : ''; ?>" class="form-control" />
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_label_border_radius; ?></label>
            <div class="col-sm-10">
              <input type="text" name="label_for_specials_label_style[border_radius]" placeholder="<?php echo $entry_label_border_radius; ?>" value="<?php echo isset($label_for_specials_label_style['border_radius']) ? $label_for_specials_label_style['border_radius'] : ''; ?>" class="form-control" />
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_label_padding; ?></label>
            <div class="col-sm-10">
              <input type="text" name="label_for_specials_label_style[padding]" placeholder="<?php echo $entry_label_padding; ?>" value="<?php echo isset($label_for_specials_label_style['padding']) ? $label_for_specials_label_style['padding'] : ''; ?>" class="form-control" />
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_label_line_height; ?></label>
            <div class="col-sm-10">
              <input type="text" name="label_for_specials_label_style[line_height]" placeholder="<?php echo $entry_label_line_height; ?>" value="<?php echo isset($label_for_specials_label_style['line_height']) ? $label_for_specials_label_style['line_height'] : ''; ?>" class="form-control" />
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_label_text_size; ?></label>
            <div class="col-sm-10">
              <input type="text" name="label_for_specials_label_style[text_size]" placeholder="<?php echo $entry_label_text_size; ?>" value="<?php echo isset($label_for_specials_label_style['text_size']) ? $label_for_specials_label_style['text_size'] : ''; ?>" class="form-control" />
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
<style>
.nav-tabs { border-bottom: 2px solid #DDD; }
.nav-tabs > li.active > a, .nav-tabs > li.active > a:focus, .nav-tabs > li.active > a:hover { border-width: 0; }
.nav-tabs > li > a { border: none; color: #666; }
.nav-tabs > li.active > a, .nav-tabs > li > a:hover { border: none; color: #4285F4 !important; background: transparent; }
.nav-tabs > li > a::after { content: ""; background: #4285F4; height: 2px; position: absolute; width: 100%; left: 0px; bottom: -1px; transition: all 250ms ease 0s; transform: scale(0); }
.nav-tabs > li.active > a::after, .nav-tabs > li:hover > a::after { transform: scale(1); }
.tab-nav > li > a::after { background: #21527d none repeat scroll 0% 0%; color: #fff; }
body{ background: #EDECEC;}
.nav-tabs li a:focus {outline: none;}
</style>
<script>
	$('select[name="label_for_specials_label_type"]').on('change', function(){
		if($(this).val() == 'text'){
			$('.dc-custom-text').fadeIn();
		} else {
			$('.dc-custom-text').fadeOut();
		}
	});
	$('select[name="label_for_specials_label_type"]').trigger('change');
	
	$('body').on('click', '#apply', function(){
		$.ajax({
			type: 'post',
			url: $('form').attr('action') + '&save',
			data: $('form').serialize(),
			beforeSend: function() {
				$('form').fadeTo('slow', 0.3);
				$('#apply').button('loading');
				$('#dc-admin-notification').remove();
			},
			complete: function() {
				$('form').fadeTo('slow', 1);
				$('#apply').button('reset');
			},
			success: function(response) {
				$('body').append('<p id="dc-admin-notification" class="alert alert-success" style="position: fixed; z-index: 999; bottom: 0px; right: 0px; left: 0px; margin: auto; display: inline-block; width: 200px; text-align: center;"><?php echo $text_saved; ?></p>');
				setTimeout(function(){
					$('#dc-admin-notification').fadeOut();
				}, 2000);
			}
		});
	});
</script>
<?php echo $footer; ?>