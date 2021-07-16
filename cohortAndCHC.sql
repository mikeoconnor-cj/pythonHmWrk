-- DEV_UHS.ATLAS.CCN_X_COHORT_LAYUP definition

create or replace TABLE CCN_X_COHORT_LAYUP (
	ORG_ID VARCHAR(30) NOT NULL,
	FK_PROVIDER_ID VARCHAR(20) NOT NULL,
	COHORT VARCHAR(100) NOT NULL,
	SUB_COHORT VARCHAR(100) NOT NULL,
	YEAR VARCHAR(4) NOT NULL,
	AGE_GROUP VARCHAR(50) NOT NULL,
	SEX_GROUP VARCHAR(50) NOT NULL,
	RACE_GROUP VARCHAR(50) NOT NULL,
	RISK_ADJUSTMENT VARCHAR(50) NOT NULL,
	PROVIDER_NAME VARCHAR(100),
	PROVIDER_COUNTY_CODE VARCHAR(10),
	PROVIDER_COUNTY_DESC VARCHAR(50),
	PROVIDER_ZIP VARCHAR(10),
	PROVIDER_STATE VARCHAR(30),
	PROVIDER_CBSA VARCHAR(60),
	TOTAL_PATIENTS NUMBER(38,0),
	MEMBER_MONTHS NUMBER(38,0),
	TOTAL_ALLOWED NUMBER(20,4),
	IP_ALLOWED NUMBER(20,4),
	OP_ALLOWED NUMBER(20,4),
	SNF_ALLOWED NUMBER(20,4),
	HHA_ALLOWED NUMBER(20,4),
	HOSPICE_ALLOWED NUMBER(20,4),
	DME_ALLOWED NUMBER(20,4),
	PARTB_EM_ALLOWED NUMBER(20,4),
	PARTB_PROC_ALLOWED NUMBER(20,4),
	PARTB_IMAG_ALLOWED NUMBER(20,4),
	PARTB_DRUGS_ALLOWED NUMBER(20,4),
	PARTB_AMBUL_ALLOWED NUMBER(20,4),
	PARTB_TEST_ALLOWED NUMBER(20,4),
	PARTB_DME_ALLOWED NUMBER(20,4),
	PARTB_OTHER_ALLOWED NUMBER(20,4),
	CC_CNT_AFIB NUMBER(38,0),
	CC_CNT_ALZH NUMBER(38,0),
	CC_CNT_ALZH_DEMEN NUMBER(38,0),
	CC_CNT_AMI NUMBER(38,0),
	CC_CNT_ANEMIA NUMBER(38,0),
	CC_CNT_ASTHMA NUMBER(38,0),
	CC_CNT_CANCER_BREAST NUMBER(38,0),
	CC_CNT_CANCER_COLORECTAL NUMBER(38,0),
	CC_CNT_CANCER_ENDOMETRIAL NUMBER(38,0),
	CC_CNT_CANCER_LUNG NUMBER(38,0),
	CC_CNT_CANCER_PROSTATE NUMBER(38,0),
	CC_CNT_CAT NUMBER(38,0),
	CC_CNT_CHF NUMBER(38,0),
	CC_CNT_CKD NUMBER(38,0),
	CC_CNT_COPD NUMBER(38,0),
	CC_CNT_DEPRESSION NUMBER(38,0),
	CC_CNT_DIAB NUMBER(38,0),
	CC_CNT_GLAUCOMA NUMBER(38,0),
	CC_CNT_HIP_FRACT NUMBER(38,0),
	CC_CNT_HYPERL NUMBER(38,0),
	CC_CNT_HYPERP NUMBER(38,0),
	CC_CNT_HYPERT NUMBER(38,0),
	CC_CNT_HYPOTH NUMBER(38,0),
	CC_CNT_ISCHEMICHEART NUMBER(38,0),
	CC_CNT_OSTEOP NUMBER(38,0),
	CC_CNT_RA_OA NUMBER(38,0),
	CC_CNT_STROKE NUMBER(38,0),
	CNT_IP_ADMITS NUMBER(38,0),
	CNT_OP_ADMITS NUMBER(38,0),
	CNT_SNF_ADMITS NUMBER(38,0),
	CNT_HHA_ADMITS NUMBER(38,0),
	CNT_HOSPICE_ADMITS NUMBER(38,0),
	CNT_UNPLANNED_ADMITS NUMBER(38,0),
	CNT_READMITS NUMBER(38,0),
	CNT_ED_ADMITS NUMBER(38,0),
	CNT_ED_AVOID_ADMITS NUMBER(38,0),
	LOAD_PERIOD VARCHAR(16777216),
	LOAD_RUN_ID NUMBER(38,0),
	LOAD_TS TIMESTAMP_LTZ(9),
	primary key (ORG_ID, FK_PROVIDER_ID, COHORT, SUB_COHORT, YEAR, AGE_GROUP, SEX_GROUP, RACE_GROUP, RISK_ADJUSTMENT)
);

