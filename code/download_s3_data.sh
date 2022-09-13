
cd $(dirname $0)/..
bsub -J s3_download -n 50 -o logs/s3.log -e logs/s3.log python3 nda-abcd-s3-downloader/download.py \
    -i datastructure_manifest.txt \
    -o bidsdata/ \
    -s subject_list.txt \
    -d nda-abcd-s3-downloader/data_subsets.txt \
    -l logs/s3 \
    -c config.ini \
    -p 50
