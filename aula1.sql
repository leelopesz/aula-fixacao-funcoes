-- Criação Banco de Dados
create database aula_fixacao;
use aula_fixacao;

-- Exercicio 1
-- a)
create table nomes (nome varchar(200));

insert into nomes (nome) values
	('Roberta'),
    ('Roberto'),
    ('Maria Clara'),
    ('João');

--b)
update nomes 
set nome = UPPER(nome);

--c)
select nome, length(nome) as tamanho from nomes;

--d)
select concat(
	if(nome like 'Roberta' or nome like 'Maria Clara', 'Sra.', 'Sr.'), nome) from nomes;

-- Exercicio 2
-- a)
create table produtos (
	produto varchar(200) not null,
	preco decimal not null,
	qtnd int not null);

--b)
update produtos set preco = round(preco, 2);

--c)
select produto, preco, abs(qtnd) as qntd_total from produtos;

--d)
select avg(preco) as media from produtos;

-- Exercicio 3
--a)
create table evento (
	data_evento datetime);

--b)
insert into evento (data_evento) values (now());

--c)
select datediff(now(), data_evento) as diferença_de_dias from evento;

--d)
select dayname(data_evento) as dia_semana from evento;

-- Exercicio 4
--a)
select produto, qtnd, if( qtnd>0, 'Em estoque', 'Fora de estoque') as estoque 
from produtos;

--b)
select produto, preco,
case 
	when preco <= 50 then 'Barato'
    when preco > 50 and preco <= 100 then 'Médio'
    when preco > 100 then 'Caro'
end as categoria
from produtos;

-- Exercicio 5
--a)
delimiter \\
create function total_valor (preco decimal , qtnd int) returns decimal 
begin 
	declare valor_total decimal (10,2);
    set valor_total = preco*qtnd;
    return valor_total;
end \\;
delimiter \\;

--b)
select produto, preco, qtnd, total_valor(preco, qtnd) as valor_total from produtos;

-- Exercicio 6
--a)
select  count(qtnd) as total_produtos from produtos;

--b)
select produto, preco from produtos 
where preco = (select max(preco) from produtos);

--c)
select produto, preco from produtos 
where preco = (select min(preco) from produtos);

--d)
select sum(if(qtnd>0, preco*qtnd,0)) as soma_estoque from produtos;

-- Exercicio 7
--a)
delimiter \\
create function Fatorial(nmr int) returns int
begin
    declare resul int default 1;
    declare i int default 1;
    while i <= nmr do
        set resul = resul * i;
        set i = i + 1;
    end while;
    return resul;
end \\
delimiter ;

select Fatorial(5) AS fatorial_5;

--b)
delimiter \\
create function exponencial(base decimal(10, 2), expoente int) returns decimal(10, 2)
begin
    declare resul decimal(10, 2);
    set resul = power(base, expoente);
    return resul;
END \\
delimiter ;

select exponencial(2, 3) AS exponencial_2;

--c)
delimiter \\
create function VPalindromo(palavra varchar(200)) returns int
begin
    declare reverso varchar(200);
    SET reverso = reverse(palavra);
    if palavra = reverso then
        return 1;
    else
        return 0;
    end if;
end \\
delimiter ;