-- DEV_UHS.ATLAS.COHORT_X_CHURN definition

create or replace TABLE COHORT_X_CHURN (
	ORG_ID VARCHAR(30),
	COHORT VARCHAR(100) NOT NULL,
	SUB_COHORT VARCHAR(100) NOT NULL,
	YEAR VARCHAR(4) NOT NULL,
	AGE_GROUP VARCHAR(50) NOT NULL,
	SEX_GROUP VARCHAR(50) NOT NULL,
	RACE_GROUP VARCHAR(50) NOT NULL,
	TOTAL_PATIENTS NUMBER(38,0),
	TOTAL_JOINED_COHORT NUMBER(38,0),
	TOTAL_LEFT_COHORT NUMBER(38,0),
	TOTAL_DIED NUMBER(38,0),
	TOTAL_LOST_ELIGIBILITY NUMBER(38,0),
	TOTAL_CURED NUMBER(38,0),
	TOTAL_NEW_ELIGIBILITY NUMBER(38,0),
	TOTAL_NEW_DIAGNOSIS NUMBER(38,0),
	LOAD_PERIOD VARCHAR(16777216),
	LOAD_RUN_ID NUMBER(38,0),
	LOAD_TS TIMESTAMP_LTZ(9),
	primary key (COHORT, SUB_COHORT, YEAR, AGE_GROUP, SEX_GROUP, RACE_GROUP)
);

-- DEV_UHS.ATLAS.GEOGRAPHY_X_COHORT_LAYUP definition

