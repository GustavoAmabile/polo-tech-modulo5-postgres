CREATE SCHEMA IF NOT EXISTS "e-commerce 926";

CREATE  TABLE "e-commerce 926".endereco ( 
	id                   serial  NOT NULL  ,
	cep                  char(8)  NOT NULL  ,
	logradouro           varchar(1000)  NOT NULL  ,
	numero               varchar(30)  NOT NULL  ,
	cidade               varchar(200)  NOT NULL  ,
	uf                   char(2)  NOT NULL  ,
	CONSTRAINT pk_endereco PRIMARY KEY ( id )
 );

CREATE  TABLE "e-commerce 926".estoque ( 
	id                   serial  NOT NULL  ,
	id_endereco          integer  NOT NULL  ,
	CONSTRAINT pk_estoque PRIMARY KEY ( id )
 );

CREATE  TABLE "e-commerce 926".fornecedor ( 
	id                   serial  NOT NULL  ,
	nome                 varchar(895)  NOT NULL  ,
	cnpj                 char(14)  NOT NULL  ,
	id_endereco          integer  NOT NULL  ,
	CONSTRAINT pk_fornecedor PRIMARY KEY ( id ),
	CONSTRAINT unq_fornecedor UNIQUE ( cnpj ) 
 );

CREATE  TABLE "e-commerce 926".produto ( 
	id                   serial  NOT NULL  ,
	descricao            varchar(1000)  NOT NULL  ,
	codigo_barras        varchar(44)  NOT NULL  ,
	valor                numeric  NOT NULL  ,
	CONSTRAINT pk_produto PRIMARY KEY ( id )
 );

CREATE  TABLE "e-commerce 926".cliente ( 
	id                   serial  NOT NULL  ,
	nome                 varchar(895)  NOT NULL  ,
	cpf                  char(11)  NOT NULL  ,
	id_endereco          integer  NOT NULL  ,
	CONSTRAINT pk_cliente PRIMARY KEY ( id ),
	CONSTRAINT cpf UNIQUE ( cpf ) 
 );

CREATE  TABLE "e-commerce 926".item_fornecedor_produto ( 
	id_fornecedor        integer  NOT NULL  ,
	id_produto           integer  NOT NULL  ,
	CONSTRAINT pk_item_fornecedor_produto PRIMARY KEY ( id_fornecedor, id_produto )
 );

CREATE  TABLE "e-commerce 926".item_produto ( 
	id_estoque           integer  NOT NULL  ,
	id_produto           integer  NOT NULL  ,
	quantidade           integer  NOT NULL  ,
	CONSTRAINT pk_item_produto PRIMARY KEY ( id_estoque, id_produto )
 );

CREATE  TABLE "e-commerce 926".pedido ( 
	pedido               serial  NOT NULL  ,
	previsao_entrega     date  NOT NULL  ,
	meio_pagamento       varchar(200)  NOT NULL  ,
	status               varchar(100)  NOT NULL  ,
	id_cliente           integer  NOT NULL  ,
	data_criacao         timestamp  NOT NULL  ,
	CONSTRAINT pk_pedido PRIMARY KEY ( pedido )
 );

CREATE  TABLE "e-commerce 926".carrinho ( 
	id_cliente           integer  NOT NULL  ,
	id_produto           integer  NOT NULL  ,
	quantidade           integer  NOT NULL  ,
	data_incercao        date  NOT NULL  ,
	CONSTRAINT pk_carrinho PRIMARY KEY ( id_cliente, id_produto )
 );

CREATE  TABLE "e-commerce 926".cupom ( 
	id                   integer  NOT NULL  ,
	descricao            varchar(1000)  NOT NULL  ,
	valor                numeric  NOT NULL  ,
	data_inicio          date  NOT NULL  ,
	data_expiracao       date  NOT NULL  ,
	clientes             varchar(200)  NOT NULL  ,
	id_pedido            integer  NOT NULL  ,
	CONSTRAINT pk_cupom PRIMARY KEY ( id )
 );

CREATE  TABLE "e-commerce 926".item_pedido ( 
	id_pedido            integer  NOT NULL  ,
	id_produto           integer  NOT NULL  ,
	quantidade           integer  NOT NULL  ,
	valor                numeric  NOT NULL  ,
	CONSTRAINT pk_item_pedido PRIMARY KEY ( id_pedido, id_produto )
 );

ALTER TABLE "e-commerce 926".carrinho ADD CONSTRAINT fk_carrinho_cliente FOREIGN KEY ( id_cliente ) REFERENCES "e-commerce 926".cliente( id );

ALTER TABLE "e-commerce 926".carrinho ADD CONSTRAINT fk_carrinho_produto FOREIGN KEY ( id_produto ) REFERENCES "e-commerce 926".produto( id );

ALTER TABLE "e-commerce 926".cliente ADD CONSTRAINT fk_cliente_endereco FOREIGN KEY ( id_endereco ) REFERENCES "e-commerce 926".endereco( id );

ALTER TABLE "e-commerce 926".cupom ADD CONSTRAINT fk_cupom_pedido FOREIGN KEY ( id_pedido ) REFERENCES "e-commerce 926".pedido( pedido );

ALTER TABLE "e-commerce 926".estoque ADD CONSTRAINT fk_estoque_endereco FOREIGN KEY ( id_endereco ) REFERENCES "e-commerce 926".endereco( id );

ALTER TABLE "e-commerce 926".fornecedor ADD CONSTRAINT fk_fornecedor_endereco FOREIGN KEY ( id_endereco ) REFERENCES "e-commerce 926".endereco( id );

ALTER TABLE "e-commerce 926".item_fornecedor_produto ADD CONSTRAINT fk_item_produto FOREIGN KEY ( id_produto ) REFERENCES "e-commerce 926".produto( id );

ALTER TABLE "e-commerce 926".item_fornecedor_produto ADD CONSTRAINT fk_item_fornecedor FOREIGN KEY ( id_fornecedor ) REFERENCES "e-commerce 926".fornecedor( id );

ALTER TABLE "e-commerce 926".item_pedido ADD CONSTRAINT fk_item_pedido_pedido FOREIGN KEY ( id_pedido ) REFERENCES "e-commerce 926".pedido( pedido );

ALTER TABLE "e-commerce 926".item_pedido ADD CONSTRAINT fk_item_pedido_produto FOREIGN KEY ( id_produto ) REFERENCES "e-commerce 926".produto( id );

ALTER TABLE "e-commerce 926".item_produto ADD CONSTRAINT fk_item_produto FOREIGN KEY ( id_produto ) REFERENCES "e-commerce 926".produto( id );

ALTER TABLE "e-commerce 926".item_produto ADD CONSTRAINT fk_item_estoque FOREIGN KEY ( id_estoque ) REFERENCES "e-commerce 926".estoque( id );

ALTER TABLE "e-commerce 926".pedido ADD CONSTRAINT fk_pedido_cliente FOREIGN KEY ( id_cliente ) REFERENCES "e-commerce 926".cliente( id );
