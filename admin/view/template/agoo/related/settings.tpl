 <table class="mynotable" style="margin-bottom:20px; background: white; vertical-align: center;">
	<tr>
	  <td><?php echo $language->get('entry_widget_status'); ?></td>
	  <td>
		  <div class="input-group">
			  <select class="form-control" name="ascp_settings[related_widget_status]">
			      <?php if (isset($ascp_settings['related_widget_status']) && $ascp_settings['related_widget_status']) { ?>
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

	<input type="hidden" id="ascp_settings_related_theme" name="ascp_settings[related_theme]" value="1">

	<tr>
		<td class="left">
			<?php echo $language->get('entry_related_theme_title'); ?>
		</td>
		<td>
        <?php foreach ($languages as $lang) { ?>
			<div class="input-group marginbottom5px"><span class="input-group-addon"><?php echo strtoupper($lang['code']); ?><br><img src="<?php echo $lang['image']; ?>" title="<?php echo $lang['name']; ?>" ></span>
				<textarea class="form-control" name="ascp_settings[related_theme_title][<?php echo $lang['language_id']; ?>]" rows="3" cols="50" ><?php if (isset($ascp_settings['related_theme_title'][$lang['language_id']])) { echo $ascp_settings['related_theme_title'][$lang['language_id']]; } else { echo ''; } ?></textarea>
			</div>
		<?php } ?>
		</td>
	</tr>
<?php if (SC_VERSION > 15) { ?>
<tr>
	  <td><?php echo $language->get('entry_related_owl_status'); ?></td>
	  <td>
		  <div class="input-group">
			  <select class="form-control" name="ascp_settings[related_owl_status]">
			      <?php if (isset($ascp_settings['related_owl_status']) && $ascp_settings['related_owl_status']) { ?>
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
<?php } ?>


 </table>