create or replace TABLE GEOGRAPHY_X_COHORT_LAYUP (
	ORG_ID VARCHAR(30) NOT NULL,
	FK_GEOGRAPHY_ID VARCHAR(100) NOT NULL,
	COHORT VARCHAR(100) NOT NULL,
	SUB_COHORT VARCHAR(100) NOT NULL,
	YEAR VARCHAR(4) NOT NULL,
	AGE_GROUP VARCHAR(50) NOT NULL,
	SEX_GROUP VARCHAR(50) NOT NULL,
	RACE_GROUP VARCHAR(50) NOT NULL,
	RISK_ADJUSTMENT VARCHAR(50),
	COUNTY_DESC VARCHAR(50),
	CBSA_DESC VARCHAR(60),
	STATE VARCHAR(30),
	TOTAL_PATIENTS NUMBER(38,0),
	MEMBER_MONTHS NUMBER(38,0),
	TOTAL_ALLOWED NUMBER(20,4),
	IP_ALLOWED NUMBER(20,4),
	OP_ALLOWED NUMBER(20,4),
	SNF_ALLOWED NUMBER(20,4),
	HHA_ALLOWED NUMBER(20,4),
	HOSPICE_ALLOWED NUMBER(20,4),
	DME_ALLOWED NUMBER(20,4),
	PARTB_EM_ALLOWED NUMBER(20,4),
	PARTB_PROC_ALLOWED NUMBER(20,4),
	PARTB_IMAG_ALLOWED NUMBER(20,4),
	PARTB_DRUGS_ALLOWED NUMBER(20,4),
	CC_CNT_AFIB NUMBER(38,0),
	CC_CNT_ALZH NUMBER(38,0),
	CC_CNT_ALZH_DEMEN NUMBER(38,0),
	CC_CNT_AMI NUMBER(38,0),
	CC_CNT_ANEMIA NUMBER(38,0),
	CC_CNT_ASTHMA NUMBER(38,0),
	CC_CNT_CANCER_BREAST NUMBER(38,0),
	CC_CNT_CANCER_COLORECTAL NUMBER(38,0),
	CC_CNT_CANCER_ENDOMETRIAL NUMBER(38,0),
	CC_CNT_CANCER_LUNG NUMBER(38,0),
	CC_CNT_CANCER_PROSTATE NUMBER(38,0),
	CC_CNT_CAT NUMBER(38,0),
	CC_CNT_CHF NUMBER(38,0),
	CC_CNT_CKD NUMBER(38,0),
	CC_CNT_COPD NUMBER(38,0),
	CC_CNT_DEPRESSION NUMBER(38,0),
	CC_CNT_DIAB NUMBER(38,0),
	CC_CNT_GLAUCOMA NUMBER(38,0),
	CC_CNT_HIP_FRACT NUMBER(38,0),
	CC_CNT_HYPERL NUMBER(38,0),
	CC_CNT_HYPERP NUMBER(38,0),
	CC_CNT_HYPERT NUMBER(38,0),
	CC_CNT_HYPOTH NUMBER(38,0),
	CC_CNT_ISCHEMICHEART NUMBER(38,0),
	CC_CNT_OSTEOP NUMBER(38,0),
	CC_CNT_RA_OA NUMBER(38,0),
	CC_CNT_STROKE NUMBER(38,0),
	LOAD_PERIOD VARCHAR(16777216),
	LOAD_RUN_ID NUMBER(38,0),
	LOAD_TS TIMESTAMP_LTZ(9),
	PARTB_AMBUL_ALLOWED NUMBER(20,4),
	PARTB_TEST_ALLOWED NUMBER(20,4),
	PARTB_DME_ALLOWED NUMBER(20,4),
	PARTB_OTHER_ALLOWED NUMBER(20,4),
	CNT_IP_ADMITS NUMBER(38,0),
	CNT_OP_ADMITS NUMBER(38,0),
	CNT_SNF_ADMITS NUMBER(38,0),
	CNT_HHA_ADMITS NUMBER(38,0),
	CNT_HOSPICE_ADMITS NUMBER(38,0),
	CNT_UNPLANNED_ADMITS NUMBER(38,0),
	CNT_READMITS NUMBER(38,0),
	CNT_ED_ADMITS NUMBER(38,0),
	CNT_ED_AVOID_ADMITS NUMBER(38,0),
	AVG_HCC NUMBER(20,4),
	GEO_TYPE VARCHAR(20),
	primary key (ORG_ID, FK_GEOGRAPHY_ID, COHORT, SUB_COHORT, YEAR, AGE_GROUP, SEX_GROUP, RACE_GROUP)
);

-- DEV_UHS.ATLAS.GEOGRAPHY_X_COHORT_RX_LAYUP definition

