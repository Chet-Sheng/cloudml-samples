# This is bash script. type bash run.sh
cd customestimator

# GCS_TRAIN_FILE=gs://cloudml-public/census/data/adult.data.csv
# GCS_EVAL_FILE=gs://cloudml-public/census/data/adult.test.csv
# CENSUS_DATA=census_data

# TRAIN_FILE=$CENSUS_DATA/adult.data.csv
# EVAL_FILE=$CENSUS_DATA/adult.test.csv

TRAIN_FILE=gs://cloudml-public/census/data/adult.data.csv
EVAL_FILE=gs://cloudml-public/census/data/adult.test.csv
CENSUS_DATA=census_data

# gsutil cp $GCS_TRAIN_FILE $TRAIN_FILE
# gsutil cp $GCS_EVAL_FILE $EVAL_FILE

export TRAIN_STEPS=1000
DATE=`date '+%Y%m%d_%H%M%S'`
export JOB_NAME=census_GPU_$DATE
export GCS_JOB_DIR=gs://cloudiq-treepie-development/huafeng.sheng@cloud-iq.com/$JOB_NAME
export SCALE_TIER=BASIC_GPU
# $ + variable name

# Local training
gcloud ml-engine jobs submit training $JOB_NAME \
                                    --module-name trainer.My_Task \
                                    --job-dir $GCS_JOB_DIR \
                                    --stream-logs \
                                    --runtime-version 1.4 \
                                    --package-path trainer/ \
                                    --region us-central1 \
                                    --scale-tier $SCALE_TIER \
                                    --\
                                    --train-files $TRAIN_FILE \
                                    --eval-files $EVAL_FILE \
                                    --train-steps $TRAIN_STEPS \
                                    --eval-steps 100



#rm -rf $CENSUS_DATA
#rm -rf $OUTPUT_DIR
