<?php echo '<?xml version="1.0" encoding="UTF-8"?>'; ?>
<rss version="2.0"
xmlns:content="http://purl.org/rss/1.0/modules/content/"
xmlns:dc="http://purl.org/dc/elements/1.1/"
xmlns:media="http://search.yahoo.com/mrss/"
xmlns:atom="http://www.w3.org/2005/Atom"
xmlns:georss="http://www.georss.org/georss">
<channel>
<title><?php echo $heading_title." ".$config_name;?></title>
<link><?php echo $url_self; ?></link>
<description><?php if (htmlspecialchars(strip_tags(html_entity_decode($description, ENT_QUOTES, 'UTF-8'))) == '') echo $config_meta_description; else  echo htmlspecialchars(strip_tags(html_entity_decode($description, ENT_QUOTES, 'UTF-8'))) ; ?></description>
<language><?php echo $lang_iso_639_1; ?></language>
<atom:link href="<?php echo $url_rss; ?>" rel="self" type="application/rss+xml" />
<?php
	if (isset($records) && $records) {
		foreach ($records as $record) {
?>
<item>
<title><?php echo $record['name']; ?></title>
<link><?php echo $record['href']; ?></link>
<pdalink><?php echo $record['href']; ?></pdalink>
<guid><?php echo md5($record['record_id'].$record['href']); ?></guid>
<pubDate><?php echo date('D, j M Y H:i:s', strtotime($record['datetime_available']))." +0300?"; ?></pubDate>
<media:rating scheme="urn:simple">nonadult</media:rating>
<?php if ($record['author']) { ?><author><?php echo $record['author']; ?></author>
<?php } ?>
<category><?php echo $record['blog_name']; ?></category>
<?php if ($record['thumb']) {  ?>
<enclosure url="<?php echo $record['thumb']; ?>" type="image/<?php
if (substr(strrchr($record['thumb'], '.'), 1) == 'jpg') {
	echo 'jpeg';
} else {
	echo substr(strrchr($record['thumb'], '.'), 1);
}
?>"/>
<?php } ?>
<?php
if (!empty($record['images'])) {
foreach ($record['images'] as $num => $image) {
?>
<enclosure url="<?php echo $image['popup']; ?>" type="image/<?php
if (strtolower(substr(strrchr($image['popup'], '.'), 1)) == 'jpg') {
	echo 'jpeg';
} else {
	echo strtolower(substr(strrchr($image['popup'], '.'), 1));
}
?>"/>
<?php } } ?>
<description><![CDATA[<?php echo htmlspecialchars(strip_tags(html_entity_decode($record['description'], ENT_QUOTES, 'UTF-8'))) ; ?>]]></description>
<?php
if (isset($record['description_full']) && $record['description_full'] != '') {
	$record['description'] = $record['description_full'];
?>
<yandex:full-text><![CDATA[<?php echo htmlspecialchars(strip_tags(html_entity_decode($record['description'], ENT_QUOTES, 'UTF-8'))) ; ?>]]></yandex:full-text>
<?php } ?>
</item>

<?php
	}
}
?>
</channel>
</rss>