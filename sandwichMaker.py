import pyinputplus as pyip

sandwchBreadResp = pyip.inputMenu(['white', 'wheat', 'sourdough'], numbered=True)

print("response is " +  str(sandwchBreadResp))

# if have an array of dictionaries (key, value) what's the best way to index
# into it to get prices?  
# print out a formatted list of ordered items with a total.

# array for-loop. for item in arrayName: 