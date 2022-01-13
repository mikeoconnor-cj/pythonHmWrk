#! python3
# pytn3Test.py  --testing the python 3.8.62 interpreter on EC2
# from openpyxl import load_workbook 
from time import time_ns
import snowflake.connector as sf
import pandas as pd
import numpy
from openpyxl import load_workbook
from tabulate import tabulate
# print('hello world')
# print(q23)

# import snowflake.connector
import os
from cryptography.hazmat.backends import default_backend
from cryptography.hazmat.primitives.asymmetric import rsa
from cryptography.hazmat.primitives.asymmetric import dsa
from cryptography.hazmat.primitives import serialization
with open("/home/ec2-user/pythonWrk/rsa_key.p8", "rb") as key:
    p_key= serialization.load_pem_private_key(
        key.read(),
        password=None,
        # os.environ['PRIVATE_KEY_PASSPHRASE'].encode(),
        backend=default_backend()
    )
    # p_key= serialization.load_private_key(
    #     key.read(),
    #     # password='',
    #     # os.environ['PRIVATE_KEY_PASSPHRASE'].encode(),
    #     backend=default_backend()
    # )

pkb = p_key.private_bytes(
    encoding=serialization.Encoding.DER,
    format=serialization.PrivateFormat.PKCS8,
    encryption_algorithm=serialization.NoEncryption())
