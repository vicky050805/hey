<?php
// Customer Details Form with JSON Saving

$dataFile = __DIR__ . "/customers.json";

$name = "";
$city = "";
$pincode = "";
$phone = "";
$email = "";
$errors = [];
$success = "";

function clean($value) {
    return htmlspecialchars($value, ENT_QUOTES, "UTF-8");
}

// Display success message after redirect
if (isset($_GET["saved"]) && $_GET["saved"] == "1") {
    $success = "Customer details saved successfully!";
}

// Process form
if ($_SERVER["REQUEST_METHOD"] == "POST") {

    $name = trim($_POST["name"] ?? "");
    $city = trim($_POST["city"] ?? "");
    $pincode = trim($_POST["pincode"] ?? "");
    $phone = trim($_POST["phone"] ?? "");
    $email = trim($_POST["email"] ?? "");

    // Name validation
    if ($name == "") {
        $errors["name"] = "Name is required.";
    } elseif (!preg_match("/^[a-zA-Z ]+$/", $name)) {
        $errors["name"] = "Name must contain only letters and spaces.";
    }

    // City validation
    if ($city == "") {
        $errors["city"] = "City is required.";
    } elseif (!preg_match("/^[a-zA-Z ]+$/", $city)) {
        $errors["city"] = "City must contain only letters and spaces.";
    }

    // Pin code validation
    if ($pincode == "") {
        $errors["pincode"] = "Pin code is required.";
    } elseif (!preg_match("/^[0-9]{6}$/", $pincode)) {
        $errors["pincode"] = "Pin code must contain exactly 6 digits.";
    }

    // Phone validation
    if ($phone == "") {
        $errors["phone"] = "Phone number is required.";
    } elseif (!preg_match("/^[0-9]{10}$/", $phone)) {
        $errors["phone"] = "Phone number must contain exactly 10 digits.";
    }

    // Email validation
    if ($email == "") {
        $errors["email"] = "Email address is required.";
    } elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $errors["email"] = "Enter a valid email address.";
    }

    // Save details if there are no errors
    if (empty($errors)) {

        $customers = [];

        if (file_exists($dataFile)) {
            $json = file_get_contents($dataFile);
            $customers = json_decode($json, true) ?? [];
        }

        $customer = [
            "id" => uniqid("customer_"),
            "name" => $name,
            "city" => $city,
            "pincode" => $pincode,
            "phone" => $phone,
            "email" => $email,
            "created_at" => date("Y-m-d H:i:s")
        ];

        $customers[] = $customer;

        $saved = file_put_contents(
            $dataFile,
            json_encode($customers, JSON_PRETTY_PRINT),
            LOCK_EX
        );

        if ($saved !== false) {
            // Redirect to clear the form
            header("Location: index.php?saved=1");
            exit;
        } else {
            $errors["general"] = "Unable to save customer details.";
        }
    }
}
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Customer Details</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background: #f0f2f5;
            margin: 0;
            padding: 20px;
        }

        .container {
            max-width: 450px;
            margin: 30px auto;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15);
        }

        h2 {
            text-align: center;
            color: #222;
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-top: 15px;
            font-weight: bold;
            color: #333;
        }

        input {
            width: 100%;
            padding: 12px;
            margin-top: 6px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 15px;
        }

        input:focus {
            outline: none;
            border-color: #007bff;
        }

        .error {
            color: #d00000;
            font-size: 13px;
            margin-top: 5px;
        }

        .success {
            background: #d4edda;
            color: #155724;
            padding: 12px;
            border-radius: 6px;
            text-align: center;
            margin-bottom: 15px;
        }

        .general-error {
            color: #d00000;
            text-align: center;
            margin-bottom: 10px;
        }

        button {
            width: 100%;
            padding: 13px;
            margin-top: 25px;
            background: #007bff;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
        }

        button:hover {
            background: #0056b3;
        }
    </style>
</head>

<body>

<div class="container">

    <h2>Customer Details</h2>

    <?php if ($success != ""): ?>
        <div class="success">
            <?php echo clean($success); ?>
        </div>
    <?php endif; ?>

    <?php if (isset($errors["general"])): ?>
        <div class="general-error">
            <?php echo clean($errors["general"]); ?>
        </div>
    <?php endif; ?>

    <form method="POST" action="">

        <label for="name">Name:</label>
        <input type="text" id="name" name="name"
               placeholder="Enter your name"
               value="<?php echo clean($name); ?>">
        <?php if (isset($errors["name"])): ?>
            <div class="error"><?php echo clean($errors["name"]); ?></div>
        <?php endif; ?>

        <label for="city">City:</label>
        <input type="text" id="city" name="city"
               placeholder="Enter your city"
               value="<?php echo clean($city); ?>">
        <?php if (isset($errors["city"])): ?>
            <div class="error"><?php echo clean($errors["city"]); ?></div>
        <?php endif; ?>

        <label for="pincode">Pin Code:</label>
        <input type="text" id="pincode" name="pincode"
               placeholder="Enter 6-digit pin code"
               maxlength="6"
               value="<?php echo clean($pincode); ?>">
        <?php if (isset($errors["pincode"])): ?>
            <div class="error"><?php echo clean($errors["pincode"]); ?></div>
        <?php endif; ?>

        <label for="phone">Phone Number:</label>
        <input type="text" id="phone" name="phone"
               placeholder="Enter 10-digit phone number"
               maxlength="10"
               value="<?php echo clean($phone); ?>">
        <?php if (isset($errors["phone"])): ?>
            <div class="error"><?php echo clean($errors["phone"]); ?></div>
        <?php endif; ?>

        <label for="email">Email Address:</label>
        <input type="email" id="email" name="email"
               placeholder="Enter your email"
               value="<?php echo clean($email); ?>">
        <?php if (isset($errors["email"])): ?>
            <div class="error"><?php echo clean($errors["email"]); ?></div>
        <?php endif; ?>

        <button type="submit">Save Customer Details</button>

    </form>

</div>

</body>
</html>