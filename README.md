# Situated Interactive MultiModal Conversations (SIMMC) Challenge 2020

## Multi-task model with Finetuning End-to-End GPT-2

**This model can do all Task1, Task2, and Task3**

Requirements:

- Python 3.6+
- PyTorch 1.5+
- Transformers 2.8.0 (important!)

# Task3 and Task2

1. **Preprocess** the datasets to reformat the data for GPT-2 input.

You should run the Task1 prepocessing before you start. 
```
$ cd mm_action_prediction/
$ ./scripts/preprocess_simmc.sh
```

Preprocess for task3
```
$ cd ../mm_dst
$ ./run_preprocess_gpt2.sh
```

2. **Train** the baseline model

```
$ ./run_train_gpt2.sh [KEYWORD] [GPU_ID]
```

The shell script above repeats the following for both {furniture|fashion} domains.

IMPORTANT **You must train multiple models to do ensemble generation**

3. **Generate** ensembled prediction for `devtest|teststd` data

```
pip uninstall transformers
pip install transformers -t transformers
mv transformers transformers_package
mv transformers_package/transformers transformers
cp modeling_utils.py transformers/
```
And add model [KEYWORDS] to generate in the following shell script 
```
$ ./run_generate_using_ensemble.sh [GPU_ID]
```

4. **Postprocess** predictions for `devtest|teststd` data

```
# For devtest set
$ ./run_postprocess_devtest_gpt2.sh

# For teststd set
$ ./run_postprocess_teststd_gpt2.sh
```

Done! 
You can now evaluate Task3 and Task2 With generated files in the following directories

```
# For devtest set
$ simmc/mm_dst/results/furniture/ensemble_devtest/
$ simmc/mm_dst/results/fashion/ensemble_devtest/

# For teststd set
$ simmc/mm_dst/results/furniture/ensemble/
$ simmc/mm_dst/results/fashion/ensemble/
```

5. Summary of the evaluation results for the `devtest set` 

*Results of the Task3 and Task2 are generated End-to-End by the same model.*

**Task3**
| Domain | Dialog Act F1 | Slot F1 |
|--------|-------|-------|
| Furniture (multimodal) | 83.47 | 80.28 |
| Fashion (multimodal) | 75.12 | 75.21 |

**Task2** 
*without single round evaluation* 
| Domain  |     BLEU-4     | R@1 | R@5 | R@10 | Mean Rank | MRR |
|----------| :-------------: | :------: | :------: | :------: | :------: |:------: |        
| Furniture | 0.111 | 26.0 | 49.6 | 61.2 | 15.9 | 0.376 |
| Fashion   | 0.135 | 24.8 | 49.9 | 63.5 | 15.0 | 0.373 |

*single round evaluation*
| Domain  |     BLEU-4     | R@1 | R@5 | R@10 | Mean Rank | MRR |
|----------| :-------------: | :------: | :------: | :------: | :------: |:------: |        
| Furniture | 0.160 | 30.8 | 61.1 | 72.6 | 12.3 | 0.440 |
| Fashion   | 0.218 | 30.5 | 60.3 | 75.2 | 11.2 | 0.448 |


# Task1

1. **Preprocess** 
You should run the Task1 prepocess before you start. 

```
$ cd ../mm_action_prediction
$ ./scripts/preprocess_simmc.sh
```

The data for task1 is provided in the data file, but if you need to run from scratch, run below

```
$ ./run_preprocess_task1.sh
```

2. **Train** the baseline model

```
$ ./run_train_task1.sh [KEYWORD] [GPU_ID]
```
The shell script above repeats training for both {furniture|fashion} domains.
You shoud train multiple models for ensemble

3. **Ensemble Generate** ensembled prediction for `devtest|teststd` data

```
pip uninstall transformers
pip install transformers -t transformers
mv transformers transformers_package
mv transformers_package/transformers transformers
cp modeling_utils.py transformers/

$ ./run_generate_using_ensemble_task1.sh [GPU_ID]
```

The generation results are saved in the `/mm_dst/results/task1` folder. Change the `path_output` to a desired path accordingly.


4. **Postprocess** predictions for `devtest|teststd` data

```
# For devtest set
$ ./run_postprocess_devtest_task1.sh

# For teststd set
$ ./run_postprocess_teststd_task1.sh
```
Done! You can now evaluate Task1 With generated files in the following directory

```
# For devtest set
$ simmc/mm_dst/results/task1/furniture/ensemble_devtest/
$ simmc/mm_dst/results/task1/fashion/ensemble_devtest/

# For teststd set
$ simmc/mm_dst/results/task1/furniture/ensemble/
$ simmc/mm_dst/results/task1/fashion/ensemble/
```

5. Summary of the evaluation results for the `devtest set` 

**Task1** 
*without single round evaluation* 
| Domain | Action Accuracy | Attribute Accuracy | Action Perplexity |
|--------|-------|-------|-------|
| Furniture (multimodal) | 79.40 | 68.95 | 1.0(not available) |
| Fashion (multimodal) | 85.62 | 80.64 | 1.0(not available) |

*single round evaluation* 
| Domain | Action Accuracy | Attribute Accuracy | Action Perplexity |
|--------|-------|-------|-------|
| Furniture (multimodal) | 93.96 | 54.55 | 1.0(not available) |
| Fashion (multimodal) | 97.25 | 33.33 | 1.0(not available) |

Since it was not possible to measure the "Action perplexity" with our model, the log probability was all set to zero. 

### Notes
The model for task1 also generates prediction of task2 and task3. We evaluated the accuracy of all three tasks but didn't provided the result here to prevent confusion with the score we are submitting. If you need the full evaluation results of Multi-tasking(task1~3) model, please contact us via email (hoon2j@gmail.com).
