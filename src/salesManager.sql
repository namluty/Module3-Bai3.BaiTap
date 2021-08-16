
create database salesManager;
use salesManager;
create table Customer(
                         cID int not null auto_increment primary key,
                         cName varchar(255) not null,
                         cAge int not null
);
create table Orders(
                       oID int not null auto_increment primary key,
                       cID int not null,
                       oDate date not null,
                       oTotalPrice double,
                       foreign key(cID) references customer(cID)
);
create table Product(
                        pID int not null auto_increment primary key,
                        pName varchar(255),
                        pPrice double not null
);

create table Oders_detail(
                            oID int ,
                            pID int,
                            odqty int,
                            foreign key (oID) references Orders(oID),
                            foreign key (pID) references product(pID)
);
#Hiển thị các thông tin  gồm oID, oDate, oPrice của tất cả các hóa đơn trong bảng Order
select Orders.oID, Orders.oDate, Product.pPrice from oders_detail
    join orders on Oders_detail.oID = Orders.oID
    join product on Oders_detail.pID = Product.pID;
#Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách
select customer.cName, Product.pName from oders_detail
    join product on Product.pID = Oders_detail.pID
    join orders on Oders_detail.oID = Orders.oID
    join customer on customer.cID = Orders.cID;
#Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào
select * from customer where cID not in (select cID from orders);
#Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn (giá một hóa đơn được tính bằng tổng giá bán của từng loại mặt hàng xuất hiện trong hóa đơn. Giá bán của từng loại được tính = odQTY*pPrice)
select orders.oID, orders.oDate, sum(Oders_detail.odqty*product.pPrice) as totalAmount
from oders_detail join product on Oders_detail.pID = product.pID
                 join orders on Oders_detail.oID = orders.oID group by Oders_detail.oID;