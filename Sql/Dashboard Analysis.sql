SELECT
o.Order_ID,
o.Order_Date,
strftime('%Y',o.Order_Date) AS Year,
strftime('%m',o.Order_Date) AS Month,
strftime('%Y-%m',o.Order_Date) AS Period,
c.Customer_ID,
c.Customer_Name,
c.Gender,
c.Age,
c.City,
c.Membership,
p.Product_ID,
p.Category,
p.Brand,
p.Price,
p.Cost,
(o.Qty) AS Qty,
(p.Price * o.Qty) AS Revenue,
((p.Price-p.Cost)*o.Qty) AS Margin,
o.Channel,
o.Campaign,
pay.Methods,
pay.Status AS Payment_Status,
s.Courier,
s.Shipping_Days,
s.Status AS Shipping_Status,
r.Rating,
r.Review_Type
FROM orders o
INNER JOIN customer c
ON o.Customer_ID = c.Customer_ID
INNER JOIN produk p
ON o.Product_ID = p.Product_ID
INNER JOIN payment pay
ON o.Order_ID = pay.Order_ID
INNER JOIN shipping s
ON o.Order_ID = s.Order_ID
INNER JOIN reviews r
ON o.Order_ID = r.Order_ID
ORDER BY o.Order_Date;