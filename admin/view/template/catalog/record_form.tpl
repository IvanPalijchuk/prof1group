<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">

<?php if (SC_VERSION > 15) { ?>
<script type="text/javascript" src="view/javascript/summernote/summernote.js"></script>
<link href="view/javascript/summernote/summernote.css" rel="stylesheet" />
<?php } ?>

<?php echo $agoo_header; ?>
  <div class="page-header">
    <div class="container-fluid">

<div id="content1" style="border: none;">

<div style="clear: both; line-height: 1px; font-size: 1px;"></div>


<?php if ($error_warning) { ?>
    <div class="alert alert-danger warning"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
           <?php if ($error_blog_main) { ?>
              <span class="error"><?php echo $error_blog_main; ?></span>
              <script>
              	$(window).on("load", function() {
               		$('#tab-links-tab').click();
               	});
              </script>
           <?php } ?>
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
     <a onclick="form_submit();" class="markbutton button_orange nohref"><?php echo $button_save; ?></a>
     <a onclick="$('#form').append('<input type=\'hidden\' name=\'button_apply\' value=\'1\'>'); form_submit();" class="markbutton button_orange nohref"><?php echo $button_apply; ?></a>
     <a onclick="location = '<?php echo $cancel; ?>';" class="markbutton button_orange nohref"><?php echo $button_cancel; ?></a>
   </div>
   <div style="width: 100%; overflow: hidden; clear: both; height: 1px; line-height: 1px;">&nbsp;</div>


  <div class="box">
   <div class="content">
      <div id="tabs" class="htabs"><a href="#tab-general"><?php echo $tab_general; ?></a>
      <a href="#tab-data"><?php echo $tab_data; ?></a>
      <a href="#tab-links" id="tab-links-tab"><?php echo $tab_links; ?></a>
    <?php if (isset($ascp_settings['reviews_widget_status']) && $ascp_settings['reviews_widget_status']) { ?>
      <a href="#tab-comments"><?php echo $url_comment_text; ?></a>
      <a href="#tab-attribute"><?php echo $tab_attribute; ?></a>
      <a href="#tab-image"><?php echo $tab_image; ?></a>
	<?php } ?>
	  <a href="#tab-design"><?php echo $tab_design; ?></a>

      </div>
	<?php $attribute_row = 0; ?>
	<?php $image_row = 0; ?>

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
                	<input type="text" class="record_name_<?php echo $lang['language_id']; ?> form-control" name="record_description[<?php echo $lang['language_id']; ?>][name]" size="100" value="<?php echo isset($record_description[$lang['language_id']]) ? $record_description[$lang['language_id']]['name'] : ''; ?>" />
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
              <input type="text" class="form-control" id="record_seo_url_<?php echo $lang['language_id']; ?>" name="keyword[<?php echo $lang['language_id']; ?>]" value="<?php if (isset($keyword[$lang['language_id']])) echo $keyword[$lang['language_id']]; ?>" size="50"/>
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
                <input type="text" class="form-control" name="record_description[<?php echo $lang['language_id']; ?>][meta_title]" size="100" value="<?php echo isset($record_description[$lang['language_id']]['meta_title']) ? $record_description[$lang['language_id']]['meta_title'] : ''; ?>" />
                </div>
                </td>
            </tr>

            <tr>
                <td><?php echo $language->get('entry_meta_h1'); ?></td>
                <td>
                <div class="input-group">
                <input type="text" class="form-control" name="record_description[<?php echo $lang['language_id']; ?>][meta_h1]" size="100" value="<?php echo isset($record_description[$lang['language_id']]['meta_h1']) ? $record_description[$lang['language_id']]['meta_h1'] : ''; ?>" />
                </div>
                </td>
            </tr>


             <tr>
                <td><?php echo $entry_meta_description; ?></td>
                <td>
                <div class="input-group">
                <textarea class="form-control" name="record_description[<?php echo $lang['language_id']; ?>][meta_description]" cols="40" rows="5"><?php echo isset($record_description[$lang['language_id']]) ? $record_description[$lang['language_id']]['meta_description'] : ''; ?></textarea>
                </div>
                </td>
             </tr>



              <tr>
                <td><?php echo $entry_meta_keyword; ?></td>
                <td>
                <div class="input-group">
                <textarea class="form-control" name="record_description[<?php echo $lang['language_id']; ?>][meta_keyword]" cols="40" rows="5"><?php echo isset($record_description[$lang['language_id']]) ? $record_description[$lang['language_id']]['meta_keyword'] : ''; ?></textarea>
                </div>
                </td>
              </tr>



             <tr>
                <td><?php echo $entry_sdescription; ?></td>

         	<?php 	if (SC_VERSION < 20) {	?>
               <td>
               <textarea class="record_textarea" name="record_description[<?php echo $lang['language_id']; ?>][sdescription]" id="sdescription<?php echo $lang['language_id']; ?>"><?php echo isset($record_description[$lang['language_id']]) ? html_entity_decode($record_description[$lang['language_id']]['sdescription'], ENT_QUOTES, 'UTF-8')  : ''; ?></textarea>
               </td>
         	<?php
         	} else {
         	?>
			<td>
                  <div class="form-group">
                    <div class="col-sm-10 sdescription-textarea input-sdescription<?php echo $lang['language_id']; ?>_" style="padding: 0; width: 100%;">
                      <textarea id="input-sdescription<?php echo $lang['language_id']; ?>_" name="record_description[<?php echo $lang['language_id']; ?>][sdescription]" placeholder="<?php echo $entry_sdescription; ?>"  class="form-control sc-admin-input-textarea"><?php echo isset($record_description[$lang['language_id']]) ? html_entity_decode($record_description[$lang['language_id']]['sdescription'], ENT_QUOTES, 'UTF-8') : ''; ?></textarea>
       				<a href="" class="hrefajax" onclick="load_editor('input-sdescription<?php echo $lang['language_id']; ?>_', '100'); return false;"><?php echo $language->get('entry_editor'); ?></a>
                   </div>
                  </div>


			</td>
         	<?php
         	}
         	?>
            </tr>



            <tr>
                <td><?php echo $entry_description; ?></td>

         	<?php if (SC_VERSION < 20) { ?>
            <td>
            	<textarea class="record_textarea" name="record_description[<?php echo $lang['language_id']; ?>][description]" id="description<?php echo $lang['language_id']; ?>" style="height: 300px;"><?php echo isset($record_description[$lang['language_id']]) ? html_entity_decode($record_description[$lang['language_id']]['description'], ENT_QUOTES, 'UTF-8') : ''; ?></textarea>
      			<br>
      			<a href="" class="hrefajax" onclick="load_editor15(); return false;"><?php echo $language->get('entry_editor'); ?></a>
      		</td>

         	<?php
         	} else {
         	?>
			<td>
                  <div class="form-group">

                    <div class="col-sm-10 input-description<?php echo $lang['language_id']; ?>_" style="padding: 0; width: 100%;">
                      <textarea id="input-description<?php echo $lang['language_id']; ?>_" name="record_description[<?php echo $lang['language_id']; ?>][description]" placeholder="<?php echo $entry_description; ?>"  class="form-control sc-admin-input-textarea"><?php echo isset($record_description[$lang['language_id']]) ?html_entity_decode($record_description[$lang['language_id']]['description'], ENT_QUOTES, 'UTF-8') : ''; ?></textarea>
      				<a href="" class="hrefajax" onclick="load_editor('input-description<?php echo $lang['language_id']; ?>_', '100'); return false;"><?php echo $language->get('entry_editor'); ?></a>

                    </div>
                  </div>


			</td>
         	<?php
         	}
         	?>
              </tr>

              <tr>
                <td><?php echo $entry_tag; ?></td>
                <td>
                <div class="form-group">
                <input type="text" class="form-control" name="record_tag[<?php echo $lang['language_id']; ?>]" value="<?php echo isset($record_tag[$lang['language_id']]) ? $record_tag[$lang['language_id']] : ''; ?>" size="80" />
                </div>
                </td>
              </tr>

        <?php if (isset($ascp_settings['tags_widget_status']) && $ascp_settings['tags_widget_status']) { ?>
         <tr>
            <td>
				<div class="form-group">
				<select class="form-control" id="record_tags_search<?php echo $lang['language_id']; ?>" name="record_tags_search[<?php echo $lang['language_id']; ?>]">
                  <option value="1" <?php if (isset($record_tags_search[$lang['language_id']]) && $record_tags_search[$lang['language_id']]==1 ) { ?>selected="selected"<?php } ?>><?php echo $language->get('text_record_tags_tag'); ?></option>
                  <option value="2" <?php if (isset($record_tags_search[$lang['language_id']]) && $record_tags_search[$lang['language_id']]==2 ) { ?>selected="selected"<?php } ?>><?php echo $language->get('text_record_tags_search'); ?></option>
                  <option value="3" <?php if (isset($record_tags_search[$lang['language_id']]) && $record_tags_search[$lang['language_id']]==3 ) { ?>selected="selected"<?php } ?>><?php echo $language->get('text_record_tags_url'); ?></option>
                </select>
                </div>

                <br>
                <?php echo $language->get('entry_record_tags_product'); ?>

            </td>
            <td>
            <div class="form-group">
            <input type="text" class="form-control" id="record_tags_product_<?php echo $lang['language_id']; ?>" name="record_tags_product[<?php echo $lang['language_id']; ?>]" value="<?php echo isset($record_tags_product[$lang['language_id']]) ? $record_tags_product[$lang['language_id']] : ''; ?>" size="80" />
            </div>
            </td>
         </tr>
         <?php } ?>
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
      <td><?php echo $entry_image; ?></td>
      <td valign="top">
      <div class="image form-group col-sm-10" data-toggle="image">

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
	      <a onclick="image_upload('image', 'thumb');"><?php echo $language->get('text_browse'); ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('#thumb').prop('src', '<?php echo $no_image; ?>'); $('#image').prop('value', '');"><?php echo $language->get('text_clear'); ?></a>
       <?php } ?>
        </div>

        </td>
    </tr>





            <tr>
              <td><?php echo $entry_date_available; ?></td>
              <td>
              <div class="input-group">
              <input type="text" name="date_available" value="<?php echo $date_available; ?>" size="20" class="datetime form-control" />
              </div>
              </td>
            </tr>

            <tr>
              <td><?php echo $entry_date_end; ?></td>
              <td>
              <div class="input-group">
              <input type="text" name="date_end" value="<?php echo $date_end; ?>" size="20" class="datetime form-control" />
              </div>
              </td>
            </tr>

            <!--
            <tr>
                <td><?php echo $entry_customer_group_v; ?></td>
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
              <td><?php echo $language->get('entry_customer_groups'); ?></td>
              <td>
              <div class="scrollbox" style="width: 50%;">
                  <?php $class = 'even'; ?>
                  <?php if (!isset($record_access)) { ?>
                  <?php foreach ($customer_groups_record as $customer_group) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div class="<?php echo $class; ?> " style="height: 30px;">
                    <input type="checkbox" name="customer_groups_record[<?php echo $customer_group['customer_group_id']; ?>]" value="<?php echo $customer_group['customer_group_id']; ?>" checked="checked" />
                    <?php echo $customer_group['name']; ?>

                   </div>
                  <?php } ?>

                  <?php } else { ?>

                  <?php foreach ($customer_groups_record as $customer_group) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div class="<?php echo $class; ?> " style="height: 30px;">
                    <?php
                    if (isset($record_access) && isset($record_access[$customer_group['customer_group_id']])) {
                    ?>
                    <input type="checkbox" name="customer_groups_record[]" value="<?php echo $customer_group['customer_group_id']; ?>" checked="checked" />
                    <?php echo $customer_group['name']; ?>
                    <?php } else { ?>
                    <input type="checkbox" name="customer_groups_record[]" value="<?php echo $customer_group['customer_group_id']; ?>" />
                    <?php echo $customer_group['name']; ?>
                    <?php } ?>
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

<style>
.dropdown-menu {	z-index: 1000000000;
}
</style>
         <tr>
            <td><?php echo $entry_author; ?></td>
            <td>
            <div class="input-group">

                 <div class="input-group">
            		<input class="form-control" type="text" name="author" value="<?php echo $author; ?>" />
                </div>

                 <div class="input-group">
                 <?php echo $entry_author_id; ?>
                 </div>

                <div class="input-group">



		           <input class="form-control" type="text" name="customer_id" value="<?php echo $customer_id; ?>" size="3" />
        		      <?php if ($error_author) { ?>
              				<span class="error"><?php echo $error_author; ?></span>
		              <?php } ?>
              	</div>



                </div>
          </td>
         </tr>



            <tr>
              <td><?php echo $entry_sort_order; ?></td>
              <td>
              <div class="input-group">
              <input class="form-control" type="text" name="sort_order" value="<?php echo $sort_order; ?>" size="2" />
              </div>
              </td>
            </tr>

           <tr>
              <td><?php echo $language->get('entry_viewed'); ?></td>
              <td>
              <div class="input-group">
              <input class="form-control" type="text" name="viewed" value="<?php  if (isset($viewed)) echo $viewed; else echo 0; ?>" size="4" />
              </div>
              </td>
            </tr>


          </table>
        </div>

        <div id="tab-links">
          <table class="form">

            <tr>
              <td><?php echo $entry_blog; ?>

              <?php if ($error_blog_main) { ?>
              <span class="error"><?php echo $error_blog_main; ?></span>
              <?php } ?>

              </td>

              </td>
              <td>
              <div class="scrollbox" style="width: 50%;">
              <table>
              <tr>
              <td><?php echo $language->get('text_main_category'); ?></td>
              <td><?php echo $language->get('text_category'); ?></td>
              <td><?php echo $language->get('text_name_category'); ?></td>
              </tr>

                  <?php $class = 'odd'; $i=0; ?>
                  <?php foreach ($categories as $blog) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>

                   <tr class="<?php echo $class; ?>">
					<?php if (in_array($blog['blog_id'], $record_blog)) {
						$endes ="";
						$check =' checked="checked" ';
					 } else {
					    $endes =' disabled ';
					    $check ="";
					 } ?>


                    <td>
                    <?php if ($blog['blog_id']==$blog_main) { ?>
                     <input type="radio" id="blog_main_<?php echo $blog['blog_id']; ?>" name="blog_main" value="<?php echo $blog['blog_id']; ?>" checked="checked" />
                    <?php } else { ?>
                     <input type="radio" id="blog_main_<?php echo $blog['blog_id']; ?>" name="blog_main" value="<?php echo $blog['blog_id']; ?>" <?php echo $endes; ?> />
                    <?php } ?>
                    </td>

                    <td>
                    <input type="checkbox" class="record_blog" name="record_blog[<?php echo $i; ?>]" value="<?php echo $blog['blog_id']; ?>" <?php echo $check; ?> />
                    </td>

                    <td>
                    <?php echo $blog['name']; ?>
                    </td>




                  </tr>



                  <?php
                   $i++;
                  }
                  ?>


                  </table>

                </div>
                <a onclick="$(this).parent().find(':checkbox').prop('checked', true);" class="nohref"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').prop('checked', false);" class="nohref"><?php echo $text_unselect_all; ?></a></td>
            </tr>

            <tr>
              <td><?php echo $entry_store; ?></td>
              <td>

              <div class="scrollbox">
                  <?php $class = 'even'; ?>
                  <div class="<?php echo $class; ?>">
                    <?php if (in_array(0, $record_store)) { ?>
                    <input type="checkbox" name="record_store[]" value="0" checked="checked" />
                    <?php echo $text_default; ?>
                    <?php } else { ?>
                    <input type="checkbox" name="record_store[]" value="0" />
                    <?php echo $text_default; ?>
                    <?php } ?>
                  </div>


                  <?php foreach ($stores as $store) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div class="<?php echo $class; ?>">
                    <?php if (in_array($store['store_id'], $record_store)) { ?>
                    <input type="checkbox" name="record_store[]" value="<?php echo $store['store_id']; ?>" checked="checked" />
                    <?php echo $store['name']; ?>
                    <?php } else { ?>
                    <input type="checkbox" name="record_store[]" value="<?php echo $store['store_id']; ?>" />
                    <?php echo $store['name']; ?>
                    <?php } ?>
                  </div>
                  <?php } ?>
                </div>
                <a onclick="$(this).parent().find(':checkbox').prop('checked', true);" class="nohref"><?php echo $language->get('text_select_all'); ?></a> / <a onclick="$(this).parent().find(':checkbox').prop('checked', false);" class="nohref"><?php echo $language->get('text_unselect_all'); ?></a></td>

                </td>
            </tr>


      	 <!--
      	 <tr>
              <td><?php echo $entry_download; ?></td>
              <td><div class="scrollbox">
                  <?php $class = 'odd'; ?>
                  <?php foreach ($downloads as $download) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div class="<?php echo $class; ?>">
                    <?php if (in_array($download['download_id'], $record_download)) { ?>
                    <input type="checkbox" name="record_download[]" value="<?php echo $download['download_id']; ?>" checked="checked" />
                    <?php echo $download['name']; ?>
                    <?php } else { ?>
                    <input type="checkbox" name="record_download[]" value="<?php echo $download['download_id']; ?>" />
                    <?php echo $download['name']; ?>
                    <?php } ?>
                  </div>
                  <?php } ?>
                </div></td>
            </tr>
             -->