create or replace TABLE GEOGRAPHY_X_COHORT_RX_LAYUP (
	ORG_ID VARCHAR(30) NOT NULL,
	FK_GEOGRAPHY_ID VARCHAR(100) NOT NULL,
	COHORT VARCHAR(100) NOT NULL,
	SUB_COHORT VARCHAR(100) NOT NULL,
	YEAR VARCHAR(4) NOT NULL,
	AGE_GROUP VARCHAR(50) NOT NULL,
	SEX_GROUP VARCHAR(50) NOT NULL,
	RACE_GROUP VARCHAR(50) NOT NULL,
	RISK_ADJUSTMENT VARCHAR(50) NOT NULL,
	COUNTY_DESC VARCHAR(50),
	CBSA_DESC VARCHAR(60),
	STATE VARCHAR(30),
	TOTAL_PATIENTS NUMBER(38,0),
	MEMBER_MONTHS NUMBER(38,0),
	TOTAL_RX_COST NUMBER(20,4),
	TOTAL_PARTD_CLAIMS NUMBER(38,0),
	ANTIBACTERIAL_COST NUMBER(20,4),
	CV_AGENT_COST NUMBER(20,4),
	ANALGESIC_COST NUMBER(20,4),
	ANTIDEPRESS_COST NUMBER(20,4),
	ANXIOLYTIC_COST NUMBER(20,4),
	GASTRO_AGENT_COST NUMBER(20,4),
	GLUCOSE_REG_COST NUMBER(20,4),
	HORM_STIM_THYROID_COST NUMBER(20,4),
	ANTICONVUL_COST NUMBER(20,4),
	ANTIEMETICS_COST NUMBER(20,4),
	ELECTROLYTE_COST NUMBER(20,4),
	HORM_STIM_ADRENAL_COST NUMBER(20,4),
	INF_BOWEL_AGENT_COST NUMBER(20,4),
	RESP_AGENT_COST NUMBER(20,4),
	DERM_AGENTS_COST NUMBER(20,4),
	BLOOD_PRODUCT_COST NUMBER(20,4),
	GENIT_AGENT_COST NUMBER(20,4),
	NERVOUS_AGENT_COST NUMBER(20,4),
	ANTIPSYCHOTIC_COST NUMBER(20,4),
	ANTISPASTIC_COST NUMBER(20,4),
	BIPOLAR_AGENT_COST NUMBER(20,4),
	OPHTH_AGENT_COST NUMBER(20,4),
	ANTIFUNGAL_COST NUMBER(20,4),
	ANTIPARKINSON_COST NUMBER(20,4),
	ANTIDEMENTIA_COST NUMBER(20,4),
	ANTIGOUT_COST NUMBER(20,4),
	ANTINEOPLASTIC_COST NUMBER(20,4),
	ANTIVIRAL_COST NUMBER(20,4),
	MUSCULO_RELAX_COST NUMBER(20,4),
	SLEEP_AGENT_COST NUMBER(20,4),
	OTHER_COST NUMBER(20,4),
	ANTIMIGRAINE_COST NUMBER(20,4),
	SEX_HORMONE_COST NUMBER(20,4),
	IMMUNO_AGENT_COST NUMBER(20,4),
	METABOLIC_BONE_COST NUMBER(20,4),
	DENTAL_ORAL_COST NUMBER(20,4),
	ANESTHETICS_COST NUMBER(20,4),
	ANTI_ADDICTION_COST NUMBER(20,4),
	ANTIPARASITICS_COST NUMBER(20,4),
	OTIC_AGENT_COST NUMBER(20,4),
	GENETIC_DISORDER_COST NUMBER(20,4),
	HORM_SUPP_THYROID_COST NUMBER(20,4),
	HORM_STIM_PROST_COST NUMBER(20,4),
	ANTIMYCOBACT_COST NUMBER(20,4),
	HORM_STIM_PITU_COST NUMBER(20,4),
	HORM_SUPP_PITU_COST NUMBER(20,4),
	ANTIMYASTHENIC_COST NUMBER(20,4),
	LOAD_PERIOD VARCHAR(255),
	LOAD_RUN_ID NUMBER(38,0),
	LOAD_TS TIMESTAMP_LTZ(9),
	GEO_TYPE VARCHAR(20),
	primary key (ORG_ID, FK_GEOGRAPHY_ID, COHORT, SUB_COHORT, YEAR, AGE_GROUP, SEX_GROUP, RACE_GROUP, RISK_ADJUSTMENT)
);

-- DEV_UHS.ATLAS.NPI_X_COHORT_LAYUP definition

