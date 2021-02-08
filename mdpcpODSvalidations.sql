USE WAREHOUSE prod_medstar_mdpcp;
USE DATABASE prod_medstar_mdpcp;

SELECT * --m-2020-10
FROM insights.max_load_period

SELECT
      tbl.table_schema
    , tbl.table_name
    , 'SELECT ' || ''''  || tbl.table_schema || '.' || tbl.table_name || ''' AS TableName, ' || 'MAX(Load_Ts) AS MaxLoadTS, MAX(load_period) as MaxLoadPer, Count(*) as rwCount, count(distinct src_ps_id) as orgIDCount FROM ' 
    || tbl.table_schema || '.' || tbl.table_name || ' where substr(load_period,3,7) = ''2020-3'''
    || ' UNION ALL '
    AS Query
FROM information_schema.tables tbl
join information_schema.columns col
    on tbl.table_name = col.table_name
    and tbl.table_schema = col.table_schema
    and col.column_name = 'LOAD_PERIOD'
WHERE --varied combinations of like and not like for '%network%' and '%layup%'
    --allow the generating SQL below to focus on NA: Base, Network and Layup phases
    tbl.table_schema = 'ODS'
    and tbl.table_name like 'MDPCP%'
--    and tbl.table_name like '%layup%' 
    --tbl.table_schema 
            --in ('atlas')
                       --in ('wkbk2')
                       --in ('ods')
                       --in ('adhoc')       
union all
select 'zzz' as table_schema
    , 'zzz' as table_name
    , 'order by TableName' as Query
ORDER BY table_schema, table_name

SELECT 'ODS.MDPCP_ASSGN_ATTRIBD' AS TableName, MAX(Load_Ts) AS MaxLoadTS, MAX(load_period) as MaxLoadPer, Count(*) as rwCount, count(distinct src_ps_id) as orgIDCount FROM ODS.MDPCP_ASSGN_ATTRIBD where substr(load_period,3,7) = '2020-3' UNION ALL 
SELECT 'ODS.MDPCP_ASSGN_TERMD' AS TableName, MAX(Load_Ts) AS MaxLoadTS, MAX(load_period) as MaxLoadPer, Count(*) as rwCount, count(distinct src_ps_id) as orgIDCount FROM ODS.MDPCP_ASSGN_TERMD where substr(load_period,3,7) = '2020-3' UNION ALL 
SELECT 'ODS.MDPCP_BENED' AS TableName, MAX(Load_Ts) AS MaxLoadTS, MAX(load_period) as MaxLoadPer, Count(*) as rwCount, count(distinct src_ps_id) as orgIDCount FROM ODS.MDPCP_BENED where substr(load_period,3,7) = '2020-3' UNION ALL 
SELECT 'ODS.MDPCP_BENED_MONTH' AS TableName, MAX(Load_Ts) AS MaxLoadTS, MAX(load_period) as MaxLoadPer, Count(*) as rwCount, count(distinct src_ps_id) as orgIDCount FROM ODS.MDPCP_BENED_MONTH where substr(load_period,3,7) = '2020-3' UNION ALL 
SELECT 'ODS.MDPCP_BENED_YEAR' AS TableName, MAX(Load_Ts) AS MaxLoadTS, MAX(load_period) as MaxLoadPer, Count(*) as rwCount, count(distinct src_ps_id) as orgIDCount FROM ODS.MDPCP_BENED_YEAR where substr(load_period,3,7) = '2020-3' UNION ALL 
SELECT 'ODS.MDPCP_PTACLM' AS TableName, MAX(Load_Ts) AS MaxLoadTS, MAX(load_period) as MaxLoadPer, Count(*) as rwCount, count(distinct src_ps_id) as orgIDCount FROM ODS.MDPCP_PTACLM where substr(load_period,3,7) = '2020-3' UNION ALL 
SELECT 'ODS.MDPCP_PTADGN' AS TableName, MAX(Load_Ts) AS MaxLoadTS, MAX(load_period) as MaxLoadPer, Count(*) as rwCount, count(distinct src_ps_id) as orgIDCount FROM ODS.MDPCP_PTADGN where substr(load_period,3,7) = '2020-3' UNION ALL 
SELECT 'ODS.MDPCP_PTAPRC' AS TableName, MAX(Load_Ts) AS MaxLoadTS, MAX(load_period) as MaxLoadPer, Count(*) as rwCount, count(distinct src_ps_id) as orgIDCount FROM ODS.MDPCP_PTAPRC where substr(load_period,3,7) = '2020-3' UNION ALL 
SELECT 'ODS.MDPCP_PTAREV' AS TableName, MAX(Load_Ts) AS MaxLoadTS, MAX(load_period) as MaxLoadPer, Count(*) as rwCount, count(distinct src_ps_id) as orgIDCount FROM ODS.MDPCP_PTAREV where substr(load_period,3,7) = '2020-3' UNION ALL 
SELECT 'ODS.MDPCP_PTBDME' AS TableName, MAX(Load_Ts) AS MaxLoadTS, MAX(load_period) as MaxLoadPer, Count(*) as rwCount, count(distinct src_ps_id) as orgIDCount FROM ODS.MDPCP_PTBDME where substr(load_period,3,7) = '2020-3' UNION ALL 
SELECT 'ODS.MDPCP_PTBPHY' AS TableName, MAX(Load_Ts) AS MaxLoadTS, MAX(load_period) as MaxLoadPer, Count(*) as rwCount, count(distinct src_ps_id) as orgIDCount FROM ODS.MDPCP_PTBPHY where substr(load_period,3,7) = '2020-3' UNION ALL 
SELECT 'ODS.MDPCP_PTD' AS TableName, MAX(Load_Ts) AS MaxLoadTS, MAX(load_period) as MaxLoadPer, Count(*) as rwCount, count(distinct src_ps_id) as orgIDCount FROM ODS.MDPCP_PTD where substr(load_period,3,7) = '2020-3'  
order by TableName


