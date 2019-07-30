<?php if ($comment_status) { ?>
<div id="cmswidget-<?php echo $cmswidget; ?>" class="cmswidget cmswidget-treecomments" data-prefix="<?php echo $prefix;?>">
<?php echo $box_begin; ?>
	<?php if (isset($settings_widget['modal_status']) && $settings_widget['modal_status']) { ?>

	<?php if (isset($settings_widget['stat_status']) && $settings_widget['stat_status'])  { ?>
    <?php  echo $html_comment; ?>
	<?php } ?>


<?php if (!isset($settings_widget['modal_stat_status']) || !$settings_widget['modal_stat_status']) { ?>

	<a href="#" onclick="modal_html_<?php echo $cmswidget; ?>(); return false;" class="<?php if (isset($settings_widget['modal_a_class']) && $settings_widget['modal_a_class']!='') { echo $settings_widget['modal_a_class']; } ?>"><?php
    if (isset($html_modal) && $html_modal != '') {
    	echo $html_modal;
    } else {
		echo $heading_title;
	}
	?></a>
<?php } ?>


	<?php } ?>
<?php if (isset($settings_widget['reserved']) && $settings_widget['reserved']!='') {
echo html_entity_decode($settings_widget['reserved'], ENT_QUOTES, 'UTF-8');
} ?>
<?php echo $box_end; ?>
</div>

<div style="display:none;">
	<div id="<?php echo $prefix;?>icomments_<?php echo $mark_id; ?>" class="cmswidget">
		<div>
			<div class="container_reviews" id="<?php echo $prefix;?>container_reviews_<?php echo $mark;?>_<?php echo $mark_id;?>">
		<noindex>
			<div class="container_reviews_vars acr<?php echo $cmswidget; ?>" style="display: none">
				<div class="mark" data-text="<?php echo $mark; ?>"></div>
				<div class="mark_id" data-text="<?php echo $mark_id; ?>"></div>
				<div class="theme" data-text="<?php echo $theme; ?>"></div>
				<div class="exec" data-text="<?php if (isset($settings_widget['handler']) && $settings_widget['handler']!='') { echo $settings_widget['handler']; }  ?>"></div>
				<div class="visual_editor" data-text="<?php echo $visual_editor; ?>"></div>
				<div class="captcha_status" data-text="<?php if ($captcha_status == '') $captcha_status = 0; echo $captcha_status; ?>"></div>
				<div class="rating_status" data-text="<?php if ($rating_status == '') $rating_status = 0; echo $rating_status; ?>"></div>
				<div class="ascp_widgets_position" data-text="<?php echo $ascp_widgets_position;?>"></div>
				<div class="settingswidget" data-text="<?php echo base64_encode(serialize($settingswidget)); ?>"></div>
				<div class="text_wait" data-text="<?php echo $text_wait; ?>"></div>
				<div class="visual_rating" data-text="<?php echo $settings_widget['visual_rating']; ?>"></div>
				<div class="signer" data-text="<?php echo $settings_widget['signer']; ?>"></div>
				<div class="imagebox" data-text="<?php echo $imagebox; ?>"></div>
				<div class="prefix" data-text="<?php echo $prefix;?>"></div>
				<div class="wysibbuploader" data-text="<?php echo $wysibbuploader;?>"></div>
				<div class="wysibbuploader_key_imageshack" data-text="<?php echo $wysibbuploader_key_imageshack;?>"></div>
			</div>
  		</noindex>

				<?php  { ?>
				<?php if (isset($settings_widget['visual_editor']) && $settings_widget['visual_editor']) { ?>
				<script>
					if (typeof WBBLANG !=="undefined"){
					CURLANG = WBBLANG['<?php echo $lang_code;?>'] || WBBLANG['en'] || CURLANG;
					}
				</script>
				<?php } ?>
		<?php if (isset($settings_widget['signer']) && $settings_widget['signer']) { ?>
		<div id="<?php echo $prefix;?>record_signer" class="floatright width70 textright" style="position:relative;">
			<div id="<?php echo $prefix;?>js_signer"  class="width100 zindex11000 textleft" style="display:none; position: absolute;"></div>
			<form id="<?php echo $prefix;?>form_signer">
				<label class="floatright">
				<a class="textdecoration_none comments_signer hrefajax" data-cmswidget="<?php echo $cmswidget; ?>">
				<?php if (SC_VERSION > 15) { ?><i class="fa fa-envelope" aria-hidden="true"></i><?php } ?>

				<?php echo $text_signer; ?>
				</a>
				<input id="<?php echo $prefix;?>comments_signer" class="comments_signer" data-cmswidget="<?php echo $cmswidget; ?>" type="checkbox" <?php if (isset($signer_status) && $signer_status) echo 'checked'; ?>/>

				</label>
			</form>
		</div>
		<?php } ?>

				<div id="<?php echo $prefix;?>div_comment_<?php echo $mark_id; ?>" class="<?php if (isset($record['sdescription']) && $record['sdescription']!='') {?>floatleft width50<?php } ?>" >
					<div id="<?php echo $prefix;?>comment_<?php echo $mark_id; ?>" >

						<?php if (!isset($settings_widget['stat_status']) || !$settings_widget['stat_status'])  { ?>
						<?php  echo $html_comment; ?>
						<?php } ?>

					</div>
			<div id="<?php echo $prefix;?>comment-title">
				<a href="#"  id="<?php echo $prefix;?>comment_id_reply_0" data-cmswidget="<?php echo $cmswidget; ?>" data-prefix="<?php echo $prefix;?>" class="comment_reply comment_buttons form_reply">
				<ins id="<?php echo $prefix;?>reply_0" class="hrefajax text_write_review"></ins>
				</a>
			</div>



			<div id="<?php echo $prefix;?>comment_work_0" class="<?php echo $prefix;?>comment_work"></div>

			<div id="<?php echo $prefix;?>reply_comments" class="<?php echo $prefix;?>comment_form comment_form" data-prefix="<?php echo $prefix;?>" style="display:none">
				<div id="<?php echo $prefix;?>comment_work_" class="<?php echo $prefix;?>form_customer_pointer width100">

					<?php if (isset($customer_id) && !$customer_id)   { ?>

					<div id="form_customer_none" style="display:none;"></div>




					<div class="form_customer <?php echo $prefix;?>form_customer" id="<?php echo $prefix;?>form_customer" style="display:none;">



						<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
							<div class="form_customer_content">
								<a href="#" class="floatright hrefajax"  onclick="$('.<?php echo $prefix;?>form_customer').hide(); $('.sc-auth').hide(); return false;"><?php echo $hide_block; ?></a>

								<div class="floatleft sc-auth-left">
									<b><?php echo $entry_email; ?></b><br />
									<input type="text" name="email" class="form-control sc-form-control" value="<?php echo $email; ?>" />
									<br />
									<b><?php echo $entry_password; ?></b><br />
									<input type="password" name="password" class="form-control sc-form-control" value="<?php echo $password; ?>" />
									<br />
									<a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a>
									<br />
									<input type="submit" value="<?php echo $button_login; ?>" class="button btn btn-primary" />
									<a href="<?php echo $register; ?>" class="marginleft10"><?php echo $error_register; ?></a>
									<?php if ($redirect) { ?>
									<input type="hidden" name="redirect" value="<?php echo $redirect; ?>#tabs" />
									<?php } ?>
								</div>
                                <div class="floatleft sc-auth" style="display:none;"></div>
							</div>
						</form>

					</div>
					<?php } ?>
					<form id="<?php echo $prefix;?>form_work_">
						<div class="seocmspro_customer_name width100 overflowhidden" <?php  if (isset($settings_widget['name_status']) && !$settings_widget['name_status'])   {   ?>style="display: none;"<?php } ?>>
						  <?php if (isset($settings_widget['avatar_status']) && $settings_widget['avatar_status']) { ?>
						  <div class="seocmspro_load_avatar seocmspro_avatar"><img src="<?php echo $avatar_customer; ?>" alt="avatar" style="width:<?php echo $avatar_width; ?>px ; height:<?php echo $avatar_height; ?>px ; "></div>
						  <?php } ?>
						<div class="seocmspro_author" <?php  if (isset($settings_widget['name_status']) && !$settings_widget['name_status'])   {   ?>style="display: none;"<?php } ?>>
						<b><ins class="color_entry_name"><?php   echo $entry_name; ?></ins></b>
						<br>
						<input type="text" name="name" class="form-control sc-form-control" onblur="if (this.value==''){this.value='<?php echo $text_login; ?>'}" onfocus="if (this.value=='<?php echo $text_login; ?>') this.value='';"  value="<?php echo $text_login; ?>" <?php
							if (isset($customer_id) && $customer_id) {
							 //echo 'readonly="readonly" style="background-color:#DDD; color: #555;"';
							}
							?>>

						<?php  if (isset($customer_id) && !$customer_id)   { ?>
						<div class="asc_textlogin">
						<a href="#" class="textdecoration_none hrefajax" data-cmswidget="<?php echo $cmswidget; ?>" data-prefix="<?php echo $prefix; ?>"><ins class="hrefajax customer_enter customer_auth" data-prefix="<?php echo $prefix; ?>" data-cmswidget="<?php echo $cmswidget; ?>"><?php echo $text_customer_enter; ?></ins></a>
						<?php echo $text_welcome; ?>
						</div>
						<?php } ?>

                         </div>
						</div>
						<div class=" bordernone width100 overflowhidden margintop5 lineheight1"></div>

						<?php include(realpath(dirname(__FILE__)).'/../../module/fields.tpl'); ?>

						<?php  if (isset($settings_widget['comment_must']) && $settings_widget['comment_must'])   {   ?>
							<b><ins class="color_entry_name"><?php echo $entry_comment;  ?></ins></b>
							<span class="blog_require">*</span>

							<div class="ascp_bbode">
								<textarea name="text" id="<?php echo $prefix;?>editor_" class="blog-record-textarea <?php echo $prefix;?>editor blog-textarea_height"></textarea>
							</div>

	                        <?php if (isset($settings_widget['help_view']) && $settings_widget['help_view']) { ?>
							<div class="help_text">
							<span class="text_note"><?php echo $text_note; ?></span>
							</div>
							<?php  } ?>
						<?php  } ?>

						<div class="bordernone width100 overflowhidden margintop5 lineheight1"></div>
						<?php if (isset($settings_widget['rating']) && $settings_widget['rating']) { ?>
						<b><ins class="color_entry_name"><?php echo $entry_rating_review; ?></ins></b>&nbsp;&nbsp;
						<?php if (isset($settings_widget['visual_rating']) && $settings_widget['visual_rating']) { ?>
						<div style="height: 25px;">
							<input type="radio" class="visual_star" name="rating" title="<?php echo $entry_bad; ?> 1" value="1" >
							<input type="radio" class="visual_star" name="rating" title="<?php echo $entry_bad; ?> 2" value="2" >
							<input type="radio" class="visual_star" name="rating" title="<?php echo $entry_bad; ?> 3" value="3" >
							<input type="radio" class="visual_star" name="rating" title="<?php echo $entry_good; ?> 4" value="4" >
							<input type="radio" class="visual_star" name="rating" title="<?php echo $entry_good; ?> 5" value="5" >
							<div class="floatleft"  style="padding-top: 5px; "><b><ins class="color_entry_name marginleft10"><span id="hover-test" ></span></ins></b></div>
							<div  class="bordernone width100 overflowhidden lineheight1"></div>
						</div>
						<?php } else { ?>
						<span><ins class="color_bad"><?php echo $entry_bad; ?></ins></span>&nbsp;
						<input type="radio"  name="rating" value="1" >
						<ins class="blog-ins_rating" style="">1</ins>
						<input type="radio"  name="rating" value="2" >
						<ins class="blog-ins_rating" >2</ins>
						<input type="radio"  name="rating" value="3" >
						<ins class="blog-ins_rating" >3</ins>
						<input type="radio"  name="rating" value="4" >
						<ins class="blog-ins_rating" >4</ins>
						<input type="radio"  name="rating" value="5" >
						<ins class="blog-ins_rating" >5</ins>
						&nbsp;&nbsp; <span><ins  class="color_good"><?php echo $entry_good; ?></ins></span>
						<?php } ?>
						<?php } else {?>
						<input type="radio" name="rating" value="5" checked style="display:none;">
						<?php } ?>
						<div class="bordernone width100 overflowhidden margintop5 lineheight1"></div>
						<?php if ($captcha_status) { ?>
						<?php if (isset($settings_widget['help_view']) && $settings_widget['help_view']) { ?>
						<div class="ascp_captcha_title help_text"><?php echo $entry_captcha_title; ?>&nbsp;&darr;</div>
						<div class="ascp_entry_captcha help_text"><?php echo $entry_captcha; ?></div>
                        <?php  } ?>
						<div class="captcha_status"></div>
						<?php  } ?>

						<?php if (isset($settings_widget['signer_answer']) && $settings_widget['signer_answer']) { ?>

                		<?php if (isset($settings_widget['signer_answer_require']) && $settings_widget['signer_answer_require']) { ?>
                		<span class="blog_require">*</span>
                		<?php } ?>

                          <?php if (isset($customer_id) && $customer_id) { ?>

							<label for="signer_answer">
							<a class="textdecoration_none hrefajax" data-cmswidget="<?php echo $cmswidget; ?>">
							<input id="signer_answer" name="signer_answer"  class="sc-form-control" data-cmswidget="<?php echo $cmswidget; ?>" type="checkbox" checked/>

							<?php echo $text_signer_answer; ?>
                           </a>
                            </label>
                		<?php } else { ?>

                		<label>
                		<b><?php echo $text_signer_answer; ?></b>
                		</label>
						   <?php echo $text_signer_answer_email; ?>
						   <input type="text" name="email_ghost" class="form-control sc-form-control" value="<?php if (isset($email_ghost) && $email_ghost!='') echo $email_ghost; ?>" />
						<?php } ?>
						<?php } ?>

						<?php if (SC_VERSION < 20) { ?>
							<div class="buttons">
								<div class="left"><a class="button button-comment" id="<?php echo $prefix;?>button-comment-0"><span><?php echo $button_write; ?></span></a></div>
							</div>
						<?php } else { ?>
				   			<div class="buttons">
				                <button type="button" id="<?php echo $prefix;?>button-comment-0" data-loading-text="" class="btn btn-primary button button-comment"><i class="fa fa-pencil-square-o"></i> <?php echo $button_write; ?></button>
				             </div>
						<?php } ?>

   					</form>
						</div>
					</div>
				</div>

				<?php if (isset($record['sdescription']) && $record['sdescription']!='') { ?>
				<div class="tel_description floatleft width50">
					<?php echo html_entity_decode($record['sdescription'], ENT_QUOTES, 'UTF-8'); ?>
				</div>
				<?php }	?>

				<?php } ?>
				<div class="overflowhidden clearboth lineheight1">&nbsp;</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">

comment_form_<?php echo $prefix;?> = $('#<?php echo $prefix;?>reply_comments').clone();
$('#<?php echo $prefix;?>reply_comments').remove();

<?php if (isset($settings_widget['modal_cb_resize']) && $settings_widget['modal_cb_resize']) { ?>
<?php echo $prefix;?>resize = function() {

var <?php echo $prefix;?>_height = $('#cboxLoadedContent').height();

var <?php echo $prefix;?>_width = $('#cboxLoadedContent').width();

var <?php echo $prefix;?>height_modal = $('#cboxLoadedContent > div').height();
var <?php echo $prefix;?>width_modal = $('#cboxLoadedContent > div').width();

 if (<?php echo $prefix;?>_height != <?php echo $prefix;?>height_modal  || <?php echo $prefix;?>_width != <?php echo $prefix;?>width_modal) {
    if (<?php echo $prefix;?>height_modal !=0 && <?php echo $prefix;?>_height!= null) {
    	if (<?php echo $prefix;?>width_modal !=0 && <?php echo $prefix;?>_width!= null) {
   			$("#cboxLoadedContent > div > div").css( { "margin" : "10px", "padding" : "20px" } );
   			$(this).colorbox.resize();
	}
	}
	}
}
<?php } ?>

modal_html_<?php echo $cmswidget; ?> = function() {

	$('#<?php echo $prefix;?>comment_id_reply_0').click();
	<?php if ($imagebox=='colorbox') { ?>

	$.colorbox.close();
	var my_form = $('#<?php echo $prefix;?>icomments_<?php echo $mark_id; ?>');

	var colorboxInterval;

	$.colorbox({
<?php if (isset($settings_widget['modal_cb_width']) && $settings_widget['modal_cb_width']!='') { ?>
		 width: "<?php echo $settings_widget['modal_cb_width']; ?>",
<?php } ?>
<?php if (isset($settings_widget['modal_cb_height']) && $settings_widget['modal_cb_height']!='') { ?>
		 height: "<?php echo $settings_widget['modal_cb_height']; ?>",
<?php } ?>

<?php if (isset($settings_widget['modal_cb_maxwidth']) && $settings_widget['modal_cb_maxwidth']!='') { ?>
		 maxWidtht: "<?php echo $settings_widget['modal_cb_maxwidth']; ?>",
<?php } ?>
<?php if (isset($settings_widget['modal_cb_maxheight']) && $settings_widget['modal_cb_maxheight']!='') { ?>
		 maxHeight: "<?php echo $settings_widget['modal_cb_maxheight']; ?>",
<?php } ?>

<?php if (isset($settings_widget['modal_cb_innerwidth']) && $settings_widget['modal_cb_innerwidth']!='') { ?>
		 innerWidth: "<?php echo $settings_widget['modal_cb_innerwidth']; ?>",
<?php } ?>
<?php if (isset($settings_widget['modal_cb_innerheight']) && $settings_widget['modal_cb_innerheight']!='') { ?>
		 innerHeight: "<?php echo $settings_widget['modal_cb_innerheight']; ?>",
<?php } ?>

<?php if (isset($settings_widget['modal_cb_initialwidth']) && $settings_widget['modal_cb_initialwidth']!='') { ?>
		 initialWidth: "<?php echo $settings_widget['modal_cb_initialwidth']; ?>",
<?php } ?>
<?php if (isset($settings_widget['modal_cb_initialheight']) && $settings_widget['modal_cb_initialheight']!='') { ?>
		 initialHeight: "<?php echo $settings_widget['modal_cb_initialheight']; ?>",
<?php } ?>

<?php if (isset($settings_widget['modal_cb_opacity']) && $settings_widget['modal_cb_opacity']!='') { ?>
		 opacity: "<?php echo $settings_widget['modal_cb_opacity']; ?>",
<?php } ?>

<?php if (isset($settings_widget['modal_cb_scrolling']) && $settings_widget['modal_cb_scrolling']) { ?>
		 scrolling: true,
<?php } else { ?>
         scrolling: false,
<?php } ?>

<?php if (isset($settings_widget['modal_cb_reposition']) && $settings_widget['modal_cb_reposition']) { ?>
		 reposition: true,
<?php } else { ?>
         reposition: false,
<?php } ?>

<?php if (isset($settings_widget['modal_cb_fixed']) && $settings_widget['modal_cb_fixed']) { ?>
		 fixed: true,
<?php } else { ?>
         fixed: false,
<?php } ?>

	 onOpen: function(){
	 },
	 onLoad: function(){
	 },
     onComplete: function () {
	    $('#colorbox').css('z-index','800');
	    $('#cboxOverlay').css('z-index','800');
	    $('#cboxOverlay').css('opacity','0.4');
	    $('#cboxWrapper').css('z-index','800');
        $("#cboxLoadedContent > div > div").css( { "margin" : "10px", "padding" : "20px" } );

<?php if (isset($settings_widget['modal_cb_resize']) && $settings_widget['modal_cb_resize']) { ?>
		$(this).colorbox.resize();
		colorboxInterval = setInterval( function() {
               <?php echo $prefix;?>resize()
			 }, 2000 );
<?php } ?>

<?php if (isset($settings_widget['modal_cbmobile_width_browser']) && $settings_widget['modal_cbmobile_width_browser']!='') { ?>
			 cbmobile_resize();
<?php } ?>

        },
	 onClosed: function(){
<?php if (isset($settings_widget['modal_cb_resize']) && $settings_widget['modal_cb_resize']) { ?>
		clearInterval(colorboxInterval);
<?php } ?>

	 },
<?php if (isset($settings_widget['modal_cb_title']) && $settings_widget['modal_cb_title']) { ?>
		 title: "<?php echo $heading_title; ?>",
<?php } ?>
	 inline:true,
	 href: my_form

	 });

	 return false;

    <?php } ?>
}


$(window).resize(function(){
	cbmobile_resize();
});


function cbmobile_resize() {

var isMobile = false;

if( /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) ) {
	isMobile = true;
}
// device detection
if (!isMobile) {
if(/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|ipad|iris|kindle|Android|Silk|lge |maemo|midp|mmp|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino/i.test(navigator.userAgent)
    || /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(navigator.userAgent.substr(0,4))) isMobile = true;
}

<?php if (isset($settings_widget['modal_cbmobile_width_browser']) && $settings_widget['modal_cbmobile_width_browser']!='') { ?>
	if ($(window).width() <= '<?php  echo $settings_widget['modal_cbmobile_width_browser'];	?>' || isMobile) {

	    $.colorbox.resize({
<?php if (isset($settings_widget['modal_cbmobile_width']) && $settings_widget['modal_cbmobile_width']!='') { ?>
		 width: "<?php echo $settings_widget['modal_cbmobile_width']; ?>",
<?php } ?>
<?php if (isset($settings_widget['modal_cbmobile_height']) && $settings_widget['modal_cbmobile_height']!='') { ?>
		 height: "<?php echo $settings_widget['modal_cbmobile_height']; ?>",
<?php } ?>

<?php if (isset($settings_widget['modal_cbmobile_maxwidth']) && $settings_widget['modal_cbmobile_maxwidth']!='') { ?>
		 maxWidtht: "<?php echo $settings_widget['modal_cbmobile_maxwidth']; ?>",
<?php } ?>
<?php if (isset($settings_widget['modal_cbmobile_maxheight']) && $settings_widget['modal_cbmobile_maxheight']!='') { ?>
		 maxHeight: "<?php echo $settings_widget['modal_cbmobile_maxheight']; ?>",
<?php } ?>

<?php if (isset($settings_widget['modal_cb_fixed']) && $settings_widget['modal_cb_fixed']) { ?>
		 fixed: true
<?php } else { ?>
         fixed: false
<?php } ?>

	    });
	} else {

	    $.colorbox.resize({
<?php if (isset($settings_widget['modal_cb_width']) && $settings_widget['modal_cb_width']!='') { ?>
		 width: "<?php echo $settings_widget['modal_cb_width']; ?>",
<?php } ?>
<?php if (isset($settings_widget['modal_cb_height']) && $settings_widget['modal_cb_height']!='') { ?>
		 height: "<?php echo $settings_widget['modal_cb_height']; ?>",
<?php } ?>

<?php if (isset($settings_widget['modal_cb_maxwidth']) && $settings_widget['modal_cb_maxwidth']!='') { ?>
		 maxWidtht: "<?php echo $settings_widget['modal_cb_maxwidth']; ?>",
<?php } ?>
<?php if (isset($settings_widget['modal_cb_maxheight']) && $settings_widget['modal_cb_maxheight']!='') { ?>
		 maxHeight: "<?php echo $settings_widget['modal_cb_maxheight']; ?>",
<?php } ?>

<?php if (isset($settings_widget['modal_cb_fixed']) && $settings_widget['modal_cb_fixed']) { ?>
		 fixed: true
<?php } else { ?>
         fixed: false
<?php } ?>

	    });

	}
<?php } ?>
}


