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
    <title>DJ Interface</title>
    <!-- <link rel="stylesheet" type="text/css" href="stylesheet/style.css" media="screen"> -->
</head>
<body>
<div class="header">
    <a href="index.php" class="logo">User Interface</a>
    <a href="dj.php" class="logo">DJ Interface</a>
</div>
HTML;

priority();
regular();

//display priority queue
function priority()
{
    global $pdo;
    try {
        $orderPriority = " ORDER BY pqid ";
        if (isset($_GET['order_by']) && isset($_GET['sort'])) {
            $orderPriority = ' ORDER BY ' . $_GET['order_by'] . ' ' . $_GET['sort'];
        }

        $sql = "SELECT pq.pqid, pr.user_name Names, ks.kfid Karaokes, ks.file_version Versions, concat('$', pq.amount_paid) Amount, s.song_title Titles, a.artist_name Artists, pq.time Time
        FROM PriorityRequest pr, PriorityQueue pq, KaraokeSong ks, Song s, Artist a, Wrote w
        WHERE pr.kfid = ks.kfid AND pq.pqid = pr.pqid AND w.songid = s.songid AND w.artistid = a.artistid AND ks.songid = s.songid " . $orderPriority;

        $rs = $pdo->query($sql);
        $rows = $rs->fetchAll(PDO::FETCH_ASSOC);

        echo '<h3><u>PRIORITY QUEUE</u></h3>';
        echo '<table width="100%" id="emp_table" border="0">';
        echo '<tr class="tr_header">';
        echo '<th><a href="' . sortorderPq('pqid') . '" class="sort">pqid</a></th>';
        echo '<th><a href="' . sortorderPq('user_name') . '" class="sort">Name</a></th>';
        echo '<th><a href="' . sortorderPq('ks.kfid') . '" class="sort">Karaoke</a></th>';
        echo '<th><a href="' . sortorderPq('file_version') . '" class="sort">Version</a></th>';
        echo '<th><a href="' . sortorderPq('amount_paid') . '" class="sort">Paid</a></th>';
        echo '<th><a href="' . sortorderPq('song_title') . '" class="sort">Title</a></th>';
        echo '<th><a href="' . sortorderPq('artist_name') . '" class="sort">Artist</a></th>';
        echo '<th><a href="' . sortorderPq('time') . '" class="sort">Time</a></th>';
        echo '</tr>';

        foreach ($rows as $row) {
            echo "<tr>";
            foreach ($row as $key => $item) {
                $id = $item;
                echo "<td align='center'>$id</td>";
            }
            echo "</tr>";
        }
        echo "</table>";
        echo '<br></br>';
    } catch (PDOException $e) {
        echo "Connection to database failed: " . $e->getMessage();
    }
}

//display regular queue
function regular()
{
    global $pdo;
    try {
        $orderRegular = " ORDER BY rqid ";
        if (isset($_GET['order_byRq']) && isset($_GET['sortRq'])) {
            $orderRegular = ' ORDER BY ' . $_GET['order_byRq'] . ' ' . $_GET['sortRq'];
        }

        $sql = "SELECT rq.rqid, rr.user_name Names, ks.kfid Karaokes, ks.file_version Versions, s.song_title Titles, a.artist_name Artists, rq.time Time
        FROM RegularRequest rr, RegularQueue rq, KaraokeSong ks, Song s, Artist a, Wrote w
        WHERE rr.kfid = ks.kfid AND rq.rqid = rr.rqid AND w.songid = s.songid AND w.artistid = a.artistid AND ks.songid = s.songid " . $orderRegular;

        $rs = $pdo->query($sql);
        $rows = $rs->fetchAll(PDO::FETCH_ASSOC);

        echo '<h3><u>REGULAR QUEUE</u></h3>';
        echo '<table width="100%" id="emp_table" border="0">';
        echo '<tr class="tr_header">';
        echo '<th><a href="' . sortorderRq('rqid') . '" class="sortRq">rqid</a></th>';
        echo '<th><a href="' . sortorderRq('user_name') . '" class="sortRq">Name</a></th>';
        echo '<th><a href="' . sortorderRq('ks.kfid') . '" class="sortRq">Karaoke</a></th>';
        echo '<th><a href="' . sortorderRq('file_version') . '" class="sortRq">Version</a></th>';
        echo '<th><a href="' . sortorderRq('song_title') . '" class="sortRq">Title</a></th>';
        echo '<th><a href="' . sortorderRq('artist_name') . '" class="sortRq">Artist</a></th>';
        echo '<th><a href="' . sortorderRq('time') . '" class="sortRq">Time</a></th>';
        echo '</tr>';

        foreach ($rows as $row) {
            echo "<tr>";
            foreach ($row as $key => $item) {
                $id = $item;
                echo "<td align='center'>$id</td>";
            }
            echo "</tr>";
        }
        echo "</table>";
        echo '<br></br>';
    } catch (PDOException $e) {
        echo "Connection to database failed: " . $e->getMessage();
    }
}

// generating orderby and sort url for table header
function sortorderPq($fieldname)
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

function sortorderRq($fieldname)
{
    $sorturl = "?order_byRq=" . $fieldname . "&sortRq=";
    $sorttype = "asc";
    if (isset($_GET['order_byRq']) && $_GET['order_byRq'] == $fieldname) {
        if (isset($_GET['sortRq']) && $_GET['sortRq'] == "asc") {
            $sorttype = "desc";
        }
    }
    $sorturl .= $sorttype;
    return $sorturl;
}

echo <<<HTML
        </form>
    </body>
</html>
HTML;
?>