<?php
use infrajs\event\Event;

Event::handler('Catalog.option', function (&$param) {

	$opt = &$param['option'];
	$block = &$param['block'];
	if ($block['id'] != 'cost') return;
	if ($block['type'] != 'number') return;
	if ($block['layout'] != 'range') return;

	$block['layout'] = 'cost';	

},'cost:range');
