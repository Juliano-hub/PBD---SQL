create database TorneioFacil;
use TorneioFacil;

create table torneio (
	id_torneio serial not null, 
	dt_ini timestamp not null, 
	dt_fim timestamp not null, 
	orcamento int,
	endereco char(30)
);
alter table torneio add primary key(id_torneio);

create table patrocinador (
	id_patrocinio serial not null, 
	cpf varchar(11) not null, 
	nome varchar(30) not null, 
	contribuiçao int not null, 
	id_torneio int not null
);
alter table patrocinador add primary key(id_patrocinio);
alter table patrocinador add foreign key (id_torneio) references torneio (id_torneio) ON DELETE SET NULL ON UPDATE CASCADE;

create table organizador(
	cpf varchar(11) not null, 
	nome char(30) not null, 
	telefone char(9), 
	email char(30), 
	id_torneio int not null
);
alter table organizador add primary key(cpf);
alter table organizador add foreign key (id_torneio) references torneio (id_torneio) ON DELETE SET NULL ON UPDATE CASCADE;

create table dias (
	id_dias serial not null, 
	dt_ini timestamp not null, 
	hr_ini time not null, 
	id_torneio int not null
);
alter table dias add primary key(id_dias);
alter table dias add foreign key (id_torneio) references torneio (id_torneio) ON DELETE SET NULL ON UPDATE CASCADE;

create table ingresso(
	id_ingresso serial not null, 
	valor int not null, 
	dt_partida timestamp not null, 
	nmr_assento int not null, 
	cpf varchar(11) not null,
	id_torneio int not null,
	id_dias int not null
);
alter table ingresso add primary key(id_ingresso);
alter table ingresso add foreign key (id_torneio) references torneio (id_torneio) ON DELETE SET NULL ON UPDATE CASCADE;
alter table ingresso add foreign key (id_dias) references dias (id_dias) ON DELETE SET NULL ON UPDATE CASCADE;

create table patrocinadormaterial (
	id_patrocinio serial not null, 
	cpf varchar(11) not null, 
	nome varchar(30) not null,
	tipo varchar(30) not null, 
	dt_aquisicao timestamp not null, 
	local_guardado char(30) not null,
	id_torneio int not null
);
alter table patrocinadormaterial add primary key(id_patrocinio);
alter table patrocinadormaterial add foreign key (id_torneio) references torneio (id_torneio) ON DELETE SET NULL ON UPDATE CASCADE;

create table times (
	id_time serial not null, 
	nome_time varchar(30),
	nmr_integrantes int not null, 
	total_partidas int not null, 
	rodadaatual int not null, 
	eliminado boolean not null, 
	id_torneio int not null
);
alter table times add primary key(id_time);
alter table times add foreign key (id_torneio) references torneio (id_torneio)  ON DELETE SET NULL ON UPDATE CASCADE;

create table integrante (
	cpf varchar(11) not null, 
	nome char(30) not null, 
	email char(30) not null, 
	id_time int not null
);
alter table integrante add primary key(cpf);
alter table integrante add foreign key (id_time) references times (id_time)	ON DELETE SET NULL ON UPDATE CASCADE;

create table alugadoemprestado (
	id_equipamento serial not null, 
	tipo varchar(30), 
	datadevolucao timestamp not null, 
	valor int, 
	emprestado boolean not null,
	partdesiguinada char(30), 
	id_patrocinio int not null
);
alter table alugadoemprestado add primary key(id_equipamento);
alter table alugadoemprestado add foreign key (id_patrocinio) references patrocinadormaterial (id_patrocinio) ON DELETE SET NULL ON UPDATE CASCADE;

create table comprado (
	id_equipamento serial not null, 
	tipo varchar(30), 
	partdesiguinada char(30), 
	valor int
);
alter table comprado add primary key(id_equipamento);

create table designado_comprado (
	id_dias int not null,
	id_equipamento_comprado int not null
);
alter table designado_comprado add foreign key (id_equipamento_comprado) references comprado (id_equipamento) ON DELETE SET NULL ON UPDATE CASCADE;
alter table designado_comprado add foreign key (id_dias) references dias (id_dias) ON DELETE SET NULL ON UPDATE CASCADE;

create table designado_alugadoemprestado (
	id_dias int not null,
	id_equipamento int not null
);
alter table designado_alugadoemprestado add foreign key (id_equipamento) references alugadoemprestado (id_equipamento) ON DELETE SET NULL ON UPDATE CASCADE;
alter table designado_alugadoemprestado add foreign key (id_dias) references dias (id_dias) ON DELETE SET NULL ON UPDATE CASCADE;

create table participa(
	id_dias int not null, 
	id_time int not null
);
alter table participa add foreign key (id_dias) references dias (id_dias) ON DELETE SET NULL ON UPDATE CASCADE;
alter table participa add foreign key (id_time) references times (id_time) ON DELETE SET NULL ON UPDATE CASCADE;

