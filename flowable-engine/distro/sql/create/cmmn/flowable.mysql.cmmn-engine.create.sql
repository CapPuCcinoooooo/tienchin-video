
CREATE TABLE ACT_CMMN_DATABASECHANGELOGLOCK (ID INT NOT NULL, `LOCKED` BIT(1) NOT NULL, LOCKGRANTED datetime NULL, LOCKEDBY VARCHAR(255) NULL, CONSTRAINT PK_ACT_CMMN_DATABASECHANGELOGLOCK PRIMARY KEY (ID));

DELETE FROM ACT_CMMN_DATABASECHANGELOGLOCK;

INSERT INTO ACT_CMMN_DATABASECHANGELOGLOCK (ID, `LOCKED`) VALUES (1, 0);

UPDATE ACT_CMMN_DATABASECHANGELOGLOCK SET `LOCKED` = 1, LOCKEDBY = '192.168.68.111 (192.168.68.111)', LOCKGRANTED = '2021-12-28 10:30:28.485' WHERE ID = 1 AND `LOCKED` = 0;

CREATE TABLE ACT_CMMN_DATABASECHANGELOG (ID VARCHAR(255) NOT NULL, AUTHOR VARCHAR(255) NOT NULL, FILENAME VARCHAR(255) NOT NULL, DATEEXECUTED datetime NOT NULL, ORDEREXECUTED INT NOT NULL, EXECTYPE VARCHAR(10) NOT NULL, MD5SUM VARCHAR(35) NULL, `DESCRIPTION` VARCHAR(255) NULL, COMMENTS VARCHAR(255) NULL, TAG VARCHAR(255) NULL, LIQUIBASE VARCHAR(20) NULL, CONTEXTS VARCHAR(255) NULL, LABELS VARCHAR(255) NULL, DEPLOYMENT_ID VARCHAR(10) NULL);

CREATE TABLE ACT_CMMN_DEPLOYMENT (ID_ VARCHAR(255) NOT NULL, NAME_ VARCHAR(255) NULL, CATEGORY_ VARCHAR(255) NULL, KEY_ VARCHAR(255) NULL, DEPLOY_TIME_ datetime NULL, PARENT_DEPLOYMENT_ID_ VARCHAR(255) NULL, TENANT_ID_ VARCHAR(255) DEFAULT '' NULL, CONSTRAINT PK_ACT_CMMN_DEPLOYMENT PRIMARY KEY (ID_));

CREATE TABLE ACT_CMMN_DEPLOYMENT_RESOURCE (ID_ VARCHAR(255) NOT NULL, NAME_ VARCHAR(255) NULL, DEPLOYMENT_ID_ VARCHAR(255) NULL, RESOURCE_BYTES_ LONGBLOB NULL, CONSTRAINT PK_CMMN_DEPLOYMENT_RESOURCE PRIMARY KEY (ID_));

ALTER TABLE ACT_CMMN_DEPLOYMENT_RESOURCE ADD CONSTRAINT ACT_FK_CMMN_RSRC_DPL FOREIGN KEY (DEPLOYMENT_ID_) REFERENCES ACT_CMMN_DEPLOYMENT (ID_);

CREATE INDEX ACT_IDX_CMMN_RSRC_DPL ON ACT_CMMN_DEPLOYMENT_RESOURCE(DEPLOYMENT_ID_);

CREATE TABLE ACT_CMMN_CASEDEF (ID_ VARCHAR(255) NOT NULL, REV_ INT NOT NULL, NAME_ VARCHAR(255) NULL, KEY_ VARCHAR(255) NOT NULL, VERSION_ INT NOT NULL, CATEGORY_ VARCHAR(255) NULL, DEPLOYMENT_ID_ VARCHAR(255) NULL, RESOURCE_NAME_ VARCHAR(4000) NULL, DESCRIPTION_ VARCHAR(4000) NULL, HAS_GRAPHICAL_NOTATION_ BIT(1) NULL, TENANT_ID_ VARCHAR(255) DEFAULT '' NULL, CONSTRAINT PK_ACT_CMMN_CASEDEF PRIMARY KEY (ID_));

