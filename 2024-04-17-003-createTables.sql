--Camilo Camacho
CREATE SCHEMA IF NOT EXISTS reservation;
--Create
create table reservation.cancelation (
    id integer not null,
    created_at TIMESTAMP DEFAULT NOW() not null,
    updated_at TIMESTAMP DEFAULT NOW() not null,
    cancel_reason_id integer not null,
    lang varchar(2),
    note varchar(2000),
    primary key (id)
);
create table reservation.order (
    id integer not null,
    created_at TIMESTAMP DEFAULT NOW() not null,
    updated_at TIMESTAMP DEFAULT NOW() not null,
    order_number integer not null,
    paid numeric(38, 2),
    payment_dt timestamp(6),
    payment_status varchar(16),
    price numeric(38, 2),
    process_code varchar(16),
    uid uuid not null,
    player_id integer not null,
    primary key (id)
);
create table reservation.time_slot (
    id integer not null,
    created_at TIMESTAMP DEFAULT NOW() not null,
    updated_at TIMESTAMP DEFAULT NOW() not null,
    end_time time not null,
    payment_dt timestamp(6),
    payment_status varchar(16),
    play_date date not null,
    price numeric(38, 2) not null,
    process_code varchar(16),
    start_time time not null,
    target_code varchar(16) not null,
    uid uuid not null,
    court_id integer not null,
    order_id integer,
    primary key (id)
);
create table reservation.time_slot_snapshot (
    id integer not null,
    created_at TIMESTAMP DEFAULT NOW() not null,
    updated_at TIMESTAMP DEFAULT NOW() not null,
    end_time time not null,
    payment_dt timestamp(6),
    payment_status varchar(16),
    play_date date not null,
    price numeric(38, 2) not null,
    process_code varchar(16),
    start_time time not null,
    target_code varchar(16) not null,
    uid uuid not null,
    cancelation_id integer,
    court_id integer not null,
    order_id integer,
    primary key (id)
);
--alter
alter table if exists reservation.order
add constraint UK_fyjoefwgr05yhu6fb9ne1ovu7 unique (uid);
alter table if exists reservation.time_slot
add constraint UK_6i0weh4xeksrgukx05x22f5l1 unique (uid);
alter table if exists reservation.time_slot_snapshot
add constraint UK_bglqnc55fxu3axwb795vh7g8b unique (uid);
--Sequence
create sequence reservation.order_seq start with 1 increment by 50;
create sequence reservation.time_slot_seq start with 1 increment by 50;
create sequence reservation.time_slot_snapshot_seq start with 1 increment by 50;
alter table if exists reservation.order
add constraint FKpk29pmly6q4mjrt3hwf7oi0d7 foreign key (player_id) references player.player;
alter table if exists reservation.time_slot
add constraint FKkylqtr2cj3bncml4x9q1kgnk6 foreign key (court_id) references org.court;
alter table if exists reservation.time_slot
add constraint FKfsbbfxse8tjfekrjc5qcq5cuq foreign key (order_id) references reservation.order;
alter table if exists reservation.time_slot_snapshot
add constraint FKfakxh9la7x7yjxufovt8mmbdr foreign key (cancelation_id) references reservation.cancelation;
alter table if exists reservation.time_slot_snapshot
add constraint FK4ymg58rn6a9ulh88udxa2676w foreign key (court_id) references org.court;
alter table if exists reservation.time_slot_snapshot
add constraint FK4pxgwhimnb3fy6kcd1o6j1by3 foreign key (order_id) references reservation.order;