--Começar a adicionar os dados
INSERT INTO torneio VALUES (1, '20-10-2010', '23-10-2010', 10000, 'Av. Rio. Nro.8');

INSERT INTO patrocinador VALUES (1, '11111111111', 'Alex', 2000, 1);
INSERT INTO patrocinador VALUES (2, '22222222222', 'Roberto', 3000, 1);
INSERT INTO patrocinador VALUES (3, '33333333333', 'Roberta', 4000, 1);
INSERT INTO patrocinador VALUES (4, '44444444444', 'Julio', 5000, 1);

INSERT INTO organizador VALUES ('55555555555', 'James', 111111111, 'ex1@gmail.com', 1);
INSERT INTO organizador VALUES ('66666666666', 'Jesse', 222222222, 'ex2@gmail.com', 1);
INSERT INTO organizador VALUES ('77777777777', 'Cris', 333333333, 'ex3@gmail.com', 1);
INSERT INTO organizador VALUES ('88888888888', 'Alberto', 444444444, 'ex4@gmail.com', 1);

INSERT INTO dias VALUES (1, '20-10-2010', '03:30', 1);
INSERT INTO dias VALUES (2, '21-10-2010', '04:10', 1);
INSERT INTO dias VALUES (3, '22-10-2010', '04:00', 1);
INSERT INTO dias VALUES (4, '23-10-2010', '03:00', 1);

INSERT INTO ingresso VALUES (1, 15, '20-10-2010', 1, '99999999999', 1, 1);
INSERT INTO ingresso VALUES (2, 10, '21-10-2010', 2, '10101010101', 1, 2);
INSERT INTO ingresso VALUES (3, 20, '22-10-2010', 3, '12121212121', 1, 3);
INSERT INTO ingresso VALUES (4, 25, '23-10-2010', 4, '13131313131', 1, 4);

INSERT INTO patrocinadormaterial VALUES (1,'94949494945', 'Elder', 'Cadeira', '15-10-2010', 'Galpão', 1);
INSERT INTO patrocinadormaterial VALUES (2,'93939393935', 'Clara', 'Mesa', '15-10-2010', 'Galpão', 1);
INSERT INTO patrocinadormaterial VALUES (3,'92929292925', 'Maria', 'Computador', '15-10-2010', 'Galpão', 1);
INSERT INTO patrocinadormaterial VALUES (4,'91919191915', 'Jana', 'Headset', '15-10-2010', 'Galpão', 1);

INSERT INTO times VALUES (1, 'A', 4, 1, 1, TRUE, 1);
INSERT INTO times VALUES (2, 'B', 4, 2, 2, TRUE, 1);
INSERT INTO times VALUES (3, 'C', 4, 3, 4, TRUE, 1);
INSERT INTO times VALUES (4, 'D', 4, 2, 4, FALSE, 1);

INSERT INTO comprado VALUES (1, 'cadeira', 'Av. Rio. Nro.8', 100);
INSERT INTO comprado VALUES (2, 'mesa', 'Av. Rio. Nro.8', 222);
INSERT INTO comprado VALUES (3, 'computador', 'Av. Rio. Nro.8', 300);
INSERT INTO comprado VALUES (4, 'fones', 'Av. Rio. Nro.8', 40);

INSERT INTO alugadoemprestado  VALUES (1, 'microfone', '24-10-2010', 100, FALSE, 'Av. Rio. Nro.8', 1);
INSERT INTO alugadoemprestado  VALUES (2, 'Caixa de som', '24-10-2010', NULL , TRUE, 'Av. Rio. Nro.8', 2);
INSERT INTO alugadoemprestado  VALUES (3, 'teclado', '24-10-2010', NULL , TRUE, 'Av. Rio. Nro.8', 3);
INSERT INTO alugadoemprestado  VALUES (4, 'monitor', '24-10-2010', 200, FALSE, 'Av. Rio. Nro.8', 4);

INSERT INTO designado_comprado VALUES (1, 1);
INSERT INTO designado_comprado VALUES (1, 2);
INSERT INTO designado_comprado VALUES (1, 3);
INSERT INTO designado_comprado VALUES (1, 4);
INSERT INTO designado_comprado VALUES (2, 1);
INSERT INTO designado_comprado VALUES (2, 2);
INSERT INTO designado_comprado VALUES (2, 3);
INSERT INTO designado_comprado VALUES (2, 4);
INSERT INTO designado_comprado VALUES (3, 1);
INSERT INTO designado_comprado VALUES (3, 2);
INSERT INTO designado_comprado VALUES (3, 3);
INSERT INTO designado_comprado VALUES (3, 4);
INSERT INTO designado_comprado VALUES (4, 1);
INSERT INTO designado_comprado VALUES (4, 2);
INSERT INTO designado_comprado VALUES (4, 3);
INSERT INTO designado_comprado VALUES (4, 4);

