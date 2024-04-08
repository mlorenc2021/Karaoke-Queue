<?php
//include login credentials
include("klogin.php");

//CONNECT TO DATABASE AND CREATE PDO OBJECT
try {
    $dsn = "mysql:host=courses;dbname=z1904531";
    $pdo = new PDO($dsn, $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    echo "Connection to database failed: " . $e->getMessage();
}

//WEBPAGE HEADER
echo <<<HTML
<!DOCTYPE html>
<html>
<head>
    <title>Select Song</title>
    <!-- <link rel="stylesheet" type="text/css" href="stylesheet/style.css" media="screen"> -->
</head>
<body>
    <div class="header">
        <a href="index.php" class="logo">User Interface</a>
        <a href="dj.php" class="logo">DJ Interface</a>
    </div>
HTML;

//check if user entered input in search box
if (!empty($_POST['searchresult'])) {
    //user search input is passed as variable
    echo '<form id="SearchForm" action="songselection.php" method="POST">
    <input type="hidden" name="searchresult" value="' . $_POST['searchresult'] . '">
    </form>

    <form id="SubmitForm" action="submit_song.php" method="POST">';

    //set up queries based on whether user searched for artist name, song title, or contributor name
    if (isset($_POST["artist"])) {
        $sql = "SELECT ks.kfid, s.songid, a.artistid, a.artist_name, s.song_title
        FROM Wrote w, Artist a, Song s, KaraokeSong ks 
        WHERE ks.songid = s.songid AND w.artistid = a.artistid AND w.songid = s.songid AND a.artist_name LIKE ?;";
    } else if (isset($_POST["song"])) {
        $sql = "SELECT ks.kfid, s.songid, a.artistid, a.artist_name, s.song_title
        FROM Wrote w, Artist a, Song s, KaraokeSong ks 
        WHERE ks.songid = s.songid AND w.artistid = a.artistid AND w.songid = s.songid AND s.song_title LIKE ?;";
    } else if (isset($_POST["contributor"])) {
        $sql = "SELECT ks.kfid, s.song_title, s.songid, cn.contributorid, cr.contributorid
        FROM Contributor cr, Contribution cn, Song s, KaraokeSong ks
        WHERE ks.songid = s.songid AND cn.songid = s.songid AND cn.contributorid = cr.contributorid AND cr.contributor_name LIKE ?;";
    }

    //fetch result set
    $rows = $pdo->prepare($sql, array(PDO::FETCH_ASSOC));
    $rows->execute(array("%{$_POST['searchresult']}%"));

    //display list of songs
    echo 'Choose a Song: ';

    //display dropdown and allow user input
    echo '<select name="songchoice" id="songchoice">';
    echo '<option value=" "></option>';
    foreach ($rows as $row) {
        echo '<option value="' . $row['kfid'] . '">' . $row['song_title'] . ' </option>';
    }
    echo '</select>';
    echo '<input type="submit" name="priority" value="Priority Queue" form="SubmitForm">';
    echo '<input type="submit" name="regular" value="Regular Queue" form="SubmitForm">';

    echo "<br><br><br></br></br></br>";
} else {
    echo '<h4><a href="index.php">EMPTY SEARCH TRY AGAIN</a></h4>';
}
echo <<<HTML
        </form>
    </body>
</html>
HTML;
?>