USE WAREHOUSE prod_medstar_mdpcp;
USE DATABASE prod_medstar_mdpcp;

WITH statData
AS
(
SELECT src_practice_id
  --, count(SRC_FILE_TYPE) AS nbrFiles
  , SRC_FILE_TYPE 
  , SRC_NUM_RECORDS 
FROM ODS.MDPCP_STAT
where substr(load_period,3,7) = '2020-3'
  --AND SRC_PRACTICE_ID = 'T1MD0261'
  AND SRC_FILE_TYPE = 'ptbphy'
  AND SRC_NUM_RECORDS > 60000
--GROUP BY src_practice_id
--  , SRC_FILE_TYPE 
ORDER BY src_practice_id
, SRC_FILE_TYPE 
)
, countData
AS
(
SELECT src_ps_id
  , count(*) AS recCount
FROM ods.MDPCP_PTBPHY 
where substr(load_period,3,7) = '2020-3'
GROUP BY src_ps_id
) 
SELECT src_practice_id
  , src_num_records
  , recCount
FROM statData
JOIN countData
  ON statData.src_practice_id = countData.src_ps_id
WHERE src_num_records <> recCount



SELECT ps_id
  , max(DAG_RUN_ID) AS maxDag
  , max(LOAD_TS) AS maxTS
  , max(CAST(load_ts AS date)) AS maxDate
FROM STG.SSF_MDPCP_5_PTBPHY_V01 
WHERE ps_id IN (
  'T1MD0625'
  , 'T1MD0370'
)
GROUP BY PS_ID 

SELECT ps_id
  , count(*) AS rwCnt
FROM STG.SSF_MDPCP_5_PTBPHY_V01 
WHERE ps_id IN (
  'T1MD0625'
  , 'T1MD0370'
) AND CAST(load_ts AS date) = '2020-11-20'
GROUP BY PS_ID 


--Insights validations

--for cclfs used in Activity, none have eff flag = true
--so Activity is empty
  --Activty impacts Pateint_awv
SELECT *
FROM INT_A3774.ods.cclf_5_pt_b_phys
WHERE effective_flag = true
SELECT *
FROM int_a3774.ods.cclf_3_pt_a_proc_cd
WHERE effective_flag = TRUE
SELECT *
FROM int_a3774.ods.cclf_1_pt_a_clm_hdr
WHERE effective_flag = TRUE
SELECT *
FROM int_a3774.ods.cclf_2_pt_a_clm_rev_ctr_det
WHERE effective_flag = TRUE
SELECT *
FROM int_a3774.ods.cclf_6_pt_b_dme
WHERE effective_flag = TRUE
SELECT *
FROM int_a3774.ods.cclf_7_pt_d
WHERE effective_flag = TRUE

