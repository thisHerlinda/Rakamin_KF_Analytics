SELECT
  t.transaction_id,
  t.date,
  t.branch_id,
  b.branch_name,
  b.kota,
  b.provinsi,
  b.rating,
  t.customer_name,
  t.product_id,
  p.product_name,
  p.price AS actual_price,
  t.discount_percentage,

  -- Persentase Gross Laba
  CASE
    WHEN p.price <= 50000 THEN 0.10
    WHEN p.price <= 100000 THEN 0.15
    WHEN p.price <= 300000 THEN 0.20
    WHEN p.price <= 500000 THEN 0.25
    ELSE 0.30
  END AS persentase_gross_laba,

  -- Nett Sales formatted as Rupiah (2 desimal, titik ribuan)
  CONCAT(
    'Rp. ',
    REPLACE(FORMAT('%.2f', ROUND(p.price * (1 - t.discount_percentage / 100), 2)), '.',',')
  ) AS nett_sales,

  -- Nett Profit formatted 
  CONCAT(
    'Rp. ',
    REPLACE(FORMAT('%.2f', ROUND(
      (p.price * (1 - t.discount_percentage / 100)) *
        CASE
          WHEN p.price <= 50000 THEN 0.10
          WHEN p.price <= 100000 THEN 0.15
          WHEN p.price <= 300000 THEN 0.20
          WHEN p.price <= 500000 THEN 0.25
          ELSE 0.30
        END
      , 2)),'.',',')
  ) AS nett_profit,

  t.rating AS rating_transaksi

FROM
  kimia_farma.kf_final_transaction t
JOIN
  kimia_farma.kf_product p
  ON t.product_id = p.product_id
JOIN
  kimia_farma.kf_kantor_cabang b
  ON t.branch_id = b.branch_id
