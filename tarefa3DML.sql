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
	CONSTRAINT pk_estoque PRIMARY KEY ( id ),
	CONSTRAINT fk_estoque_endereco FOREIGN KEY ( id_endereco ) REFERENCES "e-commerce 926".endereco( id )   
 );

CREATE  TABLE "e-commerce 926".fornecedor ( 
	id                   serial  NOT NULL  ,
	nome                 varchar(895)  NOT NULL  ,
	cnpj                 char(14)  NOT NULL  ,
	id_endereco          integer  NOT NULL  ,
	CONSTRAINT pk_fornecedor PRIMARY KEY ( id ),
	CONSTRAINT unq_fornecedor UNIQUE ( cnpj ) ,
	CONSTRAINT fk_fornecedor_endereco FOREIGN KEY ( id_endereco ) REFERENCES "e-commerce 926".endereco( id )   
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
	CONSTRAINT cpf UNIQUE ( cpf ) ,
	CONSTRAINT fk_cliente_endereco FOREIGN KEY ( id_endereco ) REFERENCES "e-commerce 926".endereco( id )   
 );

CREATE  TABLE "e-commerce 926".item_fornecedor_produto ( 
	id_fornecedor        integer  NOT NULL  ,
	id_produto           integer  NOT NULL  ,
	CONSTRAINT pk_item_fornecedor_produto PRIMARY KEY ( id_fornecedor, id_produto ),
	CONSTRAINT fk_item_produto FOREIGN KEY ( id_produto ) REFERENCES "e-commerce 926".produto( id )   ,
	CONSTRAINT fk_item_fornecedor FOREIGN KEY ( id_fornecedor ) REFERENCES "e-commerce 926".fornecedor( id )   
 );

CREATE  TABLE "e-commerce 926".item_produto ( 
	id_estoque           integer  NOT NULL  ,
	id_produto           integer  NOT NULL  ,
	quantidade           integer  NOT NULL  ,
	CONSTRAINT pk_item_produto PRIMARY KEY ( id_estoque, id_produto ),
	CONSTRAINT fk_item_produto FOREIGN KEY ( id_produto ) REFERENCES "e-commerce 926".produto( id )   ,
	CONSTRAINT fk_item_estoque FOREIGN KEY ( id_estoque ) REFERENCES "e-commerce 926".estoque( id )   
 );

CREATE  TABLE "e-commerce 926".pedido ( 
	pedido               serial  NOT NULL  ,
	previsao_entrega     date  NOT NULL  ,
	meio_pagamento       varchar(200)  NOT NULL  ,
	status               varchar(100)  NOT NULL  ,
	id_cliente           integer  NOT NULL  ,
	data_criacao         timestamp  NOT NULL  ,
	CONSTRAINT pk_pedido PRIMARY KEY ( pedido ),
	CONSTRAINT fk_pedido_cliente FOREIGN KEY ( id_cliente ) REFERENCES "e-commerce 926".cliente( id )   
 );

CREATE  TABLE "e-commerce 926".carrinho ( 
	id_cliente           integer  NOT NULL  ,
	id_produto           integer  NOT NULL  ,
	quantidade           integer  NOT NULL  ,
	data_incercao        date  NOT NULL  ,
	CONSTRAINT pk_carrinho PRIMARY KEY ( id_cliente, id_produto ),
	CONSTRAINT fk_carrinho_cliente FOREIGN KEY ( id_cliente ) REFERENCES "e-commerce 926".cliente( id )   ,
	CONSTRAINT fk_carrinho_produto FOREIGN KEY ( id_produto ) REFERENCES "e-commerce 926".produto( id )   
 );

CREATE  TABLE "e-commerce 926".cupom ( 
	id                   integer  NOT NULL  ,
	descricao            varchar(1000)  NOT NULL  ,
	valor                numeric  NOT NULL  ,
	data_inicio          date  NOT NULL  ,
	data_expiracao       date  NOT NULL  ,
	clientes             varchar(200)  NOT NULL  ,
	id_pedido            integer  NOT NULL  ,
	CONSTRAINT pk_cupom PRIMARY KEY ( id ),
	CONSTRAINT fk_cupom_pedido FOREIGN KEY ( id_pedido ) REFERENCES "e-commerce 926".pedido( pedido )   
 );

