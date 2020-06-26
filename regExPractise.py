import re


mdpcpPracticeIDclaims = ['T1MD0316_ClaimsData_PY2020_Q1_20200130_V01.zip'
                        ,'T1MD0365_ClaimsData_PY2020_Q1_20200130_V01.zip'
                        ,'T1MD0368_ClaimsData_PY2020_Q1_20200130_V03.zip'
                        ,'T1MD0369_ClaimsData_PY2020_Q1_20200130_V01.zip'
                        ,'T1MD1003_ClaimsData_PY2020_Q1_20200130_V01.zip'
                        ,'T1MD1004_ClaimsData_PY2020_Q1_20200130_V01.zip']



# mdpcpPractRegEx = re.compile(r'T^[a-zA-Z0-9]{8,9}')  # doesn't work
mdpcpPractRegEx = re.compile(r'^T[a-zA-Z0-9]{7,8}') # T something     works.. my range{} is better fixed the problem
# mdpcpPractRegEx = re.compile(r'^[T1][a-zA-Z0-9]{6,7}')  # works
# mdpcpPractRegEx = re.compile(r'[a-zA-Z0-9]{8,9}')  # works

for item in mdpcpPracticeIDclaims:
    practMO = mdpcpPractRegEx.search(item)
    print(practMO.group())                        

# for i in range(len(mdpcpPracticeIDclaims)):
#     print(str(i) + ' ' + mdpcpPracticeIDclaims[i])

# Python 3.7.1 (default, Nov 28 2018, 11:51:47) 
# index into an array of tuples of phone number 'groups'. What's with index [0]? 
    # it's just how regEx.findAll() loads tuples (created whenever groups are used in re.compile)
arrayOfTuplesOfPhonenbrParts = [('317','212','5123')
                                , ('123','321','5542')
                                , ('332','009','0001')
                                ,('122','221','5545')]

for grps in arrayOfTuplesOfPhonenbrParts:
    print(grps)
    print(grps[0])


fileDictionary = [{'fileName': 'cclf_1_pt_a_clm_hdr_a1052'
                , 'orgId': 'a1052'
                , 'fileSize': '20GB'
                , 'fileDate': '2020-01-15'
                , 'loadPeriod': 'm-2019-12'}
                , 
                {'fileName': 'cclf_1_pt_a_clm_hdr_a1052'
                , 'orgId': 'a1052'
                , 'fileSize': '15GB'
                , 'fileDate': '2019-12-15'
                , 'loadPeriod': 'm-2019-11'}
                ]

for i in range(len(fileDictionary)):
    print(str(i) )  # + fileDictionary[i])  # can't concat a dict
    for k, v in fileDictionary[i].items():
        print('Key: ' + str(k) + ' Value: ' + v)


# array of dictionary items for sandwichmaker

sandwichPartsAndPrices = [{'category': 'Bread'
                            , 'item': 'white'
                            , 'price': 8.50
                            , 'effective': '2020-01-01'}
                        , {'category': 'Bread'
                            , 'item': 'wheat'
                            , 'price': 9.00
                            , 'effective': '2020-01-01'}
                        , {'category': 'Bread'
                            , 'item': 'sourdough'
                            , 'price': 9.50
                            , 'effective': '2020-01-01'}


]

# how do I just subscript and key into the array of dictionaries?
print(fileDictionary[0]['orgId'])

# make a simpler key value sandwich dictionary and iterate through it. 

sandwichDict = {'bread|white': 8.50
                , 'bread|wheat': 9.00
                , 'bread|sourdough': 9.50
                , 'protein|chicken': 5
                , 'protein|turkey': 6
                , 'protein|ham': 6
                , 'protein|tofu': 5
                , 'cheese|cheddar': 1
                , 'cheese|Swiss': 2
                , 'cheese|mozzarella': 1
                , 'condiment|mayo': 1
                , 'condiment|mustard': 1
                , 'condiment|lettuce': 1
                , 'condiment|tomato': .50}


for k, v in sandwichDict.items():
    print('Key: ' + str(k) + ' Value: ' + str(v)) # have to cast v to str

fatArray = ['triglicerides', 'HDL', 'LDL', 'HDL-LDL Ratio', 'Omega 3s', 'Omega 6s', 'insulin', 'glycogen', 'saturated fat', 'sodium', 'potassium', 'vitamin D']

