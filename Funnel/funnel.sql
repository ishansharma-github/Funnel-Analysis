# Creating a dummy table.
create table ques(
order_date date,
user_id int,
step varchar(20)
);

# Inserting dummy data
insert into ques
values (curdate()-1,1,"DAU"),(curdate()-1,1,"Community"),(curdate()-1,1,"Payment"),(curdate()-1,1,"Order"),
		(curdate()-1,2,"DAU"),(curdate()-1,2,"Community"),(curdate()-1,2,"Payment"),
        (curdate()-1,3,"DAU"),(curdate()-1,3,"Home"),(curdate()-1,3,"Payment"),(curdate()-1,3,"Order"),
        (curdate()-1,4,"DAU"),(curdate()-1,4,"Community"),(curdate()-1,4,"Payment");
insert into ques
values  (curdate()-1,5,"DAU");
        


# This shows all user id and their journey

SELECT distinct q.user_id,t1.step as DAU,t2.step as C_or_h ,t3.step as Payment,t4.step as Orders from ques q
left join (SELECT order_date,user_id,step from ques where step = "Dau") t1 
				on q.order_date = t1.order_date and q.user_id = t1.user_id
left join (SELECT order_date,user_id,step from ques where step = "Community" or step = "Home") t2
				on q.order_date = t2.order_date and q.user_id = t2.user_id
left join (SELECT order_date,user_id,step from ques where step = "Payment") t3
				on q.order_date = t3.order_date and q.user_id = t3.user_id
left join (SELECT order_date,user_id,step from ques where step = "Order") t4
				on q.order_date = t4.order_date and q.user_id = t4.user_id;


# This gives count of all the different events based on user entered Community or Home

SELECT "Community",count(DAU) as DAU,COUNT(C_or_H) as Com_or_Home,COUNT(Payment) as Payment,COUNT(Orders) as Orders
FROM (SELECT distinct q.user_id,t1.step as DAU,t2.step as C_or_h ,t3.step as Payment,t4.step as Orders from ques q
left join (SELECT order_date,user_id,step from ques where step = "Dau") t1 
				on q.order_date = t1.order_date and q.user_id = t1.user_id
left join (SELECT order_date,user_id,step from ques where step = "Community" or step = "Home") t2
				on q.order_date = t2.order_date and q.user_id = t2.user_id
left join (SELECT order_date,user_id,step from ques where step = "Payment") t3
				on q.order_date = t3.order_date and q.user_id = t3.user_id
left join (SELECT order_date,user_id,step from ques where step = "Order") t4
				on q.order_date = t4.order_date and q.user_id = t4.user_id) q
WHERE C_or_H = "Community"
union
SELECT "Home",count(DAU),COUNT(C_or_H),COUNT(Payment),COUNT(Orders)
FROM (SELECT distinct q.user_id,t1.step as DAU,t2.step as C_or_h ,t3.step as Payment,t4.step as Orders from ques q
left join (SELECT order_date,user_id,step from ques where step = "Dau") t1 
				on q.order_date = t1.order_date and q.user_id = t1.user_id
left join (SELECT order_date,user_id,step from ques where step = "Community" or step = "Home") t2
				on q.order_date = t2.order_date and q.user_id = t2.user_id
left join (SELECT order_date,user_id,step from ques where step = "Payment") t3
				on q.order_date = t3.order_date and q.user_id = t3.user_id
left join (SELECT order_date,user_id,step from ques where step = "Order") t4
				on q.order_date = t4.order_date and q.user_id = t4.user_id) q
WHERE C_or_H = "Home";
 
 
 
