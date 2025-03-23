WITH calculation AS (SELECT DISTINCT
(CASE 
  WHEN C.price <= 50000 THEN 0.1
  WHEN C.price > 50000 AND C.price <= 100000 THEN 0.15
  WHEN C.price > 100000 AND C.price <= 300000 THEN 0.2
  WHEN C.price > 300000 AND C.price <= 500000 THEN 0.25
  WHEN C.price > 500000 THEN 0.3
 END) AS persentase_gross_laba,
 A.transaction_id,
 (C.price * (1 - A.discount_percentage)) AS nett_sales
 FROM kimia_farma.kf_product AS C
 JOIN kimia_farma.kf_final_transaction AS A 
 ON A.product_id = C.product_id)

SELECT 
A.transaction_id,
A.date,
A.branch_id,
B.branch_name,
B.kota,
B.provinsi,
B.rating AS rating_cabang,
A.customer_name,
C.product_id,
C.product_name,
C.price AS actual_price,
A.discount_percentage,
D.persentase_gross_laba,
D.nett_sales,
(D.nett_sales * D.persentase_gross_laba) AS nett_profit,
A.rating AS rating_transaksi


FROM kimia_farma.kf_final_transaction AS A
JOIN kimia_farma.kf_kantor_cabang AS B 
ON A.branch_id = B.branch_id
JOIN kimia_farma.kf_product AS C
ON A.product_id = C.product_id
JOIN calculation AS D
ON A.transaction_id = D.transaction_id 
