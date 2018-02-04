<?php
use infrajs\config\Config;
use infrajs\catalog\Catalog;
use infrajs\sequence\Sequence;

$r = ['-catalog-cost/layout.tpl','catalog-cost']; //Способ передать переменную без создания ссылки
Sequence::add(Catalog::$conf['dependencies'],[],$r[1]); //Добавлена массив в конфиг текущей сессии установки
Sequence::add(Catalog::$conf['filterstpl'],[],$r[0]);


Sequence::set(Config::$sys, ['catalog','dependencies'], Catalog::$conf['dependencies']); //Сохранено в sys конфиг для появления и в обычной сессии
Sequence::set(Config::$sys, ['catalog','filterstpl'], Catalog::$conf['filterstpl']);
