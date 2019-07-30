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


<?php if (SC_VERSION > 15) { ?>
<script type="text/javascript" src="view/javascript/summernote/summernote.js"></script>
<link href="view/javascript/summernote/summernote.css" rel="stylesheet" />
<?php } ?>
<script type="text/javascript">
var tab = 'amytabs1';
var widgets_is_loaded = false;
var myEditor = new Array();
</script>


      <div class="buttons" style="float:right;"><a onclick="$('#form').submit();" class="markbutton button_orange nohref"><?php echo $button_save; ?></a>
      <a onclick="location = '<?php echo $cancel; ?>';" class="markbutton button_orange nohref"><?php echo $button_cancel; ?></a>
      </div>
      <div style="width: 100%; overflow: hidden; clear: both; height: 1px; line-height: 1px;">&nbsp;</div>


  <div class="box">
   <div class="content">
      <div id="tabs" class="htabs"><a href="#tab-data"><?php echo $tab_data; ?></a><a href="#tab-general"><?php echo $language->get('tab_description'); ?></a></div>
       <?php
        // print_r($field_description);
       ?>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <div id="tab-general">
          <div id="languages" class="htabs">
            <?php foreach ($languages as $lang) { ?>
            <a href="#language<?php echo $lang['language_id']; ?>"><img src="<?php echo $lang['image']; ?>" title="<?php echo $lang['name']; ?>" /> <?php echo $lang['name']; ?></a>
            <?php } ?>
          </div>

          <?php foreach ($languages as $lang) {

         if (isset($field_description[$lang['language_id']]['field'])) {
          $field_description[$lang['language_id']]['field'] =  unserialize(base64_decode($field_description[$lang['language_id']]['field']));
         } else {          $field_description[$lang['language_id']]['field'] = Array();
         }


          ?>
          <div id="language<?php echo $lang['language_id']; ?>">
            <table class="form">


              <tr>
                <td><?php echo $language->get('entry_description'); ?></td>
                <td>
				<div style="width: 100%;">
					<div class="field_description<?php echo $lang['language_id']; ?> input-group marginbottom5px"><span class="input-group-addon"><?php echo strtoupper($lang['code']); ?><br><img src="<?php echo $lang['image']; ?>" title="<?php echo $lang['name']; ?>" ></span>
		                <textarea class="form-control" name="fields_description[<?php echo $lang['language_id']; ?>][field_description]" id="field_description<?php echo $lang['language_id']; ?>" style="width: 100%; height: 200px;"><?php echo isset($field_description[$lang['language_id']]['field_description']) ? $field_description[$lang['language_id']]['field_description'] : ''; ?></textarea>
					</div>
					<a href="#" class="hrefajax" onclick="load_editor('field_description<?php echo $lang['language_id']; ?>', '100'); return false;"><?php echo $language->get('entry_editor'); ?></a>
                </div>
                </td>
              </tr>


              <tr>
                <td><?php echo $language->get('entry_description_error'); ?></td>
                <td>
				<div style="width: 100%;">
					<div class="field_error<?php echo $lang['language_id']; ?> input-group marginbottom5px"><span class="input-group-addon"><?php echo strtoupper($lang['code']); ?><br><img src="<?php echo $lang['image']; ?>" title="<?php echo $lang['name']; ?>" ></span>
		                <textarea class="form-control" name="fields_description[<?php echo $lang['language_id']; ?>][field_error]" id="field_error<?php echo $lang['language_id']; ?>" style="width: 100%; height: 200px;"><?php echo isset($field_description[$lang['language_id']]['field_error']) ? $field_description[$lang['language_id']]['field_error'] : ''; ?></textarea>
					</div>
					<a href="#" class="hrefajax" onclick="load_editor('field_error<?php echo $lang['language_id']; ?>', '100'); return false;"><?php echo $language->get('entry_editor'); ?></a>
                </div>
                </td>
              </tr>


              <tr>
                <td><?php echo $language->get('entry_description_value'); ?></td>
                <td>
                <div class="form-group">
                	<textarea class="form-control" name="fields_description[<?php echo $lang['language_id']; ?>][field_value]" id="field_value<?php echo $lang['language_id']; ?>"><?php echo isset($field_description[$lang['language_id']]['field_value']) ? $field_description[$lang['language_id']]['field_value'] : ''; ?></textarea>
                </div>
                </td>
              </tr>

              <tr>
                <td><?php echo $language->get('entry_field_tempalte_in'); ?></td>
                <td>
                <div class="form-group">
                <textarea class="form-control" name="fields_description[<?php echo $lang['language_id']; ?>][field][field_template_in]" id="field_template_in<?php echo $lang['language_id']; ?>" style="width: 100%; height: 200px;"><?php echo isset($field_description[$lang['language_id']]['field']['field_template_in'] ) ? $field_description[$lang['language_id']]['field']['field_template_in'] : ''; ?></textarea>
                </div>
       				<br>
					<a href="" class="hrefajax" onclick="load_editor('field_template_in<?php echo $lang['language_id']; ?>', '100'); return false;"><?php echo $language->get('entry_editor'); ?></a>
                </td>
              </tr>


              <tr>
                <td><?php echo $language->get('entry_field_tempalte_out'); ?></td>
                <td>
                <div class="form-group">
                <textarea class="form-control" name="fields_description[<?php echo $lang['language_id']; ?>][field][field_template_out]" id="field_template_out<?php echo $lang['language_id']; ?>" style="width: 100%; height: 200px;"><?php echo isset($field_description[$lang['language_id']]['field']['field_template_out']) ? $field_description[$lang['language_id']]['field']['field_template_out'] : ''; ?></textarea>
                </div>
       				<br>
					<a href="" class="hrefajax" onclick="load_editor('field_template_out<?php echo $lang['language_id']; ?>', '100'); return false;"><?php echo $language->get('entry_editor'); ?></a>
                </td>
              </tr>


              <tr>
                <td><?php echo $language->get('entry_field_class_in'); ?></td>
                <td>


				      <div class="input-group">
				      <input class="form-control" type="text" name="fields_description[<?php echo $lang['language_id']; ?>][field][field_class_in]" id="field_class_in<?php echo $lang['language_id']; ?>" value="<?php echo isset($field_description[$lang['language_id']]['field']['field_class_in']) ? $field_description[$lang['language_id']]['field']['field_class_in'] : ''; ?>" size="20"/>
				      </div>
				</td>

              </tr>

              <tr>
                <td><?php echo $language->get('entry_field_class_out'); ?></td>
                <td>
                	<div class="input-group">
				      <input class="form-control" type="text" name="fields_description[<?php echo $lang['language_id']; ?>][field][field_class_out]" id="field_class_out<?php echo $lang['language_id']; ?>" value="<?php echo isset($field_description[$lang['language_id']]['field']['field_class_out']) ? $field_description[$lang['language_id']]['field']['field_class_out'] : ''; ?>" size="20"/>
				    </div>
				      </td>
              </tr>


            </table>
          </div>
          <?php } ?>
        </div>



        <div id="tab-data">
          <table class="form">


            <tr>
              <td><span class="required">*</span> <?php echo $entry_name; ?></td>
              <td>
				      <div class="input-group">
				      <input class="form-control" type="text" id="field_name" name="field_name" value="<?php echo $field_name; ?>" size="50"/>
				      </div>
				      </td>
            </tr>

            <tr>
              <td><span class="required">*</span> <?php echo $language->get('entry_type'); ?></td>
              <td>

              <?php
              $fileds_types = Array("text", "textarea", 'rating', 'select');

              ?>