CREATE  TABLE "e-commerce 926".item_pedido ( 
	id_pedido            integer  NOT NULL  ,
	id_produto           integer  NOT NULL  ,
	quantidade           integer  NOT NULL  ,
	valor                numeric  NOT NULL  ,
	CONSTRAINT pk_item_pedido PRIMARY KEY ( id_pedido, id_produto ),
	CONSTRAINT fk_item_pedido_pedido FOREIGN KEY ( id_pedido ) REFERENCES "e-commerce 926".pedido( pedido )   ,
	CONSTRAINT fk_item_pedido_produto FOREIGN KEY ( id_produto ) REFERENCES "e-commerce 926".produto( id )   
 );

INSERT INTO "e-commerce 926".endereco( id, cep, logradouro, numero, cidade, uf ) VALUES ( 1, '30400400', 'rua Alfa', '1', 'belo horizonte', 'MG');
INSERT INTO "e-commerce 926".endereco( id, cep, logradouro, numero, cidade, uf ) VALUES ( 2, '30400402', 'rua Alfa', '2', 'Rio de Janeiro', 'RJ');
INSERT INTO "e-commerce 926".endereco( id, cep, logradouro, numero, cidade, uf ) VALUES ( 3, '30400403', 'rua Beta', '3', 'São Paulo', 'SP');
INSERT INTO "e-commerce 926".endereco( id, cep, logradouro, numero, cidade, uf ) VALUES ( 4, '30400404', 'rua Charlie', '4', 'Fortaleza', 'CE');
INSERT INTO "e-commerce 926".endereco( id, cep, logradouro, numero, cidade, uf ) VALUES ( 5, '30400405', 'rua Eco', '5', 'Manaus', 'AM');
INSERT INTO "e-commerce 926".endereco( id, cep, logradouro, numero, cidade, uf ) VALUES ( 6, '30400406', 'rua Fox', '6', 'Porto Alegre', 'RS');
INSERT INTO "e-commerce 926".endereco( id, cep, logradouro, numero, cidade, uf ) VALUES ( 7, '30400407', 'rua Golf', '7', 'Cuiabá', 'MT');
INSERT INTO "e-commerce 926".estoque( id, id_endereco ) VALUES ( 1, 6);
INSERT INTO "e-commerce 926".estoque( id, id_endereco ) VALUES ( 2, 7);
INSERT INTO "e-commerce 926".fornecedor( id, nome, cnpj, id_endereco ) VALUES ( 1, 'Fornecedor Ltda', '00000000000001', 6);
INSERT INTO "e-commerce 926".fornecedor( id, nome, cnpj, id_endereco ) VALUES ( 2, 'SA. Fornecedor', '00000000000002', 7);
INSERT INTO "e-commerce 926".produto( id, descricao, codigo_barras, valor ) VALUES ( 1, 'Samsung S23', '1111111111111111111111', 4999.99);
INSERT INTO "e-commerce 926".produto( id, descricao, codigo_barras, valor ) VALUES ( 2, 'Lanterna Rayovac', '1111111111111111122222', 59.99);
INSERT INTO "e-commerce 926".produto( id, descricao, codigo_barras, valor ) VALUES ( 3, 'Cubo Mágico', '1111111111111111133333', 29.99);
INSERT INTO "e-commerce 926".produto( id, descricao, codigo_barras, valor ) VALUES ( 4, 'Livro - Java Oracle', '1111111111111111144444', 199.99);
INSERT INTO "e-commerce 926".produto( id, descricao, codigo_barras, valor ) VALUES ( 5, 'Fralda Pampeers', '1111111111111111155555', 79.99);
INSERT INTO "e-commerce 926".produto( id, descricao, codigo_barras, valor ) VALUES ( 6, 'Notebook Asus', '1111111111111111166666', 8999.99);
INSERT INTO "e-commerce 926".produto( id, descricao, codigo_barras, valor ) VALUES ( 7, 'Liquidificador', '1111111111111111177777', 99.99);
INSERT INTO "e-commerce 926".cliente( id, nome, cpf, id_endereco ) VALUES ( 1, 'Gustavo Amabile', '01201301456', 1);
INSERT INTO "e-commerce 926".cliente( id, nome, cpf, id_endereco ) VALUES ( 2, 'Maiara', '01201201202', 4);
INSERT INTO "e-commerce 926".cliente( id, nome, cpf, id_endereco ) VALUES ( 3, 'Maria', '01201201203', 5);
INSERT INTO "e-commerce 926".cliente( id, nome, cpf, id_endereco ) VALUES ( 4, 'Luciana', '01201201204', 6);
INSERT INTO "e-commerce 926".cliente( id, nome, cpf, id_endereco ) VALUES ( 5, 'Renan', '01201201205', 7);
INSERT INTO "e-commerce 926".cliente( id, nome, cpf, id_endereco ) VALUES ( 6, 'Vinícius', '01201201206', 2);
INSERT INTO "e-commerce 926".item_fornecedor_produto( id_fornecedor, id_produto ) VALUES ( 1, 1);
INSERT INTO "e-commerce 926".item_fornecedor_produto( id_fornecedor, id_produto ) VALUES ( 1, 2);
INSERT INTO "e-commerce 926".item_fornecedor_produto( id_fornecedor, id_produto ) VALUES ( 1, 3);
INSERT INTO "e-commerce 926".item_fornecedor_produto( id_fornecedor, id_produto ) VALUES ( 1, 4);
INSERT INTO "e-commerce 926".item_fornecedor_produto( id_fornecedor, id_produto ) VALUES ( 2, 5);
INSERT INTO "e-commerce 926".item_fornecedor_produto( id_fornecedor, id_produto ) VALUES ( 2, 6);
INSERT INTO "e-commerce 926".item_fornecedor_produto( id_fornecedor, id_produto ) VALUES ( 2, 7);
INSERT INTO "e-commerce 926".item_fornecedor_produto( id_fornecedor, id_produto ) VALUES ( 2, 3);
INSERT INTO "e-commerce 926".item_produto( id_estoque, id_produto, quantidade ) VALUES ( 1, 1, 100);
INSERT INTO "e-commerce 926".item_produto( id_estoque, id_produto, quantidade ) VALUES ( 1, 2, 1000);
INSERT INTO "e-commerce 926".item_produto( id_estoque, id_produto, quantidade ) VALUES ( 1, 3, 50);
INSERT INTO "e-commerce 926".item_produto( id_estoque, id_produto, quantidade ) VALUES ( 1, 4, 20);
INSERT INTO "e-commerce 926".item_produto( id_estoque, id_produto, quantidade ) VALUES ( 2, 3, 32);
INSERT INTO "e-commerce 926".item_produto( id_estoque, id_produto, quantidade ) VALUES ( 2, 6, 43);
INSERT INTO "e-commerce 926".item_produto( id_estoque, id_produto, quantidade ) VALUES ( 2, 7, 150);
INSERT INTO "e-commerce 926".item_produto( id_estoque, id_produto, quantidade ) VALUES ( 2, 5, 45);
INSERT INTO "e-commerce 926".pedido( pedido, previsao_entrega, meio_pagamento, status, id_cliente, data_criacao ) VALUES ( 1, '2023-04-01', 'pix', 'pendente', 3, '2023-03-23 12:00:00 AM');
INSERT INTO "e-commerce 926".pedido( pedido, previsao_entrega, meio_pagamento, status, id_cliente, data_criacao ) VALUES ( 2, '2023-05-01', 'boleto', 'aguardando confirmação', 4, '2023-03-24 12:00:00 AM');
INSERT INTO "e-commerce 926".pedido( pedido, previsao_entrega, meio_pagamento, status, id_cliente, data_criacao ) VALUES ( 3, '2023-06-01', 'cartão de crédito', 'confirmado', 1, '2023-03-26 12:00:00 AM');
INSERT INTO "e-commerce 926".pedido( pedido, previsao_entrega, meio_pagamento, status, id_cliente, data_criacao ) VALUES ( 4, '2023-07-01', 'pix', 'cancelado', 2, '2023-03-25 12:00:00 AM');
INSERT INTO "e-commerce 926".pedido( pedido, previsao_entrega, meio_pagamento, status, id_cliente, data_criacao ) VALUES ( 5, '2023-09-01', 'débito em conta', 'confirmado', 3, '2023-03-25 12:00:00 AM');
INSERT INTO "e-commerce 926".pedido( pedido, previsao_entrega, meio_pagamento, status, id_cliente, data_criacao ) VALUES ( 6, '2023-10-01', 'pix', 'pendente', 1, '2023-03-26 12:00:00 AM');
INSERT INTO "e-commerce 926".pedido( pedido, previsao_entrega, meio_pagamento, status, id_cliente, data_criacao ) VALUES ( 7, '2023-11-01', 'pix', 'aguardando confirmação', 5, '2023-03-27 12:00:00 AM');
INSERT INTO "e-commerce 926".pedido( pedido, previsao_entrega, meio_pagamento, status, id_cliente, data_criacao ) VALUES ( 8, '2023-04-01', 'pix', 'pendente', 5, '2023-03-23 12:00:00 AM');
INSERT INTO "e-commerce 926".pedido( pedido, previsao_entrega, meio_pagamento, status, id_cliente, data_criacao ) VALUES ( 9, '2023-05-01', 'boleto', 'aguardando confirmação', 3, '2023-03-24 12:00:00 AM');
INSERT INTO "e-commerce 926".pedido( pedido, previsao_entrega, meio_pagamento, status, id_cliente, data_criacao ) VALUES ( 10, '2023-06-01', 'cartão de crédito', 'confirmado', 2, '2023-03-26 12:00:00 AM');
INSERT INTO "e-commerce 926".pedido( pedido, previsao_entrega, meio_pagamento, status, id_cliente, data_criacao ) VALUES ( 11, '2023-07-01', 'pix', 'cancelado', 2, '2023-03-25 12:00:00 AM');
INSERT INTO "e-commerce 926".pedido( pedido, previsao_entrega, meio_pagamento, status, id_cliente, data_criacao ) VALUES ( 12, '2023-09-01', 'débito em conta', 'confirmado', 5, '2023-03-25 12:00:00 AM');
INSERT INTO "e-commerce 926".pedido( pedido, previsao_entrega, meio_pagamento, status, id_cliente, data_criacao ) VALUES ( 13, '2023-10-01', 'pix', 'pendente', 1, '2023-03-26 12:00:00 AM');
INSERT INTO "e-commerce 926".pedido( pedido, previsao_entrega, meio_pagamento, status, id_cliente, data_criacao ) VALUES ( 14, '2023-11-01', 'pix', 'aguardando confirmação', 4, '2023-03-27 12:00:00 AM');
INSERT INTO "e-commerce 926".carrinho( id_cliente, id_produto, quantidade, data_incercao ) VALUES ( 1, 2, 1, '2023-03-27');
INSERT INTO "e-commerce 926".carrinho( id_cliente, id_produto, quantidade, data_incercao ) VALUES ( 1, 1, 2, '2023-03-26');
INSERT INTO "e-commerce 926".carrinho( id_cliente, id_produto, quantidade, data_incercao ) VALUES ( 1, 4, 1, '2023-03-27');
INSERT INTO "e-commerce 926".carrinho( id_cliente, id_produto, quantidade, data_incercao ) VALUES ( 2, 3, 1, '2023-03-27');
INSERT INTO "e-commerce 926".carrinho( id_cliente, id_produto, quantidade, data_incercao ) VALUES ( 2, 2, 1, '2023-03-25');
INSERT INTO "e-commerce 926".carrinho( id_cliente, id_produto, quantidade, data_incercao ) VALUES ( 2, 4, 1, '2023-03-25');
INSERT INTO "e-commerce 926".carrinho( id_cliente, id_produto, quantidade, data_incercao ) VALUES ( 2, 5, 1, '2023-03-25');
INSERT INTO "e-commerce 926".carrinho( id_cliente, id_produto, quantidade, data_incercao ) VALUES ( 4, 4, 1, '2023-03-25');
INSERT INTO "e-commerce 926".carrinho( id_cliente, id_produto, quantidade, data_incercao ) VALUES ( 3, 4, 1, '2023-03-25');
INSERT INTO "e-commerce 926".carrinho( id_cliente, id_produto, quantidade, data_incercao ) VALUES ( 3, 2, 1, '2023-03-25');
INSERT INTO "e-commerce 926".carrinho( id_cliente, id_produto, quantidade, data_incercao ) VALUES ( 6, 2, 1, '2023-03-25');
INSERT INTO "e-commerce 926".cupom( id, descricao, valor, data_inicio, data_expiracao, clientes, id_pedido ) VALUES ( 1, 'desconto em smartphones', 100, '2023-03-27', '2023-04-27', 'novos clientes', 6);
INSERT INTO "e-commerce 926".cupom( id, descricao, valor, data_inicio, data_expiracao, clientes, id_pedido ) VALUES ( 2, 'desconto para pagamentos em pix', 50, '2023-03-27', '2023-04-27', 'todos clientes', 8);
INSERT INTO "e-commerce 926".cupom( id, descricao, valor, data_inicio, data_expiracao, clientes, id_pedido ) VALUES ( 3, 'desconto dia das mães', 98, '2023-04-30', '2023-05-31', 'clientes selecionados', 5);
INSERT INTO "e-commerce 926".item_pedido( id_pedido, id_produto, quantidade, valor ) VALUES ( 1, 2, 1, 59.99);
INSERT INTO "e-commerce 926".item_pedido( id_pedido, id_produto, quantidade, valor ) VALUES ( 1, 5, 2, 159.98);
INSERT INTO "e-commerce 926".item_pedido( id_pedido, id_produto, quantidade, valor ) VALUES ( 2, 3, 1, 29.99);
INSERT INTO "e-commerce 926".item_pedido( id_pedido, id_produto, quantidade, valor ) VALUES ( 2, 4, 1, 199.99);
INSERT INTO "e-commerce 926".item_pedido( id_pedido, id_produto, quantidade, valor ) VALUES ( 2, 7, 1, 99.99);
INSERT INTO "e-commerce 926".item_pedido( id_pedido, id_produto, quantidade, valor ) VALUES ( 3, 3, 1, 29.99);
INSERT INTO "e-commerce 926".item_pedido( id_pedido, id_produto, quantidade, valor ) VALUES ( 3, 7, 1, 99.99);
INSERT INTO "e-commerce 926".item_pedido( id_pedido, id_produto, quantidade, valor ) VALUES ( 5, 6, 1, 59.99);
INSERT INTO "e-commerce 926".item_pedido( id_pedido, id_produto, quantidade, valor ) VALUES ( 5, 2, 1, 8999.99);
INSERT INTO "e-commerce 926".item_pedido( id_pedido, id_produto, quantidade, valor ) VALUES ( 6, 3, 1, 29.99);
INSERT INTO "e-commerce 926".item_pedido( id_pedido, id_produto, quantidade, valor ) VALUES ( 6, 2, 1, 59.99);
INSERT INTO "e-commerce 926".item_pedido( id_pedido, id_produto, quantidade, valor ) VALUES ( 6, 7, 1, 99.99);
INSERT INTO "e-commerce 926".item_pedido( id_pedido, id_produto, quantidade, valor ) VALUES ( 6, 5, 1, 79.99);