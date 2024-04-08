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
    <title>Submit Song</title>
    <!-- <link rel="stylesheet" type="text/css" href="stylesheet/style.css" media="screen"> -->
</head>
<body>
    <div class="header">
        <a href="http://students.cs.niu.edu/~z1904531/karaokeproject/userinterface.php" class="logo">User Interface</a>
        <a href="http://students.cs.niu.edu/~z1904531/karaokeproject/djinterface.php" class="logo">DJ Interface</a>
    </div>
HTML;

//create register user form
echo '<form id="RegisterForm" action="registeruser.php" method="POST">';

//check for user input
if ($_POST["songchoice"] == " ") {
    echo '<h4><a href="http://students.cs.niu.edu/~z1904531/karaokeproject/userinterface.php">EMPTY ENTRY TRY AGAIN</a></h4>';
} elseif ($_POST["songchoice"]) {
    //pass kfid into register form to be inserted into database where kfid is the selected
    //song title and its corresponding kfid from the previous page
    echo '<input type="hidden" name="kfid" value="' . $_POST["songchoice"] . '">';

    //if user chose priority input name and amount to pay
    if (isset($_POST["priority"])) {
        echo 'Enter your name: <input type="text" name="name">';
        echo 'Enter amount: <input type="text" name="amount">';
        echo '<input type="submit" name="priority" value="Register" form="RegisterForm">';
    } elseif (isset($_POST["regular"])) {
        echo 'Enter your name: <input type="text" name="name">';
        echo '<input type="submit" name="regular" value="Register" form="RegisterForm">';
    }

    //DISPLAY SELECTED SONG INFO

    //QUERY FOR SONG, TITLE, ARTIST, YEAR AND KARAOKE VERSION
    $sql = 'SELECT s.song_title Title, a.artist_name Artist, s.year Years, ks.file_version Versions
    FROM Song s, Artist a, KaraokeSong ks, Wrote w
    WHERE w.artistid = a.artistid AND w.songid = s.songid AND ks.songid = s.songid AND ks.kfid = "' . $_POST["songchoice"] . '";';

    $rs = $pdo->query($sql);
    $rows = $rs->fetchAll(PDO::FETCH_ASSOC);
    echo "<h3><u>Song Info</u></3>";
    draw_table($rows);

    //QUERY FOR CONTRIBUTORS AND THEIR CONTRIBUTIONS TO SONG
    $sql = 'SELECT cr.contributor_name AS Names, cn.contributor_type AS Types
    FROM Contributor cr, Contribution cn, KaraokeSong ks
    WHERE cr.contributorid = cn.contributorid AND cn.songid = ks.songid AND ks.kfid = "' . $_POST["songchoice"] . '"';

    $rs = $pdo->query($sql);
    $rows = $rs->fetchAll(PDO::FETCH_ASSOC);
    echo "<h3><u>Contributor Info</u></3>";
    draw_table($rows);
}

function draw_table($rows)
{
    if (empty($rows)) {
        echo "<p>No results found </p>";
    } else {
        echo "<table class=center border=1 cellspacing=1>";
        echo "<tr>";
        foreach ($rows[0] as $key => $item) {
            echo "<th><i><u>$key</i></u></th>";
        }
        echo "</tr>";
        foreach ($rows as $row) {
            echo "<tr>";
            foreach ($row as $key => $item) {
                echo "<td>$item</td>";
            }
            echo "</tr>";
        }
        echo "</table>";
    }
}

echo <<<HTML
        </form>
    </body>
</html>
HTML;
?>