--vrdc validations
SELECT
      tbl.table_schema
    , tbl.table_name
    , 'SELECT ' || ''''  || tbl.table_schema || '.' || tbl.table_name || ''' AS TableName, ' || 'src_metric_label, MAX(src_year) AS mxyr, MIN(src_year) AS mnyr FROM ' || tbl.table_schema || '.' || tbl.table_name
    || ' GROUP BY src_metric_label UNION ALL ' AS Query
FROM information_schema.tables tbl
join information_schema.columns col 
  on tbl.table_name = col.table_name 
  and tbl.table_schema = col.table_schema 
  and col.column_name = 'src_metric_label'
WHERE tbl.table_schema IN ('ods')
    and tbl.table_name like 'vrdc_profile_list%'
union all
select 'zzz' as table_schema
    , 'zzz' as table_name
    , 'order by TableName, src_metric_label, mxyr' as Query
order by table_schema, table_name


SELECT
    tbl.table_name
    , 'SELECT ' || ''''  || tbl.table_schema || '.' || tbl.table_name || ''' AS TableName, ' || ' org_id, year, MAX(Load_Ts) AS MaxLoadTS, Count(*) as rwCount FROM ' || tbl.table_schema || '.' || tbl.table_name
    || ' GROUP BY org_id, year UNION ALL ' AS Query
FROM information_schema.tables tbl
WHERE tbl.table_schema IN ('vrdc')
    and tbl.table_name like 'cji%'
union all
select  'zzz' as table_name
    , 'order by org_id, TableName, year' as Query
order by table_name

SELECT *
FROM INT_MEDSTAR_MDPCP_FE.INSIGHTS.PROFILE_LIST_SPECIALIST  
WHERE FK_PROVIDER_ID = 'npi_num|1003084237'
ORDER BY FK_PROVIDER_ID, MONTH_CD, ATTRIBUTION_TYPE 

SELECT *
FROM SNAPSHOT_PROD_MEDSTAR_MDPCP_20201223.INSIGHTS.PROFILE_LIST_SPECIALIST 
WHERE FK_PROVIDER_ID = 'npi_num|1003084237'
ORDER BY FK_PROVIDER_ID, MONTH_CD, ATTRIBUTION_TYPE 


USE WAREHOUSE PROD_MEDSTAR_MDPCP;
USE DATABASE prod_medstar_mdpcp;
--tbl.table_schema

--non of the period ids have 's-'
select
    org_id
--  , org_level_category_cd
--  , org_group_id
  , period_id
  , measure_value_decimal
from insights.metric_value_operational_dashboard
--SNAPSHOT_PROD_MEDSTAR_MDPCP_20201118.insights.metric_value_operational_dashboard
where measure_cd = 'total_member_years_current_month'
  and patient_medicare_group_cd = '#NA' 
  and org_level_category_cd = 'aco'
  and attribution_type = 'as_was'
  and substr(period_id,3,7) >= '2019-01' 
order by org_id    
      , substr(period_id,3,7) 


stg.ssf_cclf_assgn_1_summ_v14
stg.ssf_cclf_assgn_4_tin_npi_v12
stg.ssf_cclf_expu_3_v11
stg.ssf_cclf_hassgn_0_v09
stg.ssf_cclf_hassgn_1_v09
stg.ssf_cclf_hassgn_2_v09
stg.ssf_cclf_hassgn_4_v09
stg.ssf_cclf_hassgn_6_v09
stg.ssf_cclf_preliminary_assgn_1_summ_v13
stg.ssf_cclf_prospective_assgn_1_summ_v12
stg.ssf_cclf_prospective_expu_3_v11


--more data in snowflake for this one file type

---in snowflake sfg_file_ids go lower for example 8000-15000
select min(stg_file_id) as minStgFID --15946
  , max(stg_file_id) as maxSFID --23415
  , min(ssf_file_id) as minSSFFID --same
  , max(ssf_file_id) as maxSSFFID
FROM stg.ssf_cclf_0_v26 

