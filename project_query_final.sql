
CREATE TABLE account_table(
ID int,
account_id nchar(12),
balance float,
last_activity_date datetime,
-- 0 for closed account 1 for open account
statuss Bit,
)

CREATE TABLE transaction_table(
ID int,
transaction_id nchar(12),
amount float,
transaction_date datetime,
)

CREATE TABLE branch_table(
ID int,
branch_id nchar(12),
addresss nvarchar(500),
city nvarchar(30),
namee nvarchar(30),
)

CREATE TABLE customer_table(
ID int,
customer_id nchar(12),
adresss nvarchar(500),
city nvarchar(30),
)

CREATE TABLE employee_table(
ID int,
employee_id nchar(12),
first_name nvarchar(20),
last_name nvarchar(20),
start_datee datetime,
title nvarchar(30),
)

--add and edit and delete a column
ALTER TABLE account_table
ADD test int

ALTER TABLE account_table
ALTER COLUMN test nchar(20)

ALTER TABLE account_table
DROP COLUMN test

select * from account_table

SELECT DISTINCT adresss , city
from customer_table

--Sum of monthly transactions
SELECT sum(amount) as 'sum of amount' , MONTH(transaction_date) as 'month of transaction date'
from transaction_table
group by MONTH(transaction_date)

SELECT TOP 4 first_name
from employee_table

select	amount as 'price(dollar)',amount*20000 as 'price(toman)'
from transaction_table

select transaction_date , YEAR(transaction_date) as 'year' , day(transaction_date) as 'Day'
from transaction_table

select REPLACE(transaction_date,'2020','2022') as 'replaced year'
from transaction_table

select namee , ID , addresss
from branch_table
where namee = 'gharb'

select city , addresss
from branch_table
where city = 'tehran' and
(addresss like '%gol%')

select AVG(balance) as 'balance', MAX(balance) as 'maximum balance', statuss
from account_table
group by statuss

--Number of banks' branches with district distinction
select count(addresss) as 'address'  , namee
from branch_table
group by namee

--For accounts with status = 1 get reports based on average balance less than 800 and in descending order classified by last activity status 
--برای اکانتهایی که استتوس = 1 عه میانگین بالانسشون به تفکیک آخرین وضعیت فعالیت کوچکتر از 800 و  به ترتیب نزولی
select AVG(balance) as 'balance avg',last_activity_date
from account_table
where statuss = 1
group by last_activity_date
having AVG(balance) < 800
order by AVG(balance) desc

select customer_id ,adresss as 'address' from customer_table
union
select branch_id, addresss as 'address' from branch_table

select customer_id ,adresss as 'address' from customer_table
intersect
select branch_id, addresss as 'address' from branch_table


select amount ,amount=
case
when amount < 300 then 'low'
when amount > 400 then 'high'
else 'medium'
end
from transaction_table

select transaction_date as 'date of transaction' , amount , balance
from account_table as account
inner join transaction_table as transactionn
on account.account_id = transactionn.account_id

select adresss ,max(amount) as 'amount max', city from customer_table
left join 
transaction_table on transaction_table.customer_id=customer_table.customer_id
group by city , adresss
having max(amount)<200

select adresss ,max(amount) as 'amount max', city from customer_table
right join 
transaction_table on transaction_table.customer_id=customer_table.customer_id
group by city , adresss
having max(amount)<200

--subquery
select amount from transaction_table
where amount>(select avg(amount) from transaction_table)

--Prepare a report that puts together the account balance and the day of the customer's transaction and the customer's address
--گزارشی تهیه کنید که بالانس اکانت و روز تراکنش مشتری و آدرس مشتری را کنار هم قرار دهد
SELECT account.balance AS 'balance' , DAY(transactionn.transaction_date) as 'transaction day' , customer.adresss AS 'customer address'
FROM account_table AS account
INNER JOIN transaction_table AS transactionn
ON account.account_id = transactionn.account_id
INNER JOIN customer_table AS customer
ON account.customer_id = customer.customer_id