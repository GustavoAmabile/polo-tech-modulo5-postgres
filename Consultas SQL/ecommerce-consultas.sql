-- 1
select * from cliente where nome like '%Ana%';

-- 2 
select * from pedido where date_part('year', data_criacao) = 2023;

-- 3
select * from pedido where date_part('month', data_criacao) = 01;

-- 4
select * from item_pedido where valor between 2.00 and 5.00;

-- 5
select * from item_pedido where valor >= 2.00 and valor <= 5.00;

-- 6
select * from item_pedido where valor = (select max(valor) from item_pedido)

-- 7
select max(valor) as maior_valor, 
min(valor) as menor_valor,
avg(valor) as media_valor from ecommerce926.produto p;

-- 8
select f.nome as "Nome", f.cnpj as "CNPJ", e.logradouro as "Logradouro", e.numero as "Numero", e.cidade as "Cidade", e.uf as "UF"
from fornecedor f 
join endereco e on f.id_endereco = e.id 


-- 9
select e.id as "Id Estoque", p.descricao as "Descrição Produto", ie.quantidade as "Quantidade Estoque", 
e2.logradouro as "Logradouro", e2.numero as "Numero Endereço", e2.cidade as "Cidade", e2.uf as "UF"
from estoque e
join item_estoque ie on ie.id_estoque = e.id 
join produto p on ie.id_produto = p.id 
join endereco e2 ON e2.id = e.id_endereco 

-- 10
select ecommerce926.produto.descricao, ecommerce926.produto.codigo_barras,
sum(ecommerce926.item_estoque.quantidade) as quantidade_total
from ecommerce926.produto
join ecommerce926.item_estoque on ecommerce926.produto.id = ecommerce926.item_estoque .id_produto 
group by ecommerce926.produto.descricao, ecommerce926.produto.codigo_barras;

-- 11
select p.descricao as "Descrição", ic.quantidade as "Quantidade", p.valor as "Valor", c.cpf as "CPF Cliente" from item_carrinho ic 
join cliente c on c.id = ic.id_cliente 
join produto p on p.id = ic.id_produto 
where c.cpf = '26382080861'

-- 12 
select ecommerce926.cliente.id as id_cliente, ecommerce926.cliente.nome,
ecommerce926.cliente.cpf, count(distinct ecommerce926.item_carrinho.id_produto) as quantidade_produtos
from ecommerce926.cliente join ecommerce926.item_carrinho on ecommerce926.cliente.id = ecommerce926.item_carrinho.id_cliente 
group by ecommerce926.cliente.id, ecommerce926.cliente.nome, ecommerce926.cliente.cpf
order by quantidade_produtos desc;

-- 13
select ic.id_produto as "ID Produto", p.descricao as "Descri produto", ic.data_insercao as "Data Inserção", ic.id_cliente as "ID cliente", c.nome as "Nome cliente"
from item_carrinho ic 
join produto p on p.id = ic.id_produto 
join cliente c on c.id = ic.id_cliente 
where ic.data_insercao <= (current_date - interval '10 months')
order by ic.data_insercao desc 

-- 14
select e.uf as "UF", count(c.id) from endereco e 
join cliente c on c.id_endereco = e.id
group by e.uf order by e.uf asc

-- 15
select ecommerce926.endereco.cidade as cidade, count(ecommerce926.cliente.id) as quantidade_clientes
from ecommerce926.cliente
join ecommerce926.endereco on ecommerce926.cliente.id_endereco = ecommerce926.endereco.id 
group by ecommerce926.endereco.cidade
order by quantidade_clientes desc 
limit 1;