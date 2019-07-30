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

<?php if (isset($agoo_menu)) echo $agoo_menu; ?>



      <div class="buttons" style="float:right; ">
      <a onclick="location = '<?php echo $insert; ?>'" class="mbutton button_orange nohref"><span class="sc_plus sc_round_green">+</span><?php echo $button_insert; ?></a>
      <a onclick="$('#form').attr('action', '<?php echo $copy; ?>'); $('#form').submit();" class="mbutton button_orange nohref"><span class="sc_delete sc_round_orange">+</span><?php echo $button_copy; ?></a>
      <a onclick="$('form').submit();" class="mbuttonr nohref"><span class="sc_delete sc_round_red">X</span><?php echo $button_delete; ?></a>
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
				<?php echo $language->get('column_id').' ('.$record_total.')'; ?>
               </td>
           <!--    <td class="center"><?php echo $column_image; ?></td> -->
              <td class="left"><?php if ($sort == 'pd.name') { ?>
                <a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_name; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_name; ?>"><?php echo $column_name; ?></a>
                <?php } ?></td>
              <td class="left"><?php if ($sort == 'blog_name') { ?>
                <a href="<?php echo $sort_blog; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_blog; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_blog; ?>"><?php echo $column_blog; ?></a>
                <?php } ?></td>

              <td class="left"><?php if ($sort == 'p.status') { ?>
                <a href="<?php echo $sort_status; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_status; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_status; ?>"><?php echo $column_status; ?></a>
                <?php } ?></td>

              <td class="left"><?php if ($sort == 'p.date_added') { ?>
                <a href="<?php echo $sort_date; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_date; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_date; ?>"><?php echo $column_date; ?></a>
                <?php } ?></td>

              <td class="right"><?php echo $column_action; ?></td>
            </tr>
          </thead>
          <tbody>
            <tr class="filter">
              <td></td>
               <td></td>
              <td><input type="text" name="filter_name" class="filter_name" value="<?php echo $filter_name; ?>" /></td>
              <td><input type="text" name="filter_blog" class="filter_blog" value="<?php echo $filter_blog; ?>" /></td>

               <td><select name="filter_status">
                  <option value="*"></option>
                  <?php if ($filter_status) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <?php } ?>
                  <?php if (!is_null($filter_status) && !$filter_status) { ?>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></td>

            <td></td>


              <td align="right"><a onclick="filter();" class="markbutton button_blue nohref"><?php echo $button_filter; ?></a></td>
            </tr>
            <?php if ($records) { ?>
            <?php foreach ($records as $record) { ?>
            <tr>
              <td style="text-align: center;"><?php if ($record['selected']) { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $record['record_id']; ?>" checked="checked" />
                <?php } else { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $record['record_id']; ?>" />
                <?php } ?>
               </td>

                <td style="color: #999;">
                 <?php echo $record['record_id']; ?>
                </td>



             <!-- <td class="center"><img src="<?php echo $record['image']; ?>" alt="<?php echo $record['name']; ?>" style="padding: 1px; border: 1px solid #DDDDDD;" /></td> -->
              <td class="left">
              <div style="float: left;">
              <img src="<?php echo $record['image']; ?>" alt="<?php echo $record['name']; ?>" style="padding: 1px; margin-right: 15px;border: 1px solid #EEE;" />
              </div>
              <div style="float: left; vertical-align: center; padding-top:10px;">
               <?php foreach ($record['action'] as $action) { ?>
                 <a href="<?php echo $action['href']; ?>"  style="text-decoration: none; border-bottom: 1px solid;"><?php echo $record['name']; ?></a>
                 <a href="<?php echo $record['url']; ?>" target="_blank"><?php if (SC_VERSION > 15) { ?><i class="fa fa-link" aria-hidden="true"></i><?php } else { ?>#<?php } ?></a>
                <?php } ?>


              </div>
              </td>
              <td class="left"><?php echo $record['blog']; ?></td>

             <td class="left"><a class="record_status hrefajax" data-id="<?php echo $record['record_id']; ?>" ><?php echo $record['status']; ?></a></td>

             <td class="left"><?php echo $record['date_available']; ?></td>

              <td class="right"><?php foreach ($record['action'] as $action) { ?>
                <a href="<?php echo $action['href']; ?>" class="markbuttono" style="text-decoration: none; border-bottom: 1px solid;"><?php echo $action['text']; ?></a>
                <?php } ?></td>
            </tr>
            <?php } ?>
            <?php } else { ?>
            <tr>
              <td class="center" colspan="8"><?php echo $text_no_results; ?></td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
      </form>
      <div class="pagination"><?php echo $pagination; ?></div>
    </div>
  </div>
</div>

<script type="text/javascript">
function filter() {
	url = 'index.php?route=catalog/record&<?php echo $token_name; ?>=<?php echo $token; ?>';

	var filter_name = $('input[name=\'filter_name\']').prop('value');

	if (filter_name) {
		url += '&filter_name=' + encodeURIComponent(filter_name);
	}

	var filter_blog = $('input[name=\'filter_blog\']').prop('value');

	if (filter_blog) {
		url += '&filter_blog=' + encodeURIComponent(filter_blog);
	}


	var filter_status = $('select[name=\'filter_status\']').prop('value');

	if (filter_status != '*') {
		url += '&filter_status=' + encodeURIComponent(filter_status);
	}

	location = url;
}
</script>
<script type="text/javascript">
$('#form input').keydown(function(e) {
	if (e.keyCode == 13) {
		filter();
	}
});
</script>


<script>
filter_auto = function() {
	$('.filter_name, .filter_blog').each(function() {

		var e = this;
		var iname = $(e).prop('name');
        if (iname == 'filter_blog') {        	var ipointer = 'blog_id';
        } else {        	var ipointer = '';
        }
		$(e).autocomplete({
			'source': function(request, response) {         	<?php
         	if (SC_VERSION < 20) {
         	?>
         	 var irequest = request.term;
         	<?php
         	} else {
         	?>
         	var irequest = request;
         	<?php
         	}
         	?>
			$.ajax({
					url: 'index.php?route=catalog/record/autocomplete&<?php echo $token_name; ?>=<?php echo $token; ?>'+'&pointer='+ipointer+'&'+iname+'=' +  encodeURIComponent(irequest),
					dataType: 'json',
					success: function(json) {
						response($.map(json, function(item) {
							return {
								label: item.name,
								value: item.name
							}
						}));
					}
				});

			},
			'select': function(event, ui) {
         	<?php
         	if (SC_VERSION < 20) {
         	?>
         	 var veli = ui.item.value;
         	<?php
         	} else {
         	?>
         		var veli = event['value'];
         	<?php
         	}
         	?>
 			$('input[name=\''+ iname +'\']').val(veli);
			return false;
			}
		});

	});
}
filter_auto();
</script>


<script>

$('.record_status').click(function() {
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

</div>
<?php echo $footer; ?>
