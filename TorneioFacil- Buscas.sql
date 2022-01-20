--------- busca todos os integrantes do time 1
--select nome, email, cpf, integrante.id_time from integrante INNER JOIN participa ON integrante.id_time = participa.id_time and participa.id_time = 1;

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