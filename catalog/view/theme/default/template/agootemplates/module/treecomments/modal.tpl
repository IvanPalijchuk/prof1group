<div class="container_comments" id="container_comments_<?php echo $mark;?>_<?php echo $mark_id;?>">
	<!-- <noindex> -->
		<div class="container_comments_vars acc<?php echo $cmswidget; ?>" id="container_comments_vars_<?php echo $mark;?>_<?php echo $mark_id;?>" style="display: none">
			<div class="mark" data-text="<?php echo $mark; ?>"></div>
			<div class="mark_id" data-text="<?php echo $mark_id; ?>"></div>
			<div class="text_rollup_down" data-text="<?php echo $text_rollup_down; ?>"></div>
			<div class="text_rollup" data-text="<?php echo $text_rollup; ?>"></div>
			<div class="visual_editor" data-text="<?php echo $visual_editor; ?>"></div>
			<div class="sorting" data-text="<?php echo $sorting; ?>"></div>
			<div class="page" data-text="<?php echo $page; ?>"></div>
			<div class="ascp_widgets_position" data-text="<?php echo $ascp_widgets_position; ?>"></div>
			<div class="text_voted_blog_plus" data-text="<?php echo  $text_voted_blog_plus; ?>"></div>
			<div class="text_voted_blog_minus" data-text="<?php echo  $text_voted_blog_minus; ?>"></div>
			<div class="text_all" data-text="<?php echo  $text_all; ?>"></div>
			<div class="prefix" data-text="<?php echo $prefix;?>"></div>
		</div>
	<!-- </noindex> -->

		<?php if (isset($settings_widget['stat_status']) && $settings_widget['stat_status'] && isset($comments_stat['count_comments']) && $comments_stat['count_comments'] > 0) {
         	include(DIR_TEMPLATE.$comments_stat['template']);
        } ?>


