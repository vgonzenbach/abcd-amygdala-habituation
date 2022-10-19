cd $(dirname $0)/..

for subject in $(python -c "import sys, bids; bids.config.set_option('extension_initial_dot', True); layout = bids.BIDSLayout('bidsdata'); subjects = layout.get_subjects(); sys.stdout.write(' '.join(subjects))"); do
     
    txt=bidsdata/sourcedata/sub-${subject}/ses-baselineYear1Arm1/func/sub-${subject}_ses-baselineYear1Arm1_task-nback_run-01_bold_EventRelatedInformation.txt
    if [[ -f $txt ]]; then
        replacement=$(head -n1 $txt| iconv -f utf-8 -t utf-8 -c)
        sed -i "1 s/.*/$replacement/g" $txt
        #echo $replacement
    fi
done
