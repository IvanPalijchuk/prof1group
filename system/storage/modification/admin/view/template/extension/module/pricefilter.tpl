<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-pricefilter" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>

				<button onclick="$('#content #apply').attr('value', '1'); $('#' + $('#content form').attr('id')).submit();" data-toggle="tooltip" title="<?php echo $button_apply; ?>" class="btn btn-success"><i class="fa fa-check"></i></button>
			
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-pricefilter" class="form-horizontal">

				<input type="hidden" name="apply" id="apply" value="0">
			
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
            <div class="col-sm-10">
              <select name="pricefilter_status" id="input-status" class="form-control">
                <?php if ($pricefilter_status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
          
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-pricefiltermode"><?php echo $text_pricefiltermode; ?></label>
            <div class="col-sm-10">
              <select name="pricefilter_mode" id="input-mode" class="form-control">
                <?php if ($pricefilter_mode) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-pricefilterstep"><?php echo $text_pricefilterstep; ?></label>
            <div class="col-sm-10">
          <input type="text" name="pricefilterstep" value="<?php echo $pricefilterstep;?>" class="form-control">
          </div>
          </div>
          <div class="table-responsive" id="pricefilter">
                <table class="table table-striped table-bordered table-hover">
                  <thead>
                    <tr>
                      <td class="text-left"><?php echo $entry_startprice; ?></td>
                      <td class="text-left"><?php echo $entry_endprice; ?></td>
                       <td class="text-left"><?php echo $entry_order; ?></td>
                      <td class="text-left"></td>
                    </tr>
                  </thead>
                  <tbody>
                    <?php $pricefilter_row = 0; ?>
                    <?php if($pricefilters){?>
                    <?php foreach ($pricefilters as $pricefilter) { ?>

                    <tr id="pricefilter-row<?php echo $pricefilter_row; ?>">
                      <td class="text-left"><input type="text" name="pricefilter[<?php echo $pricefilter_row; ?>][startprice]" value="<?php echo $pricefilter['startprice'];?>" class="form-control"></td>
                      <td class="text-left"><input type="text" name="pricefilter[<?php echo $pricefilter_row; ?>][endprice]" value="<?php echo $pricefilter['endprice'];?>" class="form-control"></td>
                      <td class="text-left"><input type="text" name="pricefilter[<?php echo $pricefilter_row; ?>][order]" value="<?php echo $pricefilter['order'];?>" class="form-control"></td>
                      <td class="text-left"><button type="button" onclick="$('#pricefilter-row<?php echo $pricefilter_row; ?>').remove()" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>
                    </tr>
                    <?php $pricefilter_row++; ?>
                    <?php } ?>
                    <?php } ?>
                  </tbody>
                  <tfoot>
                    <tr>
                      <td colspan="3"></td>
                      <td class="text-left"><button type="button" onclick="addPricefilter()" data-toggle="tooltip" title="<?php echo $text_pricefilteraddbutton; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>
                    </tr>
                  </tfoot>
                </table>
              </div>
          
        </form>
      </div>
    </div>
  </div>
  
  
  <script type="text/javascript"><!--
var pricefilter_row = <?php echo $pricefilter_row; ?>;

function addPricefilter() {
	pricefilter_row++;

	html  = '';
	html += '<tr id="pricefilter-row' + pricefilter_row + '">';
	html += '  <td class="left">';
	html += '    <input type="text" name="pricefilter[' + pricefilter_row + '][startprice]" value="" class="form-control">';
	html += '  </td>';
	html += '  <td class="left">';
	html += '    <input type="text" name="pricefilter[' + pricefilter_row + '][endprice]" value="" class="form-control">';
	html += '  </td>';
	html += '  <td class="left">';
	html += '    <input type="text" name="pricefilter[' + pricefilter_row + '][order]" value="" class="form-control">';
	html += '  </td>';
	html += '  <td class="left">';
	html += '    <a onclick="$(\'#pricefilter-row' + pricefilter_row + '\').remove()" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></a>';
	html += '  </td>';
	html += '</tr>';

	$('#pricefilter table tbody').append(html);
}
//--></script>
  
  
</div>
<?php echo $footer; ?>
