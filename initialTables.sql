use stardas;

-- two different ways in which Competencies can be related
drop table if exists Prereqs; -- unclear if we want this??
drop table if exists Adjacencies;
drop table if exists Access; -- primary keys are Assessors, and Cases
drop table if exists Cases; -- links learners, competencies, and documentation
-- do some research on is a relationships for person, learner and assessor
-- you may just want to straight up merge them all
drop table if exists Assessors;-- has a foreign key into Person
drop table if exists Learners;-- has a foreign key into Person
drop table if exists People;
drop table if exists Comps; -- competencies

create table Comps (
    tag varchar(50) unique,
    title varchar(100),
    primary key (tag)
) ENGINE = InnoDB;

create table People (
    pid int primary key auto_increment,
    name varchar(50)
) ENGINE = InnoDB;

-- we'll presumably add more attributes to these later
create table Learners(
    learnerid int,
    foreign key (learnerid) references People(pid),
    primary key (learnerid)
) ENGINE = InnoDB;

create table Assessors(
    assessorid int,
    foreign key (assessorid) references People(pid),
    primary key (assessorid)
) ENGINE = InnoDB;

create table Cases(
    caseid int auto_increment,
    learnerid int,
    foreign key (learnerid) references Learners(learnerid),
    tag varchar(50),
    foreign key (tag) references Comps (tag),
    documentation varchar(100),
    primary key (caseid)
) ENGINE = InnoDB;

create table Access(
    assessorid int,
    foreign key (assessorid) references Assessors(assessorid),
    caseid int,
    foreign key (caseid) references Cases (caseid),
    documentation varchar(100),
    timeout date,
    primary key (assessorid, caseid)
) ENGINE = InnoDB;

create table Adjacencies (
    comp1 varchar(50),
    comp2 varchar(50), 
    foreign key (comp1) references Comps(tag),
    foreign key (comp2) references Comps(tag),
    primary key (comp1, comp2)
) ENGINE = InnoDB;

create table Prereqs (
    comp varchar(50),
    req varchar(50), 
    foreign key (comp) references Comps(tag),
    foreign key (req) references Comps(tag),
    primary key (comp, req)
) ENGINE = InnoDB;

insert into People(name) values("Denae Gretton");
insert into People(name) values("Simon Simonson");
    


