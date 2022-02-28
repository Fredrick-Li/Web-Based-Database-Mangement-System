CREATE TABLE jl_admin (
    id             NUMBER(10) NOT NULL,
    adminname      VARCHAR2(120) NOT NULL,
    username       VARCHAR2(50) NOT NULL,
    mobilenumber   NUMBER(10) NOT NULL,
    email          VARCHAR2(200) NOT NULL,
    passcode       VARCHAR2(200) NOT NULL,
    adminregdate   TIMESTAMP WITH TIME ZONE NOT NULL
);

ALTER TABLE jl_admin ADD CONSTRAINT jl_admin_pk PRIMARY KEY ( id );

CREATE TABLE jl_bookingcar (
    id              NUMBER(10) NOT NULL,
    vehicleid       VARCHAR2(20) NOT NULL,
    bookingdate     VARCHAR2(120) NOT NULL,
    returndate      VARCHAR2(120) NOT NULL,
    bookingnumber   VARCHAR2(120) NOT NULL,
    creationdate    TIMESTAMP WITH TIME ZONE NOT NULL,
    totalcost       NUMBER(10, 2) NOT NULL,
    remark          VARCHAR2(120) NOT NULL,
    status          VARCHAR2(120) NOT NULL,
    remarkdate      TIMESTAMP WITH TIME ZONE NOT NULL,
    jl_user_id      NUMBER(10) NOT NULL,
    jl_vehicle_id   NUMBER(10) NOT NULL
);

ALTER TABLE jl_bookingcar ADD CONSTRAINT jl_bookingcar_pk PRIMARY KEY ( id );

CREATE TABLE jl_bookingtwowheeler (
    id                  NUMBER(10) NOT NULL,
    vehicleid           VARCHAR2(20) NOT NULL,
    bookingdate         VARCHAR2(120) NOT NULL,
    returndate          VARCHAR2(120) NOT NULL,
    bookingnumber       VARCHAR2(120) NOT NULL,
    creationdate        TIMESTAMP WITH TIME ZONE NOT NULL,
    totalcost           NUMBER(10, 2) NOT NULL,
    remark              VARCHAR2(120) NOT NULL,
    status              VARCHAR2(120) NOT NULL,
    remarkdate          TIMESTAMP WITH TIME ZONE NOT NULL,
    jl_vehiclevcar_id   NUMBER(10) NOT NULL,
    jl_user_id          NUMBER(10) NOT NULL
);

ALTER TABLE jl_bookingtwowheeler ADD CONSTRAINT jl_bookingtwowheeler_pk PRIMARY KEY ( id );

CREATE TABLE jl_brand (
    id             NUMBER(10) NOT NULL,
    brandname      VARCHAR2(200) NOT NULL,
    brandlogo      VARCHAR2(200) NOT NULL,
    creationdate   TIMESTAMP WITH TIME ZONE NOT NULL
);

ALTER TABLE jl_brand ADD CONSTRAINT jl_brand_pk PRIMARY KEY ( id );

CREATE TABLE jl_car_payment (
    id              NUMBER(10) NOT NULL,
    bookingcar_id   NUMBER(10) NOT NULL,
    paymentdate     TIMESTAMP WITH TIME ZONE NOT NULL,
    paymentamount   NUMBER(10, 2) NOT NULL,
    paymentmethod   VARCHAR2(10) NOT NULL,
    cardnumber      NUMBER(16) NOT NULL,
    cardfname       VARCHAR2(50) NOT NULL,
    cardlname       VARCHAR2(50) NOT NULL
);

ALTER TABLE jl_car_payment ADD CONSTRAINT jl_car_payment_pk PRIMARY KEY ( id,
                                                                          bookingcar_id );

CREATE TABLE jl_category (
    id             NUMBER(10) NOT NULL,
    categoryname   VARCHAR2(50) NOT NULL,
    updatedate     TIMESTAMP WITH TIME ZONE NOT NULL
);

ALTER TABLE jl_category ADD CONSTRAINT jl_category_pk PRIMARY KEY ( id );

CREATE TABLE jl_page (
    id                NUMBER(10) NOT NULL,
    pagetype          VARCHAR2(200) NOT NULL,
    pagetitle         VARCHAR2(200) NOT NULL,
    pagedescription   VARCHAR2(200) NOT NULL,
    email             VARCHAR2(120) NOT NULL,
    mobilenumber      NUMBER(10) NOT NULL,
    updationdate      TIMESTAMP WITH TIME ZONE NOT NULL
);

ALTER TABLE jl_page ADD CONSTRAINT jl_page_pk PRIMARY KEY ( id );

CREATE TABLE jl_twowheel_payment (
    id                     NUMBER(10) NOT NULL,
    bookingtwowheeler_id   NUMBER(10) NOT NULL,
    paymentdate            TIMESTAMP WITH TIME ZONE NOT NULL,
    paymentamount          NUMBER(10, 2) NOT NULL,
    paymentmethod          VARCHAR2(10) NOT NULL,
    cardnumber             NUMBER(16) NOT NULL,
    cardfname              VARCHAR2(50) NOT NULL,
    cardlname              VARCHAR2(50) NOT NULL
);