--ln Presto, these tables exist without data and so V08 versions are only in snowflake (data matches for those)
SELECT 'stg.ssf_cclf_hassgn_0_v09' AS TableName, stg_file_id, MAX(Load_Ts) AS MaxLoadTS, Count(*) as rwCount FROM stg.ssf_cclf_hassgn_0_v09 GROUP BY STG_FILE_ID UNION ALL 
SELECT 'stg.ssf_cclf_hassgn_2_v09' AS TableName, stg_file_id, MAX(Load_Ts) AS MaxLoadTS, Count(*) as rwCount FROM stg.ssf_cclf_hassgn_2_v09 GROUP BY STG_FILE_ID UNION ALL 
SELECT 'stg.ssf_cclf_hassgn_4_v09' AS TableName, stg_file_id, MAX(Load_Ts) AS MaxLoadTS, Count(*) as rwCount FROM stg.ssf_cclf_hassgn_4_v09 GROUP BY STG_FILE_ID UNION ALL 
SELECT 'stg.ssf_cclf_hassgn_6_v09' AS TableName, stg_file_id, MAX(Load_Ts) AS MaxLoadTS, Count(*) as rwCount FROM stg.ssf_cclf_hassgn_6_v09 GROUP BY STG_FILE_ID
order by TableName, stg_file_id



WITH compareOrg
AS
(
SELECT --*
  TABLE_1
  , TABLE_2 
  , LOAD_TS 
  ,TABLE_1_COUNT 
  ,TABLE_2_COUNT 
  ,STATUS 
  , CASE 
    WHEN TABLE_2_COUNT <> 0 OR TABLE_1_COUNT <> 0 then
        DIFF_COUNT / COALESCE(nullifzero(TABLE_2_COUNT),nullifzero(TABLE_1_COUNT)) 
    ELSE 0
  END AS diffPercent
  ,DIFF_COUNT   
FROM (
    SELECT *
         ,ROW_NUMBER() OVER (PARTITION BY TABLE_1 ORDER BY LOAD_TS DESC) AS RowNum
    FROM INT_TEST.PUBLIC.TABLE_COMPARISON 
) A
WHERE A.RowNum = 1
--    AND A.STATUS = '' -- S = Success, X = No PK, F = Failed
AND SPLIT_PART(TABLE_1,'.',1) = 'INT_A2841'
AND SPLIT_PART(TABLE_1,'.',2) = 'INSIGHTS'
ORDER BY  TABLE_1
--STATUS,
)
SELECT --*
  a.TABLE_1
  , a.TABLE_2 
  , a.LOAD_TS 
  ,a.TABLE_1_COUNT 
  ,a.TABLE_2_COUNT 
  ,a.STATUS 
  , CASE 
    WHEN a.TABLE_2_COUNT <> 0 OR a.TABLE_1_COUNT <> 0 then
        a.DIFF_COUNT / COALESCE(nullifzero(a.TABLE_2_COUNT),nullifzero(a.TABLE_1_COUNT)) 
    ELSE 0
  END AS diffPercent
  ,a.DIFF_COUNT
  , COMPAREORG.diffPercent AS A2841_DIFF_PERCENT
FROM (
    SELECT *
         ,ROW_NUMBER() OVER (PARTITION BY TABLE_1 ORDER BY LOAD_TS DESC) AS RowNum
    FROM INT_TEST.PUBLIC.TABLE_COMPARISON 
) A
LEFT JOIN COMPAREORG 
  ON SPLIT_PART(a.table_1,'.',3) = SPLIT_PART(compareorg.table_1,'.',3)

WHERE A.RowNum = 1
--    AND A.STATUS = '' -- S = Success, X = No PK, F = Failed
AND SPLIT_PART(a.TABLE_1,'.',1) = 'INT_A4709'
AND SPLIT_PART(a.TABLE_1,'.',2) = 'INSIGHTS'
ORDER BY  a.TABLE_1