<?php if (isset( $ascp_settings['related_widget_status']) && $ascp_settings['related_widget_status']) { ?>
           <tr>
              <td><?php echo $language->get('entry_related_product'); ?></td>
              <td>
              <div class="input-group">
              <input type="text" name="prelated" id="product_related" class="related form-control" value="" />
              <input type="hidden" name="phrelated" value="product">
              </div>
              </td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>
              <div class="scrollbox" id="product-related">
                  <?php $class = 'odd'; ?>
                  <?php foreach ($product_related as $product_related) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div id="product-related<?php echo $product_related['product_id']; ?>" class="<?php echo $class; ?>"> <?php echo $product_related['name']; ?><img src="view/image/delete.png" />
                    <input type="hidden" name="product_related[]" value="<?php echo $product_related['product_id']; ?>" />
                  </div>
                  <?php } ?>
                </div>
                </td>
            </tr>


           <tr>
              <td><?php echo $language->get('entry_related_record'); ?></td>
              <td>
              <div class="input-group">
              <input type="text" name="related" id="record_related" class="related form-control" value="" />
              <input type="hidden" name="rhrelated" value="record">
              </div>
              </td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>
              <div class="scrollbox" id="record-related">
                  <?php $class = 'odd'; ?>
                  <?php if (isset($record_related)) { foreach ($record_related as $record_related) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div id="record-related<?php echo $record_related['record_id']; ?>" class="<?php echo $class; ?>"> <?php echo $record_related['name']; ?><img src="view/image/delete.png" />
                    <input type="hidden" name="record_related[]" value="<?php echo $record_related['record_id']; ?>" />
                  </div>
                  <?php } } ?>
                </div>
                </td>
            </tr>

           <tr>
              <td><?php echo $language->get('entry_related_category'); ?></td>
              <td>
              <div class="input-group">
              <input type="text" name="crelated" id="category_related" class="related form-control" value="" />
              <input type="hidden" name="chrelated" value="category">
              </div>
              </td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>
              <div class="scrollbox" id="category-related">
                  <?php $class = 'odd'; ?>
                  <?php if (isset($category_related)) { foreach ($category_related as $category_related) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div id="category-related<?php echo $category_related['category_id']; ?>" class="<?php echo $class; ?>"> <?php echo $category_related['name']; ?><img src="view/image/delete.png" />
                    <input type="hidden" name="category_related[]" value="<?php echo $category_related['category_id']; ?>" />
                  </div>
                  <?php } } ?>
                </div>
                </td>
            </tr>

           <tr>
              <td><?php echo $language->get('entry_related_manufacturer'); ?></td>
              <td>
              <div class="input-group">
              <input type="text" name="mrelated" id="manufacturer_related" class="related form-control" value="" />
              <input type="hidden" name="mhrelated" value="manufacturer">
              </div>
              </td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>
              <div class="scrollbox" id="manufacturer-related">
                  <?php $class = 'odd'; ?>
                  <?php if (isset($manufacturer_related)) { foreach ($manufacturer_related as $manufacturer_related) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div id="manufacturer-related<?php echo $manufacturer_related['manufacturer_id']; ?>" class="<?php echo $class; ?>"> <?php echo $manufacturer_related['name']; ?><img src="view/image/delete.png" />
                    <input type="hidden" name="manufacturer_related[]" value="<?php echo $manufacturer_related['manufacturer_id']; ?>" />
                  </div>
                  <?php } } ?>
                </div>
                </td>
            </tr>

           <tr>
              <td><?php echo $language->get('entry_related_blog'); ?></td>
              <td>
              <div class="input-group">
              <input type="text" name="brelated" id="blog_related" class="related form-control" value="" />
              <input type="hidden" name="bhrelated" value="blog">
              </div>
              </td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>
              <div class="scrollbox" id="blog-related">
                  <?php $class = 'odd'; ?>
                  <?php if (isset($blog_related)) { foreach ($blog_related as $blog_related) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div id="blog-related<?php echo $blog_related['blog_id']; ?>" class="<?php echo $class; ?>"> <?php echo $blog_related['name']; ?><img src="view/image/delete.png" />
                    <input type="hidden" name="blog_related[]" value="<?php echo $blog_related['blog_id']; ?>" />
                  </div>
                  <?php } } ?>
                </div>
                </td>
            </tr>
   <?php }  ?>

          </table>

        </div>



  <?php if (isset( $ascp_settings['reviews_widget_status']) && $ascp_settings['reviews_widget_status']) { ?>
        <div id="tab-comments">

          <table class="form">
          <tr>
              <td><?php echo $entry_comment_status; ?></td>
              <td>
              <div class="input-group">
              <select name="comment[status]" class="form-control">
                  <?php if ($comment['status']) { ?>
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
              <td><?php echo $entry_comment_status_reg; ?></td>
              <td>
              <div class="input-group">
              <select name="comment[status_reg]" class="form-control">
                  <?php if ($comment['status_reg']) { ?>
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
              <td><?php echo $entry_comment_status_now; ?></td>
              <td>
              <div class="input-group">
              <select name="comment[status_now]" class="form-control">
                  <?php if ($comment['status_now']) { ?>
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
              <td><?php echo $language->get('entry_comment_rating'); ?></td>
              <td>
              <div class="input-group">
              <select name="comment[rating]" class="form-control">
                  <?php if ($comment['rating']) { ?>
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
              <td><?php echo $language->get('entry_comment_signer'); ?></td>
              <td>
              <div class="input-group">
              <select name="comment[signer]" class="form-control">
                  <?php if ($comment['signer']) { ?>
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
 		<td>
			<?php echo $language->get('entry_order_comments'); ?>
		</td>
		<td>
         <div class="input-group">
         <select id="comment_order"  name="comment[order]" class="form-control">
           <option value="sort"  <?php if (isset($comment['order']) &&  $comment['order']=='sort')  { echo 'selected="selected"'; } ?>><?php echo $language->get('text_what_sort'); ?></option>
           <option value="date"  <?php if (isset( $comment['order']) &&  $comment['order']=='date')  { echo 'selected="selected"'; } ?>><?php echo $language->get('text_what_date'); ?></option>
           <option value="rating" <?php if (isset( $comment['order']) &&  $comment['order']=='rating') { echo 'selected="selected"'; } ?>><?php echo $language->get('text_what_rating'); ?></option>
            <option value="rate" <?php if (isset( $comment['order']) &&  $comment['order']=='rate') { echo 'selected="selected"'; } ?>><?php echo $language->get('text_what_rate'); ?></option>
         </select>
         </div>
		</td>
	</tr>




 	<tr>
 		<td>
			<?php echo $language->get('entry_order_ad'); ?>
		</td>
		<td>
         <div class="input-group">
         <select id="comment_order_ad"  name="comment[order_ad]" class="form-control">
           <option value="desc"  <?php if (isset( $comment['order_ad']) &&  $comment['order_ad']=='desc') { echo 'selected="selected"'; } ?>><?php echo $language->get('text_what_desc'); ?></option>
           <option value="asc"   <?php if (isset( $comment['order_ad']) &&  $comment['order_ad']=='asc')  { echo 'selected="selected"'; } ?>><?php echo $language->get('text_what_asc'); ?></option>
        </select>
        </div>
		</td>
	</tr>



		    <tr>
		     <td class="left"><?php echo $language->get('entry_comment_rating_num'); ?></td>
		     <td class="left">
		      <div class="input-group">
		      <input type="text" class="form-control" name="comment[rating_num]" value="<?php  if (isset($comment['rating_num'])) echo $comment['rating_num']; ?>" size="3" />
		      </div>
		     </td>
		    </tr>

       <?php foreach ($languages as $lang) {

              if (isset($record_description[$lang['language_id']]['name']) && $record_description[$lang['language_id']]['name']!='') {
            ?>

            <tr>
              <td>
              <?php echo  $lang['name']; ?>&nbsp;&nbsp;<img src="<?php echo $lang['image']; ?>" title="<?php echo $lang['name']; ?>" />
              </td>

              <td>

<a href="<?php echo $url_comment.'&action=comment&filter_name='.$record_description[$lang['language_id']]['name']; ?>" class="markbutton"><div style=""><img src="view/image/blog-com-m.png"  style="" ></div><div style=""><?php echo $language->get('entry_comment_record'); ?>&nbsp;<ins style="text-decoration: none; font-size: 11px; color: #ACEEAD;">(<?php echo  $lang['name']; ?>)</ins></div></a>

              </td>

            </tr>
             <?php
               }
               }
             ?>





          </table>
         </div>





        <div id="tab-attribute">
          <table id="attribute" class="list">
            <thead>
              <tr>
                <td class="left"><?php echo $entry_attribute; ?></td>
                <td class="left"><?php echo $entry_text; ?></td>
                <td></td>
              </tr>
            </thead>

            <?php foreach ($record_attributes as $record_attribute) { ?>
            <tbody id="attribute-row<?php echo $attribute_row; ?>">
              <tr>
                <td class="left"><input type="text" name="record_attribute[<?php echo $attribute_row; ?>][name]" value="<?php echo $record_attribute['name']; ?>" />
                  <input type="hidden" name="record_attribute[<?php echo $attribute_row; ?>][attribute_id]" value="<?php echo $record_attribute['attribute_id']; ?>" /></td>
                <td class="left"><?php foreach ($languages as $lang) { ?>
                  <textarea name="record_attribute[<?php echo $attribute_row; ?>][record_attribute_description][<?php echo $lang['language_id']; ?>][text]" cols="40" rows="5"><?php echo isset($record_attribute['record_attribute_description'][$lang['language_id']]) ? $record_attribute['record_attribute_description'][$lang['language_id']]['text'] : ''; ?></textarea>
                  <img src="<?php echo $lang['image']; ?>" title="<?php echo $lang['name']; ?>" /><br />
                  <?php } ?></td>
                <td class="left"><a onclick="$('#attribute-row<?php echo $attribute_row; ?>').remove();" class="markbutton nohref button_purple"><?php echo $button_remove; ?></a></td>
              </tr>
            </tbody>
            <?php $attribute_row++; ?>
            <?php } ?>
            <tfoot>
              <tr>
                <td colspan="2"></td>
                <td class="left"><a onclick="addAttribute();" class="markbutton nohref"><?php echo $language->get('button_add_attribute'); ?></a></td>
              </tr>
            </tfoot>
          </table>
        </div>



       <div id="tab-image">
          <table id="images" class="list">
            <thead>
              <tr>
                <td class="left"><?php echo $entry_image; ?></td>
                <td><?php echo $language->get('entry_title'); ?></td>
                <td class="right"><?php echo $entry_sort_order; ?></td>
                <td></td>
              </tr>
            </thead>

            <?php foreach ($record_images as $record_image) { ?>
            <tbody id="image-row<?php echo $image_row; ?>">
              <tr>

    	<?php 	if (SC_VERSION > 15) {   	?>
             <td class="text-left"><a href="" id="thumb-image<?php echo $image_row; ?>" data-toggle="image" class="img-thumbnail"><img src="<?php echo $record_image['thumb']; ?>" alt="" title="" data-placeholder="<?php echo $no_image; ?>" /></a><input type="hidden" name="record_image[<?php echo $image_row; ?>][image]" value="<?php echo $record_image['image']; ?>" id="input-image<?php echo $image_row; ?>" /></td>
       	<?php  	} else { ?>
               <td class="left"><div class="image"><img src="<?php echo $record_image['thumb']; ?>" alt="" id="thumb<?php echo $image_row; ?>" />
                    <input type="hidden" name="record_image[<?php echo $image_row; ?>][image]" value="<?php echo $record_image['image']; ?>" id="image<?php echo $image_row; ?>" />
                    <br />
                    <a onclick="image_upload('image<?php echo $image_row; ?>', 'thumb<?php echo $image_row; ?>');"><?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('#thumb<?php echo $image_row; ?>').prop('src', '<?php echo $no_image; ?>'); $('#image<?php echo $image_row; ?>').prop('value', '');"><?php echo $text_clear; ?></a></div>
                </td>
        <?php  } ?>


					<td class="right">
					 <?php foreach ($languages as $lang) { ?>

					<div style="margin-bottom: 3px;">
					<?php echo $language->get('entry_title'); ?>&nbsp;<input type="text" name="record_image[<?php echo $image_row; ?>][options][title][<?php echo $lang['language_id']; ?>]" value="<?php if (isset($record_image['options']['title'][$lang['language_id']])) echo $record_image['options']['title'][$lang['language_id']]; ?>" style="width: 300px;"><img src="<?php echo $lang['image']; ?>" title="<?php echo $lang['name']; ?>" >
					</div>

					<div style="margin-bottom: 10px;">
					<?php echo $language->get('entry_description'); ?>&nbsp;<textarea name="record_image[<?php echo $image_row; ?>][options][description][<?php echo $lang['language_id']; ?>]" style="width: 300px;"><?php if (isset($record_image['options']['description'][$lang['language_id']])) echo $record_image['options']['description'][$lang['language_id']]; ?></textarea><img src="<?php echo $lang['image']; ?>" title="<?php echo $lang['name']; ?>" >
					</div>
                    <div style="border-bottom: 1px solid #DDD; height: 1px; line-height: 1px; width: 100%; margin-bottom: 5px;">&nbsp;</div>

      				<div style="margin-bottom: 3px;">
					<?php echo $language->get('entry_url'); ?>&nbsp;<input type="text" name="record_image[<?php echo $image_row; ?>][options][url][<?php echo $lang['language_id']; ?>]" value="<?php if (isset($record_image['options']['url'][$lang['language_id']])) echo $record_image['options']['url'][$lang['language_id']]; ?>" style="width: 300px;"><img src="<?php echo $lang['image']; ?>" title="<?php echo $lang['name']; ?>" >
					</div>
					<?php } ?>

                     <div style="border-bottom: 1px solid #DDD; height: 1px; line-height: 1px; width: 100%; margin-bottom: 5px;">&nbsp;</div>
      				<div style="margin-bottom: 3px;">
					<?php echo $language->get('entry_reserved'); ?>&nbsp;<textarea name="record_image[<?php echo $image_row; ?>][options][reserved]" style="width: 300px;"><?php if (isset($record_image['options']['reserved'])) echo $record_image['options']['reserved']; ?></textarea>
					</div>

					</td>


                <td class="right"><input type="text" name="record_image[<?php echo $image_row; ?>][sort_order]" value="<?php echo $record_image['sort_order']; ?>" size="2" /></td>
                <td class="left"><a onclick="$('#image-row<?php echo $image_row; ?>').remove();" class="markbutton button_purple nohref"><?php echo $button_remove; ?></a></td>
              </tr>
            </tbody>
            <?php $image_row++; ?>
            <?php } ?>
            <tfoot>
              <tr>
                <td></td>
                <td colspan="4" class="right">
                <a onclick="$('#add_images').toggle('slow'); return false;" class="markbutton nohref"><?php echo $language->get('button_add_images'); ?></a>
                <a onclick="addImage('','');" class="markbutton nohref"><?php echo $button_add_image; ?></a>
                </td>
              </tr>
            </tfoot>
          </table>

         <div id="add_images" style="display: none;">
           <!-- <form enctype="multipart/form-data"> -->
                <div class="form-group">
                    <input id="multifile" type="file" multiple class="file" data-overwrite-initial="false">
                    <input id="<?php echo $token_name; ?>" name="<?php echo $token_name; ?>" type="hidden" value="<?php echo $token; ?>">
                </div>
		  <!-- </form> -->

			<script>

		    $("#multifile").fileinput({
		        language: '<?php echo $upload_images_lang; ?>',
		        uploadUrl: '<?php echo $upload_images_url; ?>',
		        allowedFileExtensions : [<?php echo $upload_images_ext; ?>],
		        maxFileSize: <?php echo $upload_images_size; ?>,
		        maxFilesNum: <?php echo $upload_images_num; ?>,
		        maxFileCount: <?php echo $upload_images_num; ?>,
		        <?php if (SC_VERSION > 15) { ?>
		        browseIcon: '<i class="fa fa-folder-open"></i>&nbsp;',
		        removeIcon: '<i class="fa fa-times"></i>&nbsp;',
		        uploadIcon: '<i class="fa fa-upload"></i>&nbsp;',
		        fileActionSettings: {			        browseIcon: '<i class="fa fa-folder-open"></i>&nbsp;',
			        removeIcon: '<i class="fa fa-times"></i>&nbsp;',
			        uploadIcon: '<i class="fa fa-upload"></i>&nbsp;',
			        indicatorNew: '<i class="fa fa-thumbs-o-down"></i>&nbsp;',
			        indicatorSuccess: '<i class="fa fa-download"></i>&nbsp;'
		        },
               <?php } ?>
               overwriteInitial: false
			});

		    $('#multifile').on('fileuploaded', function(event, data, previewId, index) {
		        var form = data.form, files = data.files, extra = data.extra,
		            response = data.response, reader = data.reader;

		            addImage(response.thumb, response.name);

		        console.log(data);
		    });

			</script>
           </div>



        </div>

 <?php } ?>

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
                <td class="left"><?php echo $text_default;  ?></td>
                <td class="left">
                <div class="input-group">
                <select name="record_layout[0][layout_id]" class="form-control">
                    <option value=""></option>
                    <?php foreach ($layouts as $layout) { ?>
                    <?php if (isset($record_layout[0]) && $record_layout[0] == $layout['layout_id']) { ?>
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
                <select name="record_layout[<?php echo $store['store_id']; ?>][layout_id]" class="form-control">
                    <option value=""></option>
                    <?php foreach ($layouts as $layout) { ?>
                    <?php if (isset($record_layout[$store['store_id']]) && $record_layout[$store['store_id']] == $layout['layout_id']) { ?>
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



      </form>
    </div>
  </div>
</div>

<script>
var myEditor = new Array();
</script>

<?php if (SC_VERSION < 20) { ?>


<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script>

<script type="text/javascript">

function load_editor15() {

if (CKEDITOR.flag_loaded) {

	for(name in CKEDITOR.instances)	{
    	CKEDITOR.instances[name].destroy(true);
	}

   CKEDITOR.flag_loaded = false;
} else {
	<?php foreach ($languages as $lang) { ?>

	CKEDITOR.replace('sdescription<?php echo $lang['language_id']; ?>', {
		filebrowserBrowseUrl: 'index.php?route=common/filemanager&<?php echo $token_name; ?>=<?php echo $token; ?>',
		filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&<?php echo $token_name; ?>=<?php echo $token; ?>',
		filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&<?php echo $token_name; ?>=<?php echo $token; ?>',
		filebrowserUploadUrl: 'index.php?route=common/filemanager&<?php echo $token_name; ?>=<?php echo $token; ?>',
		filebrowserImageUploadUrl: 'index.php?route=common/filemanager&<?php echo $token_name; ?>=<?php echo $token; ?>',
		filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&<?php echo $token_name; ?>=<?php echo $token; ?>',
							enterMode 	: CKEDITOR.ENTER_BR,
							entities 	: false,
							htmlEncodeOutput : false
	});

	CKEDITOR.replace('description<?php echo $lang['language_id']; ?>', {
		filebrowserBrowseUrl: 'index.php?route=common/filemanager&<?php echo $token_name; ?>=<?php echo $token; ?>',
		filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&<?php echo $token_name; ?>=<?php echo $token; ?>',
		filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&<?php echo $token_name; ?>=<?php echo $token; ?>',
		filebrowserUploadUrl: 'index.php?route=common/filemanager&<?php echo $token_name; ?>=<?php echo $token; ?>',
		filebrowserImageUploadUrl: 'index.php?route=common/filemanager&<?php echo $token_name; ?>=<?php echo $token; ?>',
		filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&<?php echo $token_name; ?>=<?php echo $token; ?>',
							enterMode 	: CKEDITOR.ENTER_BR,
							entities 	: false,
							htmlEncodeOutput : false
	});
	<?php } ?>

CKEDITOR.flag_loaded = true;
}


}
</script>

<?php if (isset($ascp_settings['admin_visualeditor_status']) && $ascp_settings['admin_visualeditor_status']) { ?>
<script>
load_editor15();
</script>
<?php }	else { ?>

<?php }	?>


<style>
.record_textarea {
width: 100% !important;
}
</style>


<?php }	?>





<script>
$('.related').each(function() {
	var e = this;
	var this_pointer_name = $(e).next().prop('value');
	var this_pointer = this_pointer_name + '_id';

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
				url: 'index.php?route=catalog/record/autocomplete&pointer='+this_pointer+'&<?php echo $token_name; ?>=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(irequest),
				dataType: 'json',
				'success': function(json) {
					response($.map(json, function(item) {
						return {
						label: item.name,
						value: eval('item.'+this_pointer)
						}
					}));
				}
			});

		},
		'select': function(event, ui) {         	<?php
         	if (SC_VERSION < 20) {
         	?>
         	 var ilabel = ui.item.label;
         	 var ivalue = ui.item.value;
         	<?php
         	} else {
         	?>
         		var ilabel = event['label'];
         		var ivalue = event['value'];
         	<?php
         	}
         	?>

			$('#'+this_pointer_name+'-related' + ivalue).remove();
			$('#'+this_pointer_name+'-related').append('<div id="'+this_pointer_name+'-related' + ivalue + '">' + ilabel + '<img src="view/image/delete.png" /><input type="hidden" name="'+this_pointer_name+'_related[]" value="' + ivalue + '" /></div>');
			$('#'+this_pointer_name+'-related div:odd').prop('class', 'odd');
			$('#'+this_pointer_name+'-related div:even').prop('class', 'even');

			return false;
		}
	});

});

//*************************************************
$('input[name=\'prelated\']').autocomplete({

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
			url: 'index.php?route=catalog/record/pautocomplete&<?php echo $token_name; ?>=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(irequest),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						label: item.name,
						value: item.product_id
					}
				}));
			}
		});

	},
	'select': function(event, ui) {         	<?php
         	if (SC_VERSION < 20) {
         	?>
         	 var ilabel = ui.item.label;
         	 var ivalue = ui.item.value;
         	<?php
         	} else {
         	?>
         		var ilabel = event['label'];
         		var ivalue = event['value'];
         	<?php
         	}
         	?>

		$('#product-related' + ivalue).remove();

		$('#product-related').append('<div id="product-related' + ivalue + '">' + ilabel + '<img src="view/image/delete.png" /><input type="hidden" name="product_related[]" value="' + ivalue + '" /></div>');

		$('#product-related div:odd').prop('class', 'odd');
		$('#product-related div:even').prop('class', 'even');

		return false;
	}
});
</script>

