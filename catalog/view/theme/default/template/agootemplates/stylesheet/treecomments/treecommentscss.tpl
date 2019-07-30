/* begin compile css treecomments */
<?php if (isset($css_compile) && !empty($css_compile)) { ?>
<?php  foreach ($css_compile as $stat_cmswidget => $stat_css) { ?>


<?php if (isset($stat_css['stat_color_background']) && $stat_css['stat_color_background']!='') { ?>

#cmswidget-<?php echo $stat_cmswidget; ?> .comment-stat  {
	    background: <?php echo $stat_css['stat_color_background']; ?> none repeat scroll 0 0;
}
<?php } ?>


<?php if (isset($stat_css['stat_color_main']) && $stat_css['stat_color_main']!='') { ?>

#cmswidget-<?php echo $stat_cmswidget; ?> .sc-stat-field {
	background-color: <?php echo $stat_css['stat_color_main']; ?>;
}

#cmswidget-<?php echo $stat_cmswidget; ?> .sc-stat-comments {
    background: <?php echo $stat_css['stat_color_main']; ?> none repeat scroll 0 0;
}

#cmswidget-<?php echo $stat_cmswidget; ?> .sc-stat-comments .sc-reviews-stat__corner {
    border-left-color: <?php echo $stat_css['stat_color_main']; ?>;
}
<?php } ?>



<?php if (isset($stat_css['stat_color_two']) && $stat_css['stat_color_two']!='') { ?>
#cmswidget-<?php echo $stat_cmswidget; ?> .sc-stat-answer {
    background: <?php echo $stat_css['stat_color_two']; ?> none repeat scroll 0 0;
}
#cmswidget-<?php echo $stat_cmswidget; ?> .sc-stat-answer .sc-reviews-stat__corner {
    border-left-color: <?php echo $stat_css['stat_color_two']; ?>;
}

<?php } ?>


<?php if (isset($stat_css['stat_color_three']) && $stat_css['stat_color_three']!='') { ?>
#cmswidget-<?php echo $stat_cmswidget; ?> .sc-stat-ratings {
    background: <?php echo $stat_css['stat_color_three']; ?> none repeat scroll 0 0;
}
#cmswidget-<?php echo $stat_cmswidget; ?> .sc-stat-ratings .sc-reviews-stat__corner {
    border-left-color: <?php echo $stat_css['stat_color_three']; ?>;
}
<?php } ?>

<?php if (isset($stat_css['stat_color_four']) && $stat_css['stat_color_four']!='') { ?>
#cmswidget-<?php echo $stat_cmswidget; ?> .sc-stat-good {
    background: <?php echo $stat_css['stat_color_four']; ?> none repeat scroll 0 0;
}
#cmswidget-<?php echo $stat_cmswidget; ?> .sc-stat-good .sc-reviews-stat__corner {
    border-left-color: <?php echo $stat_css['stat_color_four']; ?>;
}

<?php } ?>

<?php if (isset($stat_css['stat_color_five']) && $stat_css['stat_color_five']!='') { ?>
#cmswidget-<?php echo $stat_cmswidget; ?> .sc-stat-white {
    background: <?php echo $stat_css['stat_color_five']; ?> none repeat scroll 0 0;
}

<?php } ?>


<?php if (isset($stat_css['bbwidth']) && $stat_css['bbwidth']!='') { ?>
#cmswidget-<?php echo $stat_cmswidget; ?> .bbimage {
    width: <?php echo $stat_css['bbwidth']; ?>px;
}

<?php } ?>




<?php } ?>
<?php } ?>
/* end compile css treecomments */