WITH compareOrg
AS
(
SELECT --*
  TABLE_1
  , TABLE_2 
  , LOAD_TS 
  ,TABLE_1_COUNT 
  ,TABLE_2_COUNT 
  ,STATUS 
  , CASE 
    WHEN TABLE_2_COUNT <> 0 OR TABLE_1_COUNT <> 0 then
        DIFF_COUNT / COALESCE(nullifzero(TABLE_2_COUNT),nullifzero(TABLE_1_COUNT)) 
    ELSE 0
  END AS diffPercent
  ,DIFF_COUNT   
FROM (
    SELECT *
         ,ROW_NUMBER() OVER (PARTITION BY TABLE_1 ORDER BY LOAD_TS DESC) AS RowNum
    FROM INT_TEST.PUBLIC.TABLE_COMPARISON 
) A
WHERE A.RowNum = 1
--    AND A.STATUS = '' -- S = Success, X = No PK, F = Failed
AND SPLIT_PART(TABLE_1,'.',1) = 'INT_A2841'
AND SPLIT_PART(TABLE_1,'.',2) = 'INSIGHTS'
ORDER BY  TABLE_1
--STATUS,
)
, main as
(
SELECT --*
  a.TABLE_1
  , a.TABLE_2 
  , a.LOAD_TS 
  ,a.TABLE_1_COUNT 
  ,a.TABLE_2_COUNT 
  ,a.STATUS 
  , CASE 
    WHEN a.TABLE_2_COUNT <> 0 OR a.TABLE_1_COUNT <> 0 then
        a.DIFF_COUNT / COALESCE(nullifzero(a.TABLE_2_COUNT),nullifzero(a.TABLE_1_COUNT)) 
    ELSE 0
  END AS diffPercent
  ,a.DIFF_COUNT
  , COMPAREORG.diffPercent AS A2841_DIFF_PERCENT
FROM (
    SELECT *
         ,ROW_NUMBER() OVER (PARTITION BY TABLE_1 ORDER BY LOAD_TS DESC) AS RowNum
    FROM INT_TEST.PUBLIC.TABLE_COMPARISON 
) A
LEFT JOIN COMPAREORG 
  ON SPLIT_PART(a.table_1,'.',3) = SPLIT_PART(compareorg.table_1,'.',3)

WHERE A.RowNum = 1
--    AND A.STATUS = '' -- S = Success, X = No PK, F = Failed
AND SPLIT_PART(a.TABLE_1,'.',1) = 'INT_A1052'
AND SPLIT_PART(a.TABLE_1,'.',2) = 'INSIGHTS'
)
SELECT *
  , A2841_DIFF_PERCENT - diffPercent AS diff_of_diff
FROM main
ORDER BY  TABLE_1



SELECT 'SELECT ' || '''' 
|| SPLIT_PART(database_name,'_',3) || ''' AS ORG_ID, ' 
|| ''''  || tbl.table_schema || '.' || tbl.table_name || ''' AS TableName, ' 
|| 'MAX(Load_Ts) AS MaxLoadTS, MAX(Load_PERIOD) AS MaxLoadPeriod, Count(*) as rwCount FROM ' || database_name || '.' || tbl.table_schema || '.' || tbl.table_name 
|| ' UNION ALL '
FROM information_schema.DATABASES
JOIN information_schema.TABLES tbl 
  ON 1 = 1
JOIN information_schema.COLUMNS col
  ON tbl.TABLE_NAME = col.TABLE_NAME 
  AND tbl.TABLE_SCHEMA  = col.TABLE_SCHEMA 
  AND col.COLUMN_NAME = 'LOAD_PERIOD'
WHERE DATABASE_NAME IN ('SNAPSHOT_PROD_A1052_20210107_PRESTO_FINAL')
  AND tbl.TABLE_SCHEMA = 
            'INSIGHTS'
  
ORDER BY DATABASE_NAME, tbl.table_name 

SELECT ORG_ID
, MONTH_CD
, NUM_ATTRIBUTED_PATIENTS
, NUM_ASSIGNABLE_PATIENTS
, PERCENT_CAPTURE_RATE
, PERCENT_ESRD
, PERCENT_DISABLED
, PERCENT_DUAL
, PERCENT_AGED
, AVERAGE_RISK_SCORE
--, ATTRIB_PMPY
--, ATTRIB_PMPY_HOSP_IP
--, ATTRIB_PMPY_OP
--, ATTRIB_PMPY_HH
--, ATTRIB_PMPY_SNF
--, ATTRIB_PMPY_PARTB
--, ATTRIB_PMPY_PARTBDME
--, ATTRIB_PMPY_HOSPICE
, TCM_ELIGIBLE_INSTANCES
, PERCENT_TCM_COMPLIANCE
, CCM_ELIGIBLE_INSTANCES
, PERCENT_CCM_COMPLIANCE
, AWV_ELIGIBLE_INSTANCES
, PERCENT_AWV_COMPLIANCE
, UNNECESSARY_CARE_PAID_AMT
, UNNECESSARY_CARE_PAID_TO_PCP_TIN
, ATTRIBUTION_TYPE
FROM INT_A2841.INSIGHTS.PROFILE_LIST_ACO

