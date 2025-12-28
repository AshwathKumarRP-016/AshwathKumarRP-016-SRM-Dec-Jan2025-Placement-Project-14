<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>JSP Discount Calculator</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            max-width: 700px;
            margin: 40px auto;
            padding: 20px;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
        }
        .container {
            background-color: white;
            border-radius: 12px;
            padding: 40px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.15);
        }
        h1 {
            color: #2c3e50;
            text-align: center;
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 3px solid #3498db;
        }
        .form-group {
            margin-bottom: 25px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #34495e;
            font-size: 16px;
        }
        input[type="number"] {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #ddd;
            border-radius: 6px;
            box-sizing: border-box;
            font-size: 16px;
            transition: border-color 0.3s;
        }
        input[type="number"]:focus {
            border-color: #3498db;
            outline: none;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
        }
        .btn {
            background: linear-gradient(to right, #3498db, #2980b9);
            color: white;
            padding: 14px 25px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            width: 100%;
            font-size: 18px;
            font-weight: 600;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
        }
        .btn:hover {
            background: linear-gradient(to right, #2980b9, #1c5a7a);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(52, 152, 219, 0.3);
        }
        .result-card {
            margin-top: 40px;
            padding: 30px;
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            border-radius: 10px;
            border-left: 5px solid #2ecc71;
            display: none;
        }
        .result-card.show {
            display: block;
            animation: fadeIn 0.5s ease;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .result-header {
            color: #27ae60;
            margin-top: 0;
            font-size: 24px;
        }
        .calculation-row {
            display: flex;
            justify-content: space-between;
            margin: 15px 0;
            padding: 15px;
            background: white;
            border-radius: 6px;
            border: 1px solid #e0e0e0;
        }
        .calculation-label {
            color: #7f8c8d;
            font-weight: 500;
        }
        .calculation-value {
            font-weight: 700;
            color: #2c3e50;
        }
        .final-price {
            font-size: 28px;
            color: #e74c3c;
            font-weight: 800;
            text-align: center;
            margin: 20px 0;
            padding: 20px;
            background: white;
            border-radius: 8px;
            border: 2px dashed #e74c3c;
        }
        .discount-badge {
            display: inline-block;
            background: #e74c3c;
            color: white;
            padding: 5px 15px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 14px;
            margin-left: 10px;
        }
        .error-message {
            color: #e74c3c;
            margin-top: 10px;
            font-weight: 600;
            padding: 12px;
            background: #ffeaea;
            border-radius: 6px;
            border-left: 4px solid #e74c3c;
            display: none;
        }
        .info-box {
            margin-top: 40px;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 8px;
            font-size: 14px;
            color: #5a6c7d;
            border-top: 3px solid #3498db;
        }
        .info-title {
            color: #3498db;
            margin-top: 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🛒 Discount Calculator</h1>
        
        <form method="post">
            <div class="form-group">
                <label for="price">Original Price ($):</label>
                <input type="number" id="price" name="price" step="0.01" min="0" placeholder="Enter original price" required>
            </div>
            
            <div class="form-group">
                <label for="discount">Discount Percentage (%):</label>
                <input type="number" id="discount" name="discount" step="0.01" min="0" max="100" placeholder="Enter discount percentage" required>
            </div>
            
            <button type="submit" class="btn">Calculate Final Price</button>
        </form>
        
        <div id="errorMessage" class="error-message"></div>
        
        <%
            
            String priceStr = request.getParameter("price");
            String discountStr = request.getParameter("discount");
            double price = 0, discount = 0, finalPrice = 0, discountAmount = 0;
            boolean hasResult = false;
            String error = null;
            
           
            if (priceStr != null && discountStr != null && 
                !priceStr.isEmpty() && !discountStr.isEmpty()) {
                try {
                   
                    price = Double.parseDouble(priceStr);
                    discount = Double.parseDouble(discountStr);
                    
                    
                    if (price < 0) {
                        error = "Price cannot be negative.";
                    } else if (discount < 0 || discount > 100) {
                        error = "Discount must be between 0% and 100%.";
                    } else {
                        
                        discountAmount = price * discount / 100;
                        finalPrice = price - discountAmount;
                        hasResult = true;
                    }
                } catch (NumberFormatException e) {
                    error = "Please enter valid numbers only.";
                }
            } else if (priceStr != null || discountStr != null) {
                error = "Please enter both price and discount percentage.";
            }
        %>
        
        <% if (hasResult) { %>
            <div id="resultCard" class="result-card show">
                <h2 class="result-header">🎉 Discount Calculation Results</h2>
                
                <div class="calculation-row">
                    <span class="calculation-label">Original Price:</span>
                    <span class="calculation-value">₹<%= String.format("%.2f", price) %></span>
                </div>
                
                <div class="calculation-row">
                    <span class="calculation-label">Discount Percentage:</span>
                    <span class="calculation-value"><%= String.format("%.1f", discount) %>% <span class="discount-badge">SAVE <%= String.format("%.1f", discount) %>%</span></span>
                </div>
                
                <div class="calculation-row">
                    <span class="calculation-label">Discount Amount:</span>
                    <span class="calculation-value">₹<%= String.format("%.2f", discountAmount) %></span>
                </div>
                
                <div class="final-price">
                    FINAL PAYABLE AMOUNT: ₹<%= String.format("%.2f", finalPrice) %>
                </div>
                
                <p style="text-align: center; color: #7f8c8d; margin-top: 20px;">
                    You save <strong>₹<%= String.format("%.2f", discountAmount) %></strong> on this purchase!
                </p>
            </div>
        <% } else if (error != null) { %>
            <script>
                
                document.getElementById('errorMessage').textContent = '<%= error %>';
                document.getElementById('errorMessage').style.display = 'block';
            </script>
        <% } %>
        
        <div class="info-box">
            <h3 class="info-title">📊 How It Works</h3>
            <p>This JSP page calculates the final price after applying a discount using the formula:</p>
            <p style="text-align: center; font-weight: 600; font-size: 18px; color: #2c3e50;">
                finalPrice = price - (price × discount ÷ 100)
            </p>
            <p><strong>Technical Implementation:</strong></p>
            <ul>
             <li>Calculates discount amount and final price</li>
              <li>Displays results on the same page</li>
            </ul>
        </div>
    </div>
    
    <script>
        // Client-side validation for better UX
        document.querySelector('form').addEventListener('submit', function(e) {
            const price = document.getElementById('price').value;
            const discount = document.getElementById('discount').value;
            const errorMessage = document.getElementById('errorMessage');
            
            
            errorMessage.style.display = 'none';
            
            
            if (!price || !discount) {
                errorMessage.textContent = 'Please fill in both fields.';
                errorMessage.style.display = 'block';
                e.preventDefault();
                return;
            }
            
            const discountNum = parseFloat(discount);
            if (discountNum < 0 || discountNum > 100) {
                errorMessage.textContent = 'Discount must be between 0% and 100%.';
                errorMessage.style.display = 'block';
                e.preventDefault();
            }
        });
    </script>
</body>
</html>