#! python3
# idUnzipErrors.py - tries to unzip files in specified path and catches errors
import os
import zipfile
from pathlib import Path

# UPDATE FILE PATHS
all_paths = [
    # "Downloads/mdpcp_checks/folder_1"
    "D:\\Users\\michael.oconnor\\q4\\NewFullZip\\samples"
]

files = []

for file_path in all_paths:
    files = os.listdir(file_path)
    for fname in files:
        winFilePath = Path(file_path) / fname
        try:
            exampleZip = zipfile.ZipFile(winFilePath)
            # don't have to actually extract... the error gets thown at the above line.  
            # exampleZip.extractall('D:\\Users\\michael.oconnor\\q4\\NewFullZip\\extractedsamples')
            exampleZip.close()
        except:
            # not sure how to specifically trap the BadZipFile error
            print('bad file: ' + str(winFilePath))