try:

    ctx = sf.connect(
        user='MICHAEL_OCONNOR_RSA',
        password='abim@3l^Fs3',
        account='carejourney.us-east-1.privatelink',
        private_key=pkb,
        warehouse='PROD_A2024',
        database='PROD_A2024'
        # schema=SCHEMA
        )

    # does this authentication work with nci?  No
    # ctx2 = sf.connect(
    #     user='MICHAEL_OCONNOR_RSA',
    #     password='abim@3l^Fs3',
    #     account='carejourney_nci.us-east-1',
    #     private_key=pkb,
    #     warehouse='DEV_BRIGHT',
    #     database='DEV_BRIGHT'
    #     # schema=SCHEMA
    #     )

        # ssl_wrap_socket() got an unexpected keyword argument 'ca_cert_data'

    # cs = ctx.cursor()
    # cs.execute('select 1')
    # result = cs.fetchall()
    # print(result)

    # orgDB = 'PROD_A2024'
    # orgDBCompare = orgDB + '_FE'
    # 'PROD_A2024_fe'

    sf_cursor = ctx.cursor()

    # 'PROD_A2024',
    orgDBList = [
                # 'PROD_A1052'
                # ,
                # 'PROD_A2024'
                #uhs
                # ,
                # 'PROD_A2251'
                # ,'PROD_A2575'
                # ,'PROD_A2841'
                #banner2
                # ,'PROD_A3229'
                #,
                #uhs2
                # ,'PROD_A3320'
                #,'PROD_A3327'
                #uhs2  
                # ,'PROD_A3367'
                # ,'PROD_A3599'
                # ,'PROD_A3632'
                #uhs
                # ,'PROD_A3667'
                #uhs
                # ,'PROD_A3669'
                #intermountain
                # ,'PROD_A3774'
                # ,'PROD_A3822'
                #uhs
                # ,'PROD_A4585'
                #uhs2
                # ,'PROD_A4709'
                # ,'PROD_A4768'
                # ,'PROD_A4806'
                #   'PROD_MEDSTAR_MDPCP'
                'PROD_ADAUGEOPI'
                , 'PROD_ILUMEDPI'
                # ,  'PROD_CARELINEPI'
                ]

    importantODStables = [
            'cclf_0_summ_stat'
            , 'cclf_1_pt_a_clm_hdr'
            , 'cclf_2_pt_a_clm_rev_ctr_det'
            , 'cclf_3_pt_a_proc_cd'
            , 'cclf_4_pt_a_diag_cd'
            , 'cclf_5_pt_b_phys'
            , 'cclf_6_pt_b_dme'
            , 'cclf_7_pt_d'
            , 'cclf_8_bene_demo'
            , 'cclf_assgn_0_header'
            , 'cclf_assgn_1_hcc'
            , 'cclf_assgn_1_summ'
            , 'cclf_assgn_2_tin'
            , 'cclf_assgn_3_ccn'
            , 'cclf_assgn_4_tin_npi'
            , 'cclf_assgn_5_turnover'
            , 'cclf_assgn_6_assgnbl'
            , 'cclf_a_pt_a_be_demo'
            , 'cclf_benchmark_1_detail'
            , 'cclf_b_pt_b_be_demo'
            , 'cclf_expu_0_header'
            , 'cclf_expu_1_detail'
            , 'cclf_expu_2_regional'
            , 'cclf_expu_2_snf'
            , 'cclf_expu_3_snf'
            , 'cclf_ng_align'
            , 'nh_network_model_0_hdr'
            , 'dce_align'
            , 'dce_palmr'
            # , 'pcf_align_attribd'
            # , 
            # 'mdpcp_assgn_attribd'
            # , 'mdpcp_assgn_termd'
            # , 'mdpcp_bened'
            # , 'mdpcp_bened_month'
            # , 'mdpcp_bened_year'
            # , 'mdpcp_ptaclm'
            # , 'mdpcp_ptadgn'
            # , 'mdpcp_ptaprc'
            # , 'mdpcp_ptarev'
            # , 'mdpcp_ptbdme'
            # , 'mdpcp_ptbphy'
            # , 'mdpcp_ptd'
            # , 'mdpcp_stat'
    ]

    importantTables = [
        'tin' 
        , 'facility'
        , 'provider'
        , 'patient'
        , 'activity'
        , 'visit'
        , 'inpatient_stay'
        , 'aco_x_patient_month'
        , 'patient_x_month'
        , 'patient_x_medicare_month'
        , 'patient_x_chronic_condition_month'
        , 'patient_x_risk_score_month'
        , 'metric_value_operational_dashboard'
        , 'profile_list_patient'
        , 'metric_value_patient_x_claim'
        , 'metric_value_qexpu'
        , 'hcc_x_patient_year'
        , 'hcc_x_patient_undercoded_layup'
    ]

    # creating a manual dictionary for now, in furture use pprint output
    tablePKDict = {'tin': ['pk_tin_id'],
                    'facility': ['pk_facility_id'],
                    'provider': ['pk_provider_id'],
                    'patient': ['pk_patient_id'],
                    'activity': ['pk_activity_id'],
                    'visit': ['pk_visit_id'],
                    'inpatient_stay': ['pk_ip_stay_id'],
                    'aco_x_patient_month': ['attribution_reason_cd',
                                            'attribution_source_cd',
                                            'fk_aco_id', 
                                            'fk_patient_id', 
                                            'month_cd'],
                    'patient_x_month': ['attribution_type',
                                        'fk_patient_id',
                                        'month_cd'],
                    'patient_x_medicare_month': ['fk_patient_id', 'month_cd'],
                    'patient_x_chronic_condition_month': ['chronic_condition_source_cd',
                                                           'fk_patient_id',
                                                           'measure_id',
                                                           'month_cd'],
                    'patient_x_risk_score_month': ['fk_patient_id',
                                                    'month_cd',
                                                    'risk_score_cd',
                                                    'risk_score_source_cd'],
                    'metric_value_operational_dashboard': ['attribution_type'
                                                            ,'measure_cd'
                                                            ,'org_group_id'
                                                            ,'org_id'
                                                            ,'org_level_category_cd'
                                                            ,'patient_medicare_group_cd'
                                                            ,'period_id'],
                    'profile_list_patient': ['attribution_type'
                                            ,'month_cd'
                                            ,'patient_id'
                                            ,'period_type'],
                    'metric_value_patient_x_claim': ['attribution_type'
                                                    ,'claim_id'
                                                    ,'fk_patient_id'
                                                    ,'month_cd'
                                                    ,'org_id'
                                                    ,'qexpu_subheader_cd'],
                    'metric_value_qexpu': ['attribution_type'
                                            , 'fk_patient_id'
                                            , 'month_cd'
                                            , 'qexpu_header_cd'],
                    'hcc_x_patient_year': ['pk_hcc_patient_year_id'],
                    'hcc_x_patient_undercoded_layup': ['dos_year'
                                                        , 'hcc'
                                                        , 'hcpcs_ra_flag'
                                                        , 'org_id' ]
                    }

    odsTblPKfieldDict = {'cclf_0_summ_stat': 'pk_cclf_stat_id',
                        'cclf_1_pt_a_clm_hdr': 'pk_pt_a_hdr_id',
                        'cclf_2_pt_a_clm_rev_ctr_det': 'pk_pt_a_rev_ctr_det_id',
                        'cclf_3_pt_a_proc_cd': 'pk_pt_a_proc_id',
                        'cclf_4_pt_a_diag_cd': 'pk_pt_a_diag_cd',
                        'cclf_5_pt_b_phys': 'pk_pt_b_phys_id',
                        'cclf_6_pt_b_dme': 'pk_pt_b_dme_id',
                        'cclf_7_pt_d': 'pk_pt_d_id',
                        'cclf_8_bene_demo': 'pk_bene_id'
                        }

    odsTblCompositePKDict = {'cclf_0_summ_stat': ['eff_start_dt', 'load_run_id', 'pk_cclf_stat_id'],
                            'cclf_1_pt_a_clm_hdr': ['eff_start_dt', 'load_run_id', 'pk_pt_a_hdr_id'],
                            'cclf_2_pt_a_clm_rev_ctr_det': ['eff_start_dt',
                                                            'load_run_id',
                                                            'pk_pt_a_rev_ctr_det_id'],
                            'cclf_3_pt_a_proc_cd': ['eff_start_dt', 'load_run_id', 'pk_pt_a_proc_id'],
                            'cclf_4_pt_a_diag_cd': ['eff_start_dt', 'load_run_id', 'pk_pt_a_diag_id'],
                            'cclf_5_pt_b_phys': ['eff_start_dt', 'load_run_id', 'pk_pt_b_phys_id'],
                            'cclf_6_pt_b_dme': ['eff_start_dt', 'load_run_id', 'pk_pt_b_dme_id'],
                            'cclf_7_pt_d': ['eff_start_dt', 'load_run_id', 'pk_pt_d_id'],
                            'cclf_8_bene_demo': ['eff_start_dt',
                                                'load_run_id',
                                                'pk_bene_id',
                                                'src_bene_rng_bgn_dt'],
                            'cclf_a_pt_a_be_demo': ['eff_start_dt', 'load_run_id', 'pk_pt_a_be_demo_id'],
                            'cclf_assgn_0_header': ['eff_start_dt', 'load_run_id', 'pk_assgn_hdr_id'],
                            'cclf_assgn_1_hcc': ['eff_start_dt', 'load_run_id', 'pk_assgn_hcc_id'],
                            'cclf_assgn_1_summ': ['eff_start_dt', 'load_run_id', 'pk_assgn_summ_id'],
                            'cclf_assgn_2_tin': ['eff_start_dt', 'load_run_id', 'pk_assgn_tin_id'],
                            'cclf_assgn_3_ccn': ['eff_start_dt', 'load_run_id', 'pk_assgn_ccn_id'],
                            'cclf_assgn_4_tin_npi': ['eff_start_dt', 'load_run_id', 'pk_assgn_tin_npi_id'],
                            'cclf_assgn_5_turnover': ['eff_start_dt',
                                                    'load_run_id',
                                                    'pk_assgn_turnover_id'],
                            'cclf_assgn_6_assgnbl': ['eff_start_dt', 'load_run_id', 'pk_assgn_assgnbl_id'],
                            'cclf_b_pt_b_be_demo': ['eff_start_dt', 'load_run_id', 'pk_pt_b_be_demo_id'],
                            'cclf_benchmark_1_detail': ['eff_start_dt',
                                                        'load_run_id',
                                                        'pk_benchmark_1_id'],
                            'cclf_expu_0_header': ['eff_start_dt', 'load_run_id', 'pk_expu_hdr_id'],
                            'cclf_expu_1_detail': ['eff_start_dt', 'load_run_id', 'pk_expu_detail_id'],
                            'cclf_expu_2_regional': ['load_run_id', 'pk_expu_regional_id'],
                            'cclf_expu_2_snf': ['eff_start_dt', 'load_run_id', 'pk_expu_snf_id'],
                            'cclf_expu_3_snf': ['load_run_id', 'pk_expu_snf_id'],
                            'cclf_ng_align': ['eff_start_dt', 'load_run_id', 'pk_ng_align_id'],
                            'nh_network_model_0_hdr': ['eff_start_dt', 'load_run_id', 'pk_net_mdl_hdr_id']
                            ,'dce_align': ['load_run_id', 'pk_dce_align_id']
                            ,'dce_palmr': ['load_run_id', 'pk_dce_palmr_id']
                            # ,
                            # 'pcf_align_attribd': ['load_run_id', 'pk_pcf_align_attribd_id']
                            }

    # def test2(tableDict):
    def test1():
        print('running test1. prod insights row counts..')
        table_results = []
        # sqlString = '''SELECT '{table}' AS TableName
        #                 , '{orgDB}' AS ordDBName
        #                 , max(date(load_ts)) AS MaxLoadTS
        #                 , max(load_period) AS MaxLP
        #                 , count(*) AS rwCount
        #             FROM {orgDB}.INSIGHTS.{table}'''.format(table='aco_x_patient_month',orgDB=orgDB)
        # sf_cursor.execute(sqlString)
        # results = sf_cursor.fetchall()        
        # table_results.append([results[0][0], results[0][1], results[0][2], results[0][3], results[0][4]])
        # print(tabulate(table_results, headers=["tableName", "orgDBName", "MaxLoadTS", "MaxLP", "rwCount"], tablefmt='psql'))
        # df = pd.DataFrame(table_results, columns=["tableName", "orgDBName", "MaxLoadTS", "MaxLP", "rwCount"])
        for table in importantTables:
            sqlString = '''SELECT '{table}' AS TableName
                            , '{orgDB}' AS ordDBName
                            , max(date(load_ts)) AS MaxLoadTS
                            , max(load_period) AS MaxLP
                            , count(*) AS rwCount
                        FROM {orgDB}.INSIGHTS.{table}'''.format(table=table,orgDB=orgDB)
            sf_cursor.execute(sqlString)
            results = sf_cursor.fetchall()
            # df3 = sf_cursor.fetch_pandas_all() # overwrites each time. need to append to a list like above
            # print(df3)
            # df4 += df3
            table_results.append([results[0][0], results[0][1], results[0][2], results[0][3], results[0][4]])

        # print(tabulate(table_results, headers=["tableName", "orgDBName", "MaxLoadTS", "MaxLP", "rwCount"], tablefmt='psql'))
        df = pd.DataFrame(table_results, columns=["tableName", "orgDBName", "MaxLoadTS", "MaxLP", "rwCount"])

        return df

    def test2():
        print('running test2..insights comparison row counts..')
        table_results = []
        for table in importantTables:
            sqlString = '''SELECT '{table}' AS TableName
                            , '{orgDB}' AS ordDBName
                            , max(date(load_ts)) AS MaxLoadTS
                            , max(load_period) AS MaxLP                            
                            , count(*) AS rwCount
                        FROM {orgDB}.INSIGHTS.{table}'''.format(table=table,orgDB=orgDBCompare)
            sf_cursor.execute(sqlString)
            results = sf_cursor.fetchall()
            # df3 = sf_cursor.fetch_pandas_all() # overwrites each time. need to append to a list like above
            # print(df3)
            # df4 += df3
            table_results.append([results[0][0], results[0][1], results[0][2], results[0][3], results[0][4]])

        df2 = pd.DataFrame(table_results, columns=["tableName", "orgDBName", "MaxLoadTS", "MaxLP", "rwCount"])
        # df3['MaxLoadTS'] = df3['MaxLoadTS'].dt.date   # hack  Can only use .dt accessor with datetimelike value
        df3 = pd.merge(df_prod, df2, how='left', on='tableName')
        df3['diff'] = df3['rwCount_x'] - df3['rwCount_y'] # does this work?

        return df3


    def dupCheckTest(tableDict):
        print('running insights dup check...')
        table_results = []
        for table, pks in tableDict.items():
            # print(table, ', '.join(tableDict[table]))
            # print(table, ', '.join(pks))
            sqlString = '''WITH dupCTE
                            AS
                            (
                            SELECT '{table}' AS tableName
                                , sum(rowsDuped) AS rowsEffected
                                , count(*) AS pkRowCount
                            FROM
                                (
                                SELECT {compositeKeys}
                                    , count(*) AS rowsDuped 
                                FROM {orgDB}.INSIGHTS.{table}
                                GROUP BY {compositeKeys}
                                HAVING count(*) > 1
                                ) a 
                            ) 
                            SELECT tableName 
                                , '{orgDB}' AS orgDBName
                                , rowsEffected
                                , pkRowCount
                            FROM dupCTE'''.format(table=table,orgDB=orgDB,compositeKeys=', '.join(pks))                            
            # print(sqlString)
            sf_cursor.execute(sqlString)
            results = sf_cursor.fetchall()
            table_results.append([results[0][0], results[0][1], results[0][2], results[0][3]])

        df4 = pd.DataFrame(table_results, columns=["tableName", "orgDBName", "rowsEffected", "pkRowCount"]) 
        return df4

    def test3():
        print('running test3..aco_x_patient_month..predicts patient_x_month dupes..')
        table = importantTables[7]
        sqlString = '''WITH 
                        step1 AS
                        (
                        SELECT attribution_reason_cd,
                                attribution_source_cd,
                                fk_aco_id, 
                                fk_patient_id, 
                                month_cd,
                                count(*) OVER (PARTITION BY attribution_source_cd, fk_aco_id, fk_patient_id, month_cd) AS dupMoCnt
                        FROM {orgDB}.insights.{table}
                        )
                        SELECT *
                        FROM step1
                        WHERE dupMoCnt > 1
                        ORDER BY fk_patient_id,
                                month_cd, 
                                attribution_source_cd,
                                attribution_reason_cd,
                                fk_aco_id'''.format(table=table, orgDB=orgDB)
        sf_cursor.execute(sqlString)
        df5 = sf_cursor.fetch_pandas_all()
        return df5

    def test4():
        print('running test4. prod ods row counts..')
        table_results = []
        for table in importantODStables:
            # for load_period, query below strips out 's-' or 'm-' from monthly loads
            sqlString = '''SELECT '{table}' AS TableName
                            , '{orgDB}' AS ordDBName
                            , max(date(load_ts)) AS MaxLoadTS
                            , max(CASE WHEN LENGTH(load_period) = 9 THEN substring(load_period,3,7) ELSE load_period end) AS MaxLP
                            , count(*) AS rwCount
                        FROM {orgDB}.ODS.{table}'''.format(table=table,orgDB=orgDB)
            sf_cursor.execute(sqlString)
            results = sf_cursor.fetchall()
            table_results.append([results[0][0], results[0][1], results[0][2], results[0][3], results[0][4]])        
        df6 = pd.DataFrame(table_results, columns=["tableName", "orgDBName", "MaxLoadTS", "MaxLP", "rwCount"])
        return df6

    def test5():
        print('running test5. prod to fe ods row count compare..')
        table_results = []
        for table in importantODStables:
            # for load_period, query below strips out 's-' or 'm-' from monthly loads
            sqlString = '''SELECT '{table}' AS TableName
                            , '{orgDB}' AS ordDBName
                            , max(date(load_ts)) AS MaxLoadTS
                            , max(CASE WHEN LENGTH(load_period) = 9 THEN substring(load_period,3,7) ELSE load_period end) AS MaxLP
                            , count(*) AS rwCount
                        FROM {orgDB}.ODS.{table}'''.format(table=table,orgDB=orgDBCompare)
            sf_cursor.execute(sqlString)
            results = sf_cursor.fetchall()
            table_results.append([results[0][0], results[0][1], results[0][2], results[0][3], results[0][4]])

        df7 = pd.DataFrame(table_results, columns=["tableName", "orgDBName", "MaxLoadTS", "MaxLP", "rwCount"])
        df8 = pd.merge(df_ods_prod, df7, how='left', on='tableName')
        df8['diff'] = df8['rwCount_x'] - df8['rwCount_y']
        return df8

    def test6():
        print('running test6..prod chronic conditions for latest mo code..')
        table = importantTables[10]
        sqlString = '''WITH ccsPerMo
                        AS 
                        (
                        SELECT measure_id
                            , count(DISTINCT fk_patient_id) AS beneCnt
                            , count(*) AS rwCnt
                        FROM {orgDB}.insights.{table}
                        WHERE chronic_condition_source_cd = 'ccw'  
                        group BY measure_id 
                        ORDER BY measure_id 
                        )
                        SELECT measure_id
                            , rwCnt
                        FROM ccsPerMo
                        ORDER BY measure_id'''.format(orgDB=orgDB, table=table)
        sf_cursor.execute(sqlString)
        df10 = sf_cursor.fetch_pandas_all()
        return df10

    def test7():
        print('running test7..prod fe chronic conditions for latest mo code..')
        table = importantTables[10]
        sqlString = '''WITH ccsPerMo
                        AS 
                        (
                        SELECT measure_id
                            , count(DISTINCT fk_patient_id) AS beneCnt
                            , count(*) AS rwCnt 
                        FROM {orgDB}.insights.{table}
                        WHERE chronic_condition_source_cd = 'ccw'  
                        group BY measure_id 
                        ORDER BY measure_id 
                        )
                        SELECT measure_id
                            , rwCnt
                        FROM ccsPerMo
                        ORDER BY measure_id'''.format(orgDB=orgDBCompare, table=table)
        sf_cursor.execute(sqlString)
        df11 = sf_cursor.fetch_pandas_all()

        # capitalization has to be exact
        df12 =  pd.merge(df_ccs_prod, df11, how='left', on='MEASURE_ID')
        df12['diff'] = df12['RWCNT_x'] - df12['RWCNT_y']

        return df12

    def dupCheckODStest(odsTableDict):
        print('running ODS dup check...')
        table_results = []
        for table, pks in odsTableDict.items():
            # print(table, ', '.join(tableDict[table]))
            # print(table, ', '.join(pks))
            sqlString = '''WITH dupCTE
                            AS
                            (
                            SELECT '{table}' AS tableName
                                , sum(rowsDuped) AS rowsEffected
                                , count(*) AS pkRowCount
                            FROM
                                (
                                SELECT {compositeKeys}
                                    , count(*) AS rowsDuped 
                                FROM {orgDB}.ODS.{table}
                                WHERE RECORD_status_CD = 'a'
                                GROUP BY {compositeKeys}
                                HAVING count(*) > 1
                                ) a 
                            ) 
                            SELECT tableName 
                                , '{orgDB}' AS orgDBName
                                , rowsEffected
                                , pkRowCount
                            FROM dupCTE'''.format(table=table,orgDB=orgDB,compositeKeys=', '.join(pks))                            
            # print(sqlString)
            sf_cursor.execute(sqlString)
            results = sf_cursor.fetchall()
            table_results.append([results[0][0], results[0][1], results[0][2], results[0][3]])

        df13 = pd.DataFrame(table_results, columns=["tableName", "orgDBName", "rowsEffected", "pkRowCount"]) 

        return df13   



    orgCount = 1
    all_test_results = {}

    output_file_path = '/home/ec2-user/pythonWrk/allTest_DCE_Orgs_11.xlsx'

    for org_db in orgDBList:
        orgDB = org_db
        orgDBCompare = orgDB + '_FE'
        orgDBCompare2 = '''SNAPSHOT_{orgDB}_20211019'''.format(orgDB = orgDB)
        # if they're not swapping ods to fe, the compare db for ods is like: SNAPSHOT_PROD_A1052_20210929

        print('org count: ' + str(orgCount))

        # all_test_results = {}
        # output_file_path = '/home/ec2-user/pythonWrk/allTest_{orgDB}.xlsx'.format(orgDB=orgDB.lower())

        df_prod = test1()   # calling the fxn
        df_merge = test2()
        df_dups = dupCheckTest(tablePKDict)
        df_aco_x = test3()
        df_ods_prod = test4()
        df_ods_merge = test5()
        df_ccs_prod = test6()
        df_ccs_merge = test7()
        df_ods_dups = dupCheckODStest(odsTblCompositePKDict)

        all_test_results['insCountMax {orgDB}'.format(orgDB=orgDB.lower())] = df_prod # we don't need this in the excel file
        all_test_results['insCountMaxC {orgDB}'.format(orgDB=orgDB.lower())] = df_merge
        all_test_results['dupInsCheck {orgDB}'.format(orgDB=orgDB.lower())] = df_dups
        all_test_results['acoXdupMonth {orgDB}'.format(orgDB=orgDB.lower())] = df_aco_x
        all_test_results['odsCountMax {orgDB}'.format(orgDB=orgDB.lower())] = df_ods_prod # we don't need this in the excel file
        all_test_results['odsCountMaxC {orgDB}'.format(orgDB=orgDB.lower())] = df_ods_merge 
        all_test_results['ccsCompare {orgDB}'.format(orgDB=orgDB.lower())] = df_ccs_merge
        all_test_results['dupODSchk {orgDB}'.format(orgDB=orgDB.lower())] = df_ods_dups

        orgCount += 1
    

    writer = pd.ExcelWriter(output_file_path, engine='xlsxwriter') # pylint: disable=abstract-class-instantiated

    for sheet_name, df in all_test_results.items():
        df.to_excel(writer, sheet_name=sheet_name, index=False)
    writer.save()

except Exception as e:
    print(e)

finally:
    try:
        sf_cursor.close()
    except:
        pass
    try:
        ctx.close()
    except:
        pass    