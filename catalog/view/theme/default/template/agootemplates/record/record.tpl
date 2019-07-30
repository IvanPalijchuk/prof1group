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
      <div class="seocmspro_content">
		<span itemscope itemtype="http://schema.org/Article">
		<meta itemscope itemprop="mainEntityOfPage"  itemtype="https://schema.org/WebPage" itemid="<?php echo $href; ?>"/>


			<?php if  (isset($comment_count) && $comment_count>0) { ?>
			<span itemtype="http://schema.org/AggregateRating" itemprop="aggregateRating" itemscope="">
				<meta itemprop="reviewCount" content="<?php echo $comment_count; ?>">
				<meta itemprop="ratingValue" content="<?php echo $rating; ?>">
				<meta itemprop="bestRating" content="5">
				<meta itemprop="worstRating" content="1">
			</span>
			<?php } ?>

			<meta itemprop="description" content="<?php echo $meta_description; ?>">

			<meta itemprop="name" content="<?php echo $heading_title; ?>">
            <meta itemprop="headline" content="<?php echo $heading_title; ?>">

			<?php if (isset($author) && $author!='') { ?>
			<meta itemprop="author" content="<?php echo $author; ?>">
			<?php } else { ?>
			<meta itemprop="author" content="Administrator">
			<?php } ?>

			<span itemprop="publisher" itemscope itemtype="https://schema.org/Organization">
				<meta itemprop="name" content="<?php echo $config->get('config_owner'); ?>">

    			<?php if (isset($publisher_logo) && $publisher_logo!='') { ?>
				<span itemprop="logo" itemscope itemtype="https://schema.org/ImageObject">
	        		<img itemprop="url" src="<?php echo $publisher_logo; ?>" style="display:none;"/>
	        		<meta itemprop="image" content="<?php echo $publisher_logo; ?>">
	        		<meta itemprop="width" content="<?php echo (int)$publisher_logo_dim['width']; ?>">
	        		<meta itemprop="height" content="<?php echo (int)$publisher_logo_dim['height']; ?>">
	    		</span>
	    		<?php } ?>

			</span>

          <?php if ($thumb) { ?>
			<span itemprop="image" itemscope itemtype="https://schema.org/ImageObject">
		    	<img itemprop="url" src="<?php echo $thumb; ?>" style="display:none;" />
		    	<meta itemprop="image" content="<?php echo $thumb; ?>">
        		<meta itemprop="width" content="<?php echo (int)$thumb_dim['width']; ?>">
        		<meta itemprop="height" content="<?php echo (int)$thumb_dim['height']; ?>">
			</span>
          <?php } else { ?>
		  	<?php if (isset($publisher_logo) && $publisher_logo != '') { ?>
			<span itemprop="image" itemscope itemtype="https://schema.org/ImageObject">
	        	<img itemprop="url" src="<?php echo $publisher_logo; ?>" style="display:none;" />
        		<meta itemprop="image" content="<?php echo $publisher_logo; ?>">
        		<meta itemprop="width" content="<?php echo (int)$publisher_logo_dim['width']; ?>">
        		<meta itemprop="height" content="<?php echo (int)$publisher_logo_dim['height']; ?>">
			</span>
           	<?php } ?>
          <?php } ?>

			<meta itemprop="dateModified" content="<?php echo $date_modified; ?>">
            <meta itemprop="datePublished" content="<?php echo $date_available; ?>">
			<meta itemprop="dateCreated" content="<?php echo $date_created; ?>">

        <div class="record-info record_content">
		<?php if (	(isset ($settings_blog['view_date']) && $settings_blog['view_date'])
				|| 	(isset ($settings_blog['view_comments']) && $settings_blog['view_comments'] && $comment_status)
				|| 	(isset ($settings_blog['view_viewed']) && $settings_blog['view_viewed'])
				|| 	(isset ($settings_blog['author_record_status']) && $settings_blog['author_record_status'] && $author!='')
				|| 	(isset ($settings_blog['view_rating']) && $settings_blog['view_rating'] && $comment_status) ) { ?>

			<div class="blog-small-record">
				<ul>
					<?php if (isset ($settings_blog['view_date']) && $settings_blog['view_date'] ) { ?>
					<li class="blog-data-record"> <?php echo $date_added; ?></li>
					<?php } ?>
					<?php if (isset ($settings_blog['view_comments']) && $settings_blog['view_comments'] && $comment_status) { ?>
					<li class="blog-comments-record"><?php echo $text_comments; ?> <ins style="text-decoration:none;" class="comment_count"><?php echo $comment_count; ?></ins></li>
					<?php } ?>
					<?php if (isset ($settings_blog['view_viewed']) && $settings_blog['view_viewed'] ) { ?>
					<li class="blog-viewed-record"><?php echo $text_viewed; ?> <?php echo $viewed; ?></li>
					<?php } ?>

					<?php if (isset ($settings_blog['author_record_status']) && $settings_blog['author_record_status'] &&  $author!='') { ?>
					<li class="blog-author-record"><?php echo $text_author;?> <a href="<?php echo $author_search_link; ?>"><?php echo $author; ?></a></li>
					<?php } ?>

					<?php if (isset ($settings_blog['view_rating']) && $settings_blog['view_rating'] && $comment_status) { ?>
                    <li class="floatright">
					<?php if ($theme_stars) { ?>
					<img class="bordernone" title="<?php echo $rating; ?>" alt="<?php echo $rating; ?>" src="catalog/view/theme/<?php echo $theme_stars; ?>/image/blogstars-<?php echo $rating; ?>.png">
					<?php } ?>

						<!-- RDFa. -->
						<?php if  ($comment_count > 0) { ?>
						<span xmlns:v="http://rdf.data-vocabulary.org/#" typeof="v:Review-aggregate">
						<span property="v:itemreviewed" style="display:none;"><?php echo $heading_title; ?></span>
						<span rel="v:rating">
						<span typeof="v:Rating">
						<span property="v:average" content="<?php echo $rating; ?>"></span>
						<span property="v:best" content="5"></span>
						</span>
						</span>
						<span property="v:votes" content="<?php echo $comment_count; ?>"></span>
						<span property="v:count" content="<?php echo $comment_count; ?>"></span>
						</span>
						<?php } ?>
					</li>
					<?php } ?>

				</ul>
			</div>
			<div class="divider100"></div>
            <?php } ?>


			<?php if (isset ($settings_blog['thumb_view']) && $settings_blog['thumb_view'] ) { ?>
			<?php if ($thumb) { ?>
			<div class="image blog-image">
				<a href="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>" class="imagebox" rel="imagebox">
				<figure>
					<img src="<?php echo $thumb; ?>"  title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>>" data-small-img="<?php echo $thumb; ?>">
				</figure>
				</a>
			</div>
			<?php } ?>
			<?php } ?>

			<?php if($description!='') {?>
			<div class="blog-record-description">
				<span itemprop="articleBody"><?php echo $description; ?></span>
			</div>
			<div class="divider100"></div>
          	<?php } ?>

			<?php if ($product_tags) {
			   echo $product_tags;
			 ?>
			<div class="divider100"></div>
			<?php } ?>

			<?php if (!isset ($settings_blog['next_status']) || (isset ($settings_blog['next_status']) && $settings_blog['next_status'])) { ?>
			<div class="blog-next-prev">
				<?php if($record_previous['name']!='') {?>
				<a href="<?php echo $record_previous['url']; ?>" data-sc-tooltip="<?php echo $record_previous['name']; ?>"><?php echo $language->get('separator_previus'); ?>&nbsp;<?php echo $record_previous['name']; ?></a>
				<?php } ?>
				<?php if($record_previous['name']!='' || $record_next['name']!='') {?>
				&nbsp;<?php echo $language->get('separator_center'); ?>&nbsp;
				<?php } ?>
				<?php if($record_next['name']!='') {?>
				<a href="<?php echo $record_next['url']; ?>" data-sc-tooltip="<?php echo $record_next['name']; ?>"><?php echo $record_next['name']; ?>&nbsp;<?php echo $language->get('separator_next'); ?></a>
				<?php } ?>
			</div>
            <?php } ?>

		</div>

	<div class="divider100"></div>

		<?php if (isset($settings_general['related_widget_status']) && $settings_general['related_widget_status'] && $products &&
		(!isset($settings_blog['related_product_tab_status']) || (isset($settings_blog['related_product_tab_status']) && !$settings_blog['related_product_tab_status']))) {
			$products_tab = false;
		} else {
			$products_tab = true;
		}
		?>


	   	<?php if ($records || $images || $attribute_groups || ($products && $products_tab) || $comment_status ) { ?>
           <ul class="nav nav-tabs <?php if (SC_VERSION <= 20 || $theme == 'journal2') { ?>htabs<?php } ?>" id="<?php if (SC_VERSION <= 20 || $theme == 'journal2') { ?>tabs<?php } else { ?>scp-tabs<?php } ?>">
			<?php if (isset ($settings_blog['thumb_view']) && $settings_blog['thumb_view'] ) { ?>
				<?php if ( (!isset($settings_blog['image_gallery_status']) && $images) ||
							(isset($settings_blog['image_gallery_status']) && $settings_blog['image_gallery_status'] && $images) ) { ?>
				<li class="active"><a href="#tab-images"  data-toggle="tab"><?php echo $tab_images; ?></a></li>
				<?php } ?>
			<?php } ?>


			<?php if (!isset ($settings_blog['thumb_view']) || !$settings_blog['thumb_view'] ) { ?>
				<?php if ( (!isset($settings_blog['image_gallery_status']) && $images) ||
							(isset($settings_blog['image_gallery_status']) && $settings_blog['image_gallery_status'] && $images) ) { ?>
				<li><a href="#tab-images"  data-toggle="tab"><?php echo $tab_images; ?></a></li>
				<?php } ?>
			<?php } ?>


			<?php if ($attribute_groups) { ?>
			<li><a href="#tab-attribute"  data-toggle="tab"><?php echo $tab_attribute; ?></a></li>
			<?php } ?>


			<?php if ($records) { ?>
			<li><a href="#tab-related"  data-toggle="tab"><?php echo $tab_related; ?> (<?php echo count($records); ?>)</a></li>
			<?php } ?>


			<?php if (isset($settings_general['related_widget_status']) && $settings_general['related_widget_status'] && ($products && $products_tab) &&
			(isset($settings_blog['related_product_tab_status']) && $settings_blog['related_product_tab_status'])) { ?>
			<li><a href="#tab-product-related"  data-toggle="tab"><?php echo $tab_product_related; ?> (<?php echo count($products); ?>)</a></li>
			<?php } ?>

		  </ul>
		 <?php } ?>





		<?php if (($theme == 'journal2' || SC_VERSION > 15) && ($records || $images || $attribute_groups || ($products && $products_tab) || $comment_status)) { ?>
		<div class="<?php if ($theme == 'journal2' ) {  ?>tabs-content<?php } elseif (SC_VERSION > 15) { ?>tab-content<?php } ?>">
        <?php } ?>

        <?php if ($records) { ?>

		<?php if (SC_VERSION > 15) { ?>

        <?php $i = 0; ?>
        <?php foreach ($records as $record) { ?>
        <?php if ($column_left && $column_right) { ?>
        <?php $class = 'col-lg-6 col-md-6 col-sm-12 col-xs-12'; ?>
        <?php } elseif ($column_left || $column_right) { ?>
        <?php $class = 'col-lg-4 col-md-4 col-sm-6 col-xs-12'; ?>
        <?php } else { ?>
        <?php $class = 'col-lg-3 col-md-3 col-sm-6 col-xs-12'; ?>
        <?php } ?>
        <?php } ?>

		<?php } else { ?>
		<?php $class = ''; ?>
		<?php } ?>
		<div id="tab-related" class="tab-pane margintop5">
			<div class="box-product ascp_row">
				<?php foreach ($records as $record) { ?>
				<div class="<?php echo $class; ?>" style="width: <?php echo $settings_blog['product_image']['width']; ?>px; min-width: 200px;">
				<div  class="record-thumb transition">
					<?php if ((!isset($settings_blog['image_record_status']) && $record['thumb']) ||  (isset($settings_blog['image_record_status']) && $settings_blog['image_record_status'] && $record['thumb']) ) { ?>

					<div class="image">
						<a href="<?php echo $record['href']; ?>"><img src="<?php echo $record['thumb']; ?>" alt="<?php echo $record['name']; ?>" class="img-responsive"/></a>
					</div>
					<?php } ?>
					<div class="sc_caption">
						<div class="name"><h4><a href="<?php echo $record['href']; ?>"><?php echo $record['name']; ?></a></h4></div>
                        <p><?php echo $record['description']; ?></p>
						<?php if ($record['rating']) { ?>
						<div class="sc_rating">
						<?php if (SC_VERSION > 15) { ?>
						<?php for ($i = 1; $i <= 5; $i++) { ?>
		                <?php if ($record['rating'] < $i) { ?>
		                <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
		                <?php } else { ?>
		                <span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
		                <?php } ?>
		                <?php } ?>
                         <?php } else { ?>
						<img src="catalog/view/theme/<?php echo $theme; ?>/image/stars-<?php echo $record['rating']; ?>.png" alt="<?php echo $record['rating']; ?>" />
						 <?php } ?>
						</div>
						<?php } ?>
					</div>

				</div>
				</div>
				<?php } ?>
			</div>
		</div>
		<?php } ?>


		<?php if ( (!isset($settings_blog['image_gallery_status']) && $images) ||
		(isset($settings_blog['image_gallery_status']) && $settings_blog['image_gallery_status'] && $images) ) { ?>
		<div id="tab-images" class="tab-pane margintop5">
			<div class="left">
				<?php if ($images) { ?>
				<div class="<?php if (SC_VERSION < 20) { ?>image-additional<?php }  ?> image-gallery-main">
					<?php foreach ($images as $image) { ?>
					<div class="image-gallery-list">
						<?php if (isset($image['title']) && $image['title']!='') { ?>
						<div class="left">
							<?php if (isset($image['url']) && $image['url']!='') { ?>
							<a href="<?php echo $image['url']; ?>">
							<?php }  ?>
							<?php echo $image['title']; ?>
							<?php if (isset($image['url']) && $image['url']!='') { ?>
							</a>
							<?php }  ?>
						</div>
						<?php } ?>
						<a href="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>" class="imagebox" rel="imagebox"><img src="<?php echo $image['thumb']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></a>
						<?php if (isset($image['description']) && $image['description']!='') { ?>
						<div>
							<?php echo $image['description']; ?>
						</div>
						<?php } ?>
					</div>
					<?php } ?>
				</div>
				<?php } ?>
			</div>
		</div>
		<?php } ?>

		<?php if ($attribute_groups) { ?>
		<div id="tab-attribute" class="tab-pane margintop5">
				<?php foreach ($attribute_groups as $attribute_group) { ?>
							<div class="sc_attribute_group_name"><?php echo $attribute_group['name']; ?></div>
								<?php foreach ($attribute_group['attribute'] as $attribute) { ?>
									<span class="sc_attribute_name"><?php echo $attribute['name']; ?></span>
									<span class="sc_attribute_text"><?php echo html_entity_decode($attribute['text'], ENT_QUOTES, 'UTF-8'); ?></span>
								<?php } ?>
				<?php } ?>
		</div>
		<?php } ?>

		<?php if (isset($settings_general['related_widget_status']) && $settings_general['related_widget_status'] && ($products && $products_tab) &&
		(isset($settings_blog['related_product_tab_status']) && $settings_blog['related_product_tab_status'])) { ?>
		<div id="tab-product-related" class="tab-pane margintop5">
		<?php
        if (isset($settings_general['related_theme']) && $settings_general['related_theme']) {
			echo $html_products_related;
		}
		?>
		</div>
        <?php } ?>


		<?php if (($theme == 'journal2' || SC_VERSION > 15) && ($records || $images || $attribute_groups || ($products && $products_tab) || $comment_status)) { ?>
		</div>
        <?php } ?>

        <?php if (SC_VERSION < 20 || $theme == 'journal2' ) {  ?>
		<script>
		$('#tabs a').each(function() {
		   var obj = $(this);
		   $(obj.attr('href')).hide();
		   $(obj).unbind('click');
		});
		$('#tabs a').tabs();
		</script>
		<?php } else { ?>
		<script>
		$(document).ready(function() {
			$('.nav-tabs li:nth-child(1)').removeClass('active');
			$('.nav-tabs li:nth-child(1) a').click();
			$('.share').show();
        });
        </script>
        <?php } ?>



		<div class="overflowhidden width100 lineheight1 bordernone clearboth">&nbsp;</div>

		<?php if (isset($settings_general['related_widget_status']) && $settings_general['related_widget_status'] && $products &&
		(!isset($settings_blog['related_product_tab_status']) || (isset($settings_blog['related_product_tab_status']) && !$settings_blog['related_product_tab_status']))) { ?>
		<?php
        if (isset($settings_general['related_theme']) && $settings_general['related_theme']) {
			echo $html_products_related;
		}

		?>
        <?php } ?>


		<?php if (isset ($settings_blog['view_share']) && $settings_blog['view_share'] ) { ?>
		<div class="share">
			<?php echo $box_share; ?>
		</div>

		<?php } ?>

		<?php if ($tags) { 	?>
		<div class="tags"><b><?php echo $text_tags; ?></b>
			<?php for ($i = 0; $i < count($tags); $i++) { ?>
			<?php if ($i < (count($tags) - 1)) { ?>
			<a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>,
			<?php } else { ?>
			<a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>
			<?php } ?>
			<?php } ?>
		</div>
		<?php } ?>
     </span>

<?php if (isset($settings_blog['reserved']) && $settings_blog['reserved']!='') {
echo html_entity_decode($settings_blog['reserved'], ENT_QUOTES, 'UTF-8');
} ?>

		</div><?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<?php echo $footer; ?>