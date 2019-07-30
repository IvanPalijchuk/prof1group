<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-account" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
        <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-account" class="form-horizontal">
  <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit_h; ?></h3>
      </div>
      <div class="panel-body">
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status"><?php echo $text_h_text_string; ?></label>
            <div class="col-sm-10">
                <?php foreach ($languages as $language) { ?>
                <li style="list-style-type: none;"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></li>
                <input type="text" name="red_string[<?php echo $language['language_id']; ?>]" value="<?php echo isset($red_string[$language['language_id']]) ? $red_string[$language['language_id']] : ''; ?>" placeholder="<?php echo $text_h_text_string; ?>" class="form-control" />
                <?php } ?>             
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status"><?php echo $text_h_work; ?></label>
            <div class="col-sm-10">
                <?php foreach ($languages as $language) { ?>
                <li style="list-style-type: none;"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></li>
                <input type="text" name="h_work[<?php echo $language['language_id']; ?>]" value="<?php echo isset($h_work[$language['language_id']]) ? $h_work[$language['language_id']] : ''; ?>" placeholder="<?php echo $text_h_work; ?>" class="form-control" />
                <?php } ?>             
            </div>
          </div>
      </div>     
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
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit_f; ?></h3>
      </div>
      <div class="panel-body">
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status"><?php echo $adress_poligon; ?></label>
            <div class="col-sm-10">
            	<span style="font-weight: bold;"><?php echo $text_name_store; ?></span>
                <?php foreach ($languages as $language) { ?>
                <li style="list-style-type: none;"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></li>
                <input type="text" name="polygon[<?php echo $language['language_id']; ?>]['name']" value="<?php echo isset($polygon[$language['language_id']]) ? $polygon[$language['language_id']]["'name'"] : ''; ?>" placeholder="<?php echo $text_name_store; ?>" class="form-control" />
                <?php } ?>
                <span style="font-weight: bold;"><?php echo $text_adress_store; ?></span>
                <?php foreach ($languages as $language) { ?>
                <li style="list-style-type: none;"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></li>
                <input type="text" name="polygon[<?php echo $language['language_id']; ?>]['adress']" value="<?php echo isset($polygon[$language['language_id']]) ? $polygon[$language['language_id']]["'adress'"] : ''; ?>" placeholder="<?php echo htmlspecialchars($text_adress_store); ?>" id="input-name<?php echo $language['language_id']; ?>" class="form-control" />
                <?php } ?> 
                <span style="font-weight: bold;"><?php echo $h_work_store; ?></span>
                <?php foreach ($languages as $language) { ?>
                <li style="list-style-type: none;"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></li>
                <input type="text" name="polygon[<?php echo $language['language_id']; ?>]['work']" value="<?php echo isset($polygon[$language['language_id']]) ? $polygon[$language['language_id']]["'work'"] : ''; ?>" placeholder="<?php echo $h_work_store; ?>" id="input-name<?php echo $language['language_id']; ?>" class="form-control" />
                <?php } ?> 
                <span style="font-weight: bold;"><?php echo $sorted_store; ?></span>
                <input type="number" min="0" name="polygon['sorted']" value="<?php echo isset($polygon['sorted']) ? $polygon['sorted'] : '0'; ?>" id="input-name<?php echo $language['language_id']; ?>" class="form-control" />             
            </div>
          </div>        
      </div>
      <div class="panel-body">
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status"><?php echo $adress_rekrut; ?></label>
            <div class="col-sm-10">
            	<span style="font-weight: bold;"><?php echo $text_name_store; ?></span>
                <?php foreach ($languages as $language) { ?>
                <li style="list-style-type: none;"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></li>
                <input type="text" name="rekrut[<?php echo $language['language_id']; ?>]['name']" value="<?php echo isset($rekrut[$language['language_id']]) ? $rekrut[$language['language_id']]["'name'"] : ''; ?>" placeholder="<?php echo $text_name_store; ?>" class="form-control" />
                <?php } ?>
                <span style="font-weight: bold;"><?php echo $text_adress_store; ?></span>
                <?php foreach ($languages as $language) { ?>
                <li style="list-style-type: none;"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></li>
                <input type="text" name="rekrut[<?php echo $language['language_id']; ?>]['adress']" value="<?php echo isset($rekrut[$language['language_id']]) ? $rekrut[$language['language_id']]["'adress'"] : ''; ?>" placeholder="<?php echo htmlspecialchars($text_adress_store); ?>" id="input-name<?php echo $language['language_id']; ?>" class="form-control" />
                <?php } ?> 
                <span style="font-weight: bold;"><?php echo $h_work_store; ?></span>
                <?php foreach ($languages as $language) { ?>
                <li style="list-style-type: none;"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></li>
                <input type="text" name="rekrut[<?php echo $language['language_id']; ?>]['work']" value="<?php echo isset($rekrut[$language['language_id']]) ? $rekrut[$language['language_id']]["'work'"] : ''; ?>" placeholder="<?php echo $h_work_store; ?>" id="input-name<?php echo $language['language_id']; ?>" class="form-control" />
                <?php } ?> 
                <span style="font-weight: bold;"><?php echo $sorted_store; ?></span>
                <input type="number" min="0" name="rekrut['sorted']" value="<?php echo isset($rekrut['sorted']) ? $rekrut['sorted'] : '0'; ?>" id="input-name<?php echo $language['language_id']; ?>" class="form-control" />             
            </div>
          </div>        
      </div>
      <div class="panel-body">
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status"><?php echo $adress_tochka; ?></label>
            <div class="col-sm-10">
            	<span style="font-weight: bold;"><?php echo $text_name_store; ?></span>
                <?php foreach ($languages as $language) { ?>
                <li style="list-style-type: none;"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></li>
                <input type="text" name="tochka[<?php echo $language['language_id']; ?>]['name']" value="<?php echo isset($tochka[$language['language_id']]) ? $tochka[$language['language_id']]["'name'"] : ''; ?>" placeholder="<?php echo $text_name_store; ?>" class="form-control" />
                <?php } ?>
                <span style="font-weight: bold;"><?php echo $text_adress_store; ?></span>
                <?php foreach ($languages as $language) { ?>
                <li style="list-style-type: none;"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></li>
                <input type="text" name="tochka[<?php echo $language['language_id']; ?>]['adress']" value="<?php echo isset($tochka[$language['language_id']]) ? $tochka[$language['language_id']]["'adress'"] : ''; ?>" placeholder="<?php echo htmlspecialchars($text_adress_store); ?>" id="input-name<?php echo $language['language_id']; ?>" class="form-control" />
                <?php } ?> 
                <span style="font-weight: bold;"><?php echo $h_work_store; ?></span>
                <?php foreach ($languages as $language) { ?>
                <li style="list-style-type: none;"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></li>
                <input type="text" name="tochka[<?php echo $language['language_id']; ?>]['work']" value="<?php echo isset($tochka[$language['language_id']]) ? $tochka[$language['language_id']]["'work'"] : ''; ?>" placeholder="<?php echo $h_work_store; ?>" id="input-name<?php echo $language['language_id']; ?>" class="form-control" />
                <?php } ?> 
                <span style="font-weight: bold;"><?php echo $sorted_store; ?></span>
                <input type="number" min="0" name="tochka['sorted']" value="<?php echo isset($tochka['sorted']) ? $tochka['sorted'] : '0'; ?>" id="input-name<?php echo $language['language_id']; ?>" class="form-control" />             
            </div>
          </div>        
      </div>
      <div class="panel-body">
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status"><?php echo $adress_forest; ?></label>
            <div class="col-sm-10">
            	<span style="font-weight: bold;"><?php echo $text_name_store; ?></span>
                <?php foreach ($languages as $language) { ?>
                <li style="list-style-type: none;"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></li>
                <input type="text" name="forest[<?php echo $language['language_id']; ?>]['name']" value="<?php echo isset($forest[$language['language_id']]) ? $forest[$language['language_id']]["'name'"] : ''; ?>" placeholder="<?php echo $text_name_store; ?>" class="form-control" />
                <?php } ?>
                <span style="font-weight: bold;"><?php echo $text_adress_store; ?></span>
                <?php foreach ($languages as $language) { ?>
                <li style="list-style-type: none;"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></li>
                <input type="text" name="forest[<?php echo $language['language_id']; ?>]['adress']" value="<?php echo isset($forest[$language['language_id']]) ? $forest[$language['language_id']]["'adress'"] : ''; ?>" placeholder="<?php echo htmlspecialchars($text_adress_store); ?>" id="input-name<?php echo $language['language_id']; ?>" class="form-control" />
                <?php } ?> 
                <span style="font-weight: bold;"><?php echo $h_work_store; ?></span>
                <?php foreach ($languages as $language) { ?>
                <li style="list-style-type: none;"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></li>
                <input type="text" name="forest[<?php echo $language['language_id']; ?>]['work']" value="<?php echo isset($forest[$language['language_id']]) ? $forest[$language['language_id']]["'work'"] : ''; ?>" placeholder="<?php echo $h_work_store; ?>" id="input-name<?php echo $language['language_id']; ?>" class="form-control" />
                <?php } ?> 
                <span style="font-weight: bold;"><?php echo $sorted_store; ?></span>
                <input type="number" min="0" name="forest['sorted']" value="<?php echo isset($forest['sorted']) ? $forest['sorted'] : '0'; ?>" id="input-name<?php echo $language['language_id']; ?>" class="form-control" />             
            </div>
          </div>        
      </div>
      <div class="panel-body">
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status"><?php echo $text_f_work; ?></label>
            <div class="col-sm-10">
                <?php foreach ($languages as $language) { ?>
                <li style="list-style-type: none;"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></li>
                <input type="text" name="f_work[<?php echo $language['language_id']; ?>]" value="<?php echo isset($f_work[$language['language_id']]) ? $f_work[$language['language_id']] : ''; ?>" placeholder="<?php echo $text_f_work; ?>" class="form-control" />
                <?php } ?>             
            </div>
          </div>
      </div>
    </div>
  </div>  
  </form>
</div>
<?php echo $footer; ?>