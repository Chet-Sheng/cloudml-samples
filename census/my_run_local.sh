# This is bash script. type bash run.sh
cd customestimator

GCS_TRAIN_FILE=gs://cloudml-public/census/data/adult.data.csv
GCS_EVAL_FILE=gs://cloudml-public/census/data/adult.test.csv
CENSUS_DATA=census_data

TRAIN_FILE=$CENSUS_DATA/adult.data.csv
EVAL_FILE=$CENSUS_DATA/adult.test.csv

gsutil cp $GCS_TRAIN_FILE $TRAIN_FILE
gsutil cp $GCS_EVAL_FILE $EVAL_FILE

export TRAIN_STEPS=1000
DATE=`date '+%Y%m%d_%H%M%S'`
export OUTPUT_DIR=census_$DATE
# $ + variable name

#Local training
python3 -m trainer.My_Task --train-files $TRAIN_FILE \
                           --eval-files $EVAL_FILE \
                           --job-dir $OUTPUT_DIR \
                           # --num-epochs 1\
                           --train-steps $TRAIN_STEPS \
                           --eval-steps 100



#rm -rf $CENSUS_DATA
#rm -rf $OUTPUT_DIR
