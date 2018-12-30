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
sunday_morning int(1) default 0,
sunday_morning_start_time time,
sunday_morning_end_time time,
sunday_afternoon int(1) default 0,
sunday_afternoon_start_time time,
sunday_afternoon_end_time time,
monday int(1) default 0,
monday_morning int(1) default 0,
monday_morning_start_time time,
monday_morning_end_time time,
monday_afternoon int(1) default 0,
monday_afternoon_start_time time,
monday_afternoon_end_time time,
tuesday int(1) default 0,
tuesday_morning int(1) default 0,
tuesday_morning_start_time time,
tuesday_morning_end_time time,
tuesday_afternoon int(1) default 0,
tuesday_afternoon_start_time time,
tuesday_afternoon_end_time time,
wednesday int(1) default 0,
wednesday_morning int(1) default 0,
wednesday_morning_start_time time,
wednesday_morning_end_time time,
wednesday_afternoon int(1) default 0,
wednesday_afternoon_start_time time,
wednesday_afternoon_end_time time,
thursday int(1) default 0,
thursday_morning int(1) default 0,
thursday_morning_start_time time,
thursday_morning_end_time time,
thursday_afternoon int(1) default 0,
thursday_afternoon_start_time time,
thursday_afternoon_end_time time,
friday int(1) default 0,
friday_morning int(1) default 0,
friday_morning_start_time time,
friday_morning_end_time time,
friday_afternoon int(1) default 0,
friday_afternoon_start_time time,
friday_afternoon_end_time time,
saturday int(1) default 0,
saturday_morning int(1) default 0,
saturday_morning_start_time time,
saturday_morning_end_time time,
saturday_afternoon int(1) default 0,
saturday_afternoon_start_time time,
saturday_afternoon_end_time time,
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