create or replace TABLE NPI_X_COHORT_LAYUP (
	ORG_ID VARCHAR(30) NOT NULL,
	FK_PROVIDER_ID VARCHAR(20) NOT NULL,
	COHORT VARCHAR(100) NOT NULL,
	SUB_COHORT VARCHAR(100) NOT NULL,
	YEAR VARCHAR(4) NOT NULL,
	AGE_GROUP VARCHAR(50) NOT NULL,
	SEX_GROUP VARCHAR(50) NOT NULL,
	RACE_GROUP VARCHAR(50) NOT NULL,
	RISK_ADJUSTMENT VARCHAR(50) NOT NULL,
	PROVIDER_NAME VARCHAR(100),
	PROVIDER_COUNTY_CODE VARCHAR(10),
	PROVIDER_COUNTY_DESC VARCHAR(50),
	PROVIDER_ZIP VARCHAR(10),
	PROVIDER_STATE VARCHAR(30),
	PROVIDER_CBSA VARCHAR(60),
	TOTAL_PATIENTS NUMBER(38,0),
	MEMBER_MONTHS NUMBER(38,0),
	TOTAL_ALLOWED NUMBER(20,4),
	IP_ALLOWED NUMBER(20,4),
	OP_ALLOWED NUMBER(20,4),
	SNF_ALLOWED NUMBER(20,4),
	HHA_ALLOWED NUMBER(20,4),
	HOSPICE_ALLOWED NUMBER(20,4),
	DME_ALLOWED NUMBER(20,4),
	PARTB_EM_ALLOWED NUMBER(20,4),
	PARTB_PROC_ALLOWED NUMBER(20,4),
	PARTB_IMAG_ALLOWED NUMBER(20,4),
	PARTB_DRUGS_ALLOWED NUMBER(20,4),
	PARTB_AMBUL_ALLOWED NUMBER(20,4),
	PARTB_TEST_ALLOWED NUMBER(20,4),
	PARTB_DME_ALLOWED NUMBER(20,4),
	PARTB_OTHER_ALLOWED NUMBER(20,4),
	CC_CNT_AFIB NUMBER(38,0),
	CC_CNT_ALZH NUMBER(38,0),
	CC_CNT_ALZH_DEMEN NUMBER(38,0),
	CC_CNT_AMI NUMBER(38,0),
	CC_CNT_ANEMIA NUMBER(38,0),
	CC_CNT_ASTHMA NUMBER(38,0),
	CC_CNT_CANCER_BREAST NUMBER(38,0),
	CC_CNT_CANCER_COLORECTAL NUMBER(38,0),
	CC_CNT_CANCER_ENDOMETRIAL NUMBER(38,0),
	CC_CNT_CANCER_LUNG NUMBER(38,0),
	CC_CNT_CANCER_PROSTATE NUMBER(38,0),
	CC_CNT_CAT NUMBER(38,0),
	CC_CNT_CHF NUMBER(38,0),
	CC_CNT_CKD NUMBER(38,0),
	CC_CNT_COPD NUMBER(38,0),
	CC_CNT_DEPRESSION NUMBER(38,0),
	CC_CNT_DIAB NUMBER(38,0),
	CC_CNT_GLAUCOMA NUMBER(38,0),
	CC_CNT_HIP_FRACT NUMBER(38,0),
	CC_CNT_HYPERL NUMBER(38,0),
	CC_CNT_HYPERP NUMBER(38,0),
	CC_CNT_HYPERT NUMBER(38,0),
	CC_CNT_HYPOTH NUMBER(38,0),
	CC_CNT_ISCHEMICHEART NUMBER(38,0),
	CC_CNT_OSTEOP NUMBER(38,0),
	CC_CNT_RA_OA NUMBER(38,0),
	CC_CNT_STROKE NUMBER(38,0),
	CNT_IP_ADMITS NUMBER(38,0),
	CNT_OP_ADMITS NUMBER(38,0),
	CNT_SNF_ADMITS NUMBER(38,0),
	CNT_HHA_ADMITS NUMBER(38,0),
	CNT_HOSPICE_ADMITS NUMBER(38,0),
	CNT_UNPLANNED_ADMITS NUMBER(38,0),
	CNT_READMITS NUMBER(38,0),
	CNT_ED_ADMITS NUMBER(38,0),
	CNT_ED_AVOID_ADMITS NUMBER(38,0),
	LOAD_PERIOD VARCHAR(16777216),
	LOAD_RUN_ID NUMBER(38,0),
	LOAD_TS TIMESTAMP_LTZ(9),
	primary key (ORG_ID, FK_PROVIDER_ID, COHORT, SUB_COHORT, YEAR, AGE_GROUP, SEX_GROUP, RACE_GROUP, RISK_ADJUSTMENT)
);

-- DEV_UHS.CHC.CHC_PROFILE_LIST_GEO_NETWORK_LAYUP definition

