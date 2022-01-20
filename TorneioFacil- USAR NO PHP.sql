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