<script type="text/javascript">
$('input[name=\'author\']').autocomplete({
	'source': function(request, response) {
         	<?php
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
			url: 'index.php?route=agooa/author/authorcomplete&<?php echo $token_name; ?>=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(irequest),
			dataType: 'json',
			success: function(json) {

				response($.map(json, function(item) {
					return {
						label: item.name,
						value: item.customer_id
					}
				}));
			}
		});
	},
	'select': function(event, ui) {
         	<?php
         	if (SC_VERSION < 20) {
         	?>
         	 var ilabel = ui.item.label;
         	 var ivalue = ui.item.value;
         	<?php
         	} else {
         	?>
         		var ilabel = event['label'];
         		var ivalue = event['value'];
         	<?php
         	}
         	?>

		$('input[name=\'author\']').val(ilabel);
		$('input[name=\'customer_id\']').val(ivalue);

		return false;
	}
});

</script>





<script>
if ($.isFunction($.fn.on)) {

$(document).on('click', '#record-related div img', function() {
	$(this).parent().remove();

	$('#record-related div:odd').prop('class', 'odd');
	$('#record-related div:even').prop('class', 'even');
});

} else {
$('#record-related div img').live('click',  function() {
	$(this).parent().remove();

	$('#record-related div:odd').prop('class', 'odd');
	$('#record-related div:even').prop('class', 'even');
});
}
</script>

