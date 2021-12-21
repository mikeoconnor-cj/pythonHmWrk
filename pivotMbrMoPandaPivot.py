#! python3
# pivotMbrMoPandaPivot.py  --uses snowflake connector, panda dataframes and panda pivoting
from time import time_ns
import snowflake.connector as sf
import pandas as pd
import numpy as np
from openpyxl import load_workbook
import openpyxl
from tabulate import tabulate
import pprint


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


    sf_cursor = ctx.cursor()


    orgDBList = [
                'PROD_A1052'
                ,'PROD_A2024'
                ,'PROD_A2251'
                ,'PROD_A2575'
                ,'PROD_A2841'
                ,'PROD_A3229'
                ,'PROD_A3320'
                ,'PROD_A3327'
                ,'PROD_A3367'
                ,'PROD_A3599'
                ,'PROD_A3632'
                ,'PROD_A3667'
                ,'PROD_A3669'
                ,'PROD_A3774'
                ,'PROD_A3822'
                ,'PROD_A4585'
                ,'PROD_A4709'
                ,'PROD_A4768'
                ,'PROD_A4806'
                #   'PROD_MEDSTAR_MDPCP'
                # 'PROD_ADAUGEOPI'
                # ,'PROD_ILUMEDPI'
                # ,'PROD_CARELINEPI'
                ]


    # group practice level .. especially used for MDPCP
    def createXLpivotWithPandaPivot():
        sqlString = '''Select ORG_GROUP_ID  	
                    , period_id	
                    , measure_value_decimal AS totlForGroup	
                from {orgDB}.insights.metric_value_operational_dashboard	
                where measure_cd = 'total_member_years_current_month'	
                    and patient_medicare_group_cd = '#NA' 
                    and org_level_category_cd = 'at_time_tin'
                    and attribution_type = 'as_was'
                    and substr(period_id,3,7) >= '2019-01' 
                order by ORG_GROUP_ID 
                    ,  period_id     
                    '''.format(orgDB = orgDB)       
        # execute sql using cursor
        sf_cursor.execute(sqlString)
        df = sf_cursor.fetch_pandas_all()

        # print(df.head())
        # print(df.columns)

        pivot = np.round(pd.pivot_table(df, values='TOTLFORGROUP',
                                            index='ORG_GROUP_ID',
                                            columns='PERIOD_ID',
                                            aggfunc=np.sum),2)

        pivot.to_excel('/home/ec2-user/pythonWrk/mbrMoPvt_72.xlsx')


    def createXLpivotWithPandaPivotsOrgLvl():
        table_results = []
        for orgDB in orgDBList:
            sqlString = '''Select org_id  	
                    , period_id	
                    , measure_value_decimal AS totlForGroup	
                from {orgDB}.insights.metric_value_operational_dashboard	
                where measure_cd = 'total_member_years_current_month'	
                    and patient_medicare_group_cd = '#NA' 
                    and org_level_category_cd = 'aco'
                    and attribution_type = 'as_was'
                    and substr(period_id,3,7) >= '2019-01' 
                order by ORG_GROUP_ID 
                    ,  period_id     
                    '''.format(orgDB = orgDB)
            sf_cursor.execute(sqlString)
            results = sf_cursor.fetchall()
            # print(results)  # this is an array of tuples  
            # table_results.append(results) # results have to be parsed or there'll be a problem at Dataframe creation
            for idx in range(len(results)):
                table_results.append([results[idx][0], results[idx][1], results[idx][2]])

        df = pd.DataFrame(table_results, columns=["org_id", "period_id", "totlForGroup"])

    #   try casting the pivot totalForGroup col to int before saving to 
    #   xlsx..  it's saving in excel string decimal format     
        df['totlForGroup'] = df['totlForGroup'].astype(int)   

        pivot = np.round(pd.pivot_table(df, values='totlForGroup',
                                            index='org_id',
                                            columns='period_id',
                                            aggfunc=np.sum),2)

                  

        pivot.to_excel('/home/ec2-user/pythonWrk/mbrMoPvt_76.xlsx')

    def createXLpivotWithPandaPivotsOrgLvlPMPY():
        table_results = []
        for orgDB in orgDBList:
            sqlString = '''Select org_id  	
                    , period_id	
                    , measure_value_decimal AS totlForGroup	
                from {orgDB}.insights.metric_value_operational_dashboard	
                where measure_cd = 'total_pmpy_current_month'	
                    and patient_medicare_group_cd = '#NA' 
                    and org_level_category_cd = 'aco'
                    and attribution_type = 'as_was'
                    and substr(period_id,3,7) >= '2019-01' 
                order by ORG_GROUP_ID 
                    ,  period_id     
                    '''.format(orgDB = orgDB)
            sf_cursor.execute(sqlString)
            results = sf_cursor.fetchall()
            # print(results)  # this is an array of tuples  
            # table_results.append(results) # results have to be parsed or there'll be a problem at Dataframe creation
            for idx in range(len(results)):
                table_results.append([results[idx][0], results[idx][1], results[idx][2]])

        df = pd.DataFrame(table_results, columns=["org_id", "period_id", "totlForGroup"])
  
        df['totlForGroup'] = df['totlForGroup'].astype(float)   

        pivot = np.round(pd.pivot_table(df, values='totlForGroup',
                                            index='org_id',
                                            columns='period_id',
                                            aggfunc=np.sum),2)

                  

        pivot.to_excel('/home/ec2-user/pythonWrk/mbrMoPvt_75.xlsx')            

# after the fxn defs
    orgDB = orgDBList[0] # when limitinig the list to just one like MDPCP

    # createXLpivotWithPandaPivot()

    createXLpivotWithPandaPivotsOrgLvl()

    # createXLpivotWithPandaPivotsOrgLvlPMPY()



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