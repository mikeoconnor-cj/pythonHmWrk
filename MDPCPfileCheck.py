import pandas as pd
import os
import time
# UPDATE FILE PATHS
all_paths = [
    "Downloads/mdpcp_checks/folder_1"
    "Downloads/mdpcp_checks/folder_2"
    "Downloads/mdpcp_checks/folder_3"
    "Downloads/mdpcp_checks/folder_4"
]
export_info = {}
for file_path in all_paths:
    folder_name = file_path.split("/")[-1]
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
writer = pd.ExcelWriter("Downloads/mdpcp_checks/file_name_checks_{}".format(date), engine='xlsxwriter')
for sheet_name, table in export_info.items():
    table.to_excel(writer, sheet_name=sheet_name)
writer.save()