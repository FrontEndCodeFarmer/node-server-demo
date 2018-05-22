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
   item_code            varchar(32) not null comment '字典编码',
   item_name            varchar(32) not null comment '字典名称',
   item_type            varchar(32) not null comment '字典类型',
   sort                 int2 comment '排序',
   enable_flag          int2 not null default '1' comment '是否启用',
   memo                 varchar(256) comment '说明'
);

alter table dict_code comment '字典表数据';

/*==============================================================*/
/* Table: dict_code_type                                        */
/*==============================================================*/
create table dict_code_type
(
   type_code            varchar(32) not null comment '字典类型编码',
   type_name            varchar(32) not null comment '字典类型名称',
   enable_flag          int2 not null default '1' comment '是否启用
            0-禁用，1-启用,默认启用',
   memo                 varchar(256) comment '说明',
   primary key (type_code)
);

alter table dict_code_type comment '字典表类型';

/*==============================================================*/
/* Table: role                                                  */
/*==============================================================*/
create table role
(
   uuid                 varchar(32) not null comment '角色id',
   role_name            varchar(64) not null comment '角色名称',
   memo                 varchar(256) comment '角色说明',
   create_time          timestamp not null comment '创建时间',
   update_time          timestamp comment '更新时间',
   create_user          VARCHAR(32) not null comment '创建用户',
   update_user          VARCHAR(32) comment '更新用户',
   delete_flag          int2 not null comment '删除标记',
   primary key (uuid)
);

alter table role comment '角色表';

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
   uuid                 VARCHAR(32) not null comment '用户id',
   user_name            VARCHAR(256) not null comment '登录用名称',
   password             VARCHAR(256) not null comment '用户密码',
   full_name            varchar(256) comment '用户名称',
   email                VARCHAR(256) comment '用户邮箱',
   phone_num            VARCHAR(128) comment '电话号码',
   department           VARCHAR(32) comment '部门id',
   user_status          int2 not null comment '用户状态：
            1-正常
            2-禁用
            
            ',
   create_time          timestamp not null comment '创建时间',
   update_time          timestamp comment '更新时间',
   create_user          VARCHAR(32) not null comment '创建用户',
   update_user          VARCHAR(32) comment '更新用户',
   delete_flag          int2 not null comment '删除标记',
   primary key (uuid)
);

alter table user comment '用户表';

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
   user_id              varchar(32) not null comment '用户id',
   role_id              varchar(32) not null comment '角色id'
);

alter table user_role comment '用户角色关联表';

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

