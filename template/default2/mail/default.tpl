<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?php echo $message["subject"];?></title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .container {
            width: 100%;
            max-width: 600px;
            margin: 20px auto;
            background: #ffffff;
            padding: 20px;
            border-radius: 3px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .header {
            background: #0073e6;
            color: white;
            text-align: center;
            padding: 10px 0;
            font-size: 20px;
            font-weight: bold;
            border-radius: 8px 8px 0 0;
        }
        .content {
            padding: 20px;
            font-size: 16px;
            color: #333;
        }
        .footer {
            text-align: center;
            padding: 10px;
            font-size: 14px;
            color: #666;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header"><?php echo $message["subject"];?></div>
    <div class="content">
        <?php echo $message["content"];?>

    </div>
    <div class="footer">&copy; <?php echo date("Y");?> Все права защищены</div>
</div>
</body>
</html>
