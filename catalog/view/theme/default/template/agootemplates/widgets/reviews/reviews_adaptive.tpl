<?php if (isset($comments) && $comments) { ?>
<div id="cmswidget-<?php echo $cmswidget; ?>" class="cmswidget">
<?php echo $box_begin; ?>

	<?php
	  	$admin = false;
	  	if (isset($settings_widget['admin_name']) && $settings_widget['admin_name']) {
			$admin_name =  array_flip(explode(";",trim($settings_widget['admin_name'])));
		}
	?>
		<style>
			 .record_columns .column_width_<?php echo $cmswidget; ?> {
			 	width: <?php if (isset ($settings_widget['block_reviews_width']) && $settings_widget['block_reviews_width'] != '' ) {
			 	 echo $settings_widget['block_reviews_width'].'; margin-right: 5px; overflow: hidden;';
			 	} else {
			 	 echo '100%;  min-width: 100%;';
			 	}
			 	?>
			 }
		</style>


		<div id="record_columns-<?php echo $cmswidget; ?>" class="<?php if (!isset($settings_widget['slider']) || !$settings_widget['slider']) { ?>record_columns <?php } else { ?> oc-module <?php } ?>">

			<?php foreach ($comments as $comment) {

				if (isset($admin_name[trim($comment['author'])]) || (isset($settings_widget['admins']) && !empty($settings_widget['admins']) && in_array($comment['customer_id'], $settings_widget['admins']))) {
				 $back_color = 'background-color: '.$settings_widget['admin_color'].';';
				 $admin = true;
				} else {
				 $back_color ='';
				 $admin = false;
				}
				?>
            <div class="content-records column_width_<?php echo $cmswidget; ?>" style="<?php echo $back_color; ?>">

				<div class="blogdescription  margintop5">
                 <div>
					<?php if (isset($settings_widget['avatar_status']) && $settings_widget['avatar_status'] && $comment['info']['avatar']) { ?>
					<div class="seocmspro_avatar">
					<img src="<?php  echo $comment['info']['avatar']; ?>" alt="<?php  echo $comment['author']; ?>" title="<?php  echo $comment['author']; ?>">
					</div>
					<?php } ?>

					<?php if (isset ($settings_widget['author_status']) && $settings_widget['author_status'] ) { ?>
					<?php if ($comment['author']) { ?>
					<div class="blog-author"><?php echo $comment['author']; ?>
					</div>
					<?php } ?>
					<?php } ?>

					<?php if (isset($settings_widget['buyer_status']) && $settings_widget['buyer_status']) { ?>
					<div>
					<?php
		            if ($admin || (isset($settings_widget['admins']) && !empty($settings_widget['admins']) && in_array($comment['customer_id'], $settings_widget['admins'])) ) {
		              echo $language->get('text_admin');
		            } else {
						if (isset($comment['info']['buyproduct']) && $comment['info']['buyproduct']!='') {
							echo $language->get('text_buyproduct');
						} else {
							if (isset($comment['info']['buy']) && $comment['info']['buy']!='') {
								echo $language->get('text_buy');
							} else {
						       if (isset($comment['info']['customer_id']) && $comment['info']['customer_id'] > 0 ) {
						       	  echo $language->get('text_registered');
						       } else {
						       	  echo $language->get('text_buy_ghost');
						       }
							}
						}
					}
					?>
					</div>
					<?php } ?>



					<?php if (isset ($settings_widget['rating_status']) && $settings_widget['rating_status'] && $comment['rating']!=0) { ?>
					<?php if ($comment['rating']) { ?>
					<div class="sc_rating">

					<?php if ($theme_stars) { ?>
					<img title="<?php echo $comment['rating']; ?>" alt="<?php echo $comment['rating']; ?>" src="catalog/view/theme/<?php echo $theme_stars; ?>/image/blogstars-<?php echo $comment['rating']; ?>.png">
					<?php } ?>

					</div>
					<?php } ?>
					<?php } ?>

					<?php if (isset ($settings_widget['rating_status']) && $settings_widget['rating_status'] && $comment['rating']==0) { ?>
					 <div class="sc_rating">&nbsp;
					 </div>
					<?php } ?>



         		</div>
				<div class="divider100 margintop2"></div>


					<?php if (isset ($settings_widget['image_status']) && $settings_widget['image_status'] ) { ?>
					<?php if ($comment['thumb']) { ?>
					<div class="image blog-image"><a href="<?php echo $comment['record_href']; ?>"><img src="<?php echo $comment['thumb']; ?>" class="sc-width-max-100" title="<?php echo $comment['record_name']; ?>" alt="<?php echo $comment['record_name']; ?>" /></a></div>
					<?php } ?>
					<?php } ?>

					<?php include(realpath(dirname(__FILE__)).'/../../module/fields_view.tpl'); ?>
					<?php echo $comment['text']; ?>&nbsp;
					<?php if (isset($settings_general['further']))
						echo str_replace('{URL}', $comment['record_href'].'#commentlink_'.$comment['comment_id'].'_'.$comment['cmswidget'], str_replace('{TITLE}', $comment['record_name'], $settings_general['further']));
					?>

		</div>

        <div class="divider100 margintop2"></div>


				       	<div class="">
					       	<ul class="ascp_horizont ascp_list_info ">

									<?php if (isset($settings_widget['date_status']) && $settings_widget['date_status']) { ?>
									<?php if ($comment['date']) { ?>
									<li class="blog-data-record"><?php echo $comment['date']; ?></li>
									<?php } ?>
									<?php } ?>

									<?php if (isset ($settings_widget['viewed_status']) && $settings_widget['viewed_status']) { ?>
									<li class="blog-viewed-record"><?php echo $text_viewed; ?> <?php echo $comment['record_viewed']; ?></li>
									<?php } ?>

									<?php if (isset ($settings_widget['comments_status']) && $settings_widget['comments_status']) { ?>
									<?php if ($comment['record_comments']) { ?>
									<li  class="blog-comments-record"><?php echo $text_comments; ?> <?php echo $comment['record_comments']; ?></li>
									<?php } ?>
									<?php } ?>

									<?php if (isset ($settings_widget['karma_status']) && $settings_widget['karma_status']) { ?>
									<?php if (isset($comment['info']['rate_delta']) && $comment['info']['rate_delta']) { ?>
									<li  class="blog-comments-karma"><?php echo $text_karma; ?>
									<?php  if($comment['info']['rate_delta']>0) {  echo '+'; } ?><?php  echo sprintf("%d", $comment['info']['rate_delta']); ?></li>
									<?php } ?>
									<?php } ?>

									<?php if (isset ($settings_widget['category_status']) && $settings_widget['category_status'] && $comment['blog_name']) { ?>
									<li class="blog-list-category"><?php echo $comment['text_category']; ?><a href="<?php echo $comment['blog_href']; ?>"><?php echo $comment['blog_name']; ?></a></li>
									<?php } ?>

									<?php if (isset ($settings_widget['record_status']) && $settings_widget['record_status'] && $comment['record_name']) { ?>
									<li class="blog-list-record"><?php echo $comment['text_record']; ?><a href="<?php echo $comment['record_href']; ?>"><?php echo $comment['record_name']; ?></a></li>
									<?php } ?>

									<?php if (isset ($settings_widget['manufacturer_status']) && $settings_widget['manufacturer_status'] && isset($comment['info']['manufacturer_name']) && $comment['info']['manufacturer_name']) { ?>
									<li class="blog-list-manufacturer"><?php echo $text_manufacturer; ?><a href="<?php echo $comment['info']['manufacturer_url']; ?>"><?php echo $comment['info']['manufacturer_name']; ?></a></li>
									<?php } ?>


		                 </ul>



                     </div>


				<div class="lineheight1">&nbsp;</div>
				<div class="blog-child_divider">&nbsp;</div>

			</div>
			<?php } ?>

		</div>

		<?php if (isset ($settings_widget['pagination']) && $settings_widget['pagination'] ) { ?>
		<div class="pagination margintop5"><?php echo $pagination; ?></div>
		<?php } ?>

<?php  if (isset($settings_widget['reviews_href'][$config_language_id]) && $settings_widget['reviews_href'][$config_language_id]!='') { ?>
<div class="overflowhidden">
<a href="<?php echo $settings_widget['reviews_href'][$config_language_id]; ?>" class="<?php echo $settings_widget['reviews_a_class']; ?>"><?php echo html_entity_decode($settings_widget['reviews_href_html'][$config_language_id], ENT_QUOTES, 'UTF-8'); ?></a>
<div class="lineheight1">&nbsp;</div>
</div>

<?php } ?>



<?php if (isset($settings_widget['reserved']) && $settings_widget['reserved']!='') {
echo html_entity_decode($settings_widget['reserved'], ENT_QUOTES, 'UTF-8');
} ?>

<?php echo $box_end; ?>
</div>


<?php if (isset($settings_widget['anchor']) && $settings_widget['anchor']!='') { ?>
<script>
<?php if (isset($settings_widget['doc_ready']) && $settings_widget['doc_ready']) { ?>
$(document).ready(function(){
<?php } ?>
		var prefix = '<?php echo $prefix;?>';
		var cmswidget = '<?php echo $cmswidget; ?>';
		var heading_title = '<?php echo $heading_title; ?>';
		var data = $('#cmswidget-<?php echo $cmswidget; ?>').clone();
		<?php echo $settings_widget['anchor']; ?>;
		delete data;
		delete prefix;
		delete cmswidget;
		delete heading_title;
<?php if (isset($settings_widget['doc_ready']) && $settings_widget['doc_ready']) { ?>
});
<?php } ?>
</script>
<?php  } ?>


<?php if (isset($settings_widget['slider']) && $settings_widget['slider']) { ?>
<script>

$('#record_columns-<?php echo $cmswidget; ?>').owlCarousel({
	items: <?php if (isset($settings_widget['block_reviews_width']) && $settings_widget['block_reviews_width'] != '') {
			 		echo round(100 / trim(str_replace('%', '', $settings_widget['block_reviews_width'])));
			 	} else {
			 		echo count($comments);
			 	}
			 	?>,
	autoPlay: 5000,
	navigation: true,
	pagination: true,
    touchDrag: false,
    loop: true,
	navigationText: ['<i class="fa fa-chevron-left fa-5x"></i>', '<i class="fa fa-chevron-right fa-5x"></i>']
});
</script>
<?php } ?>


<?php } ?>