<div class="input-group">
				              <select class="form-control" name="field_type">
                    <?php foreach ($fileds_types as $fields_type) { ?>
                    <?php if ($field_type == $fields_type) { ?>
                    <option value="<?php echo $fields_type; ?>" selected="selected"><?php echo $fields_type; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $fields_type; ?>"><?php echo $fields_type; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select>
                  </div>


              </td>
            </tr>





            <tr>
              <td><?php echo $language->get('entry_must'); ?></td>
              <td>
<div class="checkbox">
              <?php if ($field_must) { ?>

				      <input  type="checkbox" name="field_must" value="1" checked="checked" />
                <?php } else { ?>

				      <input type="checkbox" name="field_must" value="1" />
                <?php } ?>
                </div>
                </td>
            </tr>



    <tr>
      <td><?php echo $entry_image; ?></td>
      <td valign="top"><div class="image form-group" data-toggle="image">
      <?php if (SC_VERSION > 15) { ?>
      <a href="" id="thumb-image" data-toggle="image" class="img-thumbnail">
       <?php } ?>
      <img src="<?php echo $thumb; ?>" alt="" id="thumb" />
      <?php if (SC_VERSION > 15) { ?>
      </a>
      <?php } ?>
        <input type="hidden" name="field_image" value="<?php echo $field_image; ?>" id="image" />
        <br>
       <?php if (SC_VERSION < 20) { ?>
	      <a onclick="image_upload('image', 'thumb');"><?php echo $language->get('text_browse'); ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('#thumb').prop('src', '<?php echo $no_image; ?>'); $('#image').prop('value', '');"><?php echo $language->get('text_clear'); ?></a>
       <?php } ?>
        </div>

        </td>
    </tr>


             <tr>
              <td><?php echo $language->get('entry_public'); ?></td>
              <td>
<div class="input-group">
				              <select class="form-control" name="field_public">
                  <?php if ($field_public) { ?>
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
              <td><?php echo $entry_status; ?></td>
              <td>
<div class="input-group">
				              <select class="form-control" name="field_status">
                  <?php if ($field_status) { ?>
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
              <td><?php echo $entry_sort_order; ?></td>
              <td>

				      <div class="input-group">
				      <input class="form-control" type="text" name="field_order" value="<?php echo $field_order; ?>" size="2" />
				      </div>
				      </td>
            </tr>
          </table>
        </div>









   </form>
    </div>
  </div>
</div>



<?php
if (SC_VERSION > 15) {
?>
<script>


function delegateEditorClick () {
		$('#modal-image').remove();

		$(this).parents('.note-editor').find('.note-editable').focus();

		$.ajax({
			url: 'index.php?route=common/filemanager&token=' + getURLVar('token'),
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
								url: 'index.php?route=common/filemanager&token=' + getURLVar('token'),
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
						filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
						filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
						filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
						filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
						filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
						filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
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
</script>
<?php } ?>



<script type="text/javascript">
function image_upload(field, thumb) {
	$('#dialog').remove();

	$('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');

	$('#dialog').dialog({
		title: '<?php echo $text_image_manager; ?>',
		close: function (event, ui) {
			if ($('#' + field).attr('value')) {
				$.ajax({
					url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).attr('value')),
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
$('#tabs a').tabs();
$('#languages a').tabs();
</script>

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




</div>
<?php echo $footer; ?>