<?php if (isset($settings_widget['anchor']) && $settings_widget['anchor']!='') { ?>
$('#cmswidget-<?php echo $cmswidget; ?>').hide();
<?php if (isset($settings_widget['doc_ready']) && $settings_widget['doc_ready']) { ?>
$(document).ready(function(){
<?php } ?>

		    var prefix = '<?php echo $prefix;?>';
            var cmswidget = '<?php echo $cmswidget; ?>';
			var heading_title = '<?php echo $heading_title; ?>';
			var total = '<?php echo $comment_total; ?>';

			<?php  if (isset($mark_info['url'])) { ?>
			var name = '<?php if (isset($mark_info['name'])) echo htmlspecialchars($mark_info['name'], ENT_QUOTES & ~ENT_COMPAT, 'UTF-8');  ?>';
			var url = '<?php if (isset($mark_info['url'])) echo $mark_info['url']; ?>';
			<?php } ?>

			<?php  if (isset($mark_info['product_info']['url'])) { ?>
			var product_name = '<?php if (isset($mark_info['product_info']['name'])) echo htmlspecialchars($mark_info['product_info']['name'], ENT_QUOTES & ~ENT_COMPAT, 'UTF-8'); ?>';
			var product_url = '<?php if (isset($mark_info['product_info']['url'])) echo $mark_info['product_info']['url']; ?>';
			<?php } ?>


			var data = $('#cmswidget-<?php echo $cmswidget; ?>').clone();
			<?php echo $settings_widget['anchor']; ?>;
            $('#cmswidget-<?php echo $cmswidget; ?>').show();
			delete data;
			delete prefix;
			delete cmswidget;
			delete total;

			<?php  if (isset($mark_info['product_info']['url'])) { ?>
			delete product_name;
			delete product_url;
			<?php } ?>

			<?php  if (isset($mark_info['url'])) { ?>
			delete name;
			delete url;
			<?php } ?>

<?php if (isset($settings_widget['doc_ready']) && $settings_widget['doc_ready']) { ?>
});
<?php } ?>
<?php } ?>
</script>


<style>
	#colorbox, #cboxOverlay, #cboxWrapper {
	z-index: 800;
	}
</style>
<?php } ?>