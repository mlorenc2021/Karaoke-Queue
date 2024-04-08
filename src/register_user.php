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
    <title>Register User</title>
    <!-- <link rel="stylesheet" type="text/css" href="stylesheet/style.css" media="screen"> -->
</head>
<body>
<div class="header">
    <a href="index.php" class="logo">User Interface</a>
    <a href="dj.php" class="logo">DJ Interface</a>
</div>
HTML;

//check for user input
if (empty($_POST["name"])) {
    echo '<h4><a href="index.php">EMPTY ENTRY TRY AGAIN</a></h4>';
} else if (!empty($_POST["name"])) {
    //insert form data if priority or regular
    if (isset($_POST["priority"])) {
        $time = date("g:i a");
        $insertion = "INSERT INTO PriorityQueue (amount_paid, time) VALUES(:apaid, :time);";
        $stmt = $pdo->prepare($insertion, array(PDO::FETCH_ASSOC));
        $stmt->execute(array(':apaid' => $_POST["amount"], ':time' => $time));

        //get last insert id
        $lastid = $pdo->lastInsertId();

        $insertion = "INSERT INTO PriorityRequest (pqid, user_name, kfid) VALUES(:pqid, :uname, :kfid);";
        $stmt = $pdo->prepare($insertion, array(PDO::FETCH_ASSOC));
        $stmt->execute(array(':pqid' => $lastid, ':uname' => $_POST["name"], ':kfid' => $_POST["kfid"]));

        echo '<h4><a href="dj.php">You have been registered for Priority Queue</a></h4>';
    } else if (isset($_POST["regular"])) {
        $time = date("g:i a");
        $insertion = "INSERT INTO RegularQueue (time) VALUES(:time);";
        $stmt = $pdo->prepare($insertion, array(PDO::FETCH_ASSOC));
        $stmt->execute(array(':time' => $time));

        //get last insert id
        $lastid = $pdo->lastInsertId();

        $insertion = "INSERT INTO RegularRequest (rqid, user_name, kfid) VALUES(:rqid, :uname, :kfid);";
        $stmt = $pdo->prepare($insertion, array(PDO::FETCH_ASSOC));
        $stmt->execute(array(':rqid' => $lastid, ':uname' => $_POST["name"], ':kfid' => $_POST["kfid"]));

        echo '<h4><a href="dj.php">You have been registered for Regular Queue</a></h4>';
    }
}

echo <<<HTML
</form>
</body>
</html>
HTML;
?>