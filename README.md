# Situated Interactive MultiModal Conversations (SIMMC) Challenge 2020
Codes submitted for SIMMC challenge (https://github.com/facebookresearch/simmc), Track 4 of DSTC 9 (https://dstc9.dstc.community/home)

## Brief summary
### Multi-task model with Finetuning End-to-End GPT-2
We have built a GPT-2 model that (1) predicts belief state, (2) Generates assistant’s response, and (3) Predicts API with end-to-end training method. In general, our model is a multi-task model that can do all three subtasks required with competitive performances. We accomplished this by making three modifications from the baseline model.
1. We preprocessed api and attributes for each turn and added them to the end of every lines of GPT-2 input so that the model can learn which apis and attributes are needed in which circumstances and contexts.
2. For the train data, we parsed and lower-cased every camelCased dialogue acts and slots so that pertained GPT-2 model can easily be fine-tuned to our data. We postprocess the model outputs to the original format.
3. We modified the decoding step of GPT-2 generation code so that multiple model can be ensembled when generating predictions.

*In short, this model can do all Task1, 2, 3 with a single training*

## Devtest Results
We submit 3 different ensembled model predictions.  
Each model is trained differently in **size of pretrianed models** or **amount of data used while training**.  
Three ensembled models are different compositions of these models. We used three types of pretrianed models { gpt2-small | gpt2-medium | gpt2-large } along with two different amount of data while training { train | train+dev }.

### Task2 & Task3
**1. Ensemble1**  
Ensembled models : gpt2-large(train+dev), gpt2-large(train)  
`$ simmc/mm_dst/gpt2_dst/results/{furniture|fashion}/ensemble_devtest` 

| Domain  |     BLEU-4     | R@1 | R@5 | R@10 | Mean Rank | MRR | Dialog Act F1 | Slot F1 |
|----------| :-------------: | :------: | :------: | :------: | :------: |:------: | -------|-------|   
| Furniture | 0.111 | 26.0 | 49.6 | 61.2 | 15.9 | 0.376 | 83.47 | 80.28 |
| Fashion   | 0.135 | 24.8 | 49.9 | 63.5 | 15.0 | 0.373 | 75.12 | 75.21 |  


**2. Ensemble2**  
Ensembled models : gpt2-large(train+dev), gpt2-small(train+dev)  
`$ simmc/mm_dst/gpt2_dst/results/{furniture|fashion}/ensemble2_devtest`  
 
| Domain  |     BLEU-4     | R@1 | R@5 | R@10 | Mean Rank | MRR | Dialog Act F1 | Slot F1 |
|----------| :-------------: | :------: | :------: | :------: | :------: |:------: | :------: |:------: | 
| Furniture | 0.117 | 26.5 | 50.5 | 61.9 | 16.0 | 0.382 | 83.48 | 80.46 |
| Fashion   | 0.141 | 24.2 | 49.7 | 64.2 | 14.5 | 0.368 | 75.65 | 75.02 |  


**3. Ensemble3**  
Ensembled models : gpt2-large(train+dev), gpt2-large(train), gpt2-small(train+dev)  
`$ simmc/mm_dst/gpt2_dst/results/{furniture|fashion}/ensemble3_devtest`  

| Domain  |     BLEU-4     | R@1 | R@5 | R@10 | Mean Rank | MRR | Dialog Act F1 | Slot F1 |
|----------| :-------------: | :------: | :------: | :------: | :------: |:------: |:------: |:------: |    
| Furniture | 0.117 | 26.2 | 50.3 | 61.6 | 15.8 | 0.379 | 83.91 | 80.6 |
| Fashion   | 0.141 | 25.2 | 50.5 | 64.5 | 14.3 | 0.379 | 75.4 | 75.37 |  

### Task1  
Ensembled models : gpt2-medium(train+dev), gpt2-small(train+dev)  
`$ simmc/mm_dst/gpt2_dst/results/task1/{furniture|fashion}/ensemble_devtest`  

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

[NOTE] Since it was not possible to measure the "Action perplexity" with our model, the log probability was all set to zero.  
  
  
  
## Teststd Results
Teststd results are saved in following directories :  

### Task2 & Task3  
Ensemble1 : `$ simmc/mm_dst/gpt2_dst/results/{furniture|fashion}/ensemble`  
Ensemble2 : `$ simmc/mm_dst/gpt2_dst/results/{furniture|fashion}/ensemble2`  
Ensemble3 : `$ simmc/mm_dst/gpt2_dst/results/{furniture|fashion}/ensemble3`    
  
  
### Task1  
`$ simmc/mm_dst/gpt2_dst/results/task1/{furniture|fashion}/ensemble`  

***All {devtest|teststd} results can be also found in `outputs/` directory for your convenience.***

  
   
## Running model
### Installation
Install the required Python packages:
- Python 3.6+
- PyTorch 1.5+
- Transformers 2.8.0 (IMPORTANT)

### Task3 and Task2
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

(IMPORTANT) **You must train multiple models to do ensemble generation**

3. **Generate** ensembled prediction for `devtest|teststd` data

```
$ pip uninstall transformers
$ pip install transformers==2.8.0 -t transformers
$ mv transformers transformers_package
$ mv transformers_package/transformers transformers
$ cp modeling_utils.py transformers/
```
And add model [KEYWORDS] to generate in the following shell script 
```
$ ./run_generate_using_ensemble.sh [GPU_ID]
```

4. **Postprocess** predictions for `devtest|teststd` data

```
# For devtest set
$ ./run_postprocess_devtest_gpt2.sh [KEYWORD]

# For teststd set
$ ./run_postprocess_teststd_gpt2.sh [KEYWORD]
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

### Task1

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
$ pip uninstall transformers
$ pip install transformers==2.8.0 -t transformers
$ mv transformers transformers_package
$ mv transformers_package/transformers transformers
$ cp modeling_utils.py transformers/

$ ./run_generate_using_ensemble_task1.sh [GPU_ID]
```

The generation results are saved in the `/mm_dst/results/task1` folder. Change the `path_output` to a desired path accordingly.


4. **Postprocess** predictions for `devtest|teststd` data

```
# For devtest set
$ ./run_postprocess_devtest_task1.sh [KEYWORD]

# For teststd set
$ ./run_postprocess_teststd_task1.sh [KEYWORD]
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
Since it was not possible to measure the "Action perplexity" with our model, the log probability was all set to zero.  
  
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


### Notes
- The model for task1 also generates prediction of task2 and task3. We evaluated the accuracy of all three tasks but didn't provided the result here to prevent confusion with the score we are submitting. If you need the full evaluation results of Multi-tasking(task1~3) model, please contact us via email (hoon2j@gmail.com).
- If you need model parameters(trained before Sep 28th), please also contact us via email (hoon2j@gmail.com)
