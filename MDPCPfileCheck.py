import pandas as pd
import os
import time
# from openpyxl import xlsxwriter

# UPDATE FILE PATHS
all_paths = [
    # "Downloads/mdpcp_checks/folder_1"
    # "Downloads/mdpcp_checks/folder_2"
    # "Downloads/mdpcp_checks/folder_3"
    # "Downloads/mdpcp_checks/folder_4"
    "D:\Users\\michael.oconnor\\q2\\attribRptsUnzipd"
]
export_info = {}
for file_path in all_paths:
    folder_name = file_path.split("\\")[-1]
    files = os.listdir(file_path)
    all_file_names = [fname for fname in files]
    df = pd.DataFrame(all_file_names, columns=["file_name"])
    file_split_df = df['file_name'].str.split("_", expand=True).rename(columns={0: "practice_id",
                                                                                1: "file_type",
                                                                                2: "calendar_year",
                                                                                3: "quarter",
                                                                                4: "quarter_date"})
    new_df = pd.concat([df, file_split_df], axis=1)
    export_info[folder_name] = new_df
date = time.strftime("%Y%m%d")
# UPDATE OUTPUT PATH
writer = pd.ExcelWriter("D:\Users\\michael.oconnor\\file_name_checksAttrib{}.xlsx".format(date), engine='xlsxwriter')
# Downloads/mdpcp_checks/file_name_checks_
# not sure if above commented pylint line needed in pycharm
for sheet_name, table in export_info.items():
    table.to_excel(writer, sheet_name=sheet_name)
writer.save()
