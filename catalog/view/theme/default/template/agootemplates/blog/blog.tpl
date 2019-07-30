<?php echo $header; ?>
<div class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
      <h1><?php echo $heading_title; ?></h1>
      <div class="seocmspro_content blog-content seocmspro_content_main">
			<div class="divider100"></div>
			<?php if (isset ($settings_blog['view_rss']) && $settings_blog['view_rss'] ) { ?>
			<a href="<?php echo $url_rss; ?>" class="floatright">
			<?php if (SC_VERSION >= 20) { ?>
				<i class="fa fa-rss" aria-hidden="true"></i>
            <?php } else { ?>
				<img class="sc-img-rss" title="RSS" alt="RSS" src="<?php echo $image_rss; ?>">
			<?php } ?>
			</a>
			<div class="divider100"></div>
			<?php } ?>

			<?php if ((isset($description) && $description) || $thumb) { ?>
			<div class="blog-info">
				<?php if ((!isset($settings_blog['category_big_image_status']) && $thumb) || ($thumb && isset($settings_blog['category_big_image_status']) && $settings_blog['category_big_image_status'])) { ?>
				<div class="image blog-image"><img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" /></div>
				<?php } ?>
				<?php if ($description) { ?>
				<div class="blog-description">
					<?php echo $description; ?>
				</div>
				<?php } ?>
			</div>
			<div class="divider100 borderbuttom2"></div>
			<?php } ?>


			<?php if (isset($categories) && $categories) { ?>
			<div class="record_columns_center">
					<?php foreach ($categories as $blog) { ?>
					<div class="blog-category-list">
						<h4><a href="<?php echo $blog['href']; ?>"><div class="blog-category-list-name"><?php echo $blog['name']; ?><?php if ($blog['total'] > 0) echo " (".$blog['total'].")"; ?></div><?php
						if ((isset($blog['thumb']) && !isset($settings_blog['subcategory_big_image_status']) && $blog['thumb']!='') || (isset($blog['thumb']) && $blog['thumb']!='' && isset($settings_blog['subcategory_big_image_status']) && $settings_blog['subcategory_big_image_status'] )) { ?>
						<div>
							<img src="<?php echo $blog['thumb']; ?>">
						</div>
						<?php  } ?></a></h4>
					</div>
					<?php } ?>
			</div>
			<div class="divider100"></div>
			<?php } ?>


		<?php if ($records) { ?>
			<style>
			 .record_columns .column_width_ {
			 	width: <?php if (isset ($settings_blog['block_records_width']) && $settings_blog['block_records_width']!='' ) {
			 	 echo $settings_blog['block_records_width'].'; padding-right: 5px;';
			 	} else {
			 	 echo '100%; min-width: 100%;';
			 	}
			 	?>
			 }
			</style>

			<div class="record_columns">

			<?php $record_count = 1; foreach ($records as $record) { ?>
				<div class="content-records column_width_ <?php if (isset($record['settings_blog']['first100']) && $record['settings_blog']['first100'] && $record_count == 1) { ?>first100<?php } ?>">
				<div class="divider100 ascp_divider margintop2"></div>

                        <?php
                        if ((isset($record['settings_blog']['title_status']) && $record['settings_blog']['title_status'] && (!isset($record['settings_blog']['title_status']) || $record['settings_blog']['title_position']=='before' || $record['settings_blog']['title_position']=='1')) || !isset($record['settings_blog']['title_status']) ) { ?>
                        <div class="name marginbottom5">
							<h2 class="ascp-list-title"><a href="<?php echo $record['href']; ?>" class="ascp-list-title"><?php echo $record['name']; ?></a></h2>
						</div>
						<?php } ?>


					<?php if ($record['thumb'] || (isset ($record['settings_blog']['images_view']) && $record['settings_blog']['images_view']) || (isset ($record['settings_blog']['image_status']) && $record['settings_blog']['image_status']) || (!isset($record['settings_blog']['image_status'])) ) { ?>

					<div class="image blog-image<?php if (isset($record['settings_blog']['first100']) && $record['settings_blog']['first100'] && isset($record['settings_blog']['first100_image']) && $record['settings_blog']['first100_image'] && $record_count == 1) { ?> first100<?php } ?>">

						<?php if (($record['thumb'] && isset ($record['settings_blog']['image_status']) && $record['settings_blog']['image_status']) || ($record['thumb'] &&  !isset($record['settings_blog']['image_status']))	) { ?>
						<div class="image <?php if (isset($settings_blog['title_status']) && $settings_blog['title_status'] && (isset($settings_blog['images_position']) && $settings_blog['images_position'] == 'after' || $record['settings_blog']['title_position'] == '0')) { ?> blog-image <?php } ?>">

							<?php if (isset ($settings_blog['blog_small_colorbox']) && $settings_blog['blog_small_colorbox']) { ?>
							<a href="<?php echo $record['popup']; ?>" title="<?php echo $record['name']; ?>" class="imagebox" rel="imagebox">
								<img src="<?php echo $record['thumb']; ?>" title="<?php echo $record['name']; ?>" alt="<?php echo $record['name']; ?>" class="record_thumb<?php if (isset($record['settings_blog']['first100']) && $record['settings_blog']['first100'] && isset($record['settings_blog']['first100_image']) && $record['settings_blog']['first100_image'] && $record_count == 1) { ?> first100<?php } ?>">
							</a>
							<?php } else { ?>
							<a href="<?php echo $record['href']; ?>" title="<?php echo $record['name']; ?>">
								<img src="<?php echo $record['thumb']; ?>" title="<?php echo $record['name']; ?>" alt="<?php echo $record['name']; ?>" class="record_thumb<?php if (isset($record['settings_blog']['first100']) && $record['settings_blog']['first100'] && isset($record['settings_blog']['first100_image']) && $record['settings_blog']['first100_image'] && $record_count == 1) { ?> first100<?php } ?>">
							</a>
							<?php } ?>
						</div>
						<?php } ?>


						<?php if ((isset ($record['settings_blog']['images_view']) && $record['settings_blog']['images_view']) ) { $number_hide = 1; ?>
						<?php foreach ($record['images'] as $numi => $images) { ?>
						<div class="image blog-image blog-image-thumb <?php if (isset($settings_blog['images_number']) && isset($settings_blog['images_number_hide']) && $settings_blog['images_number_hide'] && $settings_blog['images_number']!='' && $number_hide > $settings_blog['images_number']  ) { ?> asc_displaynone  <?php } ?>">

							<div class="asc_gallery_min">
							<a href="<?php echo $images['popup']; ?>" class="imagebox" rel="imagebox" title="<?php echo $images['title']; ?>">
							<img src="<?php echo $images['thumb']; ?>" alt="<?php echo $images['title']; ?>" title="<?php echo $images['title']; ?>">
								<?php if (isset($settings_blog['images_number']) && isset($settings_blog['images_number_hide']) && $settings_blog['images_number_hide'] && $settings_blog['images_number']!='' && $number_hide == $settings_blog['images_number'] && ($record['images_count']-$number_hide)!=0 ) { ?>
								<div class="asc_gallery_more">
									<div>
										<div><?php echo "+".($record['images_count']-$number_hide);  ?></div>
									</div>
								</div>
								<?php } ?>

							</a>
							</div>

						</div>
                        <?php $number_hide++;  } ?>
						<?php } ?>

					</div>

					<?php } ?>

                        <?php if (isset($record['settings_blog']['title_status']) && $record['settings_blog']['title_status'] && (isset($record['settings_blog']['title_status']) && $record['settings_blog']['title_position']=='after')) { ?>
                        <div class="name marginbottom5">
						<h2 class="ascp-list-title"><a href="<?php echo $record['href']; ?>" class="ascp-list-title"><?php echo $record['name']; ?></a></h2>
						</div>
						<?php } ?>

					<div class="description record_description"><?php echo $record['description']; ?>&nbsp;

					<?php if (!empty( $record['attribute_groups'])) { ?>
					<div class="sc-attribute">
							<?php foreach ($record['attribute_groups'] as $attribute_group) { ?>
							<div class="sc_attribute_group_name"><?php echo $attribute_group['name']; ?></div>
								<?php foreach ($attribute_group['attribute'] as $attribute) { ?>
									<span class="sc_attribute_name"><?php echo $attribute['name']; ?></span>
									<span class="sc_attribute_text"><?php echo $attribute['text']; ?></span>
								<?php } ?>
							<?php } ?>
					</div>
					<?php } ?>


					<?php if (isset($settings_general['further']))
						echo  $record['further'];
					?>
					</div>

					<div class="divider100"></div>
                    <div class="blog_bottom">
					       	<ul class="ascp_horizont ascp_list_info ul55">

									<?php  if ($userLogged)  { ?>
									<li>
										<a class="zametki" target="_blank" href="<?php echo $admin_path; ?>index.php?route=catalog/record/update&token=<?php echo $token; ?>&record_id=<?php echo $record['record_id']; ?>"><?php echo $language->get('text_edit');?></a>
									</li>
									<?php } ?>

									<?php if (isset ($record['settings_blog']['view_date']) && $record['settings_blog']['view_date'] ) { ?>
									<?php if ($record['date_available']) { ?>
									<li class="blog-data-record"><?php echo $record['date_available']; ?></li>
									<?php } ?>
									<?php } ?>

									<?php if (isset ($record['settings_blog']['view_viewed']) && $record['settings_blog']['view_viewed'] ) { ?>
									<li class="blog-viewed-record"><?php echo $text_viewed; ?> <?php echo $record['viewed']; ?></li>
									<?php } ?>

									<?php if (isset ($record['settings_blog']['category_status']) && $record['settings_blog']['category_status'] ) { ?>
									<li class="blog-category-record"><?php echo $language->get('text_category_record');?><a href="<?php echo $record['blog_href']; ?>"><?php echo $record['blog_name']; ?></a></li>
									<?php } ?>

									<?php if (isset ($record['settings_blog']['author_status']) && $record['settings_blog']['author_status'] &&  $record['author']!='') { ?>
									<li class="blog-author-record"><?php echo $text_author;?><a href="<?php echo $record['author_search_link']; ?>"><?php echo $record['author']; ?></a></li>
									<?php } ?>

									<?php if (isset ($record['settings_blog']['view_comments']) && $record['settings_blog']['view_comments'] ) { ?>
									<?php if (isset($record['settings_comment']['status']) && $record['settings_comment']['status']) { ?>
									<li  class="blog-comments-record"><?php echo $text_comments; ?> <?php echo $record['comments']; ?></li>
									<?php } ?>
									<?php } ?>

		                 </ul>

		                <ul class="ascp_horizont ascp_list_info ul45">

									<?php if (isset ($record['settings_blog']['view_rating']) && $record['settings_blog']['view_rating'] ) { ?>
									<?php if ($record['rating']) { ?>
										<?php if ($theme_stars) { ?>
										<li class="floatright">
											<img class="sc-img-stars"  title="<?php echo $record['rating']; ?>" alt="<?php echo $record['rating']; ?>" src="catalog/view/theme/<?php echo $theme_stars; ?>/image/blogstars-<?php echo $record['rating']; ?>.png">
										</li>
										<?php } ?>
									<?php } ?>
									<?php } ?>

									<?php if (isset ($record['settings_blog']['view_share']) && $record['settings_blog']['view_share'] ) { ?>
									<li class="floatright">
										<?php
										  echo $record['share'];
										?>
									</li>
									<?php } ?>


							</ul>
                    </div>

					<div class="divider100"></div>
				</div>
			<?php $record_count++; } ?>

			</div>

			<div class="divider100 borderbottom2 margintop2"></div>

			<?php if (isset ($settings_blog['block_records_width']) && $settings_blog['block_records_width']!='' && $settings_blog['block_records_width']!='100%') { ?>
				<div class="record-grid textalignright margintop5 floatleft">
						<a onclick="records_grid(); return false;" class="floatleft">
							<ins id="ascp_list" class="ascp_list_grid ascp_list"></ins>
						</a>
						<a onclick="records_grid('<?php echo $settings_blog['block_records_width'];?>'); return false;" class="floatleft marginleft5">
							<ins id="ascp_grid" class="ascp_list_grid ascp_grid_active"></ins>
						</a>
				</div>
			<?php } ?>

			<?php if ((isset ($settings_blog['status_order']) && $settings_blog['status_order']) ||  (isset ($settings_blog['status_pagination']) && $settings_blog['status_pagination']) || (!isset ($settings_blog['status_pagination'])) ) { ?>

			<div class="record-filter textalignright margintop5">
		       <ul class="ascp_horizont">
				<?php if ((isset ($settings_blog['status_pagination']) && $settings_blog['status_pagination']) || (!isset ($settings_blog['status_pagination'])) ) { ?>
					<li class="sc-float-right">


						<div class="sc-blog_result">
						<?php echo $text_limit; ?>
						</div>

						<div class="form-group sc-align-right">

							<select onchange="location = this.value;" class="form-control">
								<?php foreach ($limits as $limits) { ?>
								<?php if ($limits['value'] == $limit) { ?>
								<option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
								<?php } else { ?>
								<option value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
								<?php } ?>
								<?php } ?>
							</select>

                        </div>

                        <div class="divider100"></div>
						<?php if (SC_VERSION > 15) { ?>
						<div class="sc-blog_result">
						<?php echo $results; ?>
						</div>
						<?php } ?>


					</li>
                    <?php } ?>

                   <?php if (isset ($settings_blog['status_order']) && $settings_blog['status_order']) { ?>
					<li class="sc-float-right">

						<div id="sc-blog_result">
							<?php echo $text_sort; ?>
						</div>

						<div class="form-group sc-align-right">

						<select onchange="location = this.value;" class="form-control">
							<?php foreach ($sorts as $sorts) { ?>
							<?php if ($sorts['value'] == $sort . '-' . $order) { ?>
							<option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
							<?php } else { ?>
							<option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
							<?php } ?>
							<?php } ?>
						</select>
						</div>
						<div class="divider100"></div>
						<?php if (SC_VERSION > 15) { ?>
						<div class="sc-blog_result">
						&nbsp;
						</div>
						<?php } ?>

					</li>
                   <?php } ?>
				</ul>
			</div>
			<div class="divider100"></div>

			<?php if ((isset ($settings_blog['status_pagination']) && $settings_blog['status_pagination']) || (!isset ($settings_blog['status_pagination'])) ) { ?>
				<?php if (isset($settings_blog['records_more']) && $settings_blog['records_more'] && $entry_records_more!='') { ?>
					<div id="records_more"><a class="records_more button btn btn-primary"><?php echo $entry_records_more; ?></a></div>
				<?php } ?>
			<div class="pagination margintop5"><?php echo $pagination; ?></div>
			<?php } ?>

            <?php } ?>

		<?php } ?>


			<?php if ((isset($settings_blog['status_continue']) && $settings_blog['status_continue']) && (isset($categories) && !$categories) && (isset($records) && !$records)) { ?>
			<div class="content"><?php echo $text_empty; ?></div>
			<div class="buttons">
				<div class="right"><a href="<?php echo $continue; ?>" class="button"><span><?php echo $button_continue; ?></span></a></div>
			</div>
			<?php } ?>


<?php if (isset($settings_blog['reserved']) && $settings_blog['reserved']!='') {
	echo $settings_blog['reserved'];
} ?>

    </div><?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<?php echo $footer; ?>