# Situated Interactive MultiModal Conversations (SIMMC) Challenge 2020

# Multi-task model with Finetuning End-to-End GPT-2

# This model can do all Task1, Task2, and Task3. 

Requirements:

- Python 3.6+
- PyTorch 1.5+
- Transformers 2.8.0 (important!)

# Running model for Task3 and Task2

1. **Preprocess** the datasets to reformat the data for GPT-2 input.

```
$ cd mm_dst
$ ./run_preprocess_gpt2.sh
```
2. **Train** the baseline model

```
$ ./run_train_gpt2.sh [KEYWORD] [GPU_ID]
```

The shell script above repeats the following for both {furniture|fashion} domains.


3. **Generate** ensembled prediction for `devtest|test` data

```
pip uninstall transformers
pip install transformers -t transformers
mv transformers transformers_package
mv transformers_package/transformers transformers
cp modeling_utils.py

$ ./run_generate_using_ensemble.sh [GPU_ID]
```

The generation results are saved in the `/mm_dst/results` folder. Change the `path_output` to a desired path accordingly.


4. **Postprocess** predictions for `devtest|test` data

```
$ ./run_postprocess_gpt2.sh
```

Done! You can now evaluate Task3 and Task2 With generated files in the following directory
```
$ simmc/mm_dst/results/furniture/ensemble/
$ simmc/mm_dst/results/fashion/ensemble/
```

# Running model for Task1

1. **Preprocess ** the datasets for task1 is already in the data file

2. **Train** the baseline model

```
$ ./run_train_task1.sh [KEYWORD] [GPU_ID]
```
The shell script above repeats training for both {furniture|fashion} domains.
You shoud train multiple models for ensemble

3. **Ensemble Generate** ensembled prediction for `devtest|test` data

```
pip uninstall transformers
pip install transformers -t transformers
mv transformers transformers_package
mv transformers_package/transformers transformers
cp modeling_utils.py

$ ./run_generate_using_ensemble_task1.sh [GPU_ID]
```

The generation results are saved in the `/mm_dst/results` folder. Change the `path_output` to a desired path accordingly.


4. **Postprocess** predictions for `devtest|test` data

```
$ ./run_postprocess_task1.sh
```
Done! You can now evaluate Task3 and Task2 With generated files in the following directory

```
$ simmc/mm_dst/results/task1/furniture/ensemble/
$ simmc/mm_dst/results/task1/fashion/ensemble/
```
