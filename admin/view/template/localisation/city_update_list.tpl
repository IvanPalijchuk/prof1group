<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
	  <img src="https://webmakers.com.ua/wp-content/uploads/image/nova-poshta.png" alt="Новая почта" title="Новая почта" style="height: 36px; margin-right: 20px; ">
	  <a href="<?php echo $back; ?>" data-toggle="tooltip" title="<?php echo $button_back; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
      </div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $text_success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
  </div>
</div>

<?php echo $footer; ?>
