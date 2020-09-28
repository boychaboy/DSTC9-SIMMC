KEYWORD="td_small"
# Step 2 : Generate output for Task2 evaluation
PATH_DIR=$(realpath . )
PATH_DATA_DIR=$(realpath ..)

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
