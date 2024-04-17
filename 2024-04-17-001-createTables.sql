-- Camilo Camacho
CREATE SCHEMA IF NOT EXISTS lookup;
CREATE SCHEMA IF NOT EXISTS org;
-- Lookup
create table lookup.city (
    id integer not null,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    city_code varchar(8),
    city_type varchar(16) not null,
    latitude float(53),
    longitude float(53),
    province_id integer not null,
    primary key (id)
);
create table lookup.city_text (
    id integer not null,
    lang varchar(2) not null,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    name varchar(64),
    primary key (id, lang)
);
create table lookup.country (
    id integer not null,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    abbr2 varchar(2) not null,
    abbr3 varchar(3) not null,
    facility_enabled boolean DEFAULT false not null,
    primary key (id)
);
create table lookup.country_text (
    id integer not null,
    lang varchar(2) not null,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    name varchar(255),
    official_name varchar(255),
    primary key (id, lang)
);
create table lookup.court_feature (
    id integer not null,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    court_feature_type varchar(255) not null,
    primary key (id)
);
create table lookup.court_feature_text (
    id integer not null,
    lang varchar(2) not null,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    name varchar(64),
    primary key (id, lang)
);
create table lookup.interruption_type (
    id integer not null,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    level varchar(8) not null,
    primary key (id)
);
create table lookup.interruption_type_text (
    id integer not null,
    lang varchar(2) not null,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    name varchar(32),
    primary key (id, lang)
);
create table lookup.province (
    id integer not null,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    abbr2 varchar(2) not null,
    country_id integer not null,
    is_territory boolean not null,
    official_code integer not null,
    primary key (id)
);
create table lookup.province_text (
    id integer not null,
    lang varchar(2) not null,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    name varchar(255),
    primary key (id, lang)
);
create table lookup.region (
    id integer not null,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    province_id integer not null,
    primary key (id)
);
create table lookup.region_city (
    id integer not null,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    city_id integer not null,
    region_id integer not null,
    primary key (id)
);
create table lookup.region_text (
    id integer not null,
    lang varchar(2) not null,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    name varchar(64),
    primary key (id, lang)
);
create table lookup.sport (
    id integer not null,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    has_court boolean not null,
    has_two_teams boolean not null,
    primary key (id)
);
create table lookup.sport_text (
    id integer not null,
    lang varchar(2) not null,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    name varchar(32),
    primary key (id, lang)
);
--alter
alter table if exists lookup.region_city
add constraint UKbsj1k1hqblkgswsfdhb04egs3 unique (region_id, city_id);
alter table if exists lookup.city_text
add constraint FK1pyvtu3w85156mvlrwgcrd2g3 foreign key (id) references lookup.city;
alter table if exists lookup.country_text
add constraint FK6lcjb50cwtimeg4fa5ajm6ru6 foreign key (id) references lookup.country;
alter table if exists lookup.court_feature_text
add constraint FKbjd6d84utas5ebsexihvg6pwd foreign key (id) references lookup.court_feature;
alter table if exists lookup.interruption_type_text
add constraint FK9cv3wv6ljhcu4q965lcy4a95u foreign key (id) references lookup.interruption_type;
alter table if exists lookup.province_text
add constraint FKjix39udd6qkcmx9mdrd9eyx82 foreign key (id) references lookup.province;
alter table if exists lookup.region_text
add constraint FK2467gutifou0pcqnmfcpkd6hl foreign key (id) references lookup.region;
alter table if exists lookup.sport_text
add constraint FKk22g32uwwb2hlt9k8mx69aklh foreign key (id) references lookup.sport;
-- Create ORG
create table org.address (
    id integer not null,
    created_at TIMESTAMP DEFAULT NOW(),
    created_by varchar(32),
    updated_at TIMESTAMP DEFAULT NOW(),
    updated_by varchar(32),
    city_id integer not null,
    country_id integer not null,
    post_code varchar(7),
    province_id integer not null,
    primary key (id)
);
create table org.address_text (
    lang varchar(2) not null,
    id integer not null,
    created_at TIMESTAMP DEFAULT NOW(),
    created_by varchar(32),
    updated_at TIMESTAMP DEFAULT NOW(),
    updated_by varchar(32),
    city_name varchar(128),
    line1 varchar(256),
    line2 varchar(256),
    primary key (id, lang)
);
create table org.closure (
    id integer not null,
    created_at TIMESTAMP DEFAULT NOW(),
    created_by varchar(32),
    updated_at TIMESTAMP DEFAULT NOW(),
    updated_by varchar(32),
    end_dt timestamp(6),
    facility_id integer,
    interruption_type_id integer not null,
    start_dt timestamp(6) not null,
    uid uuid not null,
    primary key (id)
);
create table org.club (
    id integer not null,
    created_at TIMESTAMP DEFAULT NOW(),
    created_by varchar(32),
    updated_at TIMESTAMP DEFAULT NOW(),
    updated_by varchar(32),
    uid uuid not null,
    address_id integer,
    primary key (id)
);
create table org.club_employee (
    id integer not null,
    created_at TIMESTAMP DEFAULT NOW(),
    created_by varchar(32),
    updated_at TIMESTAMP DEFAULT NOW(),
    updated_by varchar(32),
    club_id integer not null,
    employee_id integer not null,
    role_ids integer array not null,
    primary key (id)
);
create table org.club_text (
    id integer not null,
    lang varchar(2) not null,
    created_at TIMESTAMP DEFAULT NOW(),
    created_by varchar(32),
    updated_at TIMESTAMP DEFAULT NOW(),
    updated_by varchar(32),
    name varchar(255) not null,
    primary key (id, lang)
);
create table org.court (
    id integer not null,
    created_at TIMESTAMP DEFAULT NOW(),
    created_by varchar(32),
    updated_at TIMESTAMP DEFAULT NOW(),
    updated_by varchar(32),
    capacity integer not null,
    sport_id integer not null,
    structure varchar(16) not null,
    uid uuid not null,
    facility_id integer not null,
    primary key (id)
);
create table org.court_text (
    id integer not null,
    lang varchar(2) not null,
    created_at TIMESTAMP DEFAULT NOW(),
    created_by varchar(32),
    updated_at TIMESTAMP DEFAULT NOW(),
    updated_by varchar(32),
    name varchar(255),
    primary key (id, lang)
);
create table org.employee (
    id integer not null,
    created_at TIMESTAMP DEFAULT NOW(),
    created_by varchar(32),
    updated_at TIMESTAMP DEFAULT NOW(),
    updated_by varchar(32),
    cell_phone varchar(20),
    email varchar(62) not null,
    first_name varchar(50) not null,
    home_phone varchar(20),
    last_name varchar(50) not null,
    master_role varchar(16),
    password_hash varchar(64) not null,
    status varchar(16) not null,
    uid uuid not null,
    primary key (id)
);
create table org.facility (
    id integer not null,
    created_at TIMESTAMP DEFAULT NOW(),
    created_by varchar(32),
    updated_at TIMESTAMP DEFAULT NOW(),
    updated_by varchar(32),
    advance_book_days integer not null,
    uid uuid not null,
    address_id integer,
    club_id integer not null,
    primary key (id)
);
create table org.facility_employee (
    id integer not null,
    created_at TIMESTAMP DEFAULT NOW(),
    created_by varchar(32),
    updated_at TIMESTAMP DEFAULT NOW(),
    updated_by varchar(32),
    employee_id integer not null,
    facility_id integer not null,
    role_ids integer array not null,
    primary key (id)
);
create table org.facility_text (
    id integer not null,
    lang varchar(2) not null,
    created_at TIMESTAMP DEFAULT NOW(),
    created_by varchar(32),
    updated_at TIMESTAMP DEFAULT NOW(),
    updated_by varchar(32),
    name varchar(255),
    primary key (id, lang)
);
create table org.function (
    id integer not null,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    name varchar(255) not null,
    primary key (id)
);
create table org.interruption (
    id integer not null,
    created_at TIMESTAMP DEFAULT NOW(),
    created_by varchar(32),
    updated_at TIMESTAMP DEFAULT NOW(),
    updated_by varchar(32),
    court_id integer,
    end_dt timestamp(6),
    interruption_type_id integer not null,
    start_dt timestamp(6) not null,
    uid uuid not null,
    primary key (id)
);
create table org.interruption_text (
    id integer not null,
    lang varchar(2) not null,
    created_at TIMESTAMP DEFAULT NOW(),
    created_by varchar(32),
    updated_at TIMESTAMP DEFAULT NOW(),
    updated_by varchar(32),
    name varchar(255),
    primary key (id, lang)
);
create table org.permission (
    id integer not null,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    name varchar(255) not null,
    primary key (id)
);
create table org.permission_function (
    id integer not null,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    function_id integer not null,
    permission_id integer not null,
    primary key (id)
);
create table org.role (
    id integer not null,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    name varchar(255) not null,
    office_type varchar(16) not null,
    primary key (id)
);
create table org.role_permission (
    id integer not null,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    permission_id integer not null,
    role_id integer not null,
    primary key (id)
);
create table org.work_time (
    id integer not null,
    created_at TIMESTAMP DEFAULT NOW(),
    created_by varchar(32),
    updated_at TIMESTAMP DEFAULT NOW(),
    updated_by varchar(32),
    end_time time,
    facility_id integer not null,
    start_time time,
    week_day integer not null,
    primary key (id)
);
--Alter
alter table if exists org.club
add constraint UK_ulwfyvuug8ywyvsbti9yos1i unique (uid);
alter table if exists org.club_employee
add constraint UKh1e5w4uf12d01kroq7jhxy99i unique (employee_id, club_id);
alter table if exists org.court
add constraint UK_xmbjipplh3l5xjt6ryn2ulph unique (uid);
alter table if exists org.employee
add constraint UK_fopic1oh5oln2khj8eat6ino0 unique (email);
alter table if exists org.employee
add constraint UK_htogh8xr5yuucqrh1hk6ltapb unique (uid);
alter table if exists org.facility
add constraint UK_f60t4y0ujr71h8ukor2eloyh unique (uid);
alter table if exists org.facility_employee
add constraint UKd6l81hxtv0vddp302dldryg93 unique (employee_id, facility_id);
--Secuences
create sequence org.address_seq start with 1 increment by 50;
create sequence org.closure_seq start with 1 increment by 50;
create sequence org.club_employee_seq start with 1 increment by 50;
create sequence org.club_seq start with 1 increment by 50;
create sequence org.court_seq start with 1 increment by 50;
create sequence org.employee_seq start with 1 increment by 50;
create sequence org.facility_employee_seq start with 1 increment by 50;
create sequence org.facility_seq start with 1 increment by 50;
create sequence org.function_seq start with 1 increment by 50;
create sequence org.interruption_seq start with 1 increment by 50;
create sequence org.permission_function_seq start with 1 increment by 50;
create sequence org.permission_seq start with 1 increment by 50;
create sequence org.role_permission_seq start with 1 increment by 50;
create sequence org.role_seq start with 1 increment by 50;
create sequence org.work_time_seq start with 1 increment by 50;
--Alter
alter table if exists org.club
add constraint FK606hv3kllsega71dcrd928m17 foreign key (address_id) references org.address;
alter table if exists org.club_employee
add constraint FKq51qm1jom4eaw3phrw1fu752o foreign key (employee_id) references org.employee;
alter table if exists org.club_text
add constraint FKhwjaumri9vj2gdshv20rtmnai foreign key (id) references org.club;
alter table if exists org.court
add constraint FKc6imfp42hr45ucyhwi8jfpdvs foreign key (facility_id) references org.facility;
alter table if exists org.court_text
add constraint FKkbgysnljv8fd87c1n6u21k43f foreign key (id) references org.court;
alter table if exists org.facility
add constraint FKbpfxetgowgub5rnee0iy0nd4c foreign key (address_id) references org.address;
alter table if exists org.facility
add constraint FKh9mi01brjwxc2rahmj6cgvah3 foreign key (club_id) references org.club;
alter table if exists org.facility_employee
add constraint FKn3xkixishqupnar76rubq88e7 foreign key (employee_id) references org.employee;
alter table if exists org.facility_text
add constraint FKllqucsgbu61gp50ltbvuxgbbk foreign key (id) references org.facility;
alter table if exists org.interruption
add constraint FKho10mp699hm5ensd6w7xh7xqs foreign key (court_id) references org.court;
alter table if exists org.interruption_text
add constraint FKfimpvpqbqwqqjalcisl0ajoxn foreign key (id) references org.interruption;
alter table if exists org.permission_function
add constraint FK6s1pp5h00te46k9uemraprq9m foreign key (permission_id) references org.permission;
alter table if exists org.permission_function
add constraint FKdhmltr627d8egmqj591si2fe foreign key (function_id) references org.function;
alter table if exists org.role_permission
add constraint FKa6jx8n8xkesmjmv6jqug6bg68 foreign key (role_id) references org.role;
alter table if exists org.role_permission
add constraint FKf8yllw1ecvwqy3ehyxawqa1qp foreign key (permission_id) references org.permission;