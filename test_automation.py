import time
import os
import sys
from openpyxl.workbook import Workbook

import pandas as pd
import tabulate

sys.path.insert(0, '/Users/michael.oconnor/core') # to use resources from core repo

from scripts.python.helpers import setup_python_path, setup_target_env
from utils.python.abstracts.db.config import DB_CONFIG_CONSTANTS
from utils.python.libs.query_manager.query_manager import QueryManager

qm_mbr = QueryManager(domain=DB_CONFIG_CONSTANTS.DOMAIN.ENGINEERING,
                                     module=DB_CONFIG_CONSTANTS.MODULE.ETL_EM,
                                     db_type=DB_CONFIG_CONSTANTS.DB_TYPE.PRESTO)


today_str = time.strftime("%Y-%m-%d")
output_path = os.path.expanduser('~/Downloads/test_results_{date}.xlsx'.format(date=today_str))

tables_and_schema = {
      'cclf_1_pt_a_clm_hdr': 'ods',
      'cclf_5_pt_b_phys': 'ods',
       'cclf_7_pt_d': 'ods',
       'profile_list_pcp': 'wkbk2',
       'profile_list_patient': 'wkbk2',
      'visit': 'wkbk2',
      'patient_x_month': 'wkbk2' #,
      #'patient_x_chronic_condition_month': 'wkbk2',
      #'patient_x_unnecessary_care': 'wkbk2',
      #'metric_value': 'wkbk2',
                    }

max_load_period = str(raw_input("max load period (e.g. 2019-10): "))
expected_count = int(raw_input("Expected org count (integer): "))
expected_count_cclf =  expected_count - 1   #A3187 (MedStar) could run wkbk2 tables but not cclfs
expected_count_assgn = expected_count - 2   #eliminate A3187 and the NextGen org V235

# To record progress through tests
count = 0
total_count = len(tables_and_schema)

all_results = []

for table, schema in tables_and_schema.items():
    count += 1
    print("Running ({count}/{total_count}): {schema} {table}".format(count=count,
                                                                     total_count=total_count,
                                                                     schema=schema,
                                                                     table=table))
    sql_statement = """
                WITH wkbk2_test AS 
                (
                    SELECT
                        p.org_id
                        , o.name AS orgname
                        , o.active_flag
                        , MAX(substr(load_period, 3, 7)) AS maxload_period 
                    FROM
                        {schema}.{table} p 
                    LEFT JOIN
                        meta.org o 
                        ON p.org_id = o.org_id 
                    GROUP BY p.org_id, o.name, o.active_flag
                )

                SELECT
                    '{schema}' AS schema
                    , '{table}' AS table_name
                    , CASE
                         WHEN '{schema}' = 'wkbk2' THEN {expected_count}
                         WHEN '{schema}' = 'ods' THEN {expected_count_cclf}
                      END AS expected_org_count
                    , COUNT(*) AS observed_org_count
                    , '{max_load_period}' as max_load_period
                    , CASE
                        WHEN '{schema}' = 'wkbk2' AND COUNT(*) = {expected_count} 
                                        THEN
                                            'Pass'
                        WHEN '{schema}' = 'ods' AND COUNT(*) = {expected_count_cclf}
                                        THEN 'Pass'
                        ELSE
                            'Fail' 
                        END
                            AS test_result 
                FROM
                    wkbk2_test 
                WHERE
                    maxload_period = '{max_load_period}'
                    """.format(schema=schema,
                               table=table,
                               expected_count=expected_count,
                               expected_count_cclf=expected_count_cclf,
                               max_load_period=max_load_period)
    print(sql_statement)

    test_results = qm_mbr.run(sql_statement, return_as_array=True, record_as_dict=True)
    all_results.extend(test_results)

all_results_df = pd.DataFrame(all_results)

# Export results
all_results_df.to_excel(output_path)

print("Results were saved here: {output_path}".format(output_path=output_path))

print(tabulate.tabulate(all_results_df, headers='keys'))

