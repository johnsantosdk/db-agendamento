create database db_cmm_version_1;

use db_cmm_version_1;
/** Criação da tabelas entidades **/

create table pacientes(
	idpaciente integer auto_increment primary key,
    nome varchar(50) not null,
    sexo varchar(15) not null,
    nascimento date not null,
    cpf varchar(14) not null unique,
    email varchar(40) unique,
    created_at timestamp,
	updated_at timestamp
);


create table telefones(
	idtelefone integer auto_increment primary key,
    tipo enum('CEL', 'EMP', 'RES'),
    numero varchar(15) not null unique,
    pacienteid integer not null,
	created_at timestamp,
	updated_at timestamp
);

 
/** Um convênio pertence à um paciente, pois este convênio possui uma matricula única, exceto AERONÁUTICA 
Este convenio pertence a plano. 	deletedado ->>> plano_id integer unique,
**/
create table convenios(
	idconvenio integer auto_increment primary key,
    matricula varchar(40) not null unique,
    pacienteid integer not null unique,
    planoid integer not null,
	created_at timestamp, 
	updated_at timestamp
);

/** Um plano possui várias(N) matriculas que por sua vez pertence a um (1)paciente **/
create table planos(
	idplano integer auto_increment primary key,
    nome varchar(50) not null,
    status int(1) not null,
	created_at timestamp,
	updated_at timestamp
);
/**Um(a) atendente pode marca várias consultas para vários pacientes **/
create table atendentes(
	idatendente integer auto_increment primary key,
    nome varchar(50) not null,
    matricula int(11) not null unique,
    created_at timestamp,
	updated_at timestamp
);
/** Um médico tem uma ou várias especialidades (1,N)**/
create table medicos(
	idmedico integer auto_increment primary key,
    nome varchar(50) not null,
    cpf varchar(14)not null unique,
    crm varchar(20) not null unique,
    created_at timestamp,
	updated_at timestamp
);
/**Um hospital tem várias especialidades que por sua vez tem vários médicos com esta especialidades (0,N)**/
create table especialidades(
	idespecialidade integer auto_increment primary key,
    nome varchar(50) not null,
    created_at timestamp,
	updated_at timestamp
);
/**Em uma determinda data há nenhuma ou várias consultas marcadas para um determinado médico**/
create table consultas(
	idconsulta integer auto_increment primary key,
    data_consulta date not null,
    horario varchar(15) not null,
    pacienteid integer not null,
    medicoid integer not null,
    created_at timestamp,
	updated_at timestamp
);
/**CRIAÇÃO DAS TABBELAS DE RELAÇÕES**/
/**Relação NxN entre Médicos e suas Especialidadesidmedicoespecialidade integer auto_increment primary key,**/
create table medicoespecialidades(
    medicoid integer not null,
    especialidadeid integer not null,
    primary key(medicoid, especialidadeid),
    created_at timestamp,
	updated_at timestamp
);
create table atendentes_consultas(
	atendenteid integer,
    consultaid integer,
    primary key (atendenteid,consultaid),
    created_at timestamp,
	updated_at timestamp
);
#
CREATE TABLE agendas(
idagenda integer auto_increment primary key,
sunday int(1) default 0,
sunday_start_time time,
sunday_end_time time,
sunday_morning int(1) default 0,
sunday_afternoon int(1) default 0,
monday int(1) default 0,
monday_start_time time,
monday_end_time time,
monday_morning int(1) default 0,
monday_afternoon int(1) default 0,
tuesday int(1) default 0,
tuesday_start_time time,
tuesday_end_time time,
tuesday_morning int(1) default 0,
tuesday_afternoon int(1) default 0,
wednesday int(1) default 0,
wednesday_start_time time,
wednesday_end_time time,
wednesday_morning int(1) default 0,
wednesday_afternoon int(1) default 0,
thursday int(1) default 0,
thursday_start_time time,
thursday_end_time time,
thursday_morning int(1) default 0,
thursday_afternoon int(1) default 0,
friday int(1) default 0,
friday_start_time time,
friday_end_time time,
friday_morning int(1) default 0,
friday_afternoon int(1) default 0,
saturday int(1) default 0,
saturday_start_time time,
saturday_end_time time,
saturday_morning int(1) default 0,
saturday_afternoon int(1) default 0,
current int(1) default 0 not null,
medicoid integer not null,
especialidadeid integer not null
);

/** CRIAÇÃO DAS CONSTRAINTS **/
/**Paciente-Convenio**/
#Constraint: telefone pertence a uma pessoa
alter table telefones
add constraint fk_telefone_paciente
foreign key (pacienteid)
references pacientes(idpaciente)
on delete cascade;
#
alter table convenios 
add constraint fk_convenio_paciente 
foreign key (pacienteid) 
references pacientes(idpaciente)
on delete cascade;
/****/
alter table convenios 
add constraint fk_convenio_plano 
foreign key (planoid) 
references planos(idplano)
on delete cascade;
/**Plano-Convenio**/
/**Médio-Especialidade**/
alter table medicoespecialidades
add constraint fk_medico 
foreign key (medicoid) 
references medicos(idmedico)
on delete cascade;
/**Medico-Especialidade**/
alter table medicoespecialidades
add constraint fk_especialidade
foreign key (especialidadeid)
references especialidades(idespecialidade)
on delete cascade;
/**Atendente-Consulta**/
alter table atendentes_consultas
add constraint fk_atendente
foreign key (atendenteid)
references atendentes(idatendente);
#
alter table consultas
add constraint fk_consultas_paciente
foreign key (pacienteid)
references pacientes(idpaciente);
#Médico Consulta
alter table consultas
add constraint fk_consulta_medico
foreign key (medicoid)
references medicos(idmedico);

#Para a Nova table
alter table agendas
add constraint fk_agenda_medico
foreign key (medicoid)
references medicos(idmedico)
on delete cascade;


alter table agendas
add constraint fk_agenda_especialidade
foreign key (especialidadeid)
references especialidades(idespecialidade)
on delete cascade;