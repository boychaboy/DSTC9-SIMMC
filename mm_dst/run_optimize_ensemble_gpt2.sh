#!/bin/bash

FURNITURE=furniture_devtest_dials_predicted.txt
FASHION=fashion_devtest_dials_predicted.txt

DOMAIN=furniture
# Furniture
PATH_DIR=$(realpath .)
python -m gpt2_dst.scripts.optimize_ensemble \
    --input_path_predicted_list "${PATH_DIR}"/gpt2_dst/results/furniture/td_large/"${FURNITURE}" "${PATH_DIR}"/gpt2_dst/results/furniture/td_small/"${FURNITURE}" "${PATH_DIR}"/gpt2_dst/results/furniture/large/"${FURNITURE}" "${PATH_DIR}"/gpt2_dst/results/furniture/small/"${FURNITURE}" "${PATH_DIR}"/gpt2_dst/results/furniture/ensemble_2/"${FURNITURE}" "${PATH_DIR}"/gpt2_dst/results/furniture/ensemble_3/"${FURNITURE}" \
    --output_path_ensembled="${PATH_DIR}"/gpt2_dst/results/furniture/ensembled.txt \
    --prompts_from_file="${PATH_DIR}"/gpt2_dst/data/"${DOMAIN}"/"${DOMAIN}"_devtest_dials_predict.txt \
    --target="${PATH_DIR}"/gpt2_dst/data/"${DOMAIN}"/"${DOMAIN}"_devtest_dials_target.txt \
    --domain=furniture

echo "Evaluation of furniture : " 
# Evaluate (furniture, non-multimodal)
python -m gpt2_dst.scripts.evaluate \
    --input_path_target="${PATH_DIR}"/gpt2_dst/data/furniture/furniture_devtest_dials_target.txt \
    --input_path_predicted="${PATH_DIR}"/gpt2_dst/results/furniture/ensembled.txt \
    --output_path_report="${PATH_DIR}"/gpt2_dst/results/furniture/ensembled_devtest_dials_report.json

'
# Fashion
python -m gpt2_dst.scripts.ensemble \
    --input_path_predicted_list  "${PATH_DIR}"/results/fashion/large.txt "${PATH_DIR}"/results/fashion/td_small.txt "${PATH_DIR}"/results/fashion/small.txt --output_path_ensembled="${PATH_DIR}"/gpt2_dst/results/fashion/fashion_ensembled.txt \
    --prompts_from_file="${PATH_DIR}"/gpt2_dst/data/fashion/fashion_devtest_dials_predict.txt \
    --domain=fashion
# ~/results/td_small.txt \
echo "Evaluation of fashion : " 
# Evaluate (furniture, non-multimodal)
python -m gpt2_dst.scripts.evaluate \
    --input_path_target="${PATH_DIR}"/gpt2_dst/data/fashion/fashion_devtest_dials_target.txt \
    --input_path_predicted="${PATH_DIR}"/gpt2_dst/results/fashion/fashion_ensembled.txt \
    --output_path_report="${PATH_DIR}"/gpt2_dst/results/fashion/fashion_ensembled_devtest_dials_report.json
'
