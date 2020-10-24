# read in the mbr mo grp by xlsx, open another wb, 
import openpyxl

wb = openpyxl.load_workbook('/Users/michael.oconnor/Downloads/mbrMosGrpbyFormat_2.xlsx')
sheet = wb['Sheet1']

wb2 = openpyxl.Workbook()
sheet2 = wb2.active

orgData = {}
yearMoData = {}
orgYrMoStruct = {}


# 'MD': {'Allegany': {'pop': 75087, 'tracts': 23},
#         'Anne Arundel': {'pop': 537656, 'tracts': 104},
#         'Baltimore': {'pop': 805029, 'tracts': 214},
#         'Baltimore City': {'pop': 620961, 'tracts': 200},


# read the rows and populate a dict, to get a distict list of orgs
for rowNum in range(2, sheet.max_row + 1):
    # alternative
    # org = sheet.cell(row=rowNum, column=1).value
    org = sheet['A' + str(rowNum)].value
    yrMo = sheet['B' + str(rowNum)].value
    pmpy = sheet['C' + str(rowNum)].value

    orgData.setdefault(org, {})  # how else can you create 
                                # distinct lists?
    yearMoData.setdefault(yrMo, {})

    orgYrMoStruct.setdefault(org, {})
    orgYrMoStruct[org].setdefault(yrMo, {'pmpyNo': 0})

    orgYrMoStruct[org][yrMo]['pmpyNo'] += pmpy

orgDictKeyList = orgData.keys()
orgList = list(orgDictKeyList)

yrMoDictKeyList = yearMoData.keys()
yrMoList = sorted(list(yrMoDictKeyList))
# sorted year Mo list - how?
# for idx, val in enumerate(yrMoList):  # idx starts w/ 0
#     print(idx)
#     print(val)

# print('Done..')

# iterate through orgYrMoStruct, double for-loop?, need the key
# can I get an imperfect Excel cross tab?
# for orgItem in orgYrMoStruct:  # just returns an org string
#     for orgs in orgItem.keys():  # so there are no keys()
#         print(org)

# for orgKey in orgYrMoStruct:
#     o = orgKey
#     oVal = orgYrMoStruct[orgKey]

 # https://realpython.com/iterate-through-dictionary-python/
 # try a membership test using yrMoList's values against a
 # org's yearMonth
 # does yrMoList support enumerate so I can get the index too? using it for xlsx column  
    #  yes, starts w/ 0 
# need python 3 for this? 3.7 installed and set as interpreter.  now program can't find openpyxl
# sorted_income = {k: incomes[k] for k in sorted(incomes)}
sorted_orgYrMoStruct = {k: orgYrMoStruct[k] for k in sorted(orgYrMoStruct)}

# header 
    # create a number of dims var for the cell column parameter?
    # if I'm going to have org | orgName:
    # listOfStrings = 'A2024 | DVACO'.split('|')
    # listOfStrings = [item.strip() for item in listOfStrings]   
rwInx = 1
rwLabel1 = sheet.cell(row=rwInx, column=1).value  #org_id
sheet2.cell(row=rwInx, column=1).value = rwLabel1

for colInx, month in enumerate(yrMoList):
    sheet2.cell(row=rwInx, column=colInx + 2).value = month

rwInx += 1
for key, value in sorted_orgYrMoStruct.items():
# for key, value in orgYrMoStruct.items():
    print(key)
    print(value)
    print(str(rwInx))
    sheet2.cell(row = rwInx, column = 1).value = key
    # sorted year Mo list - how?  see above sorted
    for colInx, month in enumerate(yrMoList):
        if month in orgYrMoStruct[key].keys():
            print(str(orgYrMoStruct[key][month]['pmpyNo']))
            print(str(colInx + 2))   # could add an else and print 0
            sheet2.cell(row = rwInx, column = colInx + 2).value = orgYrMoStruct[key][month]['pmpyNo']
    rwInx += 1

# save the new wb
wb2.save('/Users/michael.oconnor/mbrMoPvt_2.xlsx')