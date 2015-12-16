<?php

// EVE SDE table name
$eve_dump = 'eve_carnyx';

try {
    $mysql = new PDO(
        'mysql:host=db;dbname=tripwire;charset=utf8',
        'tripwire',
        'weaknesspays',
        Array(
            PDO::ATTR_PERSISTENT     => true
        )
    );
} catch (PDOException $error) {
    echo 'DB error';//$error;
    var_dump($error);
}