EXCEPT 

SELECT ORG_ID
, MONTH_CD
, NUM_ATTRIBUTED_PATIENTS
, NUM_ASSIGNABLE_PATIENTS
, PERCENT_CAPTURE_RATE
, PERCENT_ESRD
, PERCENT_DISABLED
, PERCENT_DUAL
, PERCENT_AGED
, AVERAGE_RISK_SCORE
--, ATTRIB_PMPY
--, ATTRIB_PMPY_HOSP_IP
--, ATTRIB_PMPY_OP
--, ATTRIB_PMPY_HH
--, ATTRIB_PMPY_SNF
--, ATTRIB_PMPY_PARTB
--, ATTRIB_PMPY_PARTBDME
--, ATTRIB_PMPY_HOSPICE
, TCM_ELIGIBLE_INSTANCES
, PERCENT_TCM_COMPLIANCE
, CCM_ELIGIBLE_INSTANCES
, PERCENT_CCM_COMPLIANCE
, AWV_ELIGIBLE_INSTANCES
, PERCENT_AWV_COMPLIANCE
, UNNECESSARY_CARE_PAID_AMT
, UNNECESSARY_CARE_PAID_TO_PCP_TIN
, ATTRIBUTION_TYPE
FROM SNAPSHOT_PROD_A2841_20210107_PRESTO_FINAL.INSIGHTS.PROFILE_LIST_ACO


USE WAREHOUSE int_a2841;
USE DATABASE int_a2841;

--from aco_x_patient_month.sql

        SELECT
              excl.org_src_id as org_src_id
            , split_part(excl.fk_bene_id,'|',2) as beneficiary_id
            , excl.fk_assgn_hdr_id as fk_assgn_hdr_id
            , CASE
                  WHEN src_bene_death_date_prior_excl_flg = '1'     THEN 'death_date_prior'
                  WHEN src_bene_prt_a_b_only_excl_flg = '1'         THEN 'pt_ab_only'
                  WHEN src_bene_id_missing_excl_flg = '1'           THEN 'bene_id_missing'
                  WHEN src_bene_reside_outside_us_excl_flg = '1'    THEN 'reside_outside_us'
                  WHEN src_bene_other_shared_savings_excl_flg = '1' THEN 'other_shared_savings'
                  WHEN src_bene_one_mnth_mhp_excl_flg = '1'         THEN 'one_month_mhp'
                  ELSE '#NA'
              END as turnover_reason_cd
            , FALSE as assignable_curr_period_flag
            , CASE
                  WHEN split_part(excl.fk_bene_id,'|',2) IS NULL
                      THEN
                          FALSE
                      ELSE
                          TRUE
              END AS turnover_curr_period_flag
        FROM --SNAPSHOT_PROD_A2841_20210107_PRESTO_FINAL.ods.cclf_assgn_1_summ excl 
        ods.cclf_assgn_1_summ excl  
        WHERE src_bene_excl_flg = '1'
            AND record_status_cd = 'a'
            AND SPLIT_PART(excl.fk_assgn_hdr_id,'|',3) = 'q-2020-4'
            

SELECT ERA_835_VISIT_NK
  , SRC_TOTAL_CLAIM_CHARGE_AMOUNT
  , SRC_TOTAL_PAID_AMT
  , count(*) AS rwCnt
FROM ODS.CHC_ERA_835
WHERE EFFECTIVE_FLAG = TRUE
GROUP BY ERA_835_VISIT_NK
  , SRC_TOTAL_CLAIM_CHARGE_AMOUNT
  , SRC_TOTAL_PAID_AMT
HAVING count(*) > 1

