cd $(dirname $0)/..

header=$(echo 'ExperimentName Subject Session Allowed Clock.Information ConsecNonResp[Session] ConsecRTLess200[Session] DataFile.Basename ExperimentVersion FontStyle Group Handedness Main.RefreshRate NARGUID Nontarget RandomSeed RunNumber RuntimeCapabilities RuntimeVersion RuntimeVersionExpected RunTrialNumber[Session] SessionDate SessionStartDateTimeUtc SessionTime StimuliDir StudioVersion SUBID Target TotalRespGreater200[Session] TrialsPerRun[Session] triggercode Block BlockType ConsecNonResp[Block] ConsecRTLess200[Block] ConsecSameResp ControlAcc CorrectResponse Cue2Back.Duration Cue2Back.DurationError Cue2Back.FinishTime Cue2Back.OffsetDelay Cue2Back.OffsetTime Cue2Back.OnsetDelay Cue2Back.OnsetTime Cue2Back.OnsetToOnsetTime Cue2Back.StartTime CueFix.Duration CueFix.DurationError CueFix.FinishTime CueFix.OffsetDelay CueFix.OffsetTime CueFix.OnsetDelay CueFix.OnsetTime CueFix.OnsetToOnsetTime CueFix.RTTime CueFix.StartTime CueTarget.Duration CueTarget.DurationError CueTarget.FinishTime CueTarget.OffsetDelay CueTarget.OffsetTime CueTarget.OnsetDelay CueTarget.OnsetTime CueTarget.OnsetToOnsetTime CueTarget.StartTime Fix.Duration Fix.DurationError Fix.FinishTime Fix.OffsetDelay Fix.OffsetTime Fix.OnsetDelay Fix.OnsetTime Fix.OnsetToOnsetTime Fix.StartTime Fix15sec.Duration Fix15sec.DurationError Fix15sec.FinishTime Fix15sec.OffsetDelay Fix15sec.OffsetTime Fix15sec.OnsetDelay Fix15sec.OnsetTime Fix15sec.OnsetToOnsetTime Fix15sec.StartTime Procedure[Block] Run1Block1 Run1Block2 Run1Block3 Run1Block4 Run1Block5 Run1Block6 Run1Block7 Run1Block8 Run2Block1 Run2Block2 Run2Block3 Run2Block4 Run2Block5 Run2Block6 Run2Block7 Run2Block8 Running[Block] RunTrialNumber[Block] Stim.ACC Stim.Duration Stim.DurationError Stim.FinishTime Stim.OffsetDelay Stim.OffsetTime Stim.OnsetDelay Stim.OnsetTime Stim.OnsetToOnsetTime Stim.RESP Stim.RT Stim.RTTime Stim.StartTime StimType Stimulus TargetType TotalRespGreater200[Block] TrialsPerRun[Block] v1ProcList v1ProcList.Cycle v1ProcList.Sample Trial GetReady.DurationError GetReady.OffsetDelay GetReady.OffsetTime GetReady.OnsetDelay GetReady.OnsetTime GetReady.OnsetToOnsetTime GetReady.RTTime GetReady2.DurationError GetReady2.OffsetDelay GetReady2.OffsetTime GetReady2.OnsetDelay GetReady2.OnsetTime GetReady2.OnsetToOnsetTime GetReady2.RTTime Procedure[Trial] Running[Trial] Waiting4Scanner Waiting4Scanner.Cycle Waiting4Scanner.Sample Waiting4Scanner2 Waiting4Scanner2.Cycle Waiting4Scanner2.Sample' | tr ' ' $'\t')

for subject in $(python -c "import sys, bids; bids.config.set_option('extension_initial_dot', True); layout = bids.BIDSLayout('bidsdata'); subjects = layout.get_subjects(); sys.stdout.write(' '.join(subjects))"); do
     
    txt=bidsdata/sourcedata/sub-${subject}/ses-baselineYear1Arm1/func/sub-${subject}_ses-baselineYear1Arm1_task-nback_run-01_bold_EventRelatedInformation.txt
    if [[ -f $txt ]]; then
        
        #cp bidsdata/sourcedata/sub-${subject}/ses-baselineYear1Arm1/func/sub-${subject}_ses-baselineYear1Arm1_task-nback_run-02_bold_EventRelatedInformation.txt bidsdata/sourcedata/sub-${subject}/ses-baselineYear1Arm1/func/sub-${subject}_ses-baselineYear1Arm1_task-nback_run-01_bold_EventRelatedInformation.txt
        
        #if [[ $(sed '2q;d' $txt) =~ ExperimentName ]]; then
        #    sed -i '1d' $txt
        #else 
        #    sed -i "1 s/.*/$header/g" $txt
        #fi
        #sed -i "1 s/.*/$header/g" $txt
        #firstline=$(sed '1q;d' $txt)
        
        #cat $txt | iconv -f utf-8 -t utf-8 -c > $txt

        #replacement=$(head -n1 $txt | iconv -f utf-8 -t utf-8 -c)
        #sed -i "1 s/.*/$replacement/g" $txt
        #echo $replacement
    fi
done
