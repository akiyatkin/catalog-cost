<?php
use infrajs\event\Event;

Event::handler('Catalog.option', function (&$param) {

	$opt = &$param['option'];
	$block = &$param['block'];
	if ($block['id'] != 'cost') return;

	$block['layout'] = 'cost';	

},'cost:range');
