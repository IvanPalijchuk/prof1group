<!DOCTYPE html>
<!--[if IE]><![endif]-->
<!--[if IE 8 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie8"><![endif]-->
<!--[if IE 9 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<!--<![endif]-->
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title><?php echo $title; ?></title>
<base href="<?php echo $base; ?>" />
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content= "<?php echo $keywords; ?>" />
<?php } ?>
<script src="catalog/view/javascript/jquery/jquery-2.1.1.min.js" type="text/javascript"></script>
<link href="catalog/view/javascript/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen" />
<link href="catalog/view/theme/default/stylesheet/slick.css" rel="stylesheet">
<script src="catalog/view/javascript/slick.min.js" type="text/javascript"></script>
<script src="catalog/view/javascript/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<link href="catalog/view/javascript/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
<link href="//fonts.googleapis.com/css?family=Open+Sans:400,400i,300,700" rel="stylesheet" type="text/css" />
<link href="catalog/view/theme/default/stylesheet/stylesheet.css" rel="stylesheet">

<!-- Menu3rdLevel >>> -->
			<link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/menu3rdlevel/menu3rdlevel.css" />
<!-- <<< Menu3rdLevel -->
      
<?php foreach ($styles as $style) { ?>
<link href="<?php echo $style['href']; ?>" type="text/css" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>

<!-- Menu3rdLevel >>> -->
			<script type="text/javascript" src="catalog/view/javascript/menu3rdlevel/common.js"></script>
<!-- <<< Menu3rdLevel -->
      
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<?php foreach ($scripts as $script) { ?>
<script src="<?php echo $script; ?>" type="text/javascript"></script>
<?php } ?>
<?php foreach ($analytics as $analytic) { ?>
<?php echo $analytic; ?>
<?php } ?>
<script type="application/ld+json">
{
"@context": "http://schema.org",
"@type": "LocalBusiness",
"image":"https://prof1group.ua/image/catalog/prof1group.png", 
"priceRange":"$", 
"email": "Sale@prof1group.com",  

"name": "Военные магазины Prof1group",  
"openingHours":"Mo-Su 9:00-21:00", 
"telephone": "+380443928449",  
"openingHoursSpecification": [   
  {
  "@type": "OpeningHoursSpecification",
  "dayOfWeek": [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ],
  "opens": "9:00",
  "closes": "21:00"
  }
 ],
"address": { // адрес
  "@type": "PostalAddress",
  "addressCountry":"Украина", 
  "addressLocality": "Киев", 
  "postalCode":"04070" 
  }
}
</script>     
</head>
<body class="<?php echo $class; ?>">
  <div class="container" style="padding: 5px;color: red;font-weight: bold;text-align: center;"><?php echo $text_dangers; ?></div>
<nav id="top">
  <div class="container">
    <?php echo $currency; ?>
    <?php echo $language; ?>
    <div id="top-links" class="nav pull-right">
      <ul class="list-inline">
       
        <li class="dropdown"><a href="<?php echo $account; ?>" title="<?php echo $text_account; ?>" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i> <span class="hidden-xs hidden-sm hidden-md"><?php echo $text_account; ?></span> <span class="caret"></span></a>
          <ul class="dropdown-menu dropdown-menu-right">
            <?php if ($logged) { ?>
            <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
            <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
            <li><a href="<?php echo $transaction; ?>"><?php echo $text_transaction; ?></a></li>
            <li><a href="<?php echo $download; ?>"><?php echo $text_download; ?></a></li>
            <li><a href="<?php echo $logout; ?>"><?php echo $text_logout; ?></a></li>
            <?php } else { ?>
            <li><a href="<?php echo $register; ?>"><?php echo $text_register; ?></a></li>
            <li><a href="<?php echo $login; ?>"><?php echo $text_login; ?></a></li>
            <?php } ?>
          </ul>
        </li>
        <li><a href="<?php echo $wishlist; ?>" id="wishlist-total" title="<?php echo $text_wishlist; ?>"><i class="fa fa-heart"></i> <span class="hidden-xs hidden-sm hidden-md"><?php echo $text_wishlist; ?></span></a></li>
       <!-- <li><a href="<?php echo $checkout; ?>" title="<?php echo $text_checkout; ?>"><i class="fa fa-share"></i> <span class="hidden-xs hidden-sm hidden-md"><?php echo $text_checkout; ?></span></a></li> -->
      </ul>
    </div>
  </div>
</nav>
<header>
  <div class="container">
    <div class="row">
       <div class="col-xs-3 col-sm-2 col-md-1 col-lg-10">
          <div id="menu" class="navbar  topmenu"> 
            <button type="button" class="btn btn-navbar navbar-toggle menu__opnen"><i class="fa fa-bars"></i></button>
            <nav id='my--menu' class="collapse navbar-collapse navbar-ex11-collapse">
              <ul class="nav toppmenu navbar-nav">
                <li class="current-item"><a href="/"><?php echo $text_home; ?></a></li>
                <li class="dropdown"><a href="index.php?route=information/information&information_id=18"><?php echo $text_news; ?></a></li>
                <li class="dropdown"><a href="index.php?route=information/information&information_id=16"><?php echo $text_special; ?></a></li>
                <li class="dropdown"><a href="index.php?route=product/category&path=137004"><?php echo $text_productnews; ?></a></li>
                <li class="dropdown"><a href="index.php?route=product/manufacturer"><?php echo $text_brands; ?></a></li>
                <li class="dropdown"><a href="index.php?route=information/information&information_id=19"><?php echo $text_articles; ?></a></li>
                <li class="dropdown"><a href="index.php?route=information/information&information_id=14"><?php echo $text_stores; ?></a></li>
                <li class="dropdown"><a href="index.php?route=information/contact"><?php echo $text_contact; ?></a></li>
              </ul>
            </nav>
          </div>
       </div>
       <div class="hidden-md visible-lg-block col-lg-3" >
          <div id="logo">
            <?php if ($logo) { ?>
            <a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-responsive" /></a>
            <?php } else { ?>
            <h1><a href="<?php echo $home; ?>"><?php echo $name; ?></a></h1>
            <?php } ?>
          </div>
       </div>

       <div class="col-xs-6 col-sm-8 col-md-10 col-lg-5 search1"><?php echo $search; ?></div>

       <div class="col-xs-3 col-sm-2 col-md-1 col-lg-2 cart1"><?php echo $cart; ?></div>

        <div class="nomer hidden-md visible-lg-block col-lg-2">
          <ul>
            <li><a href="<?php echo $contact; ?>"><i class="fa fa-phone1"><img src="/catalog/view/theme/default/image/mobile1.jpg"></i></a> 
              <a href="tel:(044)392-84-49"><span class="hidden-xs hidden-sm hidden-md">(044) 392-84-49</span></a></li>
            <li><a href="<?php echo $contact; ?>"><i class="fa fa-phone1"><img src="/catalog/view/theme/default/image/Ikonka-MTS.png"></i></a> <a href="tel:+380668393660"><span class="hidden-xs hidden-sm hidden-md">(066) 839-36-60</span></a></li>
            <li><a href="<?php echo $contact; ?>"><i class="fa fa-phone1"><img src="/catalog/view/theme/default/image/life.png"></i></a><a href="tel:+380933254690"><span class="hidden-xs hidden-sm hidden-md">(093) 325-46-90</span></a></li>
            <li><a href="<?php echo $contact; ?>"><i class="fa fa-phone1"><img src="/catalog/view/theme/default/image/67696743.png"></i></a> <a href="tel:+380676595979"><span class="hidden-xs hidden-sm hidden-md">(067) 659-59-79</span></a></li>
            <li><a href="<?php echo $contact; ?>"><i class="fa fa-phone1">опт</i></a> <a href="tel:(044)392-84-50"><span class="hidden-xs hidden-sm hidden-md">(044) 392-84-50</span></a></li>
            <?php if(!empty($h_work)){ ?>
              <span style="float: right; font-size: 11px;"><?php echo $h_work; ?></span>
            <?php } ?>
          </ul>        
        </div>

    </div>

      <div class="row my-row">

          <div class="logo col-xs-12 col-sm-4 col-md-6">
            <?php if ($logo) { ?>
            <a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-responsive" /></a>
            <?php } else { ?>
            <h1><a href="<?php echo $home; ?>"><?php echo $name; ?></a></h1>
            <?php } ?>
          </div> 

          <div class="nomer col-sm-8 col-md-6 col-lg-2">
            <ul>
             <li><a href="<?php echo $contact; ?>"><i class="fa fa-phone1"><img src="/catalog/view/theme/default/image/mobile1.jpg"></i></a> 
                  <a href="tel:(044)392-84-49"><span class="hidden-xs hidden-sm hidden-md">( 0 4 4 )  3 9 2 - 8 4 - 4 9</span></a></li>
                <li><a href="<?php echo $contact; ?>"><i class="fa fa-phone1"><img src="/catalog/view/theme/default/image/Ikonka-MTS.png"></i></a> <a href="tel:+380668393660"><span class="hidden-xs hidden-sm hidden-md">( 0 6 6 )  8 3 9 - 3 6 - 6 0</span></a></li>
                <li><a href="<?php echo $contact; ?>"><i class="fa fa-phone1"><img src="/catalog/view/theme/default/image/life.png"></i></a><a href="tel:+380933254690"><span class="hidden-xs hidden-sm hidden-md">( 0 9 3 )  3 2 5 - 4 6 - 9 0</span></a></li>
                <li><a href="<?php echo $contact; ?>"><i class="fa fa-phone1"><img src="/catalog/view/theme/default/image/67696743.png"></i></a> <a href="tel:+380676595979"><span class="hidden-xs hidden-sm hidden-md">( 0 6 7 )  6 5 9 - 5 9 - 7 9</span></a></li>
                <li><a href="<?php echo $contact; ?>"><i class="fa fa-phone1">опт</i></a> <a href="tel:(044)392-84-50"><span class="hidden-xs hidden-sm hidden-md">( 0 4 4 )   3 9 2 - 8 4 - 5 0</span></a></li>
            </ul>
            <?php if(!empty($h_work)){ ?>
              <span class="span1" style="float: right;font-size: 11px;"><?php echo $h_work; ?></span>   
            <?php } ?>        
          </div>

      </div>
    </div>
</header>
<?php if ($categories) { ?>
<div class="container">
  <nav id="menu" class="navbar">
    <div class="navbar-header">
     <!-- <button type="button" class="btn btn-navbar navbar-toggle butonn" data-toggle="collapse" data-target=".navbar-ex1-collapse" style="width: -webkit-fill-available;margin: auto;height: 40px;"><span id="category" class="visible-xs"><?php echo $text_category; ?></span></button>-->
      <a class="btn btn-navbar navbar-toggle" href="index.php?route=product/catalog" style="width: -webkit-fill-available;margin: auto;height: 40px;font-size: 25px;">Каталог</a>
    </div>
    <div class="collapse navbar-collapse navbar-ex1-collapse">
      <ul class="nav navbar-nav">
        <?php foreach ($categories as $category) { ?>
        <?php if ($category['children']) { ?>
        <li class="dropdown"><a href="<?php echo $category['href']; ?>" class="dropdown-toggle" data-toggle="dropdown"><?php echo $category['name']; ?></a>
          <div class="dropdown-menu">
            <div class="dropdown-inner">
              <?php foreach (array_chunk($category['children'], ceil(count($category['children']) / $category['column'])) as $children) { ?>
              <ul class="list-unstyled">
                <?php foreach ($children as $child) { ?>
                
<?php // Menu3rdLevel >>> ?>
					<?php // isset check to work with another ext ?>
					<?php if (isset($child['children_lv3']) && $child['children_lv3']) { ?>
                		<li><a class="arrow" href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?></a>
                        	<div class="menu3rdlevel">
            					<div class="menu3rdlevel_inner">
              						<?php foreach (array_chunk($child['children_lv3'], ceil(count($child['children_lv3']) / $child['column'])) as $children_lv3) { ?>
              							<ul class="list-unstyled">
                							<?php foreach ($children_lv3 as $child_lv3) { ?>
                                            	<li><a href="<?php echo $child_lv3['href']; ?>"><?php echo $child_lv3['name']; ?></a></li>
                        					<?php } ?>
                                       	</ul>
                                 	<?php } ?>
                           		</div>
                                <a href="<?php echo $child['href']; ?>" class="see-all"><?php echo $text_all; ?> <?php echo $child['name']; ?></a>
                           	</div>
                        </li>
                   	<?php } else { ?>
                    	<li><a href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?></a></li>
                  	<?php } ?>
<?php // <<<Menu3rdLevel ?>
      
                <?php } ?>
              </ul>
              <?php } ?>
            </div>
            <a href="<?php echo $category['href']; ?>" class="see-all"><?php echo $text_all; ?> <?php echo $category['name']; ?></a> </div>
        </li>
        <?php } else { ?>
        <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
        <?php } ?>
        <?php } ?>
      </ul>
    </div>
  </nav>
</div>
<?php } ?>
<script>
  $('.menu__opnen').click(function(e){
  	e.preventDefault();
		$('html').one('click', function(){
			if (!$(event.target).closest("#my--menu").length) {
			 		 $('#my--menu').removeClass('block');
			 	}
    });
     e.stopPropagation();
  			$('#my--menu').toggleClass('block');
  	// 		 $(document).mouseup(function (e){
			// 	var div = $("#my--menu");
			// 	if (!div.is(e.target)
			// 	    && div.has(e.target).length === 0) {
			// 		div.removeClass("block");
			// 	}
			// });
    });
</script>