ALTER TABLE ACT_CMMN_CASEDEF ADD CONSTRAINT ACT_FK_CASE_DEF_DPLY FOREIGN KEY (DEPLOYMENT_ID_) REFERENCES ACT_CMMN_DEPLOYMENT (ID_);

CREATE INDEX ACT_IDX_CASE_DEF_DPLY ON ACT_CMMN_CASEDEF(DEPLOYMENT_ID_);

CREATE TABLE ACT_CMMN_RU_CASE_INST (ID_ VARCHAR(255) NOT NULL, REV_ INT NOT NULL, BUSINESS_KEY_ VARCHAR(255) NULL, NAME_ VARCHAR(255) NULL, PARENT_ID_ VARCHAR(255) NULL, CASE_DEF_ID_ VARCHAR(255) NULL, STATE_ VARCHAR(255) NULL, START_TIME_ datetime NULL, START_USER_ID_ VARCHAR(255) NULL, CALLBACK_ID_ VARCHAR(255) NULL, CALLBACK_TYPE_ VARCHAR(255) NULL, TENANT_ID_ VARCHAR(255) DEFAULT '' NULL, CONSTRAINT PK_ACT_CMMN_RU_CASE_INST PRIMARY KEY (ID_));

ALTER TABLE ACT_CMMN_RU_CASE_INST ADD CONSTRAINT ACT_FK_CASE_INST_CASE_DEF FOREIGN KEY (CASE_DEF_ID_) REFERENCES ACT_CMMN_CASEDEF (ID_);

CREATE INDEX ACT_IDX_CASE_INST_CASE_DEF ON ACT_CMMN_RU_CASE_INST(CASE_DEF_ID_);

CREATE INDEX ACT_IDX_CASE_INST_PARENT ON ACT_CMMN_RU_CASE_INST(PARENT_ID_);

CREATE TABLE ACT_CMMN_RU_PLAN_ITEM_INST (ID_ VARCHAR(255) NOT NULL, REV_ INT NOT NULL, CASE_DEF_ID_ VARCHAR(255) NULL, CASE_INST_ID_ VARCHAR(255) NULL, STAGE_INST_ID_ VARCHAR(255) NULL, IS_STAGE_ BIT(1) NULL, ELEMENT_ID_ VARCHAR(255) NULL, NAME_ VARCHAR(255) NULL, STATE_ VARCHAR(255) NULL, START_TIME_ datetime NULL, START_USER_ID_ VARCHAR(255) NULL, REFERENCE_ID_ VARCHAR(255) NULL, REFERENCE_TYPE_ VARCHAR(255) NULL, TENANT_ID_ VARCHAR(255) DEFAULT '' NULL, CONSTRAINT PK_CMMN_PLAN_ITEM_INST PRIMARY KEY (ID_));

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD CONSTRAINT ACT_FK_PLAN_ITEM_CASE_DEF FOREIGN KEY (CASE_DEF_ID_) REFERENCES ACT_CMMN_CASEDEF (ID_);

CREATE INDEX ACT_IDX_PLAN_ITEM_CASE_DEF ON ACT_CMMN_RU_PLAN_ITEM_INST(CASE_DEF_ID_);

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD CONSTRAINT ACT_FK_PLAN_ITEM_CASE_INST FOREIGN KEY (CASE_INST_ID_) REFERENCES ACT_CMMN_RU_CASE_INST (ID_);

CREATE INDEX ACT_IDX_PLAN_ITEM_CASE_INST ON ACT_CMMN_RU_PLAN_ITEM_INST(CASE_INST_ID_);

CREATE TABLE ACT_CMMN_RU_SENTRY_PART_INST (ID_ VARCHAR(255) NOT NULL, REV_ INT NOT NULL, CASE_DEF_ID_ VARCHAR(255) NULL, CASE_INST_ID_ VARCHAR(255) NULL, PLAN_ITEM_INST_ID_ VARCHAR(255) NULL, ON_PART_ID_ VARCHAR(255) NULL, IF_PART_ID_ VARCHAR(255) NULL, TIME_STAMP_ datetime NULL, CONSTRAINT PK_CMMN_SENTRY_PART_INST PRIMARY KEY (ID_));

