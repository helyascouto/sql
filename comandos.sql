create database DINOLANDIA

create table grupo
(
    id int not null primary key identity,
    nome varchar(50)
)
create table descobridor
(
    id int not null primary key identity,
    nome varchar(50)
)
create table era
(
    id int not null primary key identity,
    nome varchar(50),
)
create table pais
(
    id int not null primary key identity,
    nome varchar(50)
)
create table dinossauro
(
    id int not null primary key identity,
    nome varchar(50) not null,
    fk_grupo int not null,
    fk_descobridor int not null,
    toneladas int,
    ano_descoberta date,
    inicio int,
    fim int,
    fk_era int,
    fk_pais int,
    foreign key (fk_grupo) references grupo(id),
    foreign key (fk_descobridor) references descobridor(id),
    foreign key (fk_era) references era(id),
    foreign key (fk_pais) references pais(id)
)
insert into grupo
values('Anquilossauros')
insert into grupo
values('Ceratopsídeos')
insert into grupo
values('Estegossauros')
insert into grupo
values('Terápodes')
insert into descobridor
values('Maryanska')
insert into descobridor
values('John Bell Hatcher')
insert into descobridor
values('Cientistas Alemães')
insert into descobridor
values('Museu Americano de História Natural')
insert into descobridor
values('Othniel Charles Marsh')
insert into descobridor
values('Barn Brown')
insert into era
values('Cretáceo')
insert into era
values('Jurássico')
insert into pais
values('Mongólia')
insert into pais
values('Canadá')
insert into pais
values('Tanzânia')
insert into pais
values('China')
insert into pais
values('USA')
insert into dinossauro
values('Saichania', 1, 1, 4, '1977', 145, 66, 1, 1)
insert into dinossauro
values('Tricerátops', 2, 2, 6, '1887', 70, 66, 1, 2)
insert into dinossauro
values('Kentrossauro', 3, 3, 2, '1909', 201, 145, 2, 3)
insert into dinossauro
values('Pinacossauro', 1, 4, 6, '1877', 85, 75, 1, 4)
insert into dinossauro
values('Alossauro', 4, 5, 3, '1999', 155, 150, 2, 5)
insert into dinossauro
values('Torossauro', 1, 2, 8, '1891', 67, 65, 1, 5)
insert into dinossauro
values('Anquilossauro', 1, 6, 8, '1906', 67, 63, 1, 5)
select *
from dinossauro
order by dinossauro.nome
select dinossauro.nome, grupo.nome as [nome do grupo], descobridor.nome as [nome do descobridor],
    dinossauro.toneladas as [peso em toneladas], dinossauro.ano_descoberta, era.nome as [era] , pais. nome as[pais]
from dinossauro
    inner join grupo on grupo.id = dinossauro.fk_grupo
    inner join descobridor on descobridor.id = dinossauro.fk_descobridor
    inner join era on era.id = dinossauro.fk_era
    inner join pais on pais.id = dinossauro.fk_pais
order by dinossauro.nome
select *
from dinossauro
    inner join grupo on grupo.id = dinossauro.fk_grupo
where grupo.nome = 'Anquilossauros'
order by dinossauro.ano_descoberta
select *
from dinossauro
    inner join grupo on grupo.id = dinossauro.fk_grupo
where grupo.nome = 'Ceratopsídeos' or grupo.nome ='Anquilossauros' and dinossauro.ano_descoberta >= '1900' and dinossauro.ano_descoberta <='1999'
select pais.nome, count(*) as [Nº de dinossauros por pais]
from dinossauro
    inner join pais on pais.id = dinossauro.fk_pais
group by pais.nome
select avg(dinossauro.toneladas) as [Média de toneladas]
from dinossauro
where dinossauro.fk_pais = 5
select descobridor.nome, COUNT(*) as [Nº de dinossauros por descobridor]
from dinossauro
    inner join descobridor on descobridor.id = dinossauro.fk_descobridor
group by descobridor.nome



SELECT COUNT(codigo) [tota de produtos]
FROM produto
where fk_categoria in (1,2,6)

SELECT MAX(preco)[maior produto]
from produto
where fk_categoria =2

SELECT min(preco)[maior produto]
from produto
where fk_categoria = 1

SELECT avg(preco)[media preço]
from produto

SELECT SUM(estoque)[total estoque]
from produto

SELECT SUM(preco)[Preço total]
from produto

SELECT fk_categoria, SUM(estoque)[estoque total]
from produto
GROUP by fk_categoria
SELECT fk_categoria, SUM(preco)[estopreço total]
from produto
GROUP by fk_categoria

SELECT ROUND(AVG(preco),2,0) FROM produto

SELECT categoria.nome[nome categoria] , produto.nome[nome produto]
from produto INNER JOIN categoria on fk_categoria = categoria.id ; 


create trigger exercicio1
on dinossauro
after insert, update
as 
begin    
declare @ini int    
declare @fim int    
select @ini = (select inserted.inicio from inserted)
    select @fim = (select inserted.fim    from inserted)
    if(@fim < @ini)
    begin        
	PRINT('Dinossauro cadastrado com sucesso!')
    end
    else
    begin        ROLLBACK;
        RAISERROR('Datas inválidas!', 14, 1);
        return;
    end
end


create trigger exercicio2
on dinossauro
after insert, update
as
begin
    declare @dinoIni Int
    declare @dinoFim Int
    declare @eraIni Int
    declare @eraFim Int
    select @dinoIni = (select inserted.inicio from inserted)
    select @dinoFim = (select inserted.fim from inserted)
    select @eraIni = (select era.inicio from era inner join inserted on inserted.fk_era = era.id)
    select @eraFim = (select era.fim from era inner join inserted on inserted.fk_era = era.id)
    if (@dinoIni < @eraIni) and (@dinoFim > @eraFim)
    begin
        print('Dinossauro cadastrado!');
    end
    else
    begin
        rollback;
        raiserror('Datas do dinosauro não conferem com a Era informada!', 14, 1);
        return;
    end
end

