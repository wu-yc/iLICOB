#' Title
#'
#' @param input.mat The data.frame object of omics profile
#' @param input.type data type, in c("Tissue", "Organoid")
#' @param input.omics omics type, in c("RNA", "Protein", "CNV", "Methylation", "Mutation")
#'
#' @return Predicted matrix of AUC (drug response)
#' @export
#'
#' @examples AUC_mat <- iLICOB_predict(input.mat, input.type = "Tissue", input.omics = "RNA")
#'
iLICOB_predict <- function(input.mat, input.type = "Tissue", input.omics = "RNA") {



  #input.type  %in% c("Tissue", "Organoid")
  #input.omics %in% c("RNA", "Protein", "CNV", "Methylation", "Mutation")

  if (!input.type %in% c("Tissue", "Organoid")){
    cat("PLS check the input.type...\nQuit\n")
    return(NULL)
  }
  if (!input.omics %in% c("RNA", "Protein", "CNV", "Methylation", "Mutation")){
    cat("PLS check the input.omics\nQuit\n")
    return(NULL)
  }

  #load data
  # load(file = "/srv/shiny-server/LICOB/data/ML_model/data_ilicob_org")
  # load(file = "/srv/shiny-server/LICOB/data/ML_model/data_ilicob_tissue")

  data_ilicob_org.dr <- system.file("data", "data_ilicob_org", package = "iLICOB")
  load(file = data_ilicob_org.dr)
  data_ilicob_tissue.dr <- system.file("data", "data_ilicob_tissue", package = "iLICOB")
  load(file = data_ilicob_tissue.dr)

  drug.names<-data_ilicob_org[[5]]

  #prediction
  if (input.type == "Tissue"){
    # input.mat<-data_ilicob_tissue[[3]]
    data_input<-input.mat
    regr_enet_list_ref<-data_ilicob_tissue[[1]]
    input.features<-data_ilicob_tissue[[2]]

    data_feedin<-data_input[input.features,]
    data_feedin[is.na(data_feedin)]<-0
    row.names(data_feedin)<-input.features

    pred.test_result<-c()
    for (k in 1:length(drug.names)){
      pred.test_result <- cbind(pred.test_result, predict(regr_enet_list_ref[[k]], t(data_feedin)))
    }
    pred.test_result<-data.frame(pred.test_result)
    colnames(pred.test_result)<-drug.names
  }

  if (input.type == "Organoid"){
    # input.mat<-data_ilicob_org[[3]][[1]]
    data_input<-input.mat
    regr_enet_list_list<-data_ilicob_org[[1]]
    input.features<-data_ilicob_org[[2]]

    #"RNA", "Protein", "CNV", "Methylation", "Mutation"
    if (input.omics == "RNA") {regr_enet_list_ref<-regr_enet_list_list[[1]]; input.features<-input.features[[1]]}
    if (input.omics == "Protein") {regr_enet_list_ref<-regr_enet_list_list[[2]]; input.features<-input.features[[2]]}
    if (input.omics == "CNV") {regr_enet_list_ref<-regr_enet_list_list[[3]]; input.features<-input.features[[3]]}
    if (input.omics == "Methylation") {regr_enet_list_ref<-regr_enet_list_list[[4]]; input.features<-input.features[[4]]}
    if (input.omics == "Mutation") {regr_enet_list_ref<-regr_enet_list_list[[5]]; input.features<-input.features[[5]]}


    data_feedin<-data_input[input.features,]
    data_feedin[is.na(data_feedin)]<-0
    row.names(data_feedin)<-input.features


    pred.test_result<-c()
    for (k in 1:length(drug.names)){
      pred.test_result <- cbind(pred.test_result, predict(regr_enet_list_ref[[k]], t(data_feedin)))
    }
    pred.test_result<-data.frame(pred.test_result)
    colnames(pred.test_result)<-drug.names


  }

  pred.test_result

}