labTestDictionaryArray = [  
                            {'test': 'Cholesterol'
                            , 'testDate': '2020-05-12'
                            , 'testResult': '265 mg/dL'
                            , 'inRange': 'No, 114-210'
                            }
                            , 
                            {'test': 'HDL'
                            , 'testDate': '2020-05-12'
                            , 'testResult': '90 mg/dL'
                            , 'inRange': 'yes, >40 mg/dL'
                            }
                            ,
                            {'test': 'LDL Calc'
                            , 'testDate': '2020-05-12'
                            , 'testResult': '156.6 mg/dL'
                            , 'inRange': 'no, 49.0-125.0'                           
                            }
                            ,
                            {'test': 'Non-HDL Cholesterol'
                            , 'testDate': '2020-05-12'
                            , 'testResult': '170 mg/dL'
                            , 'inRange': 'no, <160 mg/dL'                           
                            }
                            ,
                            {'test': 'Triglycerides'
                            , 'testDate': '2020-05-12'
                            , 'testResult': '67 IU'
                            , 'inRange': 'yes, 36-152, went down since Dec ''19'
                            }
                            ,
                             {'test': 'Chol/HDL Ratio'
                            , 'testDate': '2020-05-12'
                            , 'testResult': '3 Ratio'
                            , 'inRange': 'yes, <6 Ratio'
                            }
                            # ,                            
                            # {'test': 'insulin'
                            # , 'testDate': '2020-05-17'
                            # , 'testResult': '90 IU'
                            # , 'inRange': ''
                            # }
                            ,
                            {'test': 'Glucose Bld'
                            , 'testDate': '2020-05-12'
                            , 'testResult': '90 mg/dL'
                            , 'inRange': 'yes'
                            }
                            # ,
                            # {'test': 'vitamin D'
                            # , 'testDate': '2020-05-17'
                            # , 'testResult': '90 IU'
                            # , 'inRange': ''
                            # }
                            ,   
                            {'test': 'Sodium'
                            , 'testDate': '2020-05-12'
                            , 'testResult': '139 mmol/L'
                            , 'inRange': 'yes'
                            }
                            ,   
                            {'test': 'Potassium'
                            , 'testDate': '2020-05-12'
                            , 'testResult': '4.2 mmol/L'
                            , 'inRange': 'yes'
                            }                            
                            ,   
                            {'test': 'Calcium'
                            , 'testDate': '2020-05-12'
                            , 'testResult': '9.3 mg/dL'
                            , 'inRange': 'yes'
                            }             
                        ]


thousFormatRegex = re.compile(r'(^(.*)\d{1,3}(,\d{3})+(.*)$)')
#  try findall bcz above does't match when number is w/in a string \ sentence 
    # is findall better?  how did phoneAndEmail.py find the regex in all the text? 
# thousFormatRegex = re.compile(r'\d{1,3},\d{3}') # | \d{1,3},(\d\d\d)+')                            
# mo = thousFormatRegex.search('look 100,001 here')

# ('the number is 1,000 that we''re trying to find')
# 1,000,000 #found
# 1,000 and 10 and 1 found
# but 1,00  found as 1
# print(mo == None )
# mo.group() == None

mo = thousFormatRegex.search('100,001')

if mo != None:
    print(mo.group())
else: 
    print('mo not created')


for grps in thousFormatRegex.findall('Hello 1,000 world'):
    print(grps)
    print(grps[0])
    # print(grps[1])


nameRegex = re.compile(r'(.*)(([A-Z]{1}[a-z]+) (Wantanabe))(.*)')
mo = nameRegex.search('hello Haruto Wantanabe goodbye')
if mo != None:
    print(mo.group())
    print(mo.groups())
    nameTpl = mo.groups()
    print(nameTpl[0])
else: 
    print('mo not created')

# 1st wrd: Alice, Bob, Carol
# 2nd wrd: eats, pets, throws
# 3rd wrd: apples, cats, baseballs
# sentence ends w/ period
# case in-sensitive

# sentenceRegex = re.compile(r'((Alice | Bob | Carol)\s(eats | pets | throws)\s(apples | cats | baseballs))\.$', re.IGNORECASE)

sentenceRegex = re.compile(r'((Alice|Bob|Carol)\s(eats|pets|throws)\s(apples|cats|baseballs)\.$)', re.IGNORECASE)
mo = sentenceRegex.search('Carol EATS cats.')
if mo != None:
    print(mo.group())
    print(mo.groups())
    sntcTpl = mo.groups()
    # print(sntcTpl[0])
else: 
    print('sntc mo not created')


# weird Swift regex - floor of qualifer range w/ findFirst doesn't seem to work like it does below in Python 
braceQualRegEx = re.compile(r'[a-z]{3}')
mObj = braceQualRegEx.search('cat ca fa')
if mObj != None:
    print(mObj.group())
    print(mObj.groups())
    sntcTpl = mObj.groups()
    # print(sntcTpl[0])
else: 
    print('brace mObj not created')