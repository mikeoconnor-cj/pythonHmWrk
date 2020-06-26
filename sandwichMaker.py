import pyinputplus as pyip

sandwichItemKeyList = [] # instantiate a list to append keys to
total = 0.0

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

sandwchBreadResp = pyip.inputMenu(['white', 'wheat', 'sourdough'], numbered=True)
sandwchBreadKey = 'bread|' + sandwchBreadResp

sandwichItemKeyList.append(sandwchBreadKey)
total += sandwichDict[sandwchBreadKey]

# print("response is " +  str(sandwchBreadResp) + ', and key to use later is: ' + sandwchBreadKey)

# if have an array of dictionaries (key, value) what's the best way to index
# into it to get prices?  
# print out a formatted list of ordered items with a total.

# array for-loop. for item in arrayName: 

proteinResp = pyip.inputMenu(['chicken', 'turkey', 'ham', 'tofu'], numbered=True)
proteinKey = 'protein|' + proteinResp
total += sandwichDict[proteinKey]

# print("response is " +  str(proteinResp) + ', and key to use later is: ' + proteinKey)

sandwichItemKeyList.append(proteinKey)

cheeseYN = pyip.inputYesNo(prompt="Would you like cheese? yes/y, no/n: ",caseSensitive=True)

if cheeseYN == "yes":
    cheeseResp = pyip.inputMenu(['cheddar', 'Swiss', 'mozzarella'], numbered=True)
    cheeseKey = 'cheese|' + cheeseResp
    # print("response is " +  str(cheeseResp) + ', and key to use later is: ' + cheeseKey)
    sandwichItemKeyList.append(cheeseKey)
    total += sandwichDict[cheeseKey]

condimentYN = pyip.inputYesNo(prompt="Would you like a topping/condiment? yes/y, no/n: ",caseSensitive=True)

if condimentYN == "yes":
    condimentResp = pyip.inputMenu(['mayo', 'mustard', 'lettuce', 'tomato'], numbered=True)
    condimentKey = 'condiment|' + condimentResp
    sandwichItemKeyList.append(condimentKey)
    total += sandwichDict[condimentKey]

# while loop end here
# loopCount += 1
# if loopCount == 1 ask the question
nbrSandwichResp = pyip.inputInt(prompt="How many sandwiches do you want: ", min=1)

# if loopCount == respSandwichNbr BREAK else CONTINUE
    # does nbrSandwichResp defined in the if have scope outside of it?
        # otherwise, set a global to the response
        # could also just forget the looping and multipy total or sndItems and total



if len(sandwichItemKeyList) > 0:
    print('Your sandwich item orders are:')
    #  print headers for items and pricews

for sndItem in sandwichItemKeyList:
    sndItemType, pipe, item = sndItem.partition('|')
    # print(sndItem)  # remove the \n  and split on the pipe
    print(sndItemType, end='\t') # remove the \n 
    print(item, end='\t')
    print(sandwichDict[sndItem])
# total won't line up with item values
# use rjust and ljust later
print('The total is: ' + str(total))
