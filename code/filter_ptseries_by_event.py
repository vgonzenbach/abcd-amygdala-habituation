# Set up packages and working directory
import os
import re
import subprocess
from bids import BIDSLayout
import numpy as np
import pandas as pd
import nibabel as nib

def setwd():
    PROJROOT = os.path.join(os.path.dirname(__file__), '..')
    os.chdir(PROJROOT)
    print(f'Working directory set to {os.getcwd()}')
    return None

setwd()

layout = BIDSLayout('bidsdata', derivatives=True)
subjects = layout.get_subjects()

def get_ptseries(sub):
    return f'bidsdata/derivatives/abcd-hcp-pipeline/sub-{sub}/ses-baselineYear1Arm1/func/sub-{sub}_ses-baselineYear1Arm1_task-nback_bold_atlas-Power2011FreeSurferSubcortical_desc-filtered_timeseries.ptseries.nii'

def get_events(sub):
    return f'bidsdata/sourcedata/sub-{sub}/ses-baselineYear1Arm1/func/sub-{sub}_ses-baselineYear1Arm1_task-nback_run-01_bold_EventRelatedInformation.txt'

def has_files(sub):
    return os.path.exists(get_ptseries(sub)) and os.path.exists(get_events(sub))


def make_subject_df(sub):
    print(sub)
    """Compute dataframe with stimulis as rows and rois as columns. Values represent the mean BOLD signal or that ROI, Stimuli"""
    try: # reading in .nii files
        ptseries_path = f'bidsdata/derivatives/abcd-hcp-pipeline/sub-{sub}/ses-baselineYear1Arm1/func/sub-{sub}_ses-baselineYear1Arm1_task-nback_bold_atlas-Power2011FreeSurferSubcortical_desc-filtered_timeseries.ptseries.nii'
        ptseries = nib.load(ptseries_path)
    except Exception as e:
        print(f'For {sub}: {e}')
        return None
    else:
        ptseries_data = ptseries.get_fdata()
        series_axis, parcel_axis = [ptseries.header.get_axis(i) for i in range(ptseries.ndim)]
    

    try: # reading in events data
        events_path = f'bidsdata/sourcedata/sub-{sub}/ses-baselineYear1Arm1/func/sub-{sub}_ses-baselineYear1Arm1_task-nback_run-01_bold_EventRelatedInformation.txt'
        with open(events_path, 'r', encoding='utf-8', errors='ignore') as f:
            # check if first line is header
            header = 1 if bool(re.search("\.edat2", f.readlines()[0])) else 0       
        event_df = pd.read_table(events_path, delimiter='\t', header=header)
    except Exception as e:
        print(f'For {sub}: {e}')
        return None
    else:
        onsets = event_df['Stim.OnsetTime'].loc[~event_df['Stim.OnsetTime'].isnull()]
        onsets = (onsets - min(onsets)) / 1000

    def map2stimuli(t):
        """For timepoint t, return stimuli based on 2.516 windows"""
        hit = [i for i, x in enumerate(onsets) if x <= t < x + 2.516]
        if hit:
            index = onsets.index[hit.pop()]
            return f"{event_df['BlockType'].loc[index]} {event_df['StimType'].loc[index]}"
        else:
            return 'NA'
    
    stim = pd.Series([map2stimuli(t) for t in series_axis.time])

    roi_dict = {name: i for i, name in enumerate(parcel_axis.name) if name.isupper() and name != 'UNKNOWN'}
    def make_roi_df(roi_name, roi_index): 
        """Get mean BOLD signal for different stimuli given an ROI"""
        return pd.DataFrame({roi_name: ptseries_data[:, roi_index], 'Stimulus' :stim}).groupby('Stimulus').mean()

    subject_df = pd.concat([make_roi_df(roi_name, roi_index) for roi_name, roi_index in roi_dict.items()], axis=1)
    subject_df.insert(0, 'subject', sub)
    subject_df = subject_df.reset_index(level=0)
    return subject_df

df_list = [make_subject_df(sub) for sub in subjects]
df = pd.concat(df_list).reset_index(drop=True)
df.to_csv('mean_bold_by_stimuli.csv', index=False)
    

