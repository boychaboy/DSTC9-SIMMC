#!/bin/bash

TEST_DATA=devtest		# {devtest|test}
PATH_DIR=$(realpath .)

if [[ $# -eq 1 ]]
then
	KEYWORD=$1
else
	echo "error : run format > ./run_generate_gpt2.sh [KEYWORD]"
	exit 1
fi

# Step 1 : Generate output for Task3 evaluation

# Furniture
# Multimodal Data
python -m gpt2_dst.utils.postprocess_output \
    --path="${PATH_DIR}"/gpt2_dst/results/furniture/"${KEYWORD}"/ \
    --domain=furniture

mv "${PATH_DIR}"/gpt2_dst/results/furniture/"${KEYWORD}"/furniture_"${TEST_DATA}"_dials_predicted.txt "${PATH_DIR}"/gpt2_dst/results/furniture/"${KEYWORD}"/furniture_"${TEST_DATA}"_dials_predicted.org
mv "${PATH_DIR}"/gpt2_dst/results/furniture/"${KEYWORD}"/furniture_"${TEST_DATA}"_dials_predicted_processed.txt "${PATH_DIR}"/gpt2_dst/results/furniture/"${KEYWORD}"/furniture_"${TEST_DATA}"_dials_predicted.txt


# Fashion
# Multimodal Data
python -m gpt2_dst.utils.postprocess_output \
    --path="${PATH_DIR}"/gpt2_dst/results/fashion/"${KEYWORD}"/ \
    --domain=fashion

mv "${PATH_DIR}"/gpt2_dst/results/fashion/"${KEYWORD}"/fashion_"${TEST_DATA}"_dials_predicted.txt "${PATH_DIR}"/gpt2_dst/results/fashion/"${KEYWORD}"/fashion_"${TEST_DATA}"_dials_predicted.org
mv "${PATH_DIR}"/gpt2_dst/results/fashion/"${KEYWORD}"/fashion_"${TEST_DATA}"_dials_predicted_processed.txt "${PATH_DIR}"/gpt2_dst/results/fashion/"${KEYWORD}"/fashion_"${TEST_DATA}"_dials_predicted.txt


# Step 2 : Generate output for Task2 evaluation

# Furniture
python -m gpt2_dst.utils.task2_output \
    --path="${PATH_DIR}"/gpt2_dst/results/furniture/"${KEYWORD}"/ \
    --domain=furniture

# Fashion
python -m gpt2_dst.utils.task2_output \
    --path="${PATH_DIR}"/gpt2_dst/results/fashion/"${KEYWORD}"/ \
    --domain=fashion


