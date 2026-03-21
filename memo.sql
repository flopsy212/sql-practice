-- ===============================
-- Docker,PostgreSQL接続コマンド
docker start postgres || docker run --name postgres -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=testdb -p 5432:5432 -d postgres
docker exec -it postgres psql -U postgres -d testdb
-- ===============================


-- ===============================
-- ① 既存テーブル削除（リセット）
-- ===============================
-- 依存関係があるので、子テーブルから消すのがポイント

DROP TABLE IF EXISTS order_items; -- 注文明細（子）
DROP TABLE IF EXISTS orders;      -- 注文（中間）
DROP TABLE IF EXISTS products;    -- 商品
DROP TABLE IF EXISTS customers;   -- 顧客


-- ===============================
-- ② テーブル作成
-- ===============================

-- 顧客テーブル
CREATE TABLE customers (
  id SERIAL PRIMARY KEY,       -- 自動採番ID
  name VARCHAR(50) NOT NULL,   -- 名前（必須）
  city VARCHAR(50) NOT NULL    -- 都市（必須）
);

-- 商品テーブル
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  category VARCHAR(50) NOT NULL, -- カテゴリ（PC / Furnitureなど）
  price INT NOT NULL             -- 価格
);

-- 注文テーブル
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_id INT NOT NULL REFERENCES customers(id), -- 顧客との紐付け（外部キー）
  order_date DATE NOT NULL                           -- 注文日
);

-- 注文明細テーブル（どの商品を何個買ったか）
CREATE TABLE order_items (
  id SERIAL PRIMARY KEY,
  order_id INT NOT NULL REFERENCES orders(id),     -- 注文との紐付け
  product_id INT NOT NULL REFERENCES products(id), -- 商品との紐付け
  quantity INT NOT NULL                            -- 数量
);


-- ===============================
-- ③ データ投入（顧客）
-- ===============================
INSERT INTO customers (name, city) VALUES
('Sho', 'Tokyo'),
('Taro', 'Osaka'),
('Hanako', 'Tokyo'),
('Yuki', 'Nagoya'),
('Ken', 'Fukuoka');


-- ===============================
-- ④ データ投入（商品）
-- ===============================
INSERT INTO products (name, category, price) VALUES
('Keyboard', 'PC', 3000),
('Mouse', 'PC', 2000),
('Monitor', 'PC', 15000),
('Desk', 'Furniture', 12000),
('Chair', 'Furniture', 8000),
('Notebook', 'Stationery', 500);


-- ===============================
-- ⑤ データ投入（注文）
-- ===============================
INSERT INTO orders (customer_id, order_date) VALUES
(1, '2026-03-01'),
(2, '2026-03-02'),
(1, '2026-03-10'),
(3, '2026-03-11'),
(4, '2026-03-15'),
(2, '2026-04-01'),
(1, '2026-04-05');


-- ===============================
-- ⑥ データ投入（注文明細）
-- ===============================
-- どの注文で何を何個買ったか

INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 1), -- Keyboard
(1, 2, 2), -- Mouse ×2
(2, 3, 1), -- Monitor
(2, 6, 3), -- Notebook ×3
(3, 5, 1), -- Chair
(3, 6, 2), -- Notebook ×2
(4, 2, 1), -- Mouse
(4, 6, 5), -- Notebook ×5
(5, 4, 1), -- Desk
(6, 1, 2), -- Keyboard ×2
(6, 2, 1), -- Mouse
(7, 3, 1), -- Monitor
(7, 5, 1); -- Chair


-- ===============================
-- ⑦ 確認用クエリ（練習）
-- ===============================

-- 顧客一覧
SELECT * FROM customers;

-- 商品一覧
SELECT * FROM products;

-- 注文一覧
SELECT * FROM orders;

-- 注文明細一覧
SELECT * FROM order_items;
