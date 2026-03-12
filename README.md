# sql-practice

---

## コンセプト

* SQLの基礎を順番に学ぶ
* GitHubに学習履歴を残す
* 問いた問題・考えたこと・つまずきポイントを記録する
* 将来的に「データエンジニア志望」のポートフォリオの土台にする

---

## ディレクトリ構成

```text
sql-practice/
├── README.md
├── .gitignore
├── docs/
│   ├── study-plan.md
│   ├── learning-log.md
│   └── cheat-sheet.md
├── sqlzoo/
│   ├── 01_select_basics.sql
│   ├── 02_select_from_world.sql
│   ├── 03_select_names.sql
│   ├── 04_select_within_select.sql
│   ├── 05_sum_and_count.sql
│   ├── 06_join.sql
│   ├── 07_more_join.sql
│   ├── 08_using_null.sql
│   ├── 09_self_join.sql
│   └── 10_window_functions.sql
├── leetcode/
│   ├── easy/
│   └── medium/
├── schemas/
│   ├── sample_schema.sql
│   └── sample_data.sql
└── notes/
    ├── join.md
    ├── group-by.md
    ├── subquery.md
    └── window-functions.md
```

---

## README.md テンプレート

```md
# SQL Practice

SQL学習用のリポジトリです。  
基礎文法からJOIN、集計、サブクエリ、ウィンドウ関数まで段階的に学習し、
解いた問題と学びを記録しています。

## 目的
- SQLの基礎力を固める
- データ抽出・集計・分析の考え方を身につける
- GitHubに学習履歴を残す
- 将来的にデータエンジニア/データアナリスト業務につながる土台を作る

## 学習内容
- SELECT / WHERE / ORDER BY
- GROUP BY / HAVING
- JOIN
- サブクエリ
- CASE
- ウィンドウ関数

## 学習ルール
- 1問ごとに「何を使う問題だったか」を一言で残す
- 間違えた問題は learning-log.md に記録する
- 解答だけで終わらず、「なぜそのSQLになるか」をメモする

## 使用教材
- SQLZoo
- LeetCode SQL
- 必要に応じて書籍・Udemy

## 進め方
1. SQLZooで基礎を固める
2. 問題ごとに `.sql` ファイルへ記録する
3. 重要概念を `notes/` に整理する
4. LeetCodeで実戦問題に挑戦する

## 今後やりたいこと
- PostgreSQL / BigQuery 方言の違い整理
- 実務想定の売上データ分析SQL追加
- Python + SQL の連携サンプル追加
```

---

## docs/study-plan.md

```md
# SQL学習計画

## Phase 1: 基礎
- SELECT
- WHERE
- ORDER BY
- LIMIT

## Phase 2: 集計
- COUNT
- SUM
- AVG
- GROUP BY
- HAVING

## Phase 3: 結合
- INNER JOIN
- LEFT JOIN
- 複数テーブル結合

## Phase 4: 応用
- サブクエリ
- CASE
- CTE
- ウィンドウ関数

## Phase 5: 実戦
- LeetCode SQL
- 模擬分析問題
```

---

## docs/learning-log.md

```md
# Learning Log

## 2026-03-12
- SQLZoo SELECT basics 開始
- WHERE と ORDER BY の違いを確認
- `GROUP BY` は「行をまとめる」、`ORDER BY` は「並べ替える」だけ

### 詰まったこと
- `WHERE` と `HAVING` の使い分けが曖昧
- 集計前条件と集計後条件で分かれることを再確認

### 次回やること
- SELECT from WORLD
- SUM and COUNT
```

---

## docs/cheat-sheet.md

````md
# SQL Cheat Sheet

## 基本形
```sql
SELECT column1, column2
FROM table_name
WHERE condition
ORDER BY column1;
````

## 集計

```sql
SELECT department, COUNT(*) AS cnt
FROM employees
GROUP BY department
HAVING COUNT(*) >= 5;
```

## JOIN

```sql
SELECT a.id, a.name, b.amount
FROM customers a
JOIN orders b
  ON a.id = b.customer_id;
```

## ウィンドウ関数

```sql
SELECT
  name,
  department,
  salary,
  RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS salary_rank
FROM employees;
```

````

---

## sqlzoo/01_select_basics.sql

```sql
-- SQLZoo: SELECT basics

-- Q1
SELECT population
FROM world
WHERE name = 'Germany';

-- メモ:
-- 特定の国の1列だけ取り出す基本問題

-- Q2
SELECT name, population
FROM world
WHERE name IN ('Sweden', 'Norway', 'Denmark');

-- メモ:
-- IN を使う複数条件の基本
````

---

## notes/join.md

```md
# JOINメモ

## JOINとは
複数テーブルを、共通するキーで結びつけること。

## よく使う種類
- INNER JOIN: 両方にあるものだけ
- LEFT JOIN: 左を全部残す
- RIGHT JOIN: 右を全部残す

## 実務で大事なこと
- どのキーで結ぶか
- 1対多なのか多対多なのか
- JOIN後に件数が増える理由を説明できるか
```

---

## 最初のコミット順

```bash
git init
git branch -M main
git add .
git commit -m "init: create sql learning repository structure"
```

次:

```bash
git add .
git commit -m "docs: add README and study plan"
```

次:

```bash
git add .
git commit -m "feat: add sqlzoo select basics answers"
```

---

## 最初にやるべき3つ

1. GitHubで `sql-practice` リポジトリを作る
2. 上の構成でフォルダを切る
3. SQLZooの `SELECT basics` を解いて `01_select_basics.sql` に保存する

---

## このリポジトリの見せ方

転職向けには、ただ問題を並べるだけだと弱い。
なので、以下を残すと少し良くなる。

* 問題の答え
* 何を学んだか
* 間違えたポイント
* 実務でどう使いそうか

例:

* `GROUP BY`: 日別売上集計
* `JOIN`: 顧客テーブルと注文テーブルの結合
* `WINDOW FUNCTION`: 売上ランキング作成

---

## 次に拡張するなら

* DockerでPostgreSQL環境を作る
* サンプルDBを自分で作る
* 売上データ分析SQLを追加する
* PythonからSQLを叩くコードを追加する