ALTER TABLE ACT_CMMN_RU_SENTRY_PART_INST ADD CONSTRAINT ACT_FK_SENTRY_CASE_DEF FOREIGN KEY (CASE_DEF_ID_) REFERENCES ACT_CMMN_CASEDEF (ID_);

CREATE INDEX ACT_IDX_SENTRY_CASE_DEF ON ACT_CMMN_RU_SENTRY_PART_INST(CASE_DEF_ID_);

ALTER TABLE ACT_CMMN_RU_SENTRY_PART_INST ADD CONSTRAINT ACT_FK_SENTRY_CASE_INST FOREIGN KEY (CASE_INST_ID_) REFERENCES ACT_CMMN_RU_CASE_INST (ID_);

CREATE INDEX ACT_IDX_SENTRY_CASE_INST ON ACT_CMMN_RU_SENTRY_PART_INST(CASE_INST_ID_);

ALTER TABLE ACT_CMMN_RU_SENTRY_PART_INST ADD CONSTRAINT ACT_FK_SENTRY_PLAN_ITEM FOREIGN KEY (PLAN_ITEM_INST_ID_) REFERENCES ACT_CMMN_RU_PLAN_ITEM_INST (ID_);

CREATE INDEX ACT_IDX_SENTRY_PLAN_ITEM ON ACT_CMMN_RU_SENTRY_PART_INST(PLAN_ITEM_INST_ID_);

CREATE TABLE ACT_CMMN_RU_MIL_INST (ID_ VARCHAR(255) NOT NULL, NAME_ VARCHAR(255) NOT NULL, TIME_STAMP_ datetime NOT NULL, CASE_INST_ID_ VARCHAR(255) NOT NULL, CASE_DEF_ID_ VARCHAR(255) NOT NULL, ELEMENT_ID_ VARCHAR(255) NOT NULL, CONSTRAINT PK_ACT_CMMN_RU_MIL_INST PRIMARY KEY (ID_));

ALTER TABLE ACT_CMMN_RU_MIL_INST ADD CONSTRAINT ACT_FK_MIL_CASE_DEF FOREIGN KEY (CASE_DEF_ID_) REFERENCES ACT_CMMN_CASEDEF (ID_);

CREATE INDEX ACT_IDX_MIL_CASE_DEF ON ACT_CMMN_RU_MIL_INST(CASE_DEF_ID_);

ALTER TABLE ACT_CMMN_RU_MIL_INST ADD CONSTRAINT ACT_FK_MIL_CASE_INST FOREIGN KEY (CASE_INST_ID_) REFERENCES ACT_CMMN_RU_CASE_INST (ID_);

CREATE INDEX ACT_IDX_MIL_CASE_INST ON ACT_CMMN_RU_MIL_INST(CASE_INST_ID_);

CREATE TABLE ACT_CMMN_HI_CASE_INST (ID_ VARCHAR(255) NOT NULL, REV_ INT NOT NULL, BUSINESS_KEY_ VARCHAR(255) NULL, NAME_ VARCHAR(255) NULL, PARENT_ID_ VARCHAR(255) NULL, CASE_DEF_ID_ VARCHAR(255) NULL, STATE_ VARCHAR(255) NULL, START_TIME_ datetime NULL, END_TIME_ datetime NULL, START_USER_ID_ VARCHAR(255) NULL, CALLBACK_ID_ VARCHAR(255) NULL, CALLBACK_TYPE_ VARCHAR(255) NULL, TENANT_ID_ VARCHAR(255) DEFAULT '' NULL, CONSTRAINT PK_ACT_CMMN_HI_CASE_INST PRIMARY KEY (ID_));

CREATE TABLE ACT_CMMN_HI_MIL_INST (ID_ VARCHAR(255) NOT NULL, REV_ INT NOT NULL, NAME_ VARCHAR(255) NOT NULL, TIME_STAMP_ datetime NOT NULL, CASE_INST_ID_ VARCHAR(255) NOT NULL, CASE_DEF_ID_ VARCHAR(255) NOT NULL, ELEMENT_ID_ VARCHAR(255) NOT NULL, CONSTRAINT PK_ACT_CMMN_HI_MIL_INST PRIMARY KEY (ID_));