create or replace TABLE CHC_PROFILE_LIST_GEO_NETWORK_LAYUP (
	ORG_ID VARCHAR(50),
	LOAD_PERIOD VARCHAR(255),
	LOAD_RUN_ID NUMBER(38,0),
	LOAD_TS TIMESTAMP_LTZ(9),
	FK_GEO_ID VARCHAR(100) NOT NULL,
	GEO_TYPE VARCHAR(20) NOT NULL,
	SOURCE_FILE VARCHAR(5) NOT NULL,
	YEAR VARCHAR(4) NOT NULL,
	PAYER_TYPE VARCHAR(50) NOT NULL,
	NUM_ATTRIBUTED_PATIENTS NUMBER(38,0),
	CLAIMS_PER_PATIENT NUMBER(14,4),
	AVERAGE_AGE NUMBER(14,4),
	PERC_FEMALE NUMBER(14,4),
	PMPY NUMBER(14,4),
	HH_PMPY NUMBER(14,4),
	INPATIENT_PMPY NUMBER(14,4),
	OUTPATIENT_PMPY NUMBER(14,4),
	PARTB_PMPY NUMBER(14,4),
	SNF_PMPY NUMBER(14,4),
	HOSPICE_PMPY NUMBER(14,4),
	PARTB_EM_PAID_AMT NUMBER(14,4),
	PARTB_PROCEDURES_PAID_AMT NUMBER(14,4),
	PARTB_IMAGING_PAID_AMT NUMBER(14,4),
	PARTB_DRUG_PAID_AMT NUMBER(14,4),
	PARTB_AMBULANCE_PAID_AMT NUMBER(14,4),
	PARTB_TEST_PAID_AMT NUMBER(14,4),
	PARTB_DME_PAID_AMT NUMBER(14,4),
	PARTB_OTHER_PAID_AMT NUMBER(14,4),
	NUM_ER_ER_NEEDED_AVOIDABLE_COUNT NUMBER(38,0),
	NUM_ER_ER_NEEDED_COUNT NUMBER(38,0),
	NUM_ER_EMERGENT_PC_TREATABLE_COUNT NUMBER(38,0),
	NUM_ER_NON_EMERGENT_COUNT NUMBER(38,0),
	NUM_ER_VISITS_COUNT NUMBER(38,0),
	NUM_ER_ER_NEEDED_AVOIDABLE_SPEND NUMBER(14,4),
	NUM_ER_ER_NEEDED_SPEND NUMBER(14,4),
	NUM_ER_EMERGENT_PC_TREATABLE_SPEND NUMBER(14,4),
	NUM_ER_NON_EMERGENT_SPEND NUMBER(14,4),
	NUM_ER_VISITS_SPEND NUMBER(14,4),
	INPATIENT_ADMITS NUMBER(38,0),
	OFFICE_VISITS NUMBER(38,0),
	URGENT_CARE_VISITS NUMBER(38,0),
	URGENT_CARE_SPEND NUMBER(14,4),
	URGENT_CARE_SPEND_PER_VISIT NUMBER(14,4),
	DISTRICT VARCHAR(25),
	constraint CHC_PROFILE_LIST_GEO_NETWORK_LAYUP_PKEY primary key (FK_GEO_ID, GEO_TYPE, SOURCE_FILE, YEAR, PAYER_TYPE)
);

-- DEV_UHS.CHC.CHC_PROFILE_LIST_PCP_NETWORK_LAYUP definition