<script>
if ($.isFunction($.fn.on)) {

$(document).on('click', '#blog-related div img', function() {
	$(this).parent().remove();

	$('#blog-related div:odd').prop('class', 'odd');
	$('#blog-related div:even').prop('class', 'even');
});

} else {

$('#blog-related div img').live('click',  function() {
	$(this).parent().remove();

	$('#blog-related div:odd').prop('class', 'odd');
	$('#blog-related div:even').prop('class', 'even');
});
}
</script>


<script>
if ($.isFunction($.fn.on)) {

$(document).on('click', '#category-related div img', function() {
	$(this).parent().remove();

	$('#category-related div:odd').prop('class', 'odd');
	$('#category-related div:even').prop('class', 'even');
});

} else {

$('#category-related div img').live('click',  function() {
	$(this).parent().remove();

	$('#category-related div:odd').prop('class', 'odd');
	$('#category-related div:even').prop('class', 'even');
});
}
</script>



<script>
if ($.isFunction($.fn.on)) {

$(document).on('click', '#manufacturer-related div img', function() {
	$(this).parent().remove();

	$('#manufacturer-related div:odd').prop('class', 'odd');
	$('#manufacturer-related div:even').prop('class', 'even');
});

} else {

$('#manufacturer-related div img').live('click',  function() {
	$(this).parent().remove();

	$('#manufacturer-related div:odd').prop('class', 'odd');
	$('#manufacturer-related div:even').prop('class', 'even');
});
}
</script>


