<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
<?php echo $agoo_header; ?>
  <div class="page-header">
    <div class="container-fluid">

<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script>


<div id="content1" style="border: none;">

<div style="clear: both; line-height: 1px; font-size: 1px;"></div>


<?php if ($error_warning) { ?>
    <div class="alert alert-danger warning"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
<?php } ?>

<?php if ($success) { ?>
    <div class="alert alert-success success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
<?php } ?>


<div class="box1">

<div class="content">

<?php echo $agoo_menu; ?>

      <div class="buttons" style="float:right;">
      <a onclick="location = '<?php echo $insert; ?>'" class="mbutton button_orange nohref"><span class="sc_plus sc_round_green">+</span><?php echo $language->get('button_insert'); ?></a>
      <a onclick="$('#form').attr('action', '<?php echo $copy; ?>'); $('#form').submit();" class="mbutton button_orange nohref"><span class="sc_delete sc_round_orange">+</span><?php echo $button_copy; ?></a>
      <a onclick="$('#form').submit();" class="mbuttonr nohref"><span class="sc_delete sc_round_red">X</span><?php echo $button_delete; ?></a>
      </div>


<div style="width: 100%; overflow: hidden; clear: both; height: 1px; line-height: 1px;">&nbsp;</div>


  <div class="box">



    <div class="content">
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="mytable">
          <thead>
            <tr>
              <td width="1" style="text-align: center;">
              <input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" />
              </td>
              <td class="left">
				<?php echo $language->get('column_id').' ('.count($categories).')'; ?>
               </td>
              <td class="left"><?php echo $column_name; ?></td>

              <td class="left">
               <?php echo $column_status; ?>
              </td>

              <td class="right"><?php echo $column_sort_order; ?></td>
              <td class="right"><?php echo $column_action; ?></td>
            </tr>
          </thead>
          <tbody>
            <?php if ($categories) { ?>
            <?php foreach ($categories as $blog) { ?>
            <tr>
              <td style="text-align: center;"><?php if ($blog['selected']) { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $blog['blog_id']; ?>" checked="checked" />
                <?php } else { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $blog['blog_id']; ?>" />
                <?php } ?></td>
 				<td class="left" style="color: #999;"><?php echo $blog['blog_id']; ?></td>

              <td class="left">

              <div style="float: left;">
              <img src="<?php echo $blog['image']; ?>" alt="<?php echo $blog['name']; ?>" style="padding: 1px; margin-right: 15px;border: 1px solid #EEE;" />
              </div>


              <?php echo $blog['name']; ?>

              <a href="<?php echo $blog['url']; ?>" target="_blank"><?php if (SC_VERSION > 15) { ?><i class="fa fa-link" aria-hidden="true"></i><?php } else { ?>#<?php } ?></a>

              </td>


             <td class="left">
             <a class="blog_status hrefajax" data-id="<?php echo $blog['blog_id']; ?>" ><?php echo $blog['status']; ?></a>
             </td>



              <td class="right"><?php echo $blog['sort_order']; ?></td>
              <td class="right"><?php foreach ($blog['action'] as $action) { ?>
                <a href="<?php echo $action['href']; ?>"  class="markbuttono"><?php echo $action['text']; ?></a>
                <?php } ?></td>
            </tr>
            <?php } ?>
            <?php } else { ?>
            <tr>
              <td class="center" colspan="4"><?php echo $text_no_results; ?></td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
      </form>
    </div>
  </div>
</div>
  </div>
</div>
</div>

<script>
$('.blog_status').click(function() {
  var id = $(this).attr('data-id');
  var this_object = $(this);

		$.ajax({
			url: '<?php echo $url_switchstatus; ?>'+'&id='+id,
			dataType: 'html',
			beforeSend: function()
			{
             	this_object.html('<?php echo $language->get('text_loading_adapter'); ?>');
			},
			success: function(html) {
				this_object.html(html);
			},
			error: function(html) {
				this_object.html('Error');
			}
		});
});
</script>

<?php echo $footer; ?>
