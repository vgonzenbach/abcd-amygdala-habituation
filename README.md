# abcd-amygdala-habituation

Preliminary analysis code for the amygdala habituation project. 

## Install 

To install this repository:

```sh
git clone https://github.com/vgonzenbach/abcd-amygdala-habituation.git
# then move into this folder
cd abcd-amygdala-habituation
```

## Usage

To download the data, first follow the numbered steps on [the DCAN labs abcd downloader](https://github.com/DCAN-Labs/nda-abcd-s3-downloader/tree/4045d4f61975852f3630a59ce470ec93c45aeaab#readme) 
to download the `datastructure_manifest.txt` file from the NDA portal. 

Then, note that the file `data_subsets.txt` in this repository already includes a subset of all the possible 
modalities and files listed in the original [`data_subsets.txt` in the DCAN repository](https://github.com/DCAN-Labs/nda-abcd-s3-downloader/blob/4045d4f61975852f3630a59ce470ec93c45aeaab/data_subsets.txt).

By default, all subjects (n≈10000) are downloaded. However, `code/make_subject_list.py` produces a list of 50 males and 50 females whose data passed QC. 
This script takes as input the `abcd_fastqc01.csv` file downloaded through NDA, and produces the `subject_list.txt` file included in this repository. 

Once all mentioned files (primarily `datastructure_manifest.txt`) have been prepared, the downloader can be called by running `code/download_s3_data.sh`:

```sh 
bash code/download_s3_data.sh
# or
chmod +x code/download_s3_data.sh
./code/download_s3_data.sh
```

Make sure you are in the root project directory before running this (i.e. have run `cd abcd-amygdala-habituation`).

## Supplementary code

- `notebooks/examine_ciftis.ipynb` explores the downloaded data structures using Python objects and methods. 
- `notebooks/analysis.ipynb` produces the exploratory box plots. 
- `notebooks/examine_event_data.Rmd` can be used in Rstudio to view the event-related metadata (i.e. block information). 
- `code/fix_nonunicode.sh` fixes encoding issues in the event related files (WARNING: might need some editing to avoid overwriting the data). 


