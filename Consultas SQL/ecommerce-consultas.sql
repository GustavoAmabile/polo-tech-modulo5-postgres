-- 1
SELECT * FROM cliente WHERE nome LIKE '%Ana%';

-- 2 
SELECT * FROM pedido WHERE date_part('year', data_criacao) = 2023;

-- 3
SELECT * FROM pedido WHERE date_part('month', data_criacao) = 01;

-- 4
SELECT * FROM item_pedido WHERE valor BETWEEN 2.00 AND 5.00;

-- 5
SELECT * FROM item_pedido WHERE valor >= 2.00 AND valor <= 5.00;

-- 6
SELECT * FROM item_pedido WHERE valor = (SELECT MAX(valor) FROM item_pedido)