<script type="text/javascript">

if ($.isFunction($.fn.on)) {
$(document).on('click', '#product-related div img', function() {
	$(this).parent().remove();

	$('#product-related div:odd').prop('class', 'odd');
	$('#product-related div:even').prop('class', 'even');
});
} else {$('#product-related div img').live('click',  function() {
	$(this).parent().remove();

	$('#product-related div:odd').prop('class', 'odd');
	$('#product-related div:even').prop('class', 'even');
});

}
</script>


<script type="text/javascript">
var attribute_row = <?php echo $attribute_row; ?>;

function addAttribute() {
	html  = '<tbody id="attribute-row' + attribute_row + '">';
    html += '  <tr>';
	html += '    <td class="left"><div class="input-group"><input class="form-control" type="text" name="record_attribute[' + attribute_row + '][name]" value="" /><input type="hidden" name="record_attribute[' + attribute_row + '][attribute_id]" value="" /></div></td>';
	html += '    <td class="left">';
	<?php foreach ($languages as $lang) { ?>
	html += '<div class="input-group marginbottom5px"><span class="input-group-addon"><?php echo strtoupper($lang['code']); ?><br><img src="<?php echo $lang['image']; ?>" title="<?php echo $lang['name']; ?>" ></span>';
	html += '<textarea name="record_attribute[' + attribute_row + '][record_attribute_description][<?php echo $lang['language_id']; ?>][text]" cols="40" rows="5" class="form-control"></textarea></div>';
    <?php } ?>
	html += '    </td>';
	html += '    <td class="left"><a onclick="$(\'#attribute-row' + attribute_row + '\').remove();" class="markbutton nohref button_purple"><?php echo $button_remove; ?></a></td>';
    html += '  </tr>';
    html += '</tbody>';

	$('#attribute tfoot').before(html);

	attributeautocomplete(attribute_row);

	attribute_row++;
}

