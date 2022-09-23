-- criação do banco E-commerce refinado
-- drop database ecommerce_refinado;
create database ecommerce_refinado;
use ecommerce_refinado;

-- criar tabela cliente
create table clients(
	idClient int auto_increment primary key,
    Fname varchar(10),
    Minit char(3),
    Lname varchar(30),
    Address varchar(200)
);

alter table clients auto_increment=1;

-- criar tabela conta
create table account(
	idAccount int auto_increment primary key,
    client_idClient int,
    CPF char(11),    
    CNPJ char(14),
    
    constraint fk_account_client foreign key (client_idClient) references clients(idClient),
    constraint unique_cpf_client unique (cpf),
    constraint unique_cnpj_client unique (cnpj)
);

alter table account auto_increment=1;

-- criar tabela produto
create table product(
	idProduct int auto_increment primary key,
    Pname varchar(100),
    Category enum('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis'),
    classification_kids bool default false,
    avaliation float default 0,
    size varchar(10)
);

alter table product auto_increment=1;

-- criar tabela pedido
create table orders(
	idOrder int auto_increment primary key,
    client_idClient int,
    orderStatus enum ('Cancelado','Confirmado','Em processamento') default 'Em processamento',
    orderDescription varchar(255),
    sendValue float default 10,
    paymentCash bool default false,
    
    constraint fk_orders_client foreign key (client_idClient) references clients(idClient)
);

alter table orders auto_increment=1;

-- criar tabela pagamento
create table payments(
	idPayment int auto_increment primary key,
    order_idOrder int,
    typePayment enum('Boleto','Cartão','Pix'),
    
    constraint fk_payments_orders foreign key (order_idOrder) references orders(idOrder)
);

alter table payments auto_increment=1;

-- criar tabela entrega
create table delivery(
	idDelivery int auto_increment primary key,
    order_idOrder int,
    trackingCode varchar(10),
    
    constraint fk_delivery_orders foreign key (order_idOrder) references orders(idOrder)
);

alter table delivery auto_increment=1;

-- criar tabela estoque
create table productStorage(
	idProductStorage int auto_increment primary key,
    storageLocation varchar(100),
    quantity int default 0
);

alter table productStorage auto_increment=1;

-- criar tabela fornecedor
create table supplier(
	idSupplier int auto_increment primary key,
    socialName varchar(100) not null,
    cnpj char(14),
    contact char (11)    
);

alter table supplier auto_increment=1;

-- criar tabela vendedor
create table seller(
	idSeller int auto_increment primary key,
    socialName varchar(100) not null,
    abstName varchar(50),
    CNPJ char(14),
    CPF char(11),
    location varchar(200),
    contact char(11) not null,
    
    constraint unique_cnpj_seller unique (CNPJ),
    constraint unique_cpf_seller unique (CPF)
);

alter table seller auto_increment=1;

-- criar tabela produto por vendedor
create table productSeller(
	idPseller int,
    idPproduct int,
    prodQuantity int default 1,
    
    primary key (idPseller, idPproduct),
    constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
    constraint fk_product_product foreign key (idPproduct) references product(idProduct)
);

-- criar tabela disponibilizar produto
create table productOrder(
	idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum('Disponível', 'Sem estoque') default 'Disponível',
    primary key (idPOproduct, idPOorder),
    
    constraint fk_productorder_seller foreign key (idPOproduct) references product(idProduct),
    constraint fk_productorder_product foreign key (idPOorder) references orders(idOrder)
);

-- criar tabela produto por estoque
create table storageLocation(
	idLproduct int,
    idLstorage int,
    location varchar(255) not null,
    primary key (idLproduct, idLstorage),
    
    constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
    constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProductStorage)
);

-- criar tabela produto por vendedor
create table productSupplier(
	idPsSupplier int,
    idPsProduct int,
    quantity int not null,
    
    primary key (idPsSupplier, idPsProduct),
    constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
    constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
);

