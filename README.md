# scRNA-seq and scATAC-seq Data Analysis Baseline Model
## Overview

Baseline model for [the Dream Challenge]: [scImpute](https://github.com/Vivianstats/scImpute)

## Dockerize your model

> !!! Note: running the `scImpute` baseline is lengthy and requires large RAM.

1. Start by cloning this repository.

2. Go to the [scImpute](./scImpute/) folder

3. Build the Docker image that will contain the model with the following command:

  ```bash
  docker build -t example-q1-model:v1 .
  ```

## Run the model locally on ...

1. find testing data ...


2. Create an `output` folder

    ```bash
    mkdir output
    ```

3. Run the dockerized model

    ```bash
    docker run \
        -v $(pwd)/{test-data-folder...}/:/data:ro \
        -v $(pwd)/output:/output:rw \
        example-q1-model:v1
    ```

6. The predictions generated are saved to `/output/*_imputed.csv`.

    ```bash
    $ ls output/*_imputed.csv
    c1_0_125_imputed.csv
    c2_0_125_imputed.csv
    c3_0_125_imputed.csv
    c4_0_125_imputed.csv
    ...
    ```

## Submit this model to the DREAM Challenge

This model meets the requirements for models to be submitted to Question 1A of [the Dream Challenge]. Please see the [instructions] on how to submit the model to synapse.

[the Dream Challenge]: https://www.synapse.org/#!Synapse:syn26720920/wiki/615338
[instructions]: 