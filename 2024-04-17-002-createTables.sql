-- Camilo Camacho
CREATE SCHEMA IF NOT EXISTS player;
--Create
create table player.address (
    id integer not null,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    city_id integer,
    city_name varchar(128),
    country_id integer,
    line1 varchar(256),
    line2 varchar(256),
    player_id integer not null,
    post_code varchar(7),
    province_id integer,
    type varchar(15) not null,
    primary key (id)
);
create table player.club_player (
    id integer not null,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    club_id integer not null,
    membership_type varchar(15) DEFAULT 'MEMBER' not null,
    player_id integer not null,
    primary key (id)
);
create table player.facility_player (
    id integer not null,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    facility_id integer not null,
    player_id integer not null,
    preference_type varchar(15) DEFAULT 'NEAR' not null,
    primary key (id)
);
create table player.player (
    id integer not null,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    cell_phone varchar(15),
    cell_phone_checked boolean DEFAULT false not null,
    email varchar(62) not null,
    email_check_code varchar(16),
    email_checked boolean DEFAULT false not null,
    first_name varchar(50) not null,
    lang varchar(2) not null,
    last_name varchar(50) not null,
    password_hash varchar(64) not null,
    uid uuid not null,
    primary key (id)
);
create table player.player_sport (
    id integer not null,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    player_id integer not null,
    sport_id integer not null,
    primary key (id)
);
--Alter
alter table if exists player.address
add constraint UKg15kporbebu83p5gv2vor34hr unique (player_id, type);
alter table if exists player.club_player
add constraint UKh1mfyymva7da8u81r4sp4dxgd unique (player_id, club_id, membership_type);
alter table if exists player.facility_player
add constraint UK6t0nd6n3tfkbeaw1n0wlaxpco unique (player_id, facility_id, preference_type);
alter table if exists player.player
add constraint UK_6xex6ypo9kddhx0mvxapw5ohr unique (uid);
alter table if exists player.player_sport
add constraint UKhvf0mga5xsi1pt7f00if1nidd unique (player_id, sport_id);
--Sequence
create sequence player.player_seq start with 1 increment by 50;
alter table if exists player.player_sport
add constraint FK1iidb8vkltbnre28ph06so315 foreign key (player_id) references player.player;