ALTER TABLE jl_twowheel_payment ADD CONSTRAINT jl_twowheel_payment_pk PRIMARY KEY ( id,
                                                                                    bookingtwowheeler_id );

CREATE TABLE jl_user (
    id             NUMBER(10) NOT NULL,
    firstname      VARCHAR2(120) NOT NULL,
    lastname       VARCHAR2(120) NOT NULL,
    email          VARCHAR2(120) NOT NULL,
    mobilenumber   NUMBER(10) NOT NULL,
    passcode       VARCHAR2(120) NOT NULL,
    regdate        TIMESTAMP WITH TIME ZONE NOT NULL
);

ALTER TABLE jl_user ADD CONSTRAINT jl_user_pk PRIMARY KEY ( id );

CREATE TABLE jl_vehicle (
    id                   NUMBER(10) NOT NULL,
    vehiclename          VARCHAR2(120) NOT NULL,
    registrationnumber   VARCHAR2(120) NOT NULL,
    rentalprice          NUMBER(10, 2) NOT NULL,
    vehiclemodel         VARCHAR2(120) NOT NULL,
    vehicledescription   CLOB NOT NULL,
    seatingcapacity      NUMBER(2) NOT NULL,
    image                VARCHAR2(200) NOT NULL,
    image1               VARCHAR2(200),
    image2               VARCHAR2(200),
    image3               VARCHAR2(200),
    image4               VARCHAR2(200),
    image5               VARCHAR2(200),
    creationdate         TIMESTAMP WITH TIME ZONE NOT NULL,
    jl_brand_id          NUMBER(10) NOT NULL,
    jl_category_id       NUMBER NOT NULL
);

ALTER TABLE jl_vehicle
    ADD CONSTRAINT ch_inh_jl_vehicle CHECK ( jl_category_id IN (
        1,
        jl_vehiclevcar
    ) );

ALTER TABLE jl_vehicle ADD CONSTRAINT jl_vehicle_pk PRIMARY KEY ( id );

CREATE TABLE jl_vehiclevcar (
    id              NUMBER(10) NOT NULL,
    class           VARCHAR2(50) NOT NULL,
    fuel            VARCHAR2(50) NOT NULL,
    doors           VARCHAR2(50) NOT NULL,
    gearbox         VARCHAR2(50) NOT NULL,
    aircondition    VARCHAR2(50) NOT NULL,
    abs             VARCHAR2(50) NOT NULL,
    airbags         VARCHAR2(50) NOT NULL,
    bluetooth       VARCHAR2(50),
    carkit          VARCHAR2(50),
    gps             VARCHAR2(50),
    music           VARCHAR2(50),
    centerlocking   VARCHAR2(50)
);

ALTER TABLE jl_vehiclevcar ADD CONSTRAINT jl_vehiclevcar_pk PRIMARY KEY ( id );

ALTER TABLE jl_car_payment
    ADD CONSTRAINT bookingcar_fk FOREIGN KEY ( bookingcar_id )
        REFERENCES jl_bookingcar ( id );

ALTER TABLE jl_bookingcar
    ADD CONSTRAINT jl_bookingcar_jl_user_fk FOREIGN KEY ( jl_user_id )
        REFERENCES jl_user ( id );

ALTER TABLE jl_bookingcar
    ADD CONSTRAINT jl_bookingcar_jl_vehicle_fk FOREIGN KEY ( jl_vehicle_id )
        REFERENCES jl_vehicle ( id );

ALTER TABLE jl_twowheel_payment
    ADD CONSTRAINT jl_bookingtwowheeler_fk FOREIGN KEY ( bookingtwowheeler_id )
        REFERENCES jl_bookingtwowheeler ( id );

ALTER TABLE jl_bookingtwowheeler
    ADD CONSTRAINT jl_user_fk FOREIGN KEY ( jl_user_id )
        REFERENCES jl_user ( id );

ALTER TABLE jl_vehicle
    ADD CONSTRAINT jl_vehicle_jl_brand_fk FOREIGN KEY ( jl_brand_id )
        REFERENCES jl_brand ( id );

ALTER TABLE jl_vehicle
    ADD CONSTRAINT jl_vehicle_jl_category_fk FOREIGN KEY ( jl_category_id )
        REFERENCES jl_category ( id );

ALTER TABLE jl_vehiclevcar
    ADD CONSTRAINT jl_vehiclevcar_jl_vehicle_fk FOREIGN KEY ( id )
        REFERENCES jl_vehicle ( id );

ALTER TABLE jl_bookingtwowheeler
    ADD CONSTRAINT vehiclevcar_fk FOREIGN KEY ( jl_vehiclevcar_id )
        REFERENCES jl_vehiclevcar ( id );