SELECT DISTINCT physician_npi
FROM 
(
SELECT attribution_type
  , month_cd
  , org_id
  , physician_npi
  , count(*) AS rwCnt
FROM prod_a2024.insights.profile_list_pcp
GROUP BY attribution_type
  , month_cd
  , org_id
  , physician_npi
HAVING count(*) > 1
) a


SELECT attribution_type
  , month_cd
  , org_id
  , physician_npi
  , count(*) AS rwCnt
FROM prod_a2024.insights.profile_list_pcp
GROUP BY attribution_type
  , month_cd
  , org_id
  , physician_npi
HAVING count(*) > 1

SELECT *
FROM prod_a1052.insights.profile_list_pcp
WHERE ATTRIBUTION_TYPE = ''
  AND MONTH_CD = ''
  AND org_id  = 'A2024'
  AND PHYSICIAN_NPI = ''

  SELECT count(*) AS rwCnt --3,838,393,795
FROM prod_change.stg.SSF_CHC_CLM_CF_MPO_CEM_DEID_V01 
WHERE RECORD_TYPE = 'C'
SELECT count(*) AS rwCnt --3,901,420,666
FROM PROD_CHANGE.ODS.CHC_CLAIM_837


SELECT count(*) AS rwCnt --10,000,339,002
FROM prod_change.stg.SSF_CHC_CLM_CF_MPO_CEM_DEID_V01 
WHERE RECORD_TYPE = 'S'
SELECT count(*) AS rwCnt --10,529,235,382
FROM PROD_CHANGE.ODS.CHC_CLAIM_837_LINE


SELECT count(*) AS rwCnt --3,414,093,652
FROM prod_change.STG.SSF_CHC_ERA_CF_DEID_V01
WHERE RECORD_TYPE = 'C'
SELECT count(*) AS rwCnt --3,590,398,721
FROM PROD_CHANGE.ODS.CHC_ERA_835


SELECT count(*) AS rwCnt --8,571,552,092
FROM PROD_CHANGE.STG.SSF_CHC_ERA_CF_DEID_V01
WHERE RECORD_TYPE = 'S'
SELECT count(*) AS rwCnt --8,846,278,129
FROM PROD_CHANGE.ODS.CHC_ERA_835_LINE 




SELECT count(*) AS rwCnt --3,838,393,795
FROM prod_change.stg.SSF_CHC_CLM_CF_MPO_CEM_DEID_V01 
WHERE RECORD_TYPE = 'C'

SELECT count(*) AS rwCnt --3,901,420,666
FROM PROD_CHANGE.ODS.CHC_CLAIM_837

SELECT count(*) AS rwCnt --3,838,390,478
FROM PROD_CHANGE.ODS.CHC_CLAIM_837
WHERE RECORD_STATUS_CD = 'a'


SELECT count(*) AS rwCnt --10,000,339,002
FROM prod_change.stg.SSF_CHC_CLM_CF_MPO_CEM_DEID_V01 
WHERE RECORD_TYPE = 'S'

SELECT count(*) AS rwCnt --10,529,235,382
FROM PROD_CHANGE.ODS.CHC_CLAIM_837_LINE

SELECT count(*) AS rwCnt --10,000,331,972
FROM PROD_CHANGE.ODS.CHC_CLAIM_837_LINE
WHERE RECORD_STATUS_CD = 'a'


SELECT count(*) AS rwCnt --3,414,093,652
FROM prod_change.STG.SSF_CHC_ERA_CF_DEID_V01
WHERE RECORD_TYPE = 'C'

SELECT count(*) AS rwCnt --3,590,398,721
FROM PROD_CHANGE.ODS.CHC_ERA_835

SELECT count(*) AS rwCnt --3,413,804,206
FROM PROD_CHANGE.ODS.CHC_ERA_835
WHERE RECORD_STATUS_CD = 'a'


SELECT count(*) AS rwCnt --8,571,552,092
FROM PROD_CHANGE.STG.SSF_CHC_ERA_CF_DEID_V01
WHERE RECORD_TYPE = 'S'

SELECT count(*) AS rwCnt --8,846,278,129
FROM PROD_CHANGE.ODS.CHC_ERA_835_LINE 

SELECT count(*) AS rwCnt --8,570,858,433
FROM PROD_CHANGE.ODS.CHC_ERA_835_LINE 
WHERE RECORD_STATUS_CD = 'a'