INSERT INTO ACT_CMMN_DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('1', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', NOW(), 1, '8:8b4b922d90b05ff27483abefc9597aa6', 'createTable tableName=ACT_CMMN_DEPLOYMENT; createTable tableName=ACT_CMMN_DEPLOYMENT_RESOURCE; addForeignKeyConstraint baseTableName=ACT_CMMN_DEPLOYMENT_RESOURCE, constraintName=ACT_FK_CMMN_RSRC_DPL, referencedTableName=ACT_CMMN_DEPLOYMENT; create...', '', 'EXECUTED', NULL, NULL, '4.3.5', '0683828602');

ALTER TABLE ACT_CMMN_CASEDEF ADD DGRM_RESOURCE_NAME_ VARCHAR(4000) NULL, ADD HAS_START_FORM_KEY_ BIT(1) NULL;

ALTER TABLE ACT_CMMN_DEPLOYMENT_RESOURCE ADD GENERATED_ BIT(1) NULL;

ALTER TABLE ACT_CMMN_RU_CASE_INST ADD LOCK_TIME_ datetime NULL;

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD ITEM_DEFINITION_ID_ VARCHAR(255) NULL, ADD ITEM_DEFINITION_TYPE_ VARCHAR(255) NULL;

INSERT INTO ACT_CMMN_DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('2', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', NOW(), 2, '8:65e39b3d385706bb261cbeffe7533cbe', 'addColumn tableName=ACT_CMMN_CASEDEF; addColumn tableName=ACT_CMMN_DEPLOYMENT_RESOURCE; addColumn tableName=ACT_CMMN_RU_CASE_INST; addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST', '', 'EXECUTED', NULL, NULL, '4.3.5', '0683828602');

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD IS_COMPLETEABLE_ BIT(1) NULL;

ALTER TABLE ACT_CMMN_RU_CASE_INST ADD IS_COMPLETEABLE_ BIT(1) NULL;

CREATE INDEX ACT_IDX_PLAN_ITEM_STAGE_INST ON ACT_CMMN_RU_PLAN_ITEM_INST(STAGE_INST_ID_);

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD IS_COUNT_ENABLED_ BIT(1) NULL;

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD VAR_COUNT_ INT NULL;

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD SENTRY_PART_INST_COUNT_ INT NULL;

INSERT INTO ACT_CMMN_DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('3', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', NOW(), 3, '8:c01f6e802b49436b4489040da3012359', 'addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_RU_CASE_INST; createIndex indexName=ACT_IDX_PLAN_ITEM_STAGE_INST, tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableNam...', '', 'EXECUTED', NULL, NULL, '4.3.5', '0683828602');

CREATE TABLE ACT_CMMN_HI_PLAN_ITEM_INST (ID_ VARCHAR(255) NOT NULL, REV_ INT NOT NULL, NAME_ VARCHAR(255) NULL, STATE_ VARCHAR(255) NULL, CASE_DEF_ID_ VARCHAR(255) NULL, CASE_INST_ID_ VARCHAR(255) NULL, STAGE_INST_ID_ VARCHAR(255) NULL, IS_STAGE_ BIT(1) NULL, ELEMENT_ID_ VARCHAR(255) NULL, ITEM_DEFINITION_ID_ VARCHAR(255) NULL, ITEM_DEFINITION_TYPE_ VARCHAR(255) NULL, CREATED_TIME_ datetime NULL, LAST_AVAILABLE_TIME_ datetime NULL, LAST_ENABLED_TIME_ datetime NULL, LAST_DISABLED_TIME_ datetime NULL, LAST_STARTED_TIME_ datetime NULL, LAST_SUSPENDED_TIME_ datetime NULL, COMPLETED_TIME_ datetime NULL, OCCURRED_TIME_ datetime NULL, TERMINATED_TIME_ datetime NULL, EXIT_TIME_ datetime NULL, ENDED_TIME_ datetime NULL, LAST_UPDATED_TIME_ datetime NULL, START_USER_ID_ VARCHAR(255) NULL, REFERENCE_ID_ VARCHAR(255) NULL, REFERENCE_TYPE_ VARCHAR(255) NULL, TENANT_ID_ VARCHAR(255) DEFAULT '' NULL, CONSTRAINT PK_ACT_CMMN_HI_PLAN_ITEM_INST PRIMARY KEY (ID_));

ALTER TABLE ACT_CMMN_RU_MIL_INST ADD TENANT_ID_ VARCHAR(255) DEFAULT '' NULL;

ALTER TABLE ACT_CMMN_HI_MIL_INST ADD TENANT_ID_ VARCHAR(255) DEFAULT '' NULL;

INSERT INTO ACT_CMMN_DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('4', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', NOW(), 4, '8:e40d29cb79345b7fb5afd38a7f0ba8fc', 'createTable tableName=ACT_CMMN_HI_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_RU_MIL_INST; addColumn tableName=ACT_CMMN_HI_MIL_INST', '', 'EXECUTED', NULL, NULL, '4.3.5', '0683828602');

ALTER TABLE ACT_CMMN_DEPLOYMENT MODIFY DEPLOY_TIME_ datetime(3);

ALTER TABLE ACT_CMMN_RU_CASE_INST MODIFY START_TIME_ datetime(3);

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST MODIFY START_TIME_ datetime(3);

ALTER TABLE ACT_CMMN_RU_SENTRY_PART_INST MODIFY TIME_STAMP_ datetime(3);

ALTER TABLE ACT_CMMN_RU_MIL_INST MODIFY TIME_STAMP_ datetime(3);

ALTER TABLE ACT_CMMN_HI_CASE_INST MODIFY START_TIME_ datetime(3);

ALTER TABLE ACT_CMMN_HI_CASE_INST MODIFY END_TIME_ datetime(3);

ALTER TABLE ACT_CMMN_HI_MIL_INST MODIFY TIME_STAMP_ datetime(3);

ALTER TABLE ACT_CMMN_RU_CASE_INST MODIFY LOCK_TIME_ datetime(3);

ALTER TABLE ACT_CMMN_HI_PLAN_ITEM_INST MODIFY CREATED_TIME_ datetime(3);

ALTER TABLE ACT_CMMN_HI_PLAN_ITEM_INST MODIFY LAST_AVAILABLE_TIME_ datetime(3);

ALTER TABLE ACT_CMMN_HI_PLAN_ITEM_INST MODIFY LAST_ENABLED_TIME_ datetime(3);

ALTER TABLE ACT_CMMN_HI_PLAN_ITEM_INST MODIFY LAST_DISABLED_TIME_ datetime(3);

ALTER TABLE ACT_CMMN_HI_PLAN_ITEM_INST MODIFY LAST_STARTED_TIME_ datetime(3);

ALTER TABLE ACT_CMMN_HI_PLAN_ITEM_INST MODIFY LAST_SUSPENDED_TIME_ datetime(3);

ALTER TABLE ACT_CMMN_HI_PLAN_ITEM_INST MODIFY COMPLETED_TIME_ datetime(3);

ALTER TABLE ACT_CMMN_HI_PLAN_ITEM_INST MODIFY OCCURRED_TIME_ datetime(3);

ALTER TABLE ACT_CMMN_HI_PLAN_ITEM_INST MODIFY TERMINATED_TIME_ datetime(3);

ALTER TABLE ACT_CMMN_HI_PLAN_ITEM_INST MODIFY EXIT_TIME_ datetime(3);

ALTER TABLE ACT_CMMN_HI_PLAN_ITEM_INST MODIFY ENDED_TIME_ datetime(3);

ALTER TABLE ACT_CMMN_HI_PLAN_ITEM_INST MODIFY LAST_UPDATED_TIME_ datetime(3);

INSERT INTO ACT_CMMN_DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('5', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', NOW(), 5, '8:70349de472f87368dcdec971a10311a0', 'modifyDataType columnName=DEPLOY_TIME_, tableName=ACT_CMMN_DEPLOYMENT; modifyDataType columnName=START_TIME_, tableName=ACT_CMMN_RU_CASE_INST; modifyDataType columnName=START_TIME_, tableName=ACT_CMMN_RU_PLAN_ITEM_INST; modifyDataType columnName=T...', '', 'EXECUTED', NULL, NULL, '4.3.5', '0683828602');

CREATE UNIQUE INDEX ACT_IDX_CASE_DEF_UNIQ ON ACT_CMMN_CASEDEF(KEY_, VERSION_, TENANT_ID_);

INSERT INTO ACT_CMMN_DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('6', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', NOW(), 6, '8:10e82e26a7fee94c32a92099c059c18c', 'createIndex indexName=ACT_IDX_CASE_DEF_UNIQ, tableName=ACT_CMMN_CASEDEF', '', 'EXECUTED', NULL, NULL, '4.3.5', '0683828602');

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST CHANGE START_TIME_ CREATE_TIME_ datetime(3);

ALTER TABLE ACT_CMMN_HI_PLAN_ITEM_INST CHANGE CREATED_TIME_ CREATE_TIME_ datetime(3);

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD LAST_AVAILABLE_TIME_ datetime(3) NULL, ADD LAST_ENABLED_TIME_ datetime(3) NULL, ADD LAST_DISABLED_TIME_ datetime(3) NULL, ADD LAST_STARTED_TIME_ datetime(3) NULL, ADD LAST_SUSPENDED_TIME_ datetime(3) NULL, ADD COMPLETED_TIME_ datetime(3) NULL, ADD OCCURRED_TIME_ datetime(3) NULL, ADD TERMINATED_TIME_ datetime(3) NULL, ADD EXIT_TIME_ datetime(3) NULL, ADD ENDED_TIME_ datetime(3) NULL, ADD ENTRY_CRITERION_ID_ VARCHAR(255) NULL, ADD EXIT_CRITERION_ID_ VARCHAR(255) NULL;

ALTER TABLE ACT_CMMN_HI_PLAN_ITEM_INST ADD ENTRY_CRITERION_ID_ VARCHAR(255) NULL, ADD EXIT_CRITERION_ID_ VARCHAR(255) NULL;

INSERT INTO ACT_CMMN_DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('7', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', NOW(), 7, '8:530bc81a1e30618ccf4a2da1f7c6c043', 'renameColumn newColumnName=CREATE_TIME_, oldColumnName=START_TIME_, tableName=ACT_CMMN_RU_PLAN_ITEM_INST; renameColumn newColumnName=CREATE_TIME_, oldColumnName=CREATED_TIME_, tableName=ACT_CMMN_HI_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_RU_P...', '', 'EXECUTED', NULL, NULL, '4.3.5', '0683828602');

ALTER TABLE ACT_CMMN_HI_PLAN_ITEM_INST ADD SHOW_IN_OVERVIEW_ BIT(1) NULL;

INSERT INTO ACT_CMMN_DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('8', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', NOW(), 8, '8:e8c2eb1ce28bc301efe07e0e29757781', 'addColumn tableName=ACT_CMMN_HI_PLAN_ITEM_INST', '', 'EXECUTED', NULL, NULL, '4.3.5', '0683828602');

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD EXTRA_VALUE_ VARCHAR(255) NULL;

ALTER TABLE ACT_CMMN_HI_PLAN_ITEM_INST ADD EXTRA_VALUE_ VARCHAR(255) NULL;

INSERT INTO ACT_CMMN_DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('9', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', NOW(), 9, '8:4cb4782b9bdec5ced2a64c525aa7b3a0', 'addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_HI_PLAN_ITEM_INST', '', 'EXECUTED', NULL, NULL, '4.3.5', '0683828602');

ALTER TABLE ACT_CMMN_RU_CASE_INST ADD REFERENCE_ID_ VARCHAR(255) NULL;

ALTER TABLE ACT_CMMN_RU_CASE_INST ADD REFERENCE_TYPE_ VARCHAR(255) NULL;

CREATE INDEX ACT_IDX_CASE_INST_REF_ID_ ON ACT_CMMN_RU_CASE_INST(REFERENCE_ID_);

ALTER TABLE ACT_CMMN_HI_CASE_INST ADD REFERENCE_ID_ VARCHAR(255) NULL;

ALTER TABLE ACT_CMMN_HI_CASE_INST ADD REFERENCE_TYPE_ VARCHAR(255) NULL;

INSERT INTO ACT_CMMN_DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('10', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', NOW(), 10, '8:341c16be247f5d17badc9809da8691f9', 'addColumn tableName=ACT_CMMN_RU_CASE_INST; addColumn tableName=ACT_CMMN_RU_CASE_INST; createIndex indexName=ACT_IDX_CASE_INST_REF_ID_, tableName=ACT_CMMN_RU_CASE_INST; addColumn tableName=ACT_CMMN_HI_CASE_INST; addColumn tableName=ACT_CMMN_HI_CASE...', '', 'EXECUTED', NULL, NULL, '4.3.5', '0683828602');

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD DERIVED_CASE_DEF_ID_ VARCHAR(255) NULL;

ALTER TABLE ACT_CMMN_HI_PLAN_ITEM_INST ADD DERIVED_CASE_DEF_ID_ VARCHAR(255) NULL;

INSERT INTO ACT_CMMN_DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('11', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', NOW(), 11, '8:d7c4da9276bcfffbfb0ebfb25e3f7b05', 'addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_HI_PLAN_ITEM_INST', '', 'EXECUTED', NULL, NULL, '4.3.5', '0683828602');

ALTER TABLE ACT_CMMN_RU_CASE_INST ADD LOCK_OWNER_ VARCHAR(255) NULL;

INSERT INTO ACT_CMMN_DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('12', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', NOW(), 12, '8:adf4ecc45f2aa9a44a5626b02e1d6f98', 'addColumn tableName=ACT_CMMN_RU_CASE_INST', '', 'EXECUTED', NULL, NULL, '4.3.5', '0683828602');

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD LAST_UNAVAILABLE_TIME_ datetime(3) NULL;

ALTER TABLE ACT_CMMN_HI_PLAN_ITEM_INST ADD LAST_UNAVAILABLE_TIME_ datetime(3) NULL;

INSERT INTO ACT_CMMN_DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('13', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', NOW(), 13, '8:7550626f964ab5518464709408333ec1', 'addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_HI_PLAN_ITEM_INST', '', 'EXECUTED', NULL, NULL, '4.3.5', '0683828602');

ALTER TABLE ACT_CMMN_RU_CASE_INST ADD LAST_REACTIVATION_TIME_ datetime(3) NULL, ADD LAST_REACTIVATION_USER_ID_ VARCHAR(255) NULL;

ALTER TABLE ACT_CMMN_HI_CASE_INST ADD LAST_REACTIVATION_TIME_ datetime(3) NULL, ADD LAST_REACTIVATION_USER_ID_ VARCHAR(255) NULL;

INSERT INTO ACT_CMMN_DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('14', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', NOW(), 14, '8:086b40b3a05596dcc8a8d7479922d494', 'addColumn tableName=ACT_CMMN_RU_CASE_INST; addColumn tableName=ACT_CMMN_HI_CASE_INST', '', 'EXECUTED', NULL, NULL, '4.3.5', '0683828602');

ALTER TABLE ACT_CMMN_RU_CASE_INST ADD BUSINESS_STATUS_ VARCHAR(255) NULL;

ALTER TABLE ACT_CMMN_HI_CASE_INST ADD BUSINESS_STATUS_ VARCHAR(255) NULL;

INSERT INTO ACT_CMMN_DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('16', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', NOW(), 15, '8:a697a222ddd99dd15b36516a252f1c63', 'addColumn tableName=ACT_CMMN_RU_CASE_INST; addColumn tableName=ACT_CMMN_HI_CASE_INST', '', 'EXECUTED', NULL, NULL, '4.3.5', '0683828602');

UPDATE ACT_CMMN_DATABASECHANGELOGLOCK SET `LOCKED` = 0, LOCKEDBY = NULL, LOCKGRANTED = NULL WHERE ID = 1;
