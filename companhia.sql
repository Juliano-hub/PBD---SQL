create table Empregado (pnome varchar(15) not null, mnome char, snome varchar(15) not null , nss char(9) not null, datanasc date, endereco varchar(30), sexo char, salario decimal(10,2), nsssuper char(9), ndep int not null);
alter table Empregado add primary key(nss);
insert into Empregado (pnome, mnome, snome, nss, datanasc, endereco, sexo, salario, ndep) values ('James', 'E', 'Borg', '888665555', '1927-11-18', 'Av. H. 8', 'M', 5500, 1);
alter table Empregado add foreign key (nsssuper) references Empregado(nss) on delete set null on update cascade; 
create table Departamento (dnome varchar(15) not null, dnumero int not null, nssger char(9) not null, datainicger date, primary key (dnumero));
insert into Departamento values ('Gerencial', '1', '888665555', '1971-06-19');
alter table Empregado add foreign key (ndep) references Departamento(dnumero);
alter table Departamento alter nssger set default '888665555';
alter table Departamento add constraint Departamento_Nome unique (dnome);
create table Locais_depto (dnumero int not null, dlocalizacao varchar(15) not null, primary key(dnumero, dlocalizacao), foreign key(dnumero) references Departamento(dnumero) on delete cascade);
create table Dependente (nssemp char(9) not null, nomedependente varchar(15) not null, sexo char, dataniv date, relacao varchar(8), primary key(nssemp, nomedependente), foreign key(nssemp) references empregado (nss));
create table Projeto (pnome varchar(15) not null, pnumero int not null, plocalizacao varchar(15), dnum int not null, primary key(pnumero), foreign key (dnum) references Departamento (dnumero));
create table Trabalha_em (nssemp char(9) not null, pnro int not null, horas decimal(3,1) not null, primary key(nssemp, pnro), foreign key(pnro) references projeto (pnumero) on delete cascade);
insert into Departamento (dnome, dnumero) values ('pesquisa',5), ('administrativo', 4);
insert into Empregado values ('Franklin', 'T', 'Wong', '333445555', '1945-12-08', 'R. B2', 'M', 4000, '888665555', 5);
alter table Trabalha_em alter column horas type decimal(3,1);
alter table Trabalha_em alter horas drop not null;
alter table Projeto add constraint nome_projeto unique (pnome);
alter table Empregado add column funcao varchar(12);
insert into Empregado values ('Jennifer', 'S', 'Wallace', '987654321', '1931-06-20', 'Trav. D. 4', 'F', 4300, '888665555', 4, NULL), ('Alicia', 'J', 'Zelaya', '999887777',
'1958-07-19', 'Av. C. 3', 'F', 2500, '987654321', 4, NULL), ('Ramesh', 'K', 'Narayan', '666884444', '1952-09-15', 'R. E. 5', 'M', 3800, '333445555', 5, NULL), ('Joyce', 'A', 'English', '453453453',
'1962-07-31', 'R. F. 6', 'F', 2500, '333445555', 5, NULL), ('Ahmad', 'V', 'Jabbar', '987987987', '1959-03-29', 'Av. G. 7', 'M', 2500, '987654321', 4, 'Assistente');

update Departamento set NSSGER='987654321' where DNUMERO=4;
update Departamento set NSSGER='333445555' where DNUMERO=5;
update Departamento set datainicger ='1880-07-01' where dnumero=5;
update Departamento set datainicger ='1800-03-10' where dnumero=4;

insert into Empregado values ('John', 'B', 'Smith', '123456789', '1965-01-09', 'F. H. 731', 'M', '3000', '333445555', '5', NULL);

insert into Locais_depto values (1, 'Houston'), (4, 'Stafford'), (5, 'Bellaire'), (5, 'Sugariand'), (5, 'Houston');
insert into Projeto values ('ProdutoX', 1, 'Bellaire', 5), ('ProdutoY', 2, 'Sugarland', 5), ('ProdutoZ', 3, 'Houston', 5), ('Automação', 10, 'Stafford', 4), ('Reorganização', 20, 'Houston', 1), ('Beneficiamento', 30, 'Stafford', 4);
insert into Trabalha_em values ('123456789', 1, 32.5),('123456789', 2, 7.5),('666884444', 3, 40.0),('453453453', 1, 20.0),('453453453', 2, 20.0),('333445555', 2, 10.0),('333445555', 3, 10.0),('333445555', 10, 10.0),('333445555', 20, 10.0),('999887777', 30, 30.0),('999887777', 10, 10.0),('987987987', 10, 35.0),('987987987', 30, 5.0),('987654321', 30, 20.0),('987654321', 20, NULL);
insert into Dependente values ('333445555', 'Alice', 'F', '1976-04-05', 'FILHA'),('333445555', 'Theodore', 'M', '1973-10-25', 'FILHO'),('333445555', 'Joy', 'F', '1948-05-03', 'ESPOSA'),('987654321', 'Abner', 'M', '1978-02-28', 'MARIDO'),('123456789', 'Michael', 'M', '1978-01-01', 'FILHO'),('123456789', 'Alice', 'F', '1978-12-31', 'FILHA'),('123456789', 'Elizabeth', 'F', '1957-05-05', 'ESPOSA');

select datanasc, endereco from Empregado where snome = 'Smith' and pnome = 'John';
select endereco, pnome, snome from Empregado,Departamento where Departamento.dnome = 'pesquisa' and dnumero = ndep;
select dnome, dlocalizacao from Departamento natural join Locais_depto where dnome = 'pesquisa';

select * from Empregado
select ndep, count(*), avg(salario) from Empregado group by ndep;
------------------- count(*) é quantas vezes o identificador que está sendo agrupado aparece
select pnumero, pnome, count(*)  from projeto, Trabalha_em where pnumero=pnro group by pnumero, pnome;

select pnumero, pnome, count(*)  from projeto, Trabalha_em where pnumero=pnro group by pnumero, pnome having count(*) > 2;
----------------------------------------------------------------------------------------------------- having seleciona só os q tem determinada caracteristica

select pnumero, pnome, count(*)  from projeto, Trabalha_em where pnumero=pnro group by pnumero, pnome having count(*) > 2 order by pnumero;
----------------------------------------------------------------------------------------------------- order by ordena pelo atributo dado