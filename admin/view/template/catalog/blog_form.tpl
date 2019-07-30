<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
<?php echo $agoo_header; ?>
  <div class="page-header">
    <div class="container-fluid">

<?php
if (SC_VERSION < 20) {
?>
<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script>
<?php
}
?>
<script>
var myEditor = new Array();
</script>


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
      <a onclick="form_submit()" class="markbutton button_orange nohref"><?php echo $button_save; ?></a>
      <?php if (isset( $ascp_settings['related_widget_status']) && $ascp_settings['related_widget_status']) { ?>
      <a onclick="$('#form').append('<input type=\'hidden\' name=\'button_apply\' value=\'1\'>'); $('#form').submit();" class="markbutton button_orange nohref"><?php echo $button_apply; ?></a>
      <?php } ?>
      <a onclick="location = '<?php echo $cancel; ?>';" class="markbutton button_orange nohref"><?php echo $button_cancel; ?></a>
	  </div>


 <div style="width: 100%; overflow: hidden; clear: both; height: 1px; line-height: 1px;">&nbsp;</div>


  <div class="box">

    <div class="content">
      <div id="tabs" class="htabs">
      <a href="#tab-general"><?php echo $tab_gen; ?></a>
      <a href="#tab-data"><?php echo $tab_data; ?></a>
	  <a href="#tab-options"><?php echo $tab_options; ?></a>
      <a href="#tab-design"><?php echo $tab_design; ?></a>

     </div>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <div id="tab-general">
          <div id="languages" class="htabs">
            <?php foreach ($languages as $lang) { ?>
            <a href="#language<?php echo $lang['language_id']; ?>"><img src="<?php echo $lang['image']; ?>" title="<?php echo $lang['name']; ?>" /> <?php echo $lang['name']; ?></a>
            <?php } ?>
          </div>
          <?php foreach ($languages as $lang) { ?>
          <div id="language<?php echo $lang['language_id']; ?>">
            <table class="form">
              <tr>
                <td><span class="required">*</span> <?php echo $entry_name; ?></td>
                <td>
                <div class="input-group">
                <input type="text" class="category_name_<?php echo $lang['language_id']; ?> form-control" name="blog_description[<?php echo $lang['language_id']; ?>][name]" size="100" value="<?php echo isset($blog_description[$lang['language_id']]['name']) ? $blog_description[$lang['language_id']]['name'] : ''; ?>" />
                 <?php if (isset($error_name[$lang['language_id']])) { ?>
                  <span class="error"><?php echo $error_name[$lang['language_id']]; ?></span>
                  <?php } ?>
                   </div>
                  </td>
              </tr>

            <tr>
              <td><?php echo $entry_keyword; ?></td>
              <td>
              <div class="input-group">
              <input type="text" id="category_seo_url_<?php echo $lang['language_id']; ?>" class="form-control" name="keyword[<?php echo $lang['language_id']; ?>]" value="<?php if (isset($keyword[$lang['language_id']])) echo $keyword[$lang['language_id']]; ?>" size="50"/>
                  <?php if (isset($error_keyword[$lang['language_id']])) { ?>
                  <span class="error"><?php echo $error_keyword[$lang['language_id']]; ?></span>
                  <?php } ?>
                  </div>
                  </td>
            </tr>



              <tr>
                <td><?php echo $language->get('entry_meta_title'); ?></td>
                <td>
                <div class="input-group">
                <input type="text" name="blog_description[<?php echo $lang['language_id']; ?>][meta_title]" class="form-control" size="100" value="<?php echo isset($blog_description[$lang['language_id']]['meta_title']) ? $blog_description[$lang['language_id']]['meta_title'] : ''; ?>" />
                 </div>
                </td>
              </tr>

              <tr>
                <td><?php echo $language->get('entry_meta_h1'); ?></td>
                <td>
                <div class="input-group">
                <input type="text" name="blog_description[<?php echo $lang['language_id']; ?>][meta_h1]" class="form-control" size="100" value="<?php echo isset($blog_description[$lang['language_id']]['meta_h1']) ? $blog_description[$lang['language_id']]['meta_h1'] : ''; ?>" />
                 </div>
                </td>
              </tr>


              <tr>
                <td><?php echo $entry_meta_description; ?></td>
                <td>
                <div class="input-group">
                <textarea id="blog_description_<?php echo $lang['language_id']; ?>_meta_description" class="form-control" name="blog_description[<?php echo $lang['language_id']; ?>][meta_description]" cols="40" rows="5"><?php echo isset($blog_description[$lang['language_id']]) ? $blog_description[$lang['language_id']]['meta_description'] : ''; ?></textarea>
                </div>
                </td>
              </tr>
              <tr>
                <td><?php echo $entry_meta_keyword; ?></td>
                <td>
                <div class="input-group">
                <textarea name="blog_description[<?php echo $lang['language_id']; ?>][meta_keyword]" class="form-control" cols="40" rows="5"><?php echo isset($blog_description[$lang['language_id']]) ? $blog_description[$lang['language_id']]['meta_keyword'] : ''; ?></textarea>
                </div>
                </td>
              </tr>


             <tr>
                <td><?php echo $entry_description; ?></td>

         	<?php
         	if (SC_VERSION < 20) {
         	?>
               <td>
               <div class="input-group">
               <textarea name="blog_description[<?php echo $lang['language_id']; ?>][description]" class="form-control" id="description<?php echo $lang['language_id']; ?>"><?php echo isset($blog_description[$lang['language_id']]) ? $blog_description[$lang['language_id']]['description'] : ''; ?></textarea>
               </div>
               </td>

         	<?php
         	} else {
         	?>
			<td>
                  <div class="form-group">

                    <div class="col-sm-10 input-description<?php echo $lang['language_id']; ?>_" style="padding: 0; width: 100%;">
                      <textarea id="input-description<?php echo $lang['language_id']; ?>_" name="blog_description[<?php echo $lang['language_id']; ?>][description]" placeholder="<?php echo $entry_description; ?>"  class="form-control sc-admin-input-textarea"><?php echo isset($blog_description[$lang['language_id']]) ? $blog_description[$lang['language_id']]['description'] : ''; ?></textarea>


						<a href="" class="hrefajax" onclick="load_editor('input-description<?php echo $lang['language_id']; ?>_', '100'); return false;"><?php echo $language->get('entry_editor'); ?></a>



                    </div>
                  </div>


			</td>
         	<?php
         	}
         	?>
              </tr>




            </table>
          </div>
          <?php } ?>
        </div>
        <div id="tab-data">
          <table class="form">
           <tr>
              <td><?php echo $entry_status; ?></td>
              <td>
              <div class="input-group">
              <select name="status" class="form-control">
                  <?php if ($status) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select>
               </div>
                </td>
            </tr>


            <tr>
              <td><?php echo $entry_parent; ?></td>
              <td>
              <div class="input-group">
              <select name="parent_id" class="form-control">
                  <option value="0"><?php echo $text_none; ?></option>
                  <?php foreach ($categories as $blog) { ?>
                  <?php if ($blog['blog_id'] == $parent_id) { ?>
                  <option value="<?php echo $blog['blog_id']; ?>" selected="selected"><?php echo $blog['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $blog['blog_id']; ?>"><?php echo $blog['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select>
                </div>
                </td>
            </tr>
    <tr>
      <td><?php echo $entry_image; ?></td>
      <td valign="top"><div class="image form-group col-sm-10" data-toggle="image">

	      <?php if (SC_VERSION > 15) { ?>
	    	  <a href="" id="thumb-image" data-toggle="image" class="img-thumbnail">
		      <img src="<?php echo $thumb; ?>" alt="" title="" data-placeholder="<?php echo $no_image; ?>" />
	       <?php } else { ?>
	      	<img src="<?php echo $thumb; ?>" alt="" id="thumb" />
	      <?php } ?>

	      <?php if (SC_VERSION > 15) { ?>
	      </a>
	       <input type="hidden" name="image" value="<?php echo $image; ?>" id="input-image" />
	     <?php } else { ?>
	        <input type="hidden" name="image" value="<?php echo $image; ?>" id="image" />
		<?php } ?>

        <br>
       <?php if (SC_VERSION < 20) { ?>
	      <a onclick="image_upload('image', 'thumb');"><?php echo $language->get('text_browse'); ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('#thumb').attr('src', '<?php echo $no_image; ?>'); $('#image').attr('value', '');"><?php echo $language->get('text_clear'); ?></a>
       <?php } ?>
        </div>

        </td>
    </tr>



            <tr>
              <td><?php echo $entry_sort_order; ?></td>
              <td>
              <div class="input-group">
              <input type="text" name="sort_order" value="<?php echo $sort_order; ?>" size="1" class="form-control"/>
              </div>
              </td>

            </tr>
           <!--
            <tr>
                <td><?php echo $entry_customer_group; ?></td>
                <td>
                  <select name="customer_group_id">
                    <?php foreach ($customer_groups as $customer_group) { ?>
                    <?php if ($customer_group['customer_group_id'] == $customer_group_id) { ?>
                    <option value="<?php echo $customer_group['customer_group_id']; ?>" selected="selected"><?php echo $customer_group['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select>
                </td>
             </tr>
               -->
            <tr>
              <td><?php echo $entry_store;

              ?></td>
              <td>
              <div class="input-group">
              <div class="scrollbox">
                  <?php $class = 'even'; ?>
                  <div class="<?php echo $class; ?>">
                    <?php if (in_array(0, $blog_store)) { ?>
                    <input type="checkbox" name="blog_store[]" value="0" checked="checked" />
                    <?php echo $text_default; ?>
                    <?php } else { ?>
                    <input type="checkbox" name="blog_store[]" value="0" />
                    <?php echo $text_default; ?>
                    <?php } ?>
                  </div>
                  <?php foreach ($stores as $store) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div class="<?php echo $class; ?>">
                    <?php if (in_array($store['store_id'], $blog_store)) { ?>
                    <input type="checkbox" name="blog_store[]" value="<?php echo $store['store_id']; ?>" checked="checked" />
                    <?php echo $store['name']; ?>
                    <?php } else { ?>
                    <input type="checkbox" name="blog_store[]" value="<?php echo $store['store_id']; ?>" />
                    <?php echo $store['name']; ?>
                    <?php } ?>
                  </div>
                  <?php } ?>
                </div>
                </div>
                <a onclick="$(this).parent().find(':checkbox').prop('checked', true);" class="nohref"><?php echo $language->get('text_select_all'); ?></a> / <a onclick="$(this).parent().find(':checkbox').prop('checked', false);" class="nohref"><?php echo $language->get('text_unselect_all'); ?></a></td>

                </td>
            </tr>



            <tr>
              <td><?php echo $language->get('entry_customer_groups'); ?></td>
              <td>
              <div class="scrollbox" style="width: 100%;">
                  <?php if (!isset($blog_access)) { ?>
                  <?php foreach ($customer_groups_blog as $customer_group) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div class="<?php echo $class; ?> " style="height: 30px;">
                    <input type="checkbox" name="customer_groups_blog[<?php echo $customer_group['customer_group_id']; ?>]" value="<?php echo $customer_group['customer_group_id']; ?>" checked="checked" />
                    <?php echo $customer_group['name']; ?>

                    <a id="button_access<?php echo $customer_group['customer_group_id']; ?>" onclick="var ch = $(this).parent().find('input:checked').val(); if (typeof ch !='undefined'){ ch = 1; } else { ch = 0; }; blog_access('<?php echo $customer_group['customer_group_id']; ?>','<?php echo $blog_id; ?>', ch); return false;" class="markbutton floatright button_orange nohref"><?php echo $language->get('button_blog_apply_access'); ?></a>

                    </div>
                  <?php } ?>

                  <?php } else { ?>

                  <?php foreach ($customer_groups_blog as $customer_group) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div class="<?php echo $class; ?> " style="height: 30px;">
                    <?php
                    if (isset($blog_access) && isset($blog_access[$customer_group['customer_group_id']])) {
                    ?>
                    <input type="checkbox" name="customer_groups_blog[]" value="<?php echo $customer_group['customer_group_id']; ?>" checked="checked" />
                    <?php echo $customer_group['name']; ?>
                    <?php } else { ?>
                    <input type="checkbox" name="customer_groups_blog[]" value="<?php echo $customer_group['customer_group_id']; ?>" />
                    <?php echo $customer_group['name']; ?>
                    <?php } ?>

                     <a id="button_access<?php echo $customer_group['customer_group_id']; ?>" onclick="var ch = $(this).parent().find('input:checked').val(); if (typeof ch !='undefined'){ ch = 1; } else { ch = 0; }; blog_access('<?php echo $customer_group['customer_group_id']; ?>','<?php echo $blog_id; ?>', ch); return false;" class="markbutton floatright button_orange nohref"><?php echo $language->get('button_blog_apply_access'); ?></a>

                  </div>
                  <?php } ?>

                  <?php } ?>


                </div>
               <a onclick="$(this).parent().find(':checkbox').prop('checked', true);" class="nohref"><?php echo $language->get('text_select_all'); ?></a> / <a onclick="$(this).parent().find(':checkbox').prop('checked', false);" class="nohref"><?php echo $language->get('text_unselect_all'); ?></a></td>
                </td>
            </tr>



 			<tr>
              <td><?php echo $language->get('entry_index_page'); ?></td>
              <td>

              <div class="scrollbox">
                 <div class="even">
                    <input type="checkbox" name="index_page[]" value="index" <?php if (in_array('index', $index_page)) { ?> checked="checked" <?php } ?> />
                 index
                 </div>
                 <div class="even">
                    <input type="checkbox" name="index_page[]" value="noindex" <?php if (in_array('noindex', $index_page)) { ?> checked="checked" <?php } ?> />
                 noindex
                 </div>
                 <div class="odd">
                    <input type="checkbox" name="index_page[]" value="follow" <?php if (in_array('follow', $index_page)) { ?> checked="checked" <?php } ?> />
                 follow
                 </div>
				<div class="odd">
                    <input type="checkbox" name="index_page[]" value="nofollow" <?php if (in_array('nofollow', $index_page)) { ?> checked="checked" <?php } ?> />
                nofollow
    			</div>
				<div class="even">
                    <input type="checkbox" name="index_page[]" value="nosnippet" <?php if (in_array('nosnippet', $index_page)) { ?> checked="checked" <?php } ?> />
                nosnippet
                </div>
				<div class="odd">
                    <input type="checkbox" name="index_page[]" value="noodp" <?php if (in_array('noodp', $index_page)) { ?> checked="checked" <?php } ?> />
                noodp
                </div>
				<div class="even">
                    <input type="checkbox" name="index_page[]" value="noarchive" <?php if (in_array('noarchive', $index_page)) { ?> checked="checked" <?php } ?> />
                noarchive
                </div>
				<div class="odd">
                    <input type="checkbox" name="index_page[]" value="noimageindex" <?php if (in_array('noimageindex', $index_page)) { ?> checked="checked" <?php } ?> />
                noimageindex
                </div>

                 </div>
				 </td>
            </tr>



          </table>
        </div>




        <div id="tab-design">
        <table class="list">
            <thead>
              <tr>
                <td class="left"><?php echo $entry_store; ?></td>
                <td class="left"><?php echo $entry_layout; ?></td>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td class="left"><?php echo $text_default; ?></td>
                <td class="left">
                <div class="input-group">
                <select name="blog_layout[0][layout_id]" class="form-control">
                    <option value=""></option>
                    <?php foreach ($layouts as $layout) { ?>
                    <?php if (isset($blog_layout[0]['layout_id']) && $blog_layout[0]['layout_id'] == $layout['layout_id']) { ?>
                    <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select>
                  </div>
                  </td>
              </tr>
            </tbody>
            <?php foreach ($stores as $store) { ?>
            <tbody>
              <tr>
                <td class="left"><?php echo $store['name']; ?></td>
                <td class="left">
                <div class="input-group">
                <select name="blog_layout[<?php echo $store['store_id']; ?>][layout_id]" class="form-control">
                    <option value=""></option>
                    <?php foreach ($layouts as $layout) { ?>
                    <?php if (isset($blog_layout[$store['store_id']]['layout_id']) && $blog_layout[$store['store_id']]['layout_id'] == $layout['layout_id']) { ?>
                    <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select>
                  </div>
                  </td>
              </tr>
            </tbody>
            <?php } ?>
          </table>
        </div>


        <div id="tab-options">


<?php if (SC_VERSION > 15) { ?>
<div class="width100" style="width: 100%; clear: both; ">
	<div class="floatright">
	 <a href="#" class="btn btn-default openall"><?php echo $language->get('entry_open_all'); ?></a> <a href="#" class="btn btn-default closeall"><?php echo $language->get('entry_close_all'); ?></a>
	</div>
</div>
<div class="width100" style="width: 100%; clear: both; height: 5px; line-height: 5px;">&nbsp;</div>
<?php } ?>
 <style>
.panel-default  {
    border: none !important;
}

.panel-default a {
    color: #000 !important;
}

.panel-default .panel-heading {
    background: #efefef none repeat scroll 0 0 !important;
    border: none !important;
    color: #000 !important;
}

.panel-title > a, .panel-title > small, .panel-title > .small, .panel-title > small > a, .panel-title > .small > a {
    color: #000;
}

 </style>
 <div class="panel-group" id="accordion">

  <div class="panel panel-default">
    <div class="panel-heading">
      <a data-toggle="collapse" data-parent="#accordion" href="#collapse1001">
      <h4 class="panel-title">
        <?php echo $language->get('entry_title_status'); ?>
      </h4>
      </a>

    </div>
    <div id="collapse1001" class="panel-collapse collapse in">
      <div class="panel-body">
		<table>
		<tr class="blog_title_block">
				<td><?php echo $language->get('entry_title_status'); ?></td>
				<td>
					<div class="input-group">
					<select name="blog_design[title_status]" class="form-control">
						<?php if (isset($blog_design['title_status']) && $blog_design['title_status']) { ?>
						<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
						<option value="0"><?php echo $text_disabled; ?></option>
						<?php } else { ?>
						<option value="1"><?php echo $text_enabled; ?></option>
						<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
						<?php } ?>
					</select>
					</div>
				</td>
			</tr>


			<tr class="blog_title_block">
				<td><?php echo $language->get('entry_title_position'); ?></td>
				<td>
					<div class="input-group">
					<select name="blog_design[title_position]" class="form-control">
						<?php if (!isset($blog_design['title_position']) || $blog_design['title_position']=='before' || $blog_design['title_position']=='1') { ?>
						<option value="before" selected="selected"><?php echo  $language->get('text_title_position_before'); ?></option>
						<option value="after"><?php echo $language->get('text_title_position_after'); ?></option>
						<?php } else { ?>
						<option value="before"><?php echo $language->get('text_title_position_before'); ?></option>
						<option value="after" selected="selected"><?php echo $language->get('text_title_position_after'); ?></option>
						<?php } ?>
					</select>
					</div>
				</td>
			</tr>
		</table>
      </div>
    </div>
  </div>

  <div class="panel panel-default">
    <div class="panel-heading">

      <a data-toggle="collapse" data-parent="#accordion" href="#collapse1002">
      <h4 class="panel-title">
        <?php echo $language->get('entry_image_categories'); ?>
      </h4>
      </a>

    </div>
    <div id="collapse1002" class="panel-collapse collapse">
      <div class="panel-body">
		<table>
			<tr class="blog_category_block">
				<td><?php echo $language->get('entry_category_big_image_status'); ?>
			</td>
				<td>
					<div class="input-group">
					<select name="blog_design[category_big_image_status]" id="w_category_big_image_status" class="form-control">
						<?php if (isset($blog_design['category_big_image_status']) && $blog_design['category_big_image_status']) { ?>
						<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
						<option value="0"><?php echo $text_disabled; ?></option>
						<?php } else { ?>
						<option value="1"><?php echo $text_enabled; ?></option>
						<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
						<?php } ?>
					</select>
                    </div>
				</td>
			</tr>

 			<tr  class="blog_category_block">
				<td><?php echo $language->get('entry_image_category_adaptive_resize'); ?></td>
				<td>
					<div class="input-group">
					<select name="blog_design[image_category_adaptive_resize]" class="form-control">
						<?php if (isset( $blog_design['image_category_adaptive_resize']) && $blog_design['image_category_adaptive_resize']) { ?>
						<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
						<option value="0"><?php echo $text_disabled; ?></option>
						<?php } else { ?>
						<option value="1"><?php echo $text_enabled; ?></option>
						<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
						<?php } ?>
					</select>
					</div>
				</td>
			</tr>

    <tr class="blog_category_block">
     <td class="left"><?php echo $entry_big_dim; ?></td>
     <td class="left">

				<div class="sc_table">

					<div class="input-group">
					      <input class="form-control" type="text" name="blog_design[blog_big][width]" value="<?php  if (isset($blog_design['blog_big']['width'])) echo $blog_design['blog_big']['width']; ?>" size="3"  />
					</div>

					<div>
					x
					</div>

					<div class="input-group">
						<input class="form-control" type="text" name="blog_design[blog_big][height]" value="<?php if (isset($blog_design['blog_big']['height'])) echo $blog_design['blog_big']['height']; ?>" size="3" />
					</div>

                </div>


     </td>
    </tr>


			<tr class="blog_category_block">
				<td><?php echo $language->get('entry_subcategory_big_image_status'); ?>
			</td>
				<td>
					<div class="input-group">
					<select name="blog_design[subcategory_big_image_status]" id="w_subcategory_big_image_status" class="form-control">
						<?php if (isset($blog_design['subcategory_big_image_status']) && $blog_design['subcategory_big_image_status']) { ?>
						<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
						<option value="0"><?php echo $text_disabled; ?></option>
						<?php } else { ?>
						<option value="1"><?php echo $text_enabled; ?></option>
						<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
						<?php } ?>
					</select>
					</div>

				</td>
			</tr>



    <tr class="blog_category_block">
     <td class="left"><?php echo $language->get('entry_image_subcategory_dim'); ?></td>
     <td class="left">

				<div class="sc_table">

					<div class="input-group">
      <input class="form-control" type="text" name="blog_design[blog_subcategory][width]" value="<?php  if (isset($blog_design['blog_subcategory']['width'])) echo $blog_design['blog_subcategory']['width']; ?>" size="3" />
 					</div>

					<div>
					x
					</div>

					<div class="input-group">
     <input class="form-control" type="text" name="blog_design[blog_subcategory][height]" value="<?php if (isset($blog_design['blog_subcategory']['height'])) echo $blog_design['blog_subcategory']['height']; ?>" size="3" />
 					</div>

                </div>


    </td>
    </tr>
        </table>
      </div>
    </div>
  </div>



<!--
 <div class="panel panel-default">
    <div class="panel-heading">
      <a data-toggle="collapse" data-parent="#accordion" href="#collapse1003">
      <h4 class="panel-title">
        <?php echo $language->get('entry_image_categories'); ?>
      </h4>
      </a>
    </div>
    <div id="collapse1003" class="panel-collapse collapse">
      <div class="panel-body">

      </div>
    </div>
  </div>
-->


 <div class="panel panel-default">
    <div class="panel-heading">

      <a data-toggle="collapse" data-parent="#accordion" href="#collapse1004">
      <h4 class="panel-title">
        <?php echo $language->get('entry_image_records'); ?>
      </h4>
      </a>

    </div>
    <div id="collapse1004" class="panel-collapse collapse">
      <div class="panel-body">
      	<table>
			<tr class="blog_image_block">
				<td>
					<?php echo $language->get('entry_image_status'); ?>
				</td>
				<td>
					<div class="input-group">
					<select name="blog_design[image_status]" id="w_image_status" class="form-control">
						<?php if (isset($blog_design['image_status']) && $blog_design['image_status']) { ?>
						<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
						<option value="0"><?php echo $text_disabled; ?></option>
						<?php } else { ?>
						<option value="1"><?php echo $text_enabled; ?></option>
						<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
						<?php } ?>
					</select>
                    </div>

					<script>
					  if ($('#w_image_status').val() == 1 ) {
                      $('.image-blog_design').show('slow');
					  } else {
					  	$('.image-blog_design').hide();
					  }


					$('#w_avatar_status').on('change', function() {
					  if (this.value == 1 ) {
                      $('.image-blog_design').show('slow');
					  } else {
					  	$('.image-blog_design').hide('slow');
					  }
					});
					</script>


				</td>
			</tr>

    <tr class="blog_image_block">
     <td class="left"><?php echo $entry_small_dim; ?></td>
     <td class="left">
				<div class="sc_table">

					<div class="input-group">
      <input class="form-control" type="text" name="blog_design[blog_small][width]" value="<?php if (isset($blog_design['blog_small']['width'])) echo $blog_design['blog_small']['width']; ?>" size="3" />
 					</div>

					<div>
					x
					</div>

					<div class="input-group">
      <input class="form-control" type="text" name="blog_design[blog_small][height]" value="<?php if (isset($blog_design['blog_small']['height'])) echo $blog_design['blog_small']['height']; ?>" size="3" />
 					</div>

                </div>


    </td>
    </tr>

          <tr class="blog_image_block">
              <td><?php echo $language->get('entry_blog_small_colorbox'); ?></td>
              <td>
              <div class="input-group">
              <select name="blog_design[blog_small_colorbox]" class="form-control">
                  <?php if (isset( $blog_design['blog_small_colorbox']) && $blog_design['blog_small_colorbox']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select>
                </div>
                </td>
            </tr>



			<tr  class="blog_image_block">
				<td><?php echo $language->get('entry_image_adaptive_resize'); ?></td>
				<td>
					<div class="input-group">
					<select name="blog_design[image_adaptive_resize]" class="form-control">
						<?php if (isset( $blog_design['image_adaptive_resize']) && $blog_design['image_adaptive_resize']) { ?>
						<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
						<option value="0"><?php echo $text_disabled; ?></option>
						<?php } else { ?>
						<option value="1"><?php echo $text_enabled; ?></option>
						<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
						<?php } ?>
					</select>
					</div>
				</td>
			</tr>

           <tr class="blog_image_block">
              <td><?php echo $language->get('entry_thumb_view'); ?></td>
              <td>
              <div class="input-group">
              <select name="blog_design[thumb_view]" class="form-control">
                  <?php if (isset( $blog_design['thumb_view']) && $blog_design['thumb_view']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select>
                </div>
                </td>
            </tr>


    <tr class="blog_image_block">
     <td class="left"><?php echo $language->get('entry_image_dim'); ?></td>
     <td class="left">
                <div class="sc_table">
					<div class="input-group">
      <input class="form-control" type="text" name="blog_design[thumb_image][width]" value="<?php  if (isset($blog_design['thumb_image']['width'])) echo $blog_design['thumb_image']['width']; ?>" size="3" />
 					</div>

					<div>
					x
					</div>

					<div class="input-group">
      <input class="form-control" type="text" name="blog_design[thumb_image][height]" value="<?php if (isset($blog_design['thumb_image']['height'])) echo $blog_design['thumb_image']['height']; ?>" size="3" />
 					</div>

                </div>

     </td>
    </tr>
      	</table>
      </div>
    </div>
  </div>

<?php if (isset( $ascp_settings['reviews_widget_status']) && $ascp_settings['reviews_widget_status']) { ?>
 <div class="panel panel-default">
    <div class="panel-heading">

      <a data-toggle="collapse" data-parent="#accordion" href="#collapse1005">
      <h4 class="panel-title">
        <?php echo $language->get('entry_image_gallery_list'); ?>
      </h4>
      </a>

    </div>
    <div id="collapse1005" class="panel-collapse collapse">
      <div class="panel-body">
      	<table>

			<tr class="blog_images_block">
				<td><?php echo $language->get('entry_images_view'); ?>

				</td>
				<td>
					<div class="input-group">
					<select class="form-control" name="blog_design[images_view]" id="wblog_design_images_view">
						<?php if (isset( $blog_design['images_view']) && $blog_design['images_view']) { ?>
						<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
						<option value="0"><?php echo $text_disabled; ?></option>
						<?php } else { ?>
						<option value="1"><?php echo $text_enabled; ?></option>
						<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
						<?php } ?>
					</select>
					</div>
					<script>
					  if ($('#wblog_design_images_view').val() == 1 ) {
                      $('.images-blog_design').show('slow');
					  } else {
					  	$('.images-blog_design').hide();
					  }


					$('#wblog_design_images_view').on('change', function() {
					  if (this.value == 1 ) {
                      $('.images-blog_design').show('slow');
					  } else {
					  	$('.images-blog_design').hide('slow');
					  }

					});
					</script>

				</td>
			</tr>


			<tr  class="blog_images_block">
				<td><?php echo $language->get('entry_images_adaptive_resize'); ?></td>
				<td>
					<div class="input-group">
					<select class="form-control" name="blog_design[images_adaptive_resize]">
						<?php if (isset( $blog_design['images_adaptive_resize']) && $blog_design['images_adaptive_resize']) { ?>
						<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
						<option value="0"><?php echo $text_disabled; ?></option>
						<?php } else { ?>
						<option value="1"><?php echo $text_enabled; ?></option>
						<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
						<?php } ?>
					</select>
					</div>
				</td>
			</tr>





    <tr class="blog_images_block">
     <td class="left"><?php echo $language->get('entry_images_dim'); ?></td>
     <td class="left">
              <div class="sc_table">
					<div class="input-group">
      <input class="form-control" type="text" name="blog_design[images][width]" value="<?php  if (isset($blog_design['images']['width'])) echo $blog_design['images']['width']; ?>" size="3" />
					</div>

					<div>
					x
					</div>

					<div class="input-group">
      <input class="form-control" type="text" name="blog_design[images][height]" value="<?php if (isset($blog_design['images']['height'])) echo $blog_design['images']['height']; ?>" size="3" />
  					</div>

                </div>


    </td>
    </tr>

			<tr  class="blog_images_block">
				<td>
					<?php echo $language->get('entry_images_number'); ?>
				</td>
				<td>
					<div class="input-group">
						<input class="form-control" type="text" name="blog_design[images_number]" value="<?php  if (isset( $blog_design['images_number'])) echo $blog_design['images_number']; ?>" size="3" />
					</div>
				</td>
			</tr>

			<tr  class="blog_images_block">
				<td><?php echo $language->get('entry_images_number_hide'); ?></td>
				<td>
					<div class="input-group">
					<select class="form-control" name="blog_design[images_number_hide]">
						<?php if (isset( $blog_design['images_number_hide']) && $blog_design['images_number_hide']) { ?>
						<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
						<option value="0"><?php echo $text_disabled; ?></option>
						<?php } else { ?>
						<option value="1"><?php echo $text_enabled; ?></option>
						<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
						<?php } ?>
					</select>
					</div>
				</td>
			</tr>



			<tr  class="blog_images_block">
				<td><?php echo $language->get('entry_images_position'); ?></td>
				<td>
					<div class="input-group">
					<select class="form-control" name="blog_design[images_position]">
						<?php if (!isset($blog_design['images_position']) || $blog_design['images_position']) { ?>
						<option value="1" selected="selected"><?php echo  $language->get('text_images_position_before'); ?></option>
						<option value="0"><?php echo $language->get('text_images_position_after'); ?></option>
						<?php } else { ?>
						<option value="1"><?php echo $language->get('text_images_position_before'); ?></option>
						<option value="0" selected="selected"><?php echo $language->get('text_images_position_after'); ?></option>
						<?php } ?>
					</select>
					</div>
				</td>
			</tr>

      	</table>
      </div>
    </div>
  </div>

 <div class="panel panel-default">
    <div class="panel-heading">

      <a data-toggle="collapse" data-parent="#accordion" href="#collapse1006">
      <h4 class="panel-title">
        <?php echo $language->get('entry_image_gallery'); ?>
      </h4>
      </a>

    </div>
    <div id="collapse1006" class="panel-collapse collapse">
      <div class="panel-body">
      	<table>
			<tr  class="blog_image_gallery_block">
				<td><?php echo $language->get('entry_image_gallery_status'); ?>
			</td>
				<td>
					<div class="input-group">
					<select class="form-control" name="blog_design[image_gallery_status]">
						<?php if (isset($blog_design['image_gallery_status']) && $blog_design['image_gallery_status']) { ?>
						<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
						<option value="0"><?php echo $text_disabled; ?></option>
						<?php } else { ?>
						<option value="1"><?php echo $text_enabled; ?></option>
						<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
						<?php } ?>
					</select>
                    </div>
				</td>
			</tr>

			<tr  class="blog_image_gallery_block">
				<td><?php echo $language->get('entry_image_gallery_adaptive_resize'); ?></td>
				<td>
					<div class="input-group">
					<select class="form-control" name="blog_design[image_gallery_adaptive_resize]">
						<?php if (isset( $blog_design['image_gallery_adaptive_resize']) && $blog_design['image_gallery_adaptive_resize']) { ?>
						<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
						<option value="0"><?php echo $text_disabled; ?></option>
						<?php } else { ?>
						<option value="1"><?php echo $text_enabled; ?></option>
						<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
						<?php } ?>
					</select>
					</div>
				</td>
			</tr>


    <tr  class="blog_image_gallery_block">
     <td class="left"><?php echo $language->get('entry_gallery_image_dim'); ?></td>
     <td class="left">
                <div class="sc_table">
					<div class="input-group">
      <input class="form-control" type="text" name="blog_design[gallery_image][width]" value="<?php  if (isset($blog_design['gallery_image']['width'])) echo $blog_design['gallery_image']['width']; ?>" size="3" />
					</div>

					<div>
					x
					</div>

					<div class="input-group">
      <input class="form-control" type="text" name="blog_design[gallery_image][height]" value="<?php if (isset($blog_design['gallery_image']['height'])) echo $blog_design['gallery_image']['height']; ?>" size="3" />
  					</div>

                </div>


     </td>
    </tr>


      	</table>
      </div>
    </div>
  </div>
<?php } ?>

<?php if (isset( $ascp_settings['related_widget_status']) && $ascp_settings['related_widget_status']) { ?>
 <div class="panel panel-default">
    <div class="panel-heading">

      <a data-toggle="collapse" data-parent="#accordion" href="#collapse1007">
      <h4 class="panel-title">
        <?php echo $language->get('entry_image_products_record'); ?>
      </h4>
      </a>


    </div>
    <div id="collapse1007" class="panel-collapse collapse">
      <div class="panel-body">
      	<table>

  			<tr class="blog_image_product_block">
				<td><?php echo $language->get('entry_image_product_status'); ?>
			</td>
				<td>
					<div class="input-group">
					<select class="form-control" name="blog_design[image_product_status]">
						<?php if (isset($blog_design['image_product_status']) && $blog_design['image_product_status']) { ?>
						<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
						<option value="0"><?php echo $text_disabled; ?></option>
						<?php } else { ?>
						<option value="1"><?php echo $text_enabled; ?></option>
						<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
						<?php } ?>
					</select></div>

				</td>
			</tr>

  			<tr class="blog_image_product_block">
				<td><?php echo $language->get('entry_related_product_tab_status'); ?>
			</td>
				<td>
					<div class="input-group">
					<select class="form-control" name="blog_design[related_product_tab_status]">
						<?php if (isset($blog_design['related_product_tab_status']) && $blog_design['related_product_tab_status']) { ?>
						<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
						<option value="0"><?php echo $text_disabled; ?></option>
						<?php } else { ?>
						<option value="1"><?php echo $text_enabled; ?></option>
						<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
						<?php } ?>
					</select></div>

				</td>
			</tr>



			<tr  class="blog_image_product_block">
				<td><?php echo $language->get('entry_image_product_adaptive_resize'); ?></td>
				<td>
					<div class="input-group"><select class="form-control" name="blog_design[image_product_adaptive_resize]">
						<?php if (isset( $blog_design['image_product_adaptive_resize']) && $blog_design['image_product_adaptive_resize']) { ?>
						<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
						<option value="0"><?php echo $text_disabled; ?></option>
						<?php } else { ?>
						<option value="1"><?php echo $text_enabled; ?></option>
						<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
						<?php } ?>
					</select></div>
				</td>
			</tr>



    <tr  class="blog_image_product_block">
     <td class="left"><?php echo $language->get('entry_product_image_dim'); ?></td>
     <td class="left">
                 <div class="sc_table">
					<div class="input-group">
       <input class="form-control" type="text" name="blog_design[product_image][width]" value="<?php  if (isset($blog_design['product_image']['width'])) echo $blog_design['product_image']['width']; ?>" size="3" />
					</div>

					<div>
					x
					</div>

					<div class="input-group">
      <input class="form-control" type="text" name="blog_design[product_image][height]" value="<?php if (isset($blog_design['product_image']['height'])) echo $blog_design['product_image']['height']; ?>" size="3" />
  					</div>

                </div>

     </td>
    </tr>
      	</table>
      </div>
    </div>
  </div>


 <div class="panel panel-default">
    <div class="panel-heading">

      <a data-toggle="collapse" data-parent="#accordion" href="#collapse1008">
      <h4 class="panel-title">
        <?php echo $language->get('entry_image_records_record'); ?>
      </h4>
      </a>

    </div>
    <div id="collapse1008" class="panel-collapse collapse">
      <div class="panel-body">
      	<table>
			<tr class="blog_image_record_block">
				<td><?php echo $language->get('entry_image_record_status'); ?>
			</td>
				<td>
					<div class="input-group"><select class="form-control" name="blog_design[image_record_status]">
						<?php if (isset($blog_design['image_record_status']) && $blog_design['image_record_status']) { ?>
						<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
						<option value="0"><?php echo $text_disabled; ?></option>
						<?php } else { ?>
						<option value="1"><?php echo $text_enabled; ?></option>
						<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
						<?php } ?>
					</select></div>

				</td>
			</tr>

			<tr  class="blog_image_record_block">
				<td><?php echo $language->get('entry_image_record_adaptive_resize'); ?></td>
				<td>
					<div class="input-group"><select class="form-control" name="blog_design[image_record_adaptive_resize]">
						<?php if (isset( $blog_design['image_record_adaptive_resize']) && $blog_design['image_record_adaptive_resize']) { ?>
						<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
						<option value="0"><?php echo $text_disabled; ?></option>
						<?php } else { ?>
						<option value="1"><?php echo $text_enabled; ?></option>
						<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
						<?php } ?>
					</select></div>
				</td>
			</tr>



    <tr  class="blog_image_record_block">
     <td class="left"><?php echo $language->get('entry_record_image_dim'); ?></td>
     <td class="left">
                <div class="sc_table">
					<div class="input-group">
      <input class="form-control" type="text" name="blog_design[record_image][width]" value="<?php  if (isset($blog_design['record_image']['width'])) echo $blog_design['record_image']['width']; ?>" size="3" />
					</div>

					<div>
					x
					</div>

					<div class="input-group">
      <input class="form-control" type="text" name="blog_design[record_image][height]" value="<?php if (isset($blog_design['record_image']['height'])) echo $blog_design['record_image']['height']; ?>" size="3" />
  					</div>

                </div>

     </td>
    </tr>

      	</table>
      </div>
    </div>
  </div>
<?php } ?>


</div>



<script>
$('.closeall').click(function(){
  $('.panel-collapse.in')
    .collapse('hide');
    return false;
});
$('.openall').click(function(){
  $('.panel-collapse:not(".in")')
    .collapse('show');
    return false;
});
</script>


   <table class="mynotable" style="margin-bottom:20px; background: white; vertical-align: center;">

    <tr>
     <td class="left"><?php echo $entry_blog_num_records; ?></td>
     <td class="left">
     <div class="input-group">
      <input class="form-control" type="text" name="blog_design[blog_num_records]" value="<?php  if (isset($blog_design['blog_num_records'])) echo $blog_design['blog_num_records']; ?>" size="3" />
      </div>
     </td>
    </tr>


          <tr class="">
              <td><?php echo $language->get('entry_count_categories'); ?></td>
              <td>
              <div class="input-group">
              <select class="form-control" name="blog_design[count_categories]">
                  <?php if (isset( $blog_design['count_categories']) && $blog_design['count_categories']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select>
                </div>
                </td>
            </tr>


          <tr class="">
              <td><?php echo $language->get('entry_sub_categories_status'); ?></td>
              <td>
              <div class="input-group">
              <select class="form-control" name="blog_design[sub_categories_status]">
                  <?php if (isset( $blog_design['sub_categories_status']) && $blog_design['sub_categories_status']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select>
                </div>
                </td>
            </tr>



          <tr class="blog_image_gallery_block">
              <td><?php echo $language->get('entry_records_more'); ?></td>
              <td><div class="input-group"><select class="form-control" name="blog_design[records_more]">
                  <?php if (isset( $blog_design['records_more']) && $blog_design['records_more']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></div></td>
            </tr>

          <tr>
              <td><?php echo $language->get('entry_first100'); ?></td>
              <td><div class="input-group">
              <select class="form-control" name="blog_design[first100]">
                  <?php if (isset($blog_design['first100']) && $blog_design['first100']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></div></td>
            </tr>

          <tr>
              <td><?php echo $language->get('entry_first100_image'); ?></td>
              <td><div class="input-group">
              <select class="form-control" name="blog_design[first100_image]">
                  <?php if (isset($blog_design['first100_image']) && $blog_design['first100_image']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></div></td>
            </tr>



    <tr  class="blog_image_record_block_">
     <td class="left"><?php echo $language->get('entry_record_image_first100_dim'); ?></td>
     <td class="left">
                <div class="sc_table">
					<div class="input-group">
      <input class="form-control" type="text" name="blog_design[record_image_first100][width]" value="<?php  if (isset($blog_design['record_image_first100']['width'])) echo $blog_design['record_image_first100']['width']; ?>" size="3" />
					</div>

					<div>
					x
					</div>

					<div class="input-group">
      <input class="form-control" type="text" name="blog_design[record_image_first100][height]" value="<?php if (isset($blog_design['record_image_first100']['height'])) echo $blog_design['record_image_first100']['height']; ?>" size="3" />
  					</div>

                </div>

     </td>
    </tr>



    <tr  class="blog_image_record_block">
     <td class="left"><?php echo $language->get('entry_images_first100_dim'); ?></td>
     <td class="left">
                <div class="sc_table">
					<div class="input-group">
      <input class="form-control" type="text" name="blog_design[images_first100][width]" value="<?php  if (isset($blog_design['images_first100']['width'])) echo $blog_design['images_first100']['width']; ?>" size="3" />
					</div>

					<div>
					x
					</div>

					<div class="input-group">
      <input class="form-control" type="text" name="blog_design[images_first100][height]" value="<?php if (isset($blog_design['images_first100']['height'])) echo $blog_design['images_first100']['height']; ?>" size="3" />
  					</div>

                </div>

     </td>
    </tr>





<?php if (isset( $ascp_settings['reviews_widget_status']) && $ascp_settings['reviews_widget_status']) { ?>
   <tr>
     <td class="left"><?php echo $entry_blog_num_comments; ?></td>
     <td class="left">
      <div class="input-group">
      <input class="form-control" type="text" name="blog_design[blog_num_comments]" value="<?php  if (isset($blog_design['blog_num_comments'])) echo $blog_design['blog_num_comments']; ?>" size="3" />
     </div>
     </td>
    </tr>
<?php } ?>

    <tr>
     <td class="left"><?php echo $entry_blog_num_desc; ?></td>
     <td class="left">
      <div class="input-group">
      <input class="form-control" type="text" name="blog_design[blog_num_desc]" value="<?php  if (isset($blog_design['blog_num_desc'])) echo $blog_design['blog_num_desc']; ?>" size="3" />
     </div>
     </td>
    </tr>

    <tr>
     <td class="left"><?php echo $entry_blog_num_desc_words; ?></td>
     <td class="left">
     <div class="input-group">
      <input class="form-control" type="text" name="blog_design[blog_num_desc_words]" value="<?php  if (isset($blog_design['blog_num_desc_words'])) echo $blog_design['blog_num_desc_words']; ?>" size="3" />
     </div>
     </td>
    </tr>

    <tr>
     <td class="left"><?php echo $entry_blog_num_desc_pred; ?></td>
     <td class="left">
      <div class="input-group">
      <input class="form-control" type="text" name="blog_design[blog_num_desc_pred]" value="<?php  if (isset($blog_design['blog_num_desc_pred'])) echo $blog_design['blog_num_desc_pred']; ?>" size="3" />
      </div>
     </td>
    </tr>


    <tr>
     <td class="left"><?php echo $entry_blog_template; ?></td>
     <td class="left">
      <div class="input-group">
      <input type="text" class="template form-control" name="blog_design[blog_template]" value="<?php  if (isset($blog_design['blog_template'])) echo $blog_design['blog_template']; ?>" size="50" />
      <input type="hidden" name="tpath" value="blog">
      </div>
     </td>
    </tr>

    <tr>
     <td class="left"><?php echo $language->get('entry_block_records_width'); ?></td>
     <td class="left">
      <div class="input-group">
      <input class="form-control" type="text" size="6" name="blog_design[block_records_width]" id="blog_design_block_records_width" value="<?php  if (isset($blog_design['block_records_width'])) echo $blog_design['block_records_width']; ?>" size="50" />

                 <div>
                 <?php echo $language->get('entry_block_records_width_templates'); ?>
                 </div>

	               <div>
					<div class="input-group"><select class="form-control" id="select_block_records_width">

	                 <?php  if (!isset($blog_design['block_records_width'])) {$blog_design['block_records_width'] = ''; } ?>
	                 <option value="<?php echo $blog_design['block_records_width']; ?>"><?php echo $language->get('entry_current_value'); ?></option>

                      <?php foreach ($block_records_width_templates as $block_records_width_name => $block_records_width_value) { ?>
	                   <option value="<?php echo $block_records_width_value; ?>"><?php echo $block_records_width_name; ?></option>
                       <?php } ?>
	                 </select></div>
	                 </div>
						<script>
						$( '#select_block_records_width' )
						.change(function () {
						var str = '';
						$( '#select_block_records_width option:selected' ).each(function() {
						str = $(this).val();
						});

						$( '#blog_design_block_records_width' ).val( str );

						})
						.change();
						</script>



     </td>
    </tr>

    <tr>
     <td class="left"><?php echo $entry_blog_template_record; ?></td>
     <td class="left">
      <div class="input-group">
      <input type="text" class="template form-control" name="blog_design[blog_template_record]" value="<?php  if (isset($blog_design['blog_template_record'])) echo $blog_design['blog_template_record']; ?>" size="50" />
      <input type="hidden" name="tpath" value="record">
     </div>
     </td>
    </tr>

<?php if (isset( $ascp_settings['reviews_widget_status']) && $ascp_settings['reviews_widget_status']) { ?>
    <tr>
     <td class="left"><?php echo  $language->get('entry_blog_template_comment'); ?></td>
     <td class="left">
      <div class="input-group">
      <input type="text" class="template form-control" name="blog_design[blog_template_comment]" value="<?php  if (isset($blog_design['blog_template_comment'])) echo $blog_design['blog_template_comment']; ?>" size="50" />
 	  <input type="hidden" name="tpath" value="module/treecomments">
     </div>
     </td>
    </tr>

    <tr>
     <td class="left"><?php echo  $language->get('entry_template_comment_stat'); ?></td>
     <td class="left">
      <div class="input-group">
      <input type="text" class="template form-control" name="blog_design[blog_template_comment_stat]" value="<?php  if (isset($blog_design['blog_template_comment_stat'])) echo $blog_design['blog_template_comment_stat']; ?>" size="50" />
 	  <input type="hidden" name="tpath" value="module/treecomments/stat">
 	  </div>
     </td>
    </tr>

<?php } ?>
 	<tr>
 		<td>
			<?php echo $language->get('entry_order_records'); ?>
		</td>
		<td>
         <div class="input-group"><select class="form-control" id="blog_design_order"  name="blog_design[order]">
           <option value="sort"  <?php if (isset($blog_design['order']) &&  $blog_design['order']=='sort')  { echo 'selected="selected"'; } ?>><?php echo $language->get('text_what_sort'); ?></option>
           <option value="latest"  <?php if (isset( $blog_design['order']) &&  $blog_design['order']=='latest')  { echo 'selected="selected"'; } ?>><?php echo $language->get('text_what_latest'); ?></option>
           <option value="popular" <?php if (isset( $blog_design['order']) &&  $blog_design['order']=='popular') { echo 'selected="selected"'; } ?>><?php echo $language->get('text_what_popular'); ?></option>
<?php if (isset( $ascp_settings['reviews_widget_status']) && $ascp_settings['reviews_widget_status']) { ?>
           <option value="rating" <?php if (isset( $blog_design['order']) &&  $blog_design['order']=='rating') { echo 'selected="selected"'; } ?>><?php echo $language->get('text_what_rating'); ?></option>
           <option value="comments" <?php if (isset( $blog_design['order']) &&  $blog_design['order']=='comments') { echo 'selected="selected"'; } ?>><?php echo $language->get('text_what_comments'); ?></option>
<?php } ?>
         </select></div>
		</td>
	</tr>

 	<tr>
 		<td>
			<?php echo $language->get('entry_order_ad'); ?>
		</td>
		<td>
         <div class="input-group"><select class="form-control" id="blog_design_order_ad"  name="blog_design[order_ad]">
           <option value="desc"  <?php if (isset( $blog_design['order_ad']) &&  $blog_design['order_ad']=='desc') { echo 'selected="selected"'; } ?>><?php echo $language->get('text_what_desc'); ?></option>
           <option value="asc"   <?php if (isset( $blog_design['order_ad']) &&  $blog_design['order_ad']=='asc')  { echo 'selected="selected"'; } ?>><?php echo $language->get('text_what_asc'); ?></option>
        </select></div>
		</td>
	</tr>

          <tr>
              <td><?php echo $language->get('entry_status_order'); ?></td>
              <td><div class="input-group"><select class="form-control" name="blog_design[status_order]">
                  <?php if (isset($blog_design['status_order']) && $blog_design['status_order']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></div></td>
            </tr>

          <tr>
              <td><?php echo $language->get('entry_status_pagination'); ?></td>
              <td><div class="input-group"><select class="form-control" name="blog_design[status_pagination]">
                  <?php if (isset($blog_design['status_pagination']) && $blog_design['status_pagination']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></div></td>
            </tr>

          <tr>
              <td><?php echo $language->get('entry_category_status'); ?></td>
              <td><div class="input-group"><select class="form-control" name="blog_design[category_status]">
                  <?php if (isset( $blog_design['category_status']) && $blog_design['category_status']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></div></td>
            </tr>


          <tr>
              <td><?php echo $language->get('entry_next_status'); ?></td>
              <td><div class="input-group"><select class="form-control" name="blog_design[next_status]">
                  <?php if (isset( $blog_design['next_status']) && $blog_design['next_status']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></div></td>
            </tr>

          <tr>
              <td><?php echo $language->get('entry_status_continue'); ?></td>
              <td><div class="input-group"><select class="form-control" name="blog_design[status_continue]">
                  <?php if (isset( $blog_design['status_continue']) && $blog_design['status_continue']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></div></td>
            </tr>



          <tr>
              <td><?php echo $language->get('entry_author_status'); ?></td>
              <td><div class="input-group"><select class="form-control" name="blog_design[author_status]">
                  <?php if (isset( $blog_design['author_status']) && $blog_design['author_status']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></div></td>
            </tr>

          <tr>
              <td><?php echo $language->get('entry_author_record_status'); ?></td>
              <td><div class="input-group"><select class="form-control" name="blog_design[author_record_status]">
                  <?php if (isset( $blog_design['author_record_status']) && $blog_design['author_record_status']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></div></td>
            </tr>



          <tr>
              <td><?php echo $language->get('entry_view_date'); ?></td>
              <td><div class="input-group"><select class="form-control" name="blog_design[view_date]">
                  <?php if (isset( $blog_design['view_date']) && $blog_design['view_date']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></div></td>
            </tr>


          <tr>
              <td><?php echo $language->get('entry_view_share'); ?></td>
              <td><div class="input-group"><select class="form-control" name="blog_design[view_share]">
                  <?php if (isset( $blog_design['view_share']) && $blog_design['view_share']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></div></td>
            </tr>
<?php if (isset( $ascp_settings['reviews_widget_status']) && $ascp_settings['reviews_widget_status']) { ?>
          <tr>
              <td><?php echo $language->get('entry_view_comments'); ?></td>
              <td><div class="input-group"><select class="form-control" name="blog_design[view_comments]">
                  <?php if (isset( $blog_design['view_comments']) && $blog_design['view_comments']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></div></td>
            </tr>
 <?php } ?>
          <tr>
              <td><?php echo $language->get('entry_view_viewed'); ?></td>
              <td><div class="input-group"><select class="form-control" name="blog_design[view_viewed]">
                  <?php if (isset( $blog_design['view_viewed']) && $blog_design['view_viewed']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></div></td>
            </tr>

<?php if (isset( $ascp_settings['reviews_widget_status']) && $ascp_settings['reviews_widget_status']) { ?>
          <tr>
              <td><?php echo $language->get('entry_view_rating'); ?></td>
              <td><div class="input-group"><select class="form-control" name="blog_design[view_rating]">
                  <?php if (isset( $blog_design['view_rating']) && $blog_design['view_rating']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></div></td>
            </tr>
<?php } ?>

          <tr>
              <td><?php echo $language->get('entry_view_rss'); ?></td>
              <td><div class="input-group"><select class="form-control" name="blog_design[view_rss]">
                  <?php if (isset($blog_design['view_rss']) && $blog_design['view_rss']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></div></td>
            </tr>
 <?php if (isset( $ascp_settings['reviews_widget_status']) && $ascp_settings['reviews_widget_status']) { ?>
          <tr>
              <td><?php echo $language->get('entry_view_captcha'); ?></td>
              <td><div class="input-group"><select class="form-control" name="blog_design[view_captcha]">
                  <?php if (isset( $blog_design['view_captcha']) && $blog_design['view_captcha']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></div></td>
            </tr>

          <tr>
              <td><?php echo $language->get('entry_visual_editor'); ?></td>
              <td><div class="input-group"><select class="form-control" name="blog_design[visual_editor]">
                  <?php if (isset($blog_design['visual_editor']) && $blog_design['visual_editor']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></div></td>
            </tr>

		    <tr>
		     <td class="left"><?php echo $language->get('entry_bbwidth'); ?></td>
		     <td class="left">
		      <div class="input-group">
		      <input class="form-control" type="text" name="blog_design[bbwidth]" value="<?php if (isset($blog_design['bbwidth'])) echo $blog_design['bbwidth']; ?>" size="3" />
		      </div>
		      </td>
		    </tr>

 <?php } ?>

    <tr>
     <td class="left"><?php echo $language->get('entry_end_url_category'); ?></td>
     <td class="left">
      <div class="input-group">
      <input type="text" class="template form-control" name="blog_design[end_url_category]" value="<?php  if (isset($blog_design['end_url_category'])) echo $blog_design['end_url_category']; ?>" size="20" />
      </div>

     </td>
    </tr>

     <!--
    <tr>
     <td class="left"><?php echo $language->get('entry_end_url_record'); ?></td>
     <td class="left">
      <input type="text" class="template" name="blog_design[end_url_record]" value="<?php  if (isset($blog_design['end_url_record'])) echo $blog_design['end_url_record']; ?>" size="20" />

     </td>
    </tr>
      -->


            <tr>
              <td><?php echo $entry_devider; ?></td>
              <td><div class="input-group"><?php
              if (!isset($blog_design['blog_devider'])) $blog_design['blog_devider']=1;
              if ($blog_design['blog_devider']==1)  { ?>
                <input type="radio" name="blog_design[blog_devider]" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="blog_design[blog_devider]" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="blog_design[blog_devider]" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="blog_design[blog_devider]" value="0" checked="checked" />
                <?php echo $text_no; ?>
                <?php } ?></div></td>
            </tr>


            <tr>
              <td><?php echo $entry_short_path; ?></td>
              <td><div class="input-group"><?php if (isset($blog_design['blog_short_path']) && $blog_design['blog_short_path']==1)  { ?>
                <input type="radio" name="blog_design[blog_short_path]" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="blog_design[blog_short_path]" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="blog_design[blog_short_path]" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="blog_design[blog_short_path]" value="0" checked="checked" />
                <?php echo $text_no; ?>
                <?php } ?></div></td>
            </tr>

            <tr>
              <td><?php echo $language->get('entry_blog_short_path_category') ?></td>
              <td><div class="input-group"><?php if (isset($blog_design['blog_short_path_category']) && $blog_design['blog_short_path_category']==1)  { ?>
                <input type="radio" name="blog_design[blog_short_path_category]" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="blog_design[blog_short_path_category]" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="blog_design[blog_short_path_category]" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="blog_design[blog_short_path_category]" value="0" checked="checked" />
                <?php echo $text_no; ?>
                <?php } ?></div></td>
            </tr>



   <?php foreach ($languages as $lang) { ?>
	<tr>
		<td class="left">
			<?php echo $language->get('entry_title_further'); ?> <br>(<?php echo $lang['name']; ?>)
		</td>
			<td>

				<div class="input-group marginbottom5px">
				<span class="input-group-addon"><?php echo strtoupper($lang['code']); ?><br><img src="<?php echo $lang['image']; ?>" title="<?php echo $lang['name']; ?>" ></span>
					<textarea class="form-control" name="blog_design[further][<?php echo $lang['language_id']; ?>]" rows="3" cols="50" ><?php if (isset($blog_design['further'][$lang['language_id']])) { echo $blog_design['further'][$lang['language_id']]; } else { echo ''; } ?></textarea>
				</div>

			</td>

	</tr>
   <?php } ?>


     <tr>
     <td class="left"><?php echo $language->get('entry_reserved'); ?></td>
     <td class="left">
      <div class="input-group">
      <textarea class="form-control" name="blog_design[reserved]"><?php  if (isset($blog_design['reserved'])) echo $blog_design['reserved']; ?></textarea>
      </div>
     </td>
    </tr>

<?php if (isset( $ascp_settings['reviews_widget_status']) && $ascp_settings['reviews_widget_status']) { ?>
          <tr>
              <td><?php echo $language->get('entry_attribute_groups_status'); ?></td>
              <td><div class="input-group"><select class="form-control" name="blog_design[attribute_groups_status]">
                  <?php if (isset( $blog_design['attribute_groups_status']) && $blog_design['attribute_groups_status']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></div></td>
            </tr>


          <tr>
              <td><?php echo $language->get('entry_description_full'); ?></td>
              <td><div class="input-group"><select class="form-control" name="blog_design[description_full]">
                  <?php if (isset( $blog_design['description_full']) && $blog_design['description_full']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></div></td>
            </tr>
<?php } ?>

    <tr>
     <td></td>
     <td></td>
    </tr>

   </table>

      </div>

      </form>
    </div>
  </div>
</div>

<?php if (SC_VERSION > 15) { ?>
<script type="text/javascript" src="view/javascript/summernote/summernote.js"></script>
<link href="view/javascript/summernote/summernote.css" rel="stylesheet" />
<?php } ?>

<script>
function form_submit() {
$('#form').submit();
}
</script>

<?php
if (SC_VERSION > 15) {
?>
<script>


function delegateEditorClick () {
		$('#modal-image').remove();

		$(this).parents('.note-editor').find('.note-editable').focus();

		$.ajax({
			url: 'index.php?route=common/filemanager&<?php echo $token_name; ?>=' + getURLVar('<?php echo $token_name; ?>'),
			dataType: 'html',
			beforeSend: function() {
				$('#button-image i').replaceWith('<i class="fa fa-circle-o-notch fa-spin"></i>');
				$('#button-image').prop('disabled', true);
			},
			complete: function() {
				$('#button-image i').replaceWith('<i class="fa fa-upload"></i>');
				$('#button-image').prop('disabled', false);
			},
			success: function(html) {
				$('body').append('<div id="modal-image" class="modal">' + html + '</div>');

				$('#modal-image').modal('show');
			}
		});
	}


function load_delegate(idName) {
	$('.' + idName + ' button[data-event=\'showImageDialog\']').attr('data-toggle', 'image').removeAttr('data-event');
	$(document).on('.' + idName + ' button[data-toggle=\'image\']', 'click', delegateEditorClick);
}

function load_summernote(idName, idHeight) {

         	<?php
         	if (SC_VERSION > 21) {
         	?>

		$(idName).summernote({
			height: idHeight,
			toolbar: [
				['style', ['style']],
				['font', ['bold', 'underline', 'clear']],
				['fontname', ['fontname']],
				['color', ['color']],
				['para', ['ul', 'ol', 'paragraph']],
				['table', ['table']],
				['insert', ['link', 'image', 'video']],
				['view', ['fullscreen', 'codeview', 'help']]
			],
			buttons: {
    			image: function() {
					var ui = $.summernote.ui;

					// create button
					var button = ui.button({
						contents: '<i class="fa fa-image" />',
						tooltip: $.summernote.lang[$.summernote.options.lang].image.image,
						click: function () {
							$('#modal-image').remove();

							$.ajax({
								url: 'index.php?route=common/filemanager&<?php echo $token_name; ?>=' + getURLVar('<?php echo $token_name; ?>'),
								dataType: 'html',
								beforeSend: function() {
									$('#button-image i').replaceWith('<i class="fa fa-circle-o-notch fa-spin"></i>');
									$('#button-image').prop('disabled', true);
								},
								complete: function() {
									$('#button-image i').replaceWith('<i class="fa fa-upload"></i>');
									$('#button-image').prop('disabled', false);
								},
								success: function(html) {
									$('body').append('<div id="modal-image" class="modal">' + html + '</div>');

									$('#modal-image').modal('show');

									$('#modal-image').delegate('a.thumbnail', 'click', function(e) {
										e.preventDefault();

										$(idName).summernote('insertImage', $(this).attr('href'));

										$('#modal-image').modal('hide');
									});
								}
							});
						}
					});

					return button.render();
				}
  			}
		});

<?php } else { ?>

$(idName).summernote({height: idHeight});

<?php } ?>


}


function load_editor(idName, idHeight) {

	if (myEditor.indexOf(idName)== -1) {

		if("destroy" in $('#'+idName)) {
			$('#'+idName).destroy();
		} else {
          	$('#'+idName).summernote('destroy');
		}

		load_summernote('#'+idName);

        myEditor.push(idName);
		load_delegate(idName);
	} else {

		if("code" in $('#'+idName)) {
			var html = $('#'+idName).code();
		} else {
          	var html = $('#'+idName).summernote('code');
		}

		if("destroy" in $('#'+idName)) {
			$('#'+idName).destroy();
		} else {
          	$('#'+idName).summernote('destroy');
		}

        var currentVal = '';
        $('#'+idName).val(currentVal + html);

		myEditor.splice(myEditor.indexOf(idName), 1);

	}
	return false;
}

</script>


 <style>
.note-editable {
min-height: 300px !important;
}
</style>
<?php } else { ?>
<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script>
<script language="javascript">

function load_editor(idName, idHeight) {
	if (!myEditor[idName]) {
	    CKEDITOR.remove(idName);
		var html = $('#'+idName).html();
		var config = {
						filebrowserBrowseUrl: 'index.php?route=common/filemanager&<?php echo $token_name; ?>=<?php echo $token; ?>',
						filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&<?php echo $token_name; ?>=<?php echo $token; ?>',
						filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&<?php echo $token_name; ?>=<?php echo $token; ?>',
						filebrowserUploadUrl: 'index.php?route=common/filemanager&<?php echo $token_name; ?>=<?php echo $token; ?>',
						filebrowserImageUploadUrl: 'index.php?route=common/filemanager&<?php echo $token_name; ?>=<?php echo $token; ?>',
						filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&<?php echo $token_name; ?>=<?php echo $token; ?>',
						enterMode 	: CKEDITOR.ENTER_BR,
						entities 	: false,
						htmlEncodeOutput : false
					};

		myEditor[idName] = CKEDITOR.replace(idName, config, html );

	  }	else {
		var currentVal = '';
		$('#'+idName).html(currentVal + myEditor[idName].getData());

		if("destroy" in myEditor[idName]) {
			myEditor[idName].destroy();
		} else {
          	myEditor[idName].summernote('destroy');
		}

		myEditor[idName] = null;
	}
}

<?php foreach ($languages as $lang) { ?>
load_editor('description<?php echo $lang['language_id'];?>', '100');
<?php } ?>



</script>
<?php } ?>


<script type="text/javascript">
function image_upload(field, thumb) {
	$('#dialog').remove();

	$('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&<?php echo $token_name; ?>=<?php echo $token; ?>&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');

	$('#dialog').dialog({
		title: '<?php echo $text_image_manager; ?>',
		close: function (event, ui) {
			if ($('#' + field).attr('value')) {
				$.ajax({
					url: 'index.php?route=common/filemanager/image&<?php echo $token_name; ?>=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).val()),
					dataType: 'text',
					success: function(data) {
						$('#' + thumb).replaceWith('<img src="' + data + '" alt="" id="' + thumb + '" />');
					}
				});
			}
		},
		bgiframe: false,
		width: 800,
		height: 400,
		resizable: false,
		modal: false
	});
};
</script>



<script type="text/javascript">
function blog_access(group, blog_id , ch) {

				$('#button_access'+group).append('<ins class="loading">...<img src="view/image/aloading16.png" alt=""></ins>');

				$.ajax({
					url: 'index.php?route=catalog/blog/blog_access&group='+group+'&blog_id='+blog_id+'&ch=' + ch + '&<?php echo $token_name; ?>=<?php echo $token; ?>',
					dataType: 'html',
					success: function(html) {
						$('#button_access'+group+' > ins').remove();
						if (html) {                          alert(html);
						}

					}
				});


};
</script>


<script type="text/javascript"><!--
$('#tabs a').tabs();
$('#languages a').tabs();
//--></script>

<script>
template_auto = function() {
	$('.template').each(function() {

		var e = this;
		var iname = $(e).prop('name');
		var path  = $(e).nextAll('input:first').prop('value');


		$(e).autocomplete({
			'source': function(request, response) {

				$.ajax({
					url: 'index.php?route=module/blog/autocomplete_template&path='+path+'&<?php echo $token_name; ?>=<?php echo $token; ?>',
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
template_auto();
</script>

<script type="text/javascript" src="view/javascript/blog/synctranslit/jquery.synctranslit.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){

    <?php foreach ($languages as $lang) { ?>
	if ($('#category_seo_url_<?php echo $lang['language_id']; ?>').val()=='') {
			$(".category_name_<?php echo $lang['language_id']; ?>").syncTranslit({destination: "category_seo_url_<?php echo $lang['language_id']; ?>"});
	}
   <?php } ?>



});
</script>

</div>
</div>
</div>

<script type="text/javascript">

function odd_even() {
	var kz = 0;
	$('table tr').each(function(i,elem) {
	$(this).removeClass('odd');
	$(this).removeClass('even');
		if ($(this).is(':visible')) {
			kz++;
			if (kz % 2 == 0) {
				$(this).addClass('odd');
			}
		}
	});
}

$(document).ready(function(){
	odd_even();

	$('.htabs a').click(function() {
		odd_even();
	});

	$('.vtabs a').click(function() {
		odd_even();
	});
});

function select_this(ithis) {

if (!$(ithis).hasClass('no_change')) {
	        $(ithis).removeClass('sc_select_enable');
	        $(ithis).removeClass('sc_select_disable');

			this_val = $(ithis).find('option:selected').val()

			if (this_val == '1' ) {
				$(ithis).addClass('sc_select_enable');
			}

			if (this_val == '0' || this_val == '' ) {
				$(ithis).addClass('sc_select_disable');
			}

			if (this_val != '0' && this_val != '1' && this_val != '') {
				$(ithis).addClass('sc_select_other');
			}
		}
}


function input_this(ithis) {

		if (!$(ithis).hasClass('no_change')) {
	        $(ithis).removeClass('sc_select_enable');
	        $(ithis).removeClass('sc_select_disable');

			if ( $(ithis).val() != '' ) {
				$(ithis).addClass('sc_select_enable');
			} else {
				$(ithis).addClass('sc_select_disable');
			}
		}
}



function input_select_change() {
	$('input').each(function(){
		input_this(this);
	});

	$('select').each(function(){
		select_this(this);
	});
}

$(document).ready(function(){

$(document).on('change', 'select', function(event) {
		select_this(this);
	  });

$(document).on('blur', 'input', function(event) {
		input_this(this)
	  });
input_select_change();
});



</script>

<?php echo $footer; ?>
