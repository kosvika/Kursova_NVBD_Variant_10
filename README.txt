# Cable TV Data Warehouse & BI System

Курсова робота з проєктування баз даних, ETL-процесів та бізнес-аналітики  
Варіант 10

---

## 1. Опис проєкту

Даний проєкт реалізує повний цикл побудови аналітичної системи для кабельного телебачення:
- операційна база даних (OLTP),
- сховище даних (Data Warehouse),
- ETL-процеси (SSIS),
- OLAP-куб (SSAS),
- аналітичні звіти (SSRS).

Проєкт побудований з урахуванням вимог до великих обсягів даних, цілісності, бізнес-логіки та аналітики.

---

## 2. Архітектура системи

OLTP → SSIS (ETL) → Data Warehouse → SSAS Cube → SSRS Reports

- OLTP використовується як джерело даних
- Data Warehouse реалізований за схемою «зірка»
- Аналітика виконується через OLAP-куб
- Звіти створені на основі куба

---

## 3. Структура SQL-файлів

### 3.1 OLTP (операційна база даних)

- OLTP_CREATE_TABLES.sql  
  Створення операційних таблиць:
  - Subscribers  
  - Movies  
  - Movie_Orders  
  - Invoices  
  - Payments  

- SUBSCRIBERS.sql  
- MOVIES.sql  
- MOVIE_ORDERS.sql  
- INVOICES.sql  
- PAYMENTS.sql  

Генерація реалістичних тестових даних:
- Subscribers — 100 000
- Movies — 5 000
- Movie Orders — 1 000 000
- Invoices — 500 000
- Payments — згідно статусів інвойсів

---

### 3.2 Data Warehouse (DWH)

#### Dimension Tables
- DIM_SUBSCRIBER.sql (SCD Type 2)
- DIM_MOVIE.sql
- DIM_DATE.sql
- DIM_CHANNEL_GROUP.sql

#### Fact Tables
- FACT_MOVIE_ORDERS.sql
- FACT_INVOICES.sql

#### Додаткові обʼєкти
- CREATE_INDEXES.sql — індекси для оптимізації
- FACT_INVOICES_TRIGGER.sql — контроль бізнес-логіки
- CREATE_PROCEDURE.sql — збережена процедура
- CREATE_FUNCTION.sql — користувацька функція

---

### 3.3 Перевірка та валідація даних

- CHECK_COUNT.sql — перевірка кількості записів
- CHECK_INTEGRITY.sql — перевірка цілісності FK
- CHECK_REAL.sql — перевірка бізнес-логіки (Paid + Debt = Total)
- TEST_PRODUCTIVITY.sql — перевірка продуктивності аналітичних запитів

---

## 4. ETL-процеси (SSIS)

ETL реалізовано в SQL Server Integration Services:
- Extract з OLTP
- Transform:
  - Data Cleansing
  - Data Conversion
  - Derived Column
  - Lookup
  - Conditional Split
- Load у Data Warehouse

---

## 5. OLAP-куб (SSAS)

- Multidimensional Cube
- Мінімум 5 вимірів
- 7+ мір (Sum, Count, Min, Max, Average, Distinct Count, Calculated)
- Calculated Measures
- Perspectives

Куб успішно оброблений (Process Full).

---

## 6. Аналітичні звіти (SSRS)

Реалізовано 7 різних типів звітів, включно з:
- Table Report
- Matrix Report
- Chart Reports (Column, Line, Pie, Bar)
- Dashboard
- Drill-down report

Параметри:
- Multi-select
- Dropdown
- Range (за сумами)
- Boolean

Звіти перевірені в режимі Preview.