create or replace TABLE CHC_PROFILE_LIST_PCP_NETWORK_LAYUP (
	ORG_ID VARCHAR(50),
	LOAD_PERIOD VARCHAR(255),
	LOAD_RUN_ID NUMBER(38,0),
	LOAD_TS TIMESTAMP_LTZ(9),
	FK_PROVIDER_ID VARCHAR(20) NOT NULL,
	SOURCE_FILE VARCHAR(5) NOT NULL,
	YEAR VARCHAR(4) NOT NULL,
	PAYER_TYPE VARCHAR(50) NOT NULL,
	NUM_ATTRIBUTED_PATIENTS NUMBER(38,0),
	CLAIMS_PER_PATIENT NUMBER(14,4),
	AVERAGE_AGE NUMBER(14,4),
	PERC_FEMALE NUMBER(14,4),
	PMPY NUMBER(14,4),
	HH_PMPY NUMBER(14,4),
	INPATIENT_PMPY NUMBER(14,4),
	OUTPATIENT_PMPY NUMBER(14,4),
	PARTB_PMPY NUMBER(14,4),
	SNF_PMPY NUMBER(14,4),
	HOSPICE_PMPY NUMBER(14,4),
	PARTB_EM_PAID_AMT NUMBER(14,4),
	PARTB_PROCEDURES_PAID_AMT NUMBER(14,4),
	PARTB_IMAGING_PAID_AMT NUMBER(14,4),
	PARTB_DRUG_PAID_AMT NUMBER(14,4),
	PARTB_AMBULANCE_PAID_AMT NUMBER(14,4),
	PARTB_TEST_PAID_AMT NUMBER(14,4),
	PARTB_DME_PAID_AMT NUMBER(14,4),
	PARTB_OTHER_PAID_AMT NUMBER(14,4),
	NUM_ER_ER_NEEDED_AVOIDABLE_COUNT NUMBER(38,0),
	NUM_ER_ER_NEEDED_COUNT NUMBER(38,0),
	NUM_ER_EMERGENT_PC_TREATABLE_COUNT NUMBER(38,0),
	NUM_ER_NON_EMERGENT_COUNT NUMBER(38,0),
	NUM_ER_VISITS_COUNT NUMBER(38,0),
	NUM_ER_ER_NEEDED_AVOIDABLE_SPEND NUMBER(14,4),
	NUM_ER_ER_NEEDED_SPEND NUMBER(14,4),
	NUM_ER_EMERGENT_PC_TREATABLE_SPEND NUMBER(14,4),
	NUM_ER_NON_EMERGENT_SPEND NUMBER(14,4),
	NUM_ER_VISITS_SPEND NUMBER(14,4),
	INPATIENT_ADMITS NUMBER(38,0),
	OFFICE_VISITS NUMBER(38,0),
	GROUP_LEVEL_1_ID VARCHAR(255),
	GROUP_LEVEL_1_NAME VARCHAR(255),
	GROUP_LEVEL_2_ID VARCHAR(255),
	GROUP_LEVEL_2_NAME VARCHAR(255),
	GROUP_LEVEL_3_ID VARCHAR(255),
	GROUP_LEVEL_3_NAME VARCHAR(255),
	GROUP_LEVEL_4_ID VARCHAR(255),
	GROUP_LEVEL_4_NAME VARCHAR(255),
	GROUP_NETWORK_FLAG BOOLEAN,
	NETWORK_1_ID VARCHAR(255),
	NETWORK_1_NAME VARCHAR(255),
	NETWORK_2_ID VARCHAR(255),
	NETWORK_2_NAME VARCHAR(255),
	APM_NAME_1 VARCHAR(255),
	APM_NAME_2 VARCHAR(255),
	APM_NAME_3 VARCHAR(255),
	PROVIDER_NAME VARCHAR(255),
	PROVIDER_COUNTY_CODE VARCHAR(20),
	PROVIDER_COUNTY_DESC VARCHAR(255),
	PROVIDER_ZIP VARCHAR(10),
	PROVIDER_STATE VARCHAR(255),
	PROVIDER_SPECIALTY VARCHAR(255),
	URGENT_CARE_VISITS NUMBER(38,0),
	URGENT_CARE_SPEND NUMBER(14,4),
	URGENT_CARE_SPEND_PER_VISIT NUMBER(14,4),
	constraint CHC_PROFILE_LIST_PCP_NETWORK_LAYUP_PKEY primary key (FK_PROVIDER_ID, SOURCE_FILE, YEAR, PAYER_TYPE)
);

-- DEV_UHS.CHC.CHC_PROFILE_LIST_SPECIALIST_NETWORK_LAYUP definition

create or replace TABLE CHC_PROFILE_LIST_SPECIALIST_NETWORK_LAYUP (
	ORG_ID VARCHAR(50),
	LOAD_PERIOD VARCHAR(255),
	LOAD_RUN_ID NUMBER(38,0),
	LOAD_TS TIMESTAMP_LTZ(9),
	FK_PROVIDER_ID VARCHAR(20) NOT NULL,
	SOURCE_FILE VARCHAR(5) NOT NULL,
	YEAR VARCHAR(4) NOT NULL,
	PAYER_TYPE VARCHAR(50) NOT NULL,
	TOTAL_BENES NUMBER(38,0),
	AVERAGE_AGE NUMBER(14,4),
	PERC_FEMALE NUMBER(14,4),
	CLAIMS_PER_PATIENT NUMBER(14,4),
	PAID_PER_PATIENT NUMBER(14,4),
	NUM_SERVICES NUMBER(14,4),
	PAID_PER_SERVICE NUMBER(14,4),
	PARTB_PAID_AMT NUMBER(14,4),
	PARTB_EM_PAID_AMT NUMBER(14,4),
	PARTB_PROCEDURES_PAID_AMT NUMBER(14,4),
	PARTB_IMAGING_PAID_AMT NUMBER(14,4),
	PARTB_DRUG_PAID_AMT NUMBER(14,4),
	PARTB_AMBULANCE_PAID_AMT NUMBER(14,4),
	PARTB_TEST_PAID_AMT NUMBER(14,4),
	PARTB_DME_PAID_AMT NUMBER(14,4),
	PARTB_OTHER_PAID_AMT NUMBER(14,4),
	GROUP_LEVEL_1_ID VARCHAR(255),
	GROUP_LEVEL_1_NAME VARCHAR(255),
	GROUP_LEVEL_2_ID VARCHAR(255),
	GROUP_LEVEL_2_NAME VARCHAR(255),
	GROUP_LEVEL_3_ID VARCHAR(255),
	GROUP_LEVEL_3_NAME VARCHAR(255),
	GROUP_LEVEL_4_ID VARCHAR(255),
	GROUP_LEVEL_4_NAME VARCHAR(255),
	GROUP_NETWORK_FLAG BOOLEAN,
	NETWORK_1_ID VARCHAR(255),
	NETWORK_1_NAME VARCHAR(255),
	NETWORK_2_ID VARCHAR(255),
	NETWORK_2_NAME VARCHAR(255),
	APM_NAME_1 VARCHAR(255),
	APM_NAME_2 VARCHAR(255),
	APM_NAME_3 VARCHAR(255),
	PROVIDER_NAME VARCHAR(255),
	PROVIDER_COUNTY_CODE VARCHAR(20),
	PROVIDER_COUNTY_DESC VARCHAR(255),
	PROVIDER_ZIP VARCHAR(10),
	PROVIDER_STATE VARCHAR(255),
	PROVIDER_SPECIALTY VARCHAR(255),
	constraint CHC_PROFILE_LIST_SPECIALIST_NETWORK_LAYUP_PKEY primary key (FK_PROVIDER_ID, SOURCE_FILE, YEAR, PAYER_TYPE)
);