<?php
	if (isset($comments) && $comments) {	  	if (isset($record_comment['admin_name']) && $record_comment['admin_name']) {
			$admin_name =  array_flip(explode(";",trim($record_comment['admin_name'])));
		}
?>
		<style>
			 .record_columns .column_width_<?php echo $cmswidget; ?> {
			 	width: <?php if (isset ($settings_widget['block_stat_width']) && $settings_widget['block_stat_width']!='' ) {
			 	 echo $settings_widget['block_stat_width'].'; padding-right: 5px; overflow: hidden;';
			 	} else {
			 	 echo '100%;  min-width: 100%;';
			 	}
			 	?>
			 }
		</style>

<div class="record_columns">
<?php
		$admin = false;
		$numbercomment = 0;

		foreach ($comments as $number => $comment) {

				if (isset($settings_widget['number_comments']) && $numbercomment >= $settings_widget['number_comments']) {		          break;
				}

				$numbercomment++;
				if (isset($admin_name[trim($comment['author'])]) || (isset($settings_widget['admins']) && in_array($comment['customer_id'], $settings_widget['admins']))) {				 	$back_color = 'background-color: '.$record_comment['admin_color'].';';
				 	$admin = true;
				} else {				 	$back_color ='';
				 	$admin = false;
				}
	?>
<div class="column_width_<?php echo $cmswidget; ?>">
	<div id="commentlink_<?php  echo $comment['comment_id']; ?>_<?php  echo $cmswidget; ?>" class="comment_content">
  		<div class="padding2 comment_block" style="<?php echo $back_color; ?>">

			<?php if (isset($settings_widget['avatar_status']) && $settings_widget['avatar_status'] && $comment['avatar']) { ?>
			<div class="seocmspro_avatar sc_h_s">
				<img src="<?php  echo $comment['avatar']; ?>" alt="<?php  echo $comment['author']; ?>" title="<?php  echo $comment['author']; ?>">
			</div>
			<?php } ?>

			<div class="seocmspro_author sc_h_s">
			<b><?php  echo $comment['author']; ?></b>

			<?php if (isset($settings_widget['buyer_status']) && $settings_widget['buyer_status']) { ?>
			<div class="sc_h_s">
			<!-- <noindex> -->
			<?php
            if ($admin || (isset($settings_widget['admins']) && in_array($comment['customer_id'], $settings_widget['admins'])) ) {              echo $text_admin;
            } else {
				if ($comment['buyproduct']!='') {
					echo $text_buyproduct;
				} else {					if ($comment['buy']!='') {
						echo $text_buy;
					} else {				       if ($comment['customer_id'] > 0 ) {				       	  echo $text_registered;
				       } else {				       	  echo $text_buy_ghost;
				       }
					}
				}
			}
			?>
			<!-- </noindex> -->
			</div>
			<?php } ?>


			<?php if (isset($settings_widget['rating']) && $settings_widget['rating'] && $comment['rating_mark']==0 ) { ?>
			<div class="sc_h_s">
				<?php if ($theme_stars) { ?>
					<img style="border: 0px;"  title="<?php echo $comment['rating']; ?>" alt="<?php echo $comment['rating']; ?>" src="catalog/view/theme/<?php echo $theme_stars; ?>/image/blogstars-<?php echo $comment['rating']; ?>.png">
				<?php } ?>
 			</div>
  			<?php } ?>

			<div class="com_date_added sc_h_s"><?php if (isset($settings_widget['date_status']) && $settings_widget['date_status']) { ?>
			<ul class="ascp_horizont ascp_list_info">
				<li class="blog-data-record"><?php echo $comment['date_added']; ?></li>
			</ul>


			<?php } ?>
		</div>

        </div>




  		<div class="width100 overflowhidden lineheight1">&nbsp;</div>

			<div class="com_text color_<?php  if($comment['delta'] >= 0) {  echo '000'; } else {  echo 'aaa'; } ?>">

<?php include(realpath(dirname(__FILE__)).'/../fields_view.tpl'); ?>

			<div class="bbcode-text" id="bbcode-text-<?php echo  $comment['comment_id']; ?>">
					<?php echo $comment['text']; ?>
			</div>

			</div>

			<?php if (isset ($settings_widget['karma']) && $settings_widget['karma']) { ?>
                <ul class="ascp_horizont ascp_list_info">
				<li class="blog-comments-karma <?php  if($comment['delta']>=0) {  echo 'sc-positive'; } else {  echo 'sc-negative'; } ?> " >
                   <?php echo $language->get('text_karma'); ?>
					<span title="All <?php  echo $comment['rate_count']; ?>: ↑<?php  echo $comment['rate_count_blog_plus']; ?> & ↓<?php  echo $comment['rate_count_blog_minus']; ?>" class="score">
					<?php  if($comment['delta']>0) {  echo '+'; } ?><?php  echo sprintf("%d", $comment['delta']); ?>
					</span>
				</li>
				</ul>

			<?php } ?>

			<div class="overflowhidden width100 lineheight1 height1">&nbsp;</div>

		</div>
	</div>
</div>
<?php } ?>
</div>


<?php  } ?>


<?php if (isset($record['record_href']) && $record['record_href'] != '' && isset($settings_widget['stat_href_html'][$config_language_id]) && $settings_widget['stat_href_html'][$config_language_id] != '') { ?>
<div class="overflowhidden">
<a href="<?php echo $record['record_href']; ?>" class="<?php if (isset($settings_widget['stat_a_class']) && $settings_widget['stat_a_class'] != '') { echo $settings_widget['stat_a_class']; } ?>" ><?php if (isset($settings_widget['stat_href_html'][$config_language_id]) && $settings_widget['stat_href_html'][$config_language_id]!='') { echo html_entity_decode($settings_widget['stat_href_html'][$config_language_id], ENT_QUOTES, 'UTF-8') ; } ?></a>
<div class="lineheight1 height1">&nbsp;</div>
</div>
<?php } ?>



<script>
$(document).ready(function(){
$('.sc_h_s').show();
});
</script>
</div>