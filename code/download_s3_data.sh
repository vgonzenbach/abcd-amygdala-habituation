
cd $(dirname $0)/..
python3 nda-abcd-s3-downloader/download.py \
    -i datastructure_manifest.txt \
    -o bidsdata/ \
    -s subject_list.txt \
    -d data_subsets.txt \
    -l logs/s3 #\
    #-c config.ini #\
    #-p 50