-- DEV_UHS.CHC.NPI_X_PAYER_X_PROCEDURE_SPEND definition

create or replace TABLE NPI_X_PAYER_X_PROCEDURE_SPEND (
	ORG_ID VARCHAR(50),
	LOAD_PERIOD VARCHAR(255),
	LOAD_RUN_ID NUMBER(38,0),
	LOAD_TS TIMESTAMP_LTZ(9),
	FK_PROVIDER_ID VARCHAR(20) NOT NULL,
	SOURCE_FILE VARCHAR(5) NOT NULL,
	YEAR VARCHAR(4) NOT NULL,
	FK_PAYER_ID VARCHAR(20) NOT NULL,
	PROCEDURE VARCHAR(20) NOT NULL,
	MODIFIER_1 VARCHAR(20) NOT NULL,
	MODIFIER_2 VARCHAR(20) NOT NULL,
	PLACE_OF_SERVICE VARCHAR(20) NOT NULL,
	TOTAL_BILLED_UNITS VARCHAR(20) NOT NULL,
	TOTAL_CLAIM_COUNT NUMBER(38,0) NOT NULL,
	PAYER_TYPE VARCHAR(50) NOT NULL,
	TOTAL_ALLOWED NUMBER(14,4),
	TOTAL_PAID NUMBER(14,4),
	GROUP_LEVEL_1_NAME VARCHAR(255),
	GROUP_LEVEL_2_ID VARCHAR(255),
	GROUP_LEVEL_2_NAME VARCHAR(255),
	GROUP_LEVEL_3_ID VARCHAR(255),
	GROUP_LEVEL_3_NAME VARCHAR(255),
	GROUP_LEVEL_4_ID VARCHAR(255),
	GROUP_LEVEL_4_NAME VARCHAR(255),
	GROUP_NETWORK_FLAG BOOLEAN,
	NETWORK_1_ID VARCHAR(255),
	NETWORK_1_NAME VARCHAR(255),
	NETWORK_2_ID VARCHAR(255),
	NETWORK_2_NAME VARCHAR(255),
	APM_NAME_1 VARCHAR(255),
	APM_NAME_2 VARCHAR(255),
	APM_NAME_3 VARCHAR(255),
	PROVIDER_NAME VARCHAR(255),
	PROVIDER_COUNTY_CODE VARCHAR(20),
	PROVIDER_COUNTY_DESC VARCHAR(255),
	PROVIDER_ZIP VARCHAR(10),
	PROVIDER_STATE VARCHAR(255),
	PROVIDER_SPECIALTY VARCHAR(255),
	PROCEDURE_DESC VARCHAR(16777216),
	constraint NPI_X_PAYER_X_PROCEDURE_SPEND_PKEY primary key (FK_PROVIDER_ID, SOURCE_FILE, YEAR, FK_PAYER_ID, PROCEDURE, MODIFIER_1, MODIFIER_2, PLACE_OF_SERVICE, TOTAL_BILLED_UNITS, TOTAL_CLAIM_COUNT, PAYER_TYPE)
);

