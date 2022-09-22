-- inserção de dados e queres
use ecommerce;

show tables;
desc clients;
-- idClient, Fname, Minit, Lname, CPF, Address
insert into Clients (Fname, Minit, Lname, CPF, Address)
	values('Maria','M','Silva',123456789,'rua silva de prata 29, Carangola - Cidade das Flores'),
		  ('Matheus','O','Pimentel',987654321,'rua alameda 289, Centro - Cidade das Flores'),
          ('Ricardo','F','Silva',45678913,'avenida alameda vinha 1009, centro - Cidade das Flores'),
          ('Julia','S','França',789123456,'rua laranjeiras 861, centro - Cidade das Flores'),
          ('Roberta','G','Assis',98745631,'avenida koller 19, centro - Cidade das Flores'),
          ('Isabela','M','Cruz',654789123,'rua alameda das flores 28, centro - Cidade das Flores');

desc product;
-- idProduct, Pname, classification_kids, category ('Eletrônico', 'Vestimenta','Brinquedos','Alimentos','Móveis'), avaliation, size
insert into product (Pname, classification_kids, category, avaliation, size)
	values ('Fone de ouvido',false,'Eletrônico','4',null),
		   ('Barbie Elsa',true,'Brinquedos','3',null),
		   ('Boby Carters',true,'Vestimenta','5',null),
           ('Microfone Vedo - Youtuber',false,'Eletrônico','4',null),
           ('Sofá Retrátil',false,'Móveis','3','3x57x80'),
           ('Farinha de arroz',false,'Alimentos','2',null),
           ('Fire Stick Amazon',false,'Eletrônico','3',null);

select * from clients;
select * from product;

delete from orders where idOrderClient in (1,2,3,4);
-- idOrder, idOrderClient, orderStatus, orderDescription, sendValue, paymentCash
insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash)
	values (1,default,'compra via aplicativo',null,1),
		   (2,default,'compra via aplicativo',50,0),
           (3,'Confirmado',null,null,1),
           (4, default, 'compra via web site',150,0);
           
select * from orders;
-- idPOproduct, idPOorder, poQuantity, poStatus

insert into productOrder (idPOproduct, idPOorder, poQuantity, poStatus)
	values (1,5,2,null),
		   (2,5,1,null),
           (3,6,1,null);
           
-- storageLocation, quantity

insert into productStorage (storageLocation, quantity)
	values ('Rio de Janeiro',1000),
		   ('Rio de Janeiro',500),
           ('São Paulo',10),
           ('São Paulo',100),
           ('São Paulo',10),
           ('Brasília',60);
           
-- idLproduct, idLstorage, location

insert into storageLocation (idLproduct, idLstorage, location)
	values (1,2,'RJ'),
		   (2,6,'GO');

-- idSupplier, SocialName, CNPJ, contact

insert into supplier (SocialName, CNPJ, contact)
	values ('Almeida e flihos', 123456789123456,'21985474'),
		   ('Eletrônicos Silva', 854519649143457,'21985484'),
           ('Eletrônicos Valma', 934567893934695,'21975474');
           
-- idPsSupplier, idPsProduct, quantity

insert into productSupplier (idPsSupplier, idPsProduct, quantity)
	values (1,1,500),
		   (1,2,400),
           (2,4,633),
           (3,3,5),
           (2,5,10);
           
-- SocialName, AbstName, CNPJ, CPF, location, contact

insert into seller (SocialName, AbstName, CNPJ, CPF, location, contact)
	values ('Tech eletronics', null, 123456789456321, null, 'Rio de Janeiro', 219946287),
		   ('Botique Durgas', null, null, 123456783, 'Rio de Janeiro', 219567895),
           ('kids world', null, 456789123654485, null, 'São Paulo', 1198657484);
           
-- idPseller, idPproduct, prodQuantity

insert into productSeller (idPseller, idPproduct, prodQuantity)
	values (1,6,80),
		   (2,7,10);

select count(*) from clients;

select * from clients c, orders o where c.idclient = idOrderClient;

select Fname, Lname, idOrder, orderStatus from clients c, orders o where c.idclient = idOrderClient;

select concat(Fname,' ',Lname) as client, idOrder as Request, orderStatus as Status from clients c, orders o where c.idClient = idOrderClient;

insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash)
	values (2,default,'compra via aplicativo',null,1);
    
select count(*) from clients c, orders o where c.idClient = idOrderClient;

select * from clients c, orders o
		where c.idClient = idOrderClient
        group by idOrder;

select * from clients left outer join orders ON idClient = idOrderClient;

select * from clients c inner join orders o ON c.idClient = o.idOrderClient
	inner join productOrder p on p.idPOorder = o.idOrder;

select c.idclient, Fname, count(*) as Number_of_orders from clients c
	inner join orders o ON c.idClient = o.idOrderClient	
    group by idClient;


