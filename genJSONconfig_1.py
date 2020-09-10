from openpyxl import load_workbook
import pandas as pd
from openpyxl.utils.dataframe import dataframe_to_rows

wb = load_workbook('D:/Users/michael.oconnor/q2/attribRptsUnzipd/T1MD0261_BeneAttrRpt_CY2020_Q2_20200430.xlsx')
ws = wb["Attributed Beneficiaries"]
jsonString = ''


df = pd.read_excel('D:/Users/michael.oconnor/q2/attribRptsUnzipd/T1MD0261_BeneAttrRpt_CY2020_Q2_20200430.xlsx', sheet_name="Attributed Beneficiaries", skiprows=8)

print(str(len(df["Last Name"])))

rows = dataframe_to_rows(df, index=False)

for r_idx, row in enumerate(rows, 1):
    for c_idx, col in enumerate(row, 1):
        # print(df.iloc[r_idx-1,c_idx-1])
        # print(col) 
        jsonString += "{" + "\n" + "\t" + '"' + "name" + '"' + ": " + '"' + col + '"' + "," + "\n" # + "}" + "\n"
        jsonString += "\t" + '"' + "sequence" + '"' + ": " + str(c_idx) + "," + "\n"  + "}" + "\n"
        # colDtyp = df[col].dtypes 
        # print(colDtyp)  # the only non object (string) is Risk Score: float64

    if r_idx >= 1:
        break

# print("end of header data")
print(jsonString)
# mySeries = df.dtypes
 # above returns all objects (which represents strings) excepts for Risk Score which is float64
 # gives a warning about deprecation
# print(mySeries)