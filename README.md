# iLICOB
`iLICOB`: an R package for exploring LICOB resource.

## Requirements
    install.packages(c("pacman"))
 
## Install
    devtools::install_github("wu-yc/iLICOB")

## Quick Start
`iLICOB` generally supports two main functions: (1) Predict drug response based on omics profile; (2) Query gene of interest. 


### 1. Load packages and demo data
The demo data is a subset of LICOB omics data and TCGA-LIHC RNA-seq data (Cell. 169.7(2017):1327-1341).

    #load packages
    library(iLICOB)
    library(pacman)
    p_load(DALEX,caret,tidyverse,elasticnet)
    
    #load data
    load(file = system.file("data", "data_ilicob_org", package = "iLICOB"))
    load(file = system.file("data", "data_ilicob_tissue", package = "iLICOB"))



### 2. Predict drug response based on omics profile
    # 1 - Tissue demo data (TCGA-LIHC RNA-seq data)
    mat = data_ilicob_tissue[[3]]
    AUC.predicted = iLICOB_predict(input.mat = mat, input.type = "Tissue", input.omics = "RNA")

    # 2 - Organoid demo data (LICOB RNA-seq data)
    mat = data_ilicob_org[[3]][[1]]
    AUC.predicted = iLICOB_predict(input.mat = mat, input.type = "Tissue", input.omics = "RNA")

    # 3 - Organoid demo data (LICOB Proteome data)
    mat = data_ilicob_org[[3]][[2]]
    AUC.predicted = iLICOB_predict(input.mat, input.type = "Organoid", input.omics = "Protein")

    # 4 - Organoid demo data (LICOB CNV data)
    mat = data_ilicob_org[[3]][[3]]
    AUC.predicted = iLICOB_predict(input.mat, input.type = "Organoid", input.omics = "CNV")

    # 5 - Organoid demo data (LICOB Methylation data)
    mat = data_ilicob_org[[3]][[4]]
    AUC.predicted = iLICOB_predict(input.mat, input.type = "Organoid", input.omics = "Methylation")

    # 6 - Organoid demo data (LICOB Mutation data)
    mat = data_ilicob_org[[3]][[5]]
    AUC.predicted = iLICOB_predict(input.mat, input.type = "Organoid", input.omics = "Mutation")


`input.mat` is a data.frame object of omics profile.

`input.type` is the data type of input matrix. It supports "Tissue" and "Organoid". The default value is "Tissue".

`input.mat` is the omics type of input matrix. It supports "RNA", "Protein", "CNV", "Methylation", and "Mutation". The default value is "RNA".

This function will return a data.frame object containing the predicted AUC matrix.


### 3. Query gene of interest.




## Online version of iLICOB
http://cancerdiversity.asia/LICOB/


## Contact

Qiang Gao, MD, PhD

Department of Liver Surgery and Transplantation, Liver Cancer Institute, Zhongshan Hospital, Fudan University, Shanghai, China

gaoqiang@fudan.edu.cn


Any technical question please contact Yingcheng Wu (wuyc@usa.com).

Copyright (C) 2020-2021 Gao Lab @ Fudan University.






