#!/bin/bash

PATH_DIR=$(realpath .)
PATH_DATA_DIR=$(realpath ..)

KEYWORD=$1

# Step 1 : Generate output for Task3 evaluation

# Furniture
# Multimodal Data
python -m gpt2_dst.scripts.postprocess_output \
    --path="${PATH_DIR}"/gpt2_dst/results/furniture/"${KEYWORD}"/ \
    --domain=furniture \
    --data=devtest

# Fashion
# Multimodal Data
python -m gpt2_dst.scripts.postprocess_output \
    --path="${PATH_DIR}"/gpt2_dst/results/fashion/"${KEYWORD}"/ \
    --domain=fashion \
    --data=devtest

cp "${PATH_DIR}"/gpt2_dst/results/furniture/"${KEYWORD}"/furniture_devtest_belief_state.json "${PATH_DATA_DIR}"/data/belief_simmc_furniture/furniture_devtest_belief_state.json

cp "${PATH_DIR}"/gpt2_dst/results/fashion/"${KEYWORD}"/fashion_devtest_belief_state.json "${PATH_DATA_DIR}"/data/belief_simmc_fashion/fashion_devtest_belief_state.json

# Step 2 : Generate output for Task2 evaluation
python -m gpt2_dst.scripts.task2_output \
    --path="${PATH_DIR}"/gpt2_dst/results/furniture/"${KEYWORD}"/ \
    --domain=furniture \
    --data=devtest \
    --dials_path="${PATH_DATA_DIR}"/data/simmc_furniture/furniture_devtest_dials.json \
    --retrieval_candidate_path="${PATH_DATA_DIR}"/data/simmc_furniture/furniture_devtest_dials_retrieval_candidates.json

# Fashion
python -m gpt2_dst.scripts.task2_output \
    --path="${PATH_DIR}"/gpt2_dst/results/fashion/"${KEYWORD}"/ \
    --domain=fashion \
    --data=devtest \
    --dials_path="${PATH_DATA_DIR}"/data/simmc_fashion/fashion_devtest_dials.json \
    --retrieval_candidate_path="${PATH_DATA_DIR}"/data/simmc_fashion/fashion_devtest_dials_retrieval_candidates.json
