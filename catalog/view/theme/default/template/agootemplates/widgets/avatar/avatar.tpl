<div id="cmswidget-<?php echo $cmswidget; ?>" class="cmswidget">
<?php echo $box_begin; ?>
	   		<ul class="list-unstyled">
		   		<li>
		   			<a href="#" onclick="return false;" id="avatar_menu"><?php echo $language->get('url_avatar_text'); ?></a>
		   		</li>
	   		</ul>
<?php if (isset($settings_widget['reserved']) && $settings_widget['reserved'] != '') {
echo html_entity_decode($settings_widget['reserved'], ENT_QUOTES, 'UTF-8');
} ?>
<?php echo $box_end; ?>
</div>

<?php if (isset($settings_widget['anchor']) && $settings_widget['anchor']!='') { ?>
<script>
	<?php if (isset($settings_widget['doc_ready']) && $settings_widget['doc_ready']) { ?>
	$(document).ready(function(){
	<?php  } ?>
		var cmswidget = '<?php echo $cmswidget; ?>';
		var prefix = '<?php echo $prefix;?>';
		var data = $('#cmswidget-<?php echo $cmswidget; ?>').clone();
		data = $(data).html();

		avatarload = function() {

			 var url_str = '<?php echo $link; ?>'+'&sc_ajax=1';
			 $('.error').remove();
			 $('.success').remove();
			 $('.alert').remove();
			 $.ajax({
			            type: 'POST',
			            url: url_str,
			            data: {
			                cmswidget: '<?php echo $cmswidget; ?>',
			                layout_id: '<?php echo $layout_id; ?>',
			                url: '<?php echo $url; ?>',
			                sc_ajax: '1'
			            },
			            dataType: 'html',
			            async: 'false',
			            beforeSend: function () {
			              $(content_selector).html('<?php echo $language->get('text_sc_loading'); ?>...<img src="catalog/view/theme/default/image/aloading16.png" alt="loading" class="loading" style="padding-left: 5px;" />');
			            },
			            success: function (data) {
			                $(content_selector).html(data);
			            },
			            complete: function (data) {

			            }
			     });
			}

			 $('#avatar_menu').click(function () {
			      avatarload();
			    });


		<?php echo $settings_widget['anchor']; ?>;

		delete data;
		delete prefix;
		delete cmswidget;

	<?php if (isset($settings_widget['doc_ready']) && $settings_widget['doc_ready']) { ?>
	});
	<?php  } ?>

</script>
<?php  } ?>