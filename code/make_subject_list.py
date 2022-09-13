import os
import pandas as pd

# Set working directory
PROJROOT = os.path.join(os.path.dirname(__file__), '..')
os.chdir(PROJROOT)

df = pd.read_csv('abcd_fastqc01.csv')

# pick ids of 50 males and 50 females
subj_id = list(df[df.sex == 'M'][0:50].subjectkey) + list(df[df.sex == 'F'][0:50].subjectkey)
# format subject ids
lines = [f"sub-{id.replace('_', '')}" for id in subj_id]

with open('subject_list.txt', 'w') as fp:
    for line in lines:
        # write each item on a new line
        fp.write(f"{line}\n")
    print('subject_list.txt created successfully.')