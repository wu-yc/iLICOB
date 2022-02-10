#' Title
#'
#' @param input.gene The gene symbol
#' @param input.omics omics type, in c("RNA", "Protein", "CNV", "Methylation")
#' @param cor.method correlation type, in c("pearson", "spearman")
#'
#' @return The correlation value and P value of the input gene and drug responses (AUC value)
#' @export
#'
#' @examples cor_mat <- iLICOB_query("CD274", input.omics = "RNA", cor.method = "pearson")
iLICOB_query <- function(input.gene, input.omics = "RNA", cor.method = "pearson") {

  #cor.method  %in% c("pearson", "spearman")
  #input.omics %in% c("RNA", "Protein", "CNV", "Methylation")

  if (!cor.method %in% c(c("pearson", "spearman"))){
    cat("PLS check the cor.method\nQuit\n")
    return(NULL)
  }
  if (!input.omics %in% c("RNA", "Protein", "CNV", "Methylation")){
    cat("PLS check the input.omics\nQuit\n")
    return(NULL)
  }

  data_ilicob_org.dr <- system.file("data", "data_ilicob_org", package = "iLICOB")
  load(file = data_ilicob_org.dr)

  if (input.omics == "RNA") {omics_mat<-data_ilicob_org[[4]][[1]]}
  if (input.omics == "Protein") {omics_mat<-data_ilicob_org[[4]][[2]]}
  if (input.omics == "CNV") {omics_mat<-data_ilicob_org[[4]][[3]]}
  if (input.omics == "Methylation") {omics_mat<-data_ilicob_org[[4]][[4]]}
  org_drug<-data_ilicob_org[[4]][[6]]
  input.method = cor.method

  if (!input.gene %in% row.names(omics_mat)){
    cat("The input gene cannot be found\nQuit\n")
    return(NULL)
  }

  sample_intersect<-intersect(colnames(omics_mat), row.names(org_drug))
  cot_mat<-c()

  for (k in 1:length(colnames(org_drug))){
    rho.tmp <- cor.test(as.numeric(as.character(t(omics_mat[input.gene,sample_intersect]))), org_drug[sample_intersect,k], method = input.method)$estimate
    p.tmp <- cor.test(as.numeric(as.character(t(omics_mat[input.gene,sample_intersect]))), org_drug[sample_intersect,k], method = input.method)$p.value
    cot_mat<-rbind(cot_mat, c(rho.tmp, p.tmp))
  }
  cot_mat<-data.frame(cot_mat)
  row.names(cot_mat)<-colnames(org_drug); colnames(cot_mat)<-c("Correlation", "Pvalue")

  cot_mat
}