<?php if (SC_VERSION < 20) { ?>
$.widget('custom.catcomplete', $.ui.autocomplete, {
	_renderMenu: function(ul, items) {
		var self = this, currentCategory = '';

		$.each(items, function(index, item) {
			if (item.blog != currentCategory) {
				ul.append('<li class="ui-autocomplete-blog">' + item.blog + '</li>');

				currentCategory = item.blog;
			}

			self._renderItem(ul, item);
		});
	}
});

<?php } ?>


function attributeautocomplete(attribute_row) {
	$('input[name=\'record_attribute[' + attribute_row + '][name]\']').<?php if (SC_VERSION < 20) { ?>catcomplete<?php } else { ?>autocomplete<?php } ?>({

		'source': function(request, response) {
         	<?php
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
				url: 'index.php?route=catalog/attribute/autocomplete&<?php echo $token_name; ?>=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(irequest),
				dataType: 'json',
				'success': function(json) {
					response($.map(json, function(item) {
						return {
				<?php if (SC_VERSION < 20) { ?>blog<?php } else { ?>category<?php } ?>: item.attribute_group,
							label: item.name,
							value: item.attribute_id
						}
					}));
				}
			});
		},
		'select': function(event, ui) {         	<?php
         	if (SC_VERSION < 20) {
         	?>
         	 var ilabel = ui.item.label;
         	 var ivalue = ui.item.value;
         	<?php
         	} else {
         	?>
         		var ilabel = event['label'];
         		var ivalue = event['value'];
         	<?php
         	}
         	?>
			$('input[name=\'record_attribute[' + attribute_row + '][name]\']').prop('value', ilabel);
			$('input[name=\'record_attribute[' + attribute_row + '][attribute_id]\']').prop('value', ivalue);

			return false;
		}
	});
}

