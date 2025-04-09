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
      (p.price * (1 - t.discount_percentage / 100…
[19.23, 9/4/2025] This Nurma: # Rakamin_KF_Analytycs

Repository ini berisi analisis data transaksi Kimia Farma menggunakan Google BigQuery.

## Query: Perhitungan Nett Sales dan Nett Profit

File: [nett_profit_query.sql](https://github.com/username/Rakamin_KF_Analytycs/blob/main/nett_profit_query.sql)

### Deskripsi:
Query ini menghitung:
- Nett Sales (setelah diskon)
- Gross Profit Percentage berdasarkan rentang harga
- Nett Profit (nett sales * gross profit %)
- Format hasil ke dalam format mata uang Rupiah

### Struktur Data:
- *kf_final_transaction*: Data transaksi
- *kf_product*: Data produk
- *kf_kantor_cabang*: Data cabang Kimia Farma

### Contoh Output Kolom:
- transaction_id
- branch_name
- actual_price
- discount_percentage
- nett_sales
- nett_profit

### Format Rupiah:
Output menggunakan format Rp. 25.000,00 dengan koma desimal dan titik ribuan.

---

### Cara Menjalankan:
Jalankan query di BigQuery SQL editor setelah memilih dataset yang sesuai.
