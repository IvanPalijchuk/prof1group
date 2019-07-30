<div class="panel panel-default">
  <div class="panel-heading"><?php echo $heading_title; ?></div>
  <div class="list-group">
    <div class="list-group-item">
		<div id="filter-group-pricefilter">
			  <?php foreach ($pricefilters as $pricefilter) {?>
				<div class="checkbox">
				  <label>
					<?php if (in_array($pricefilter['pricefilter'], $price_filters)) { ?>
					<input class="pricefilter" type="checkbox" name="pricefilter[]" value="<?php echo $pricefilter['pricefilter']; ?>" id="brandfilter<?php echo $pricefilter['pricefilter']; ?>" checked="checked" />
					<?php echo $pricefilter['label']; ?>
					<?php } else { ?>
					<input class="pricefilter" type="checkbox" name="pricefilter[]" value="<?php echo $pricefilter['pricefilter']; ?>" id="pricefilter<?php echo $pricefilter['pricefilter']; ?>" />
					<?php echo $pricefilter['label']; ?>
					<?php } ?>
				  </label>
				</div>
			  <?php } ?>
			</div>  
    </div>

  </div>
</div>

<script type="text/javascript"><!--
$('.pricefilter').on('click', function() {
	pricefilter = [];
	
	$('input[name^=\'pricefilter\']:checked').each(function(element) {
		pricefilter.push(this.value);
	});
	
	location = '<?php echo $action; ?>&pricefilter=' + pricefilter.join(',');
});
//--></script> 