$('#attribute tbody').each(function(index, element) {
	attributeautocomplete(index);
});
</script>


<script type="text/javascript">
function image_upload(field, thumb) {
	$('#dialog').remove();

	$('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&<?php echo $token_name; ?>=<?php echo $token; ?>&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');

	$('#dialog').dialog({
		title: '<?php echo $text_image_manager; ?>',
		close: function (event, ui) {
			if ($('#' + field).prop('value')) {
				$.ajax({
					url: 'index.php?route=common/filemanager/image&<?php echo $token_name; ?>=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).prop('value')),
					dataType: 'text',
					success: function(text) {
						$('#' + thumb).replaceWith('<img src="' + text + '" alt="" id="' + thumb + '" />');
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
var image_row = <?php echo $image_row; ?>;

function addImage(img_thumb, img_value) {

    if (img_thumb == '') {    	img_thumb = '<?php echo $no_image; ?>'
    }

    html  = '<tbody id="image-row' + image_row + '">';
	html += '  <tr>';


         	<?php
         	if (SC_VERSION > 15) {
         	?>
	html += '  <td class="text-left"><a href="" id="thumb-image' + image_row + '"data-toggle="image" class="img-thumbnail"><img src="'+img_thumb+'" alt="" title="" data-placeholder="'+img_thumb+'" /><input type="hidden" name="record_image[' + image_row + '][image]" value="'+img_value+'" id="input-image' + image_row + '" /></td>';

         	<?php
         	} else {
         	?>
	html += '    <td class="left"><div class="image"><img src="'+img_thumb+'" alt="" id="thumb' + image_row + '" /><input type="hidden" name="record_image[' + image_row + '][image]" value="'+img_value+'" id="image' + image_row + '" /><br /><a onclick="image_upload(\'image' + image_row + '\', \'thumb' + image_row + '\');"><?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$(\'#thumb' + image_row + '\').prop(\'src\', \'<?php echo $no_image; ?>\'); $(\'#image' + image_row + '\').prop(\'value\', \'\');"><?php echo $text_clear; ?></a></div></td>';

         	<?php
         	}
         	?>


	html += '			<td class="right">';
						 <?php foreach ($languages as $lang) { ?>

	html += '				<div class="input-group marginbottom5px"><span class="input-group-addon"><?php echo strtoupper($lang['code']); ?> <img src="<?php echo $lang['image']; ?>" title="<?php echo $lang['name']; ?>" ></span>';

	html += '				<?php echo $language->get('entry_title'); ?>&nbsp;<input class="form-control" type="text" name="record_image[' + image_row  + '][options][title][<?php echo $lang['language_id']; ?>]" value="" style="width: 300px;">';
	html += '				</div>';

	html += '				<div class="input-group marginbottom5px"><span class="input-group-addon"><?php echo strtoupper($lang['code']); ?> <img src="<?php echo $lang['image']; ?>" title="<?php echo $lang['name']; ?>" ></span>';

	html += '				<?php echo $language->get('entry_description'); ?>&nbsp;<textarea class="form-control" name="record_image[' + image_row  + '][options][description][<?php echo $lang['language_id']; ?>]" style="width: 300px;"></textarea>';
	html += '				</div>';

	html += '				<div class="input-group marginbottom5px"><span class="input-group-addon"><?php echo strtoupper($lang['code']); ?> <img src="<?php echo $lang['image']; ?>" title="<?php echo $lang['name']; ?>" ></span>';
	html += '				<?php echo $language->get('entry_url'); ?>&nbsp;<input class="form-control" type="text" name="record_image[' + image_row  + '][options][url][<?php echo $lang['language_id']; ?>]" value="" style="width: 300px;">';
	html += '				</div>';
	html += '				<div style="border-bottom: 1px solid #DDD; height: 1px; line-height: 1px; width: 100%; margin-bottom: 5px;">&nbsp;</div>';

    <?php } ?>


	html += '				<div class="input-group marginbottom5px"><span class="input-group-addon"></span>';
	html += '				<?php echo $language->get('entry_reserved'); ?>&nbsp;<textarea class="form-control" name="record_image[' + image_row  + '][options][reserved]" style="width: 300px;"></textarea>';
	html += '				</div>';


	html += '			</td>';
	html += '    <td class="right"><div class="input-group marginbottom5px"><input class="form-control" type="text" name="record_image[' + image_row + '][sort_order]" value="'+image_row+'" /></div></td>';
	html += '    <td class="left"><a onclick="$(\'#image-row' + image_row  + '\').remove();" class="markbutton button_purple nohref"><?php echo $button_remove; ?></a></td>';
	html += '  </tr>';
	html += '</tbody>';

	$('#images tfoot').before(html);

	image_row++;
}
</script>



<script>
$('.record_blog').click(function() {

var c = this.checked;
var v = $(this).val();

if (c) {    $('#blog_main_'+v).removeAttr("disabled");
} else {	$('#blog_main_'+v).prop("disabled", "disabled");

	$('#blog_main_'+v).prop('checked',false);
}

});

</script>




<?php if (isset($ascp_settings['tags_widget_status']) && $ascp_settings['tags_widget_status']) { ?>
<?php
if (SC_VERSION > 15) {
 foreach ($languages as $lang) { ?>


<script type="text/javascript">
$('#record_tags_product_<?php echo $lang['language_id']; ?>').autocomplete({
	'source': function(request, response) {
         	<?php
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
			url: 'index.php?route=agoo/tags/tags/authorcomplete&<?php echo $token_name; ?>=<?php echo $token; ?>&language_id=<?php echo $lang['language_id']; ?>&filter_name=' +  encodeURIComponent(irequest),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						label: item.tag,
						value: item.tag
					}
				}));
			}
		});
	},
	'select': function(event, ui) {
         	<?php
         	if (SC_VERSION < 20) {
         	?>
         	 var ilabel = ui.item.label;
         	 var ivalue = ui.item.value;
         	<?php
         	} else {
         	?>
         		var ilabel = event['label'];
         		var ivalue = event['value'];
         	<?php
         	}
         	?>

		$('#record_tags_product_<?php echo $lang['language_id']; ?>').val(ilabel);

		return false;
	}
});

</script>
<?php } } } ?>

<?php if (SC_VERSION < 20) { ?>
<script type="text/javascript" src="view/javascript/blog/timepicker/jquery-ui-timepicker-addon.js"></script>
<script type="text/javascript" src="view/javascript/blog/timepicker/localization/jquery-ui-timepicker-<?php echo $config_language; ?>.js"></script>
<?php } ?>

<script type="text/javascript">
$(document).ready(function(){
	$('.datetime').datetimepicker({
       <?php if (SC_VERSION < 20) { ?>
		dateFormat: 'yy-mm-dd',
		timeFormat: 'HH:mm:ss'
	<?php } else { ?>
        format: 'YYYY-MM-DD HH:mm:SS'
	<?php } ?>

	});
});
</script>

<script type="text/javascript" src="view/javascript/blog/synctranslit/jquery.synctranslit.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
    <?php foreach ($languages as $lang) { ?>
	if ($('#record_seo_url_<?php echo $lang['language_id']; ?>').val()=='') {			$(".record_name_<?php echo $lang['language_id']; ?>").syncTranslit({destination: "record_seo_url_<?php echo $lang['language_id']; ?>"});
	}
   <?php } ?>

});
</script>

