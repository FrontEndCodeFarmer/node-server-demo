/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2018/5/21 18:00:44                           */
/*==============================================================*/


drop table if exists dict_code;

drop table if exists dict_code_type;

drop table if exists role;

drop table if exists user;

drop table if exists user_role;

/*==============================================================*/
/* Table: dict_code                                             */
/*==============================================================*/
create table dict_code
(
   item_code            varchar(32) not null comment '�ֵ����',
   item_name            varchar(32) not null comment '�ֵ�����',
   item_type            varchar(32) not null comment '�ֵ�����',
   sort                 int2 comment '����',
   enable_flag          int2 not null default '1' comment '�Ƿ�����',
   memo                 varchar(256) comment '˵��'
);

alter table dict_code comment '�ֵ������';

/*==============================================================*/
/* Table: dict_code_type                                        */
/*==============================================================*/
create table dict_code_type
(
   type_code            varchar(32) not null comment '�ֵ����ͱ���',
   type_name            varchar(32) not null comment '�ֵ���������',
   enable_flag          int2 not null default '1' comment '�Ƿ�����
            0-���ã�1-����,Ĭ������',
   memo                 varchar(256) comment '˵��',
   primary key (type_code)
);

alter table dict_code_type comment '�ֵ������';

/*==============================================================*/
/* Table: role                                                  */
/*==============================================================*/
create table role
(
   uuid                 varchar(32) not null comment '��ɫid',
   role_name            varchar(64) not null comment '��ɫ����',
   memo                 varchar(256) comment '��ɫ˵��',
   create_time          timestamp not null comment '����ʱ��',
   update_time          timestamp comment '����ʱ��',
   create_user          VARCHAR(32) not null comment '�����û�',
   update_user          VARCHAR(32) comment '�����û�',
   delete_flag          int2 not null comment 'ɾ�����',
   primary key (uuid)
);

alter table role comment '��ɫ��';

/*==============================================================*/
/* Index: idx_role_role_name                                    */
/*==============================================================*/
create index idx_role_role_name on role
(
   role_name
);

/*==============================================================*/
/* Table: user                                                  */
/*==============================================================*/
create table user
(
   uuid                 VARCHAR(32) not null comment '�û�id',
   user_name            VARCHAR(256) not null comment '��¼������',
   password             VARCHAR(256) not null comment '�û�����',
   full_name            varchar(256) comment '�û�����',
   email                VARCHAR(256) comment '�û�����',
   phone_num            VARCHAR(128) comment '�绰����',
   department           VARCHAR(32) comment '����id',
   user_status          int2 not null comment '�û�״̬��
            1-����
            2-����
            
            ',
   create_time          timestamp not null comment '����ʱ��',
   update_time          timestamp comment '����ʱ��',
   create_user          VARCHAR(32) not null comment '�����û�',
   update_user          VARCHAR(32) comment '�����û�',
   delete_flag          int2 not null comment 'ɾ�����',
   primary key (uuid)
);

alter table user comment '�û���';

/*==============================================================*/
/* Index: idx_user_user_uuid                                    */
/*==============================================================*/
create index idx_user_user_uuid on user
(
   uuid
);

/*==============================================================*/
/* Index: idx_user_user_name                                    */
/*==============================================================*/
create index idx_user_user_name on user
(
   user_name
);

/*==============================================================*/
/* Table: user_role                                             */
/*==============================================================*/
create table user_role
(
   user_id              varchar(32) not null comment '�û�id',
   role_id              varchar(32) not null comment '��ɫid'
);

alter table user_role comment '�û���ɫ������';

/*==============================================================*/
/* Index: idx_user_role_user_id                                 */
/*==============================================================*/
create index idx_user_role_user_id on user_role
(
   user_id
);

alter table dict_code add constraint FK_CODE_REFERENCE_CODE_TYPE foreign key (item_type)
      references dict_code_type (type_code) on delete cascade on update cascade;

alter table user_role add constraint FK_USER_ROLE_Reference_ROLE foreign key (role_id)
      references role (uuid) on delete cascade on update cascade;

alter table user_role add constraint FK_USER_ROLE_Reference_USER foreign key (user_id)
      references user (uuid) on delete cascade on update cascade;

