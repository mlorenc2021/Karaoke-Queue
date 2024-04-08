<?php
// FILEPATH: /c:/Users/matth/OneDrive/Desktop/projects/Karaoke-Queue/src/index.php

//include login credentials
include("klogin.php");

//connect to database
try {
    $dsn = "mysql:host=courses;dbname=z1904531";
    $pdo = new PDO($dsn, $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    echo "Connection to database failed: " . $e->getMessage();
}

song_list();

function song_list()
{
    global $pdo;
    try {
        $orderby = " ORDER BY song_title ";
        if (isset($_GET['order_by']) && isset($_GET['sort'])) {
            $orderby = ' ORDER BY ' . $_GET['order_by'] . ' ' . $_GET['sort'];
        }
        // fetch rows
        $sql = "SELECT DISTINCT song_title, artist_name, year FROM Wrote 
            INNER JOIN Artist USING(artistid) 
            INNER JOIN Song USING(songid) 
            INNER JOIN Contribution USING(songid) " . $orderby;
        $result = $pdo->query($sql);
        $rows = $result->fetchAll(PDO::FETCH_ASSOC);
        echo "<table width='100%' id='emp_table' border='0'>";
        echo "<tr class='tr_header'>";
        echo "<th><a href='" . sortorder('song_title') . "' class='sort'>Song</a></th>";
        echo "<th><a href='" . sortorder('artist_name') . "' class='sort'>Artist</a></th>";
        echo "<th><a href='" . sortorder('year') . "' class='sort'>Year</a></th>";
        echo "</tr>";
        foreach ($rows as $row) {
            echo "<tr>";
            foreach ($row as $key => $item) {
                $id = $item;
                echo "<td align='center'>$id</td>";
            }
            echo "</tr>";
        }
        echo "</table>";
    } catch (PDOException $e) {
        echo "Connection to database failed: " . $e->getMessage();
    }
}

// generating orderby and sort url for table header
function sortorder($fieldname)
{
    $sorturl = "?order_by=" . $fieldname . "&sort=";
    $sorttype = "asc";
    if (isset($_GET['order_by']) && $_GET['order_by'] == $fieldname) {
        if (isset($_GET['sort']) && $_GET['sort'] == "asc") {
            $sorttype = "desc";
        }
    }
    $sorturl .= $sorttype;
    return $sorturl;
}

global $pdo;
echo <<<HTML
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>User Interface</title>
    <!-- <link rel="stylesheet" type="text/css" href="stylesheet/style.css" media="screen"> -->
</head>
<body>
    <div class="header">
        <a href="index.php" class="logo">User Interface</a>
        <a href="dj.php" class="logo">DJ Interface</a>
    </div>
    <form id="FrontPage" method="POST" action="select_song.php">
        <h4>Search for an Artist, Song, or Contributor</h4>
        <input class="search" type="search" name="searchresult" placeholder="By name or title">
        <input class="search" type="submit" value="Artist" name="artist" form="FrontPage">
        <input class="search" type="submit" value="Song" name="song" form="FrontPage">
        <input class="search" type="submit" value="Contributor" name="contributor" form="FrontPage">
    </form>
</body>
</html>
HTML;
?>