<script type="text/javascript">
$(document).ready(function(){
  	$('#tabs a').tabs();
	$('#languages a').tabs();
	$('#vtab-option a').tabs();
});
</script>


<script>
function form_submit() {
<?php
  if (SC_VERSION > 99) {
?>
<?php foreach ($languages as $lang) { ?>


		if("code" in $('#input-description<?php echo $lang['language_id']; ?>_')) {
			var html = $('#input-description<?php echo $lang['language_id']; ?>_').code();
		} else {
          	var html = $('#input-description<?php echo $lang['language_id']; ?>_').summernote('code');
		}

		if("destroy" in $('#input-description<?php echo $lang['language_id']; ?>_')) {
			$('#input-description<?php echo $lang['language_id']; ?>_').destroy();
		} else {
          	$('#input-description<?php echo $lang['language_id']; ?>_').summernote('destroy');
		}

		$("textarea[name='record_description[<?php echo $lang['language_id']; ?>][description]']").val(html);

		if("code" in $('#input-sdescription<?php echo $lang['language_id']; ?>_')) {
			var html = $('#input-sdescription<?php echo $lang['language_id']; ?>_').code();
		} else {
          	var html = $('#input-sdescription<?php echo $lang['language_id']; ?>_').summernote('code');
		}

		if("destroy" in $('#input-sdescription<?php echo $lang['language_id']; ?>_')) {
			$('#input-sdescription<?php echo $lang['language_id']; ?>_').destroy();
		} else {
          	$('#input-sdescription<?php echo $lang['language_id']; ?>_').summernote('destroy');
		}

        $("textarea[name='record_description[<?php echo $lang['language_id']; ?>][sdescription]']").val(html);



<?php } ?>
<?php } ?>

setTimeout("$('#form').submit()", 100);

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

<?php if (isset($ascp_settings['admin_visualeditor_status']) && $ascp_settings['admin_visualeditor_status']) { ?>
<?php foreach ($languages as $lang) { ?>

load_editor('input-sdescription<?php echo $lang['language_id']; ?>_', '100');
load_editor('input-description<?php echo $lang['language_id']; ?>_', '100');

<?php } ?>
<?php } ?>

</script>


 <style>
.note-editable {
min-height: 300px !important;
}
</style>
<?php } ?>


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
