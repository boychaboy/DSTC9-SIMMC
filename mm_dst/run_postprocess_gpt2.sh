#!/bin/bash

TEST_DATA=test		# {devtest|test}
PATH_DIR=$(realpath .)
PATH_DATA_DIR=$(realpath ..)
#echo "${PATH_DATA_DIR}"
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
python -m gpt2_dst.scripts.postprocess_output \
    --path="${PATH_DIR}"/gpt2_dst/results/furniture/"${KEYWORD}"/ \
    --domain=furniture \
    --data="${TEST_DATA}"

# Fashion
# Multimodal Data
python -m gpt2_dst.scripts.postprocess_output \
    --path="${PATH_DIR}"/gpt2_dst/results/fashion/"${KEYWORD}"/ \
    --domain=fashion \
    --data="${TEST_DATA}"

cp "${PATH_DIR}"/gpt2_dst/results/furniture/"${KEYWORD}"/furniture_"${TEST_DATA}"_belief_state.json "${PATH_DATA_DIR}"/data/simmc_furniture/furniture_"${TEST_DATA}"_belief_state.json

cp "${PATH_DIR}"/gpt2_dst/results/fashion/"${KEYWORD}"/fashion_"${TEST_DATA}"_belief_state.json "${PATH_DATA_DIR}"/data/simmc_fashion/fahsion_"${TEST_DATA}"_belief_state.json

# Step 2 : Generate output for Task2 evaluation
python -m gpt2_dst.scripts.task2_output \
    --path="${PATH_DIR}"/gpt2_dst/results/furniture/"${KEYWORD}"/ \
    --domain=furniture \
    --dials_path="${PATH_DATA_DIR}"/data/simmc_furniture/furniture_devtest_dials.json \
    --retrieval_candidate_path="${PATH_DATA_DIR}"/data/simmc_furniture/furniture_devtest_dials_retrieval_candidates.json
# Fashion
python -m gpt2_dst.scripts.task2_output \
    --path="${PATH_DIR}"/gpt2_dst/results/fashion/"${KEYWORD}"/ \
    --domain=fashion \
    --dials_path="${PATH_DATA_DIR}"/data/simmc_fashion/fashion_devtest_dials.json \
    --retrieval_candidate_path="${PATH_DATA_DIR}"/data/simmc_fashion/fashion_devtest_dials_retrieval_candidates.json


