#!/bin/bash

PATH_DIR=$(realpath .)

if [[ $# -eq 1 ]]
then
	KEYWORD=$1
else
	echo "error : run format > ./run_evluate_task1.sh [KEYWORD]"
	exit 1
fi

echo "Furniture : "
# Evaluate (Furniture, multi-modal)
python -m gpt2_dst.scripts.evaluate \
    --input_path_target="${PATH_DIR}"/gpt2_dst/data/furniture/furniture_devtest_dials_target.txt \
    --input_path_predicted="${PATH_DIR}"/gpt2_dst/results/furniture/"${KEYWORD}"/furniture_devtest_dials_predicted.txt \
    --output_path_report="${PATH_DIR}"/gpt2_dst/results/furniture/"${KEYWORD}"/furniture_devtest_dials_report.json

echo "Fashion : "
# Evaluate (Fashion, multi-modal)
python -m gpt2_dst.scripts.evaluate \
    --input_path_target="${PATH_DIR}"/gpt2_dst/data/fashion/fashion_devtest_dials_target.txt \
    --input_path_predicted="${PATH_DIR}"/gpt2_dst/results/fashion/"${KEYWORD}"/fashion_devtest_dials_predicted.txt \
    --output_path_report="${PATH_DIR}"/gpt2_dst/results/fashion/"${KEYWORD}"/fashion_devtest_dials_report.json