INSERT INTO designado_alugadoemprestado VALUES (1, 1);
INSERT INTO designado_alugadoemprestado VALUES (1, 2);
INSERT INTO designado_alugadoemprestado VALUES (1, 3);
INSERT INTO designado_alugadoemprestado VALUES (1, 4);
INSERT INTO designado_alugadoemprestado VALUES (2, 1);
INSERT INTO designado_alugadoemprestado VALUES (2, 2);
INSERT INTO designado_alugadoemprestado VALUES (2, 3);
INSERT INTO designado_alugadoemprestado VALUES (2, 4);
INSERT INTO designado_alugadoemprestado VALUES (3, 1);
INSERT INTO designado_alugadoemprestado VALUES (3, 2);
INSERT INTO designado_alugadoemprestado VALUES (3, 3);
INSERT INTO designado_alugadoemprestado VALUES (3, 4);
INSERT INTO designado_alugadoemprestado VALUES (4, 1);
INSERT INTO designado_alugadoemprestado VALUES (4, 2);
INSERT INTO designado_alugadoemprestado VALUES (4, 3);
INSERT INTO designado_alugadoemprestado VALUES (4, 4);

INSERT INTO participa  VALUES (1, 1);
INSERT INTO participa  VALUES (1, 2);
INSERT INTO participa  VALUES (2, 2);
INSERT INTO participa  VALUES (2, 3);
INSERT INTO participa  VALUES (3, 3);
INSERT INTO participa  VALUES (3, 4);
INSERT INTO participa  VALUES (4, 3);
INSERT INTO participa  VALUES (4, 4);

INSERT INTO integrante  VALUES ('30303030303', 'Albert', 'ex10@gmail.com', 1);
INSERT INTO integrante  VALUES ('31313131313', 'Roger', 'ex11@gmail.com', 1);
INSERT INTO integrante  VALUES ('32323232323', 'Mark', 'ex12@gmail.com', 1);
INSERT INTO integrante  VALUES ('34343434343', 'Fernando', 'ex13@gmail.com', 1);
INSERT INTO integrante  VALUES ('35353535353', 'Julia', 'ex14@gmail.com', 2);
INSERT INTO integrante  VALUES ('36363636363', 'Lucas', 'ex15@gmail.com', 2);
INSERT INTO integrante  VALUES ('37373737373', 'Fernando', 'ex16@gmail.com', 2);
INSERT INTO integrante  VALUES ('38383838383', 'Juliano', 'ex17@gmail.com', 2);
INSERT INTO integrante  VALUES ('39393939393', 'Matheus', 'ex18@gmail.com', 3);
INSERT INTO integrante  VALUES ('40404040404', 'Junior', 'ex19@gmail.com', 3);
INSERT INTO integrante  VALUES ('41414141414', 'Sabrina', 'ex20@gmail.com', 3);
INSERT INTO integrante  VALUES ('42424242424', 'Henrique', 'ex21@gmail.com', 3);
INSERT INTO integrante  VALUES ('43434343434', 'Gabriel', 'ex22@gmail.com', 4);
INSERT INTO integrante  VALUES ('45454545454', 'Alberta', 'ex23@gmail.com', 4);
INSERT INTO integrante  VALUES ('46464646464', 'Patricia', 'ex24@gmail.com', 4);
INSERT INTO integrante  VALUES ('47474747474', 'Tulio', 'ex25@gmail.com', 4);

--------- busca todos os integrantes do time 1
select nome, email, cpf, integrante.id_time from integrante INNER JOIN participa ON integrante.id_time = participa.id_time and participa.id_time = 1;

-- busca todas as partidas e os times que vão jogar naquele dia
select nome_time, dt_ini, hr_ini FROM dias INNER JOIN participa ON participa.id_dias = dias.id_dias INNER JOIN times ON times.id_time = participa.id_time ORDER BY dt_ini ASC;

-- bucas o nome, data e valor do equipamento, basicamente em qual dia ele foi alocado 
select tipo, dt_ini, valor FROM dias JOIN designado_comprado ON dias.id_dias = designado_comprado.id_dias JOIN comprado ON comprado.id_equipamento = designado_comprado.id_equipamento_comprado ORDER BY dt_ini ASC;

-- busca todos os patrocinadores que deram dinheiro
select cpf, nome, contribuiçao from patrocinador  ORDER BY contribuiçao;

-- busca os dados de ingresso
select valor, nmr_assento, cpf, id_ingresso, id_dias from ingresso;

-- busca os dados de organizador
select nome, telefone, cpf, email from organizador;
