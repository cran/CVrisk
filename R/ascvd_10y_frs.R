#' Framingham 2008 ASCVD risk score (with lab measurement)
#'
#' Computes 10-year risk for ASCVD event (coronary death, myocardial
#' infarction (MI), coronary insufficiency, angina, ischemic stroke,
#' hemorrhagic stroke, transient ischemic attack, peripheral artery disease,
#' or heart failure).
#'
#' @param gender patient gender (male, female)
#' @param age patient age (years), between 30 and 74
#' @param hdl HDL cholesterol (mg/dL)
#' @param totchol Total cholesterol (mg/dL)
#' @param sbp Systolic blood pressure (mm Hg)
#' @param bp_med Patient is on a blood pressure medication (1=Yes, 0=No)
#' @param smoker Current smoker (1=Yes, 0=No)
#' @param diabetes Diabetes (1=Yes, 0=No)
#' @param ... Additional predictors can be passed and will be ignored
#'
#' @return Estimated 10-Y Risk for hard ASCVD event (percent)
#'
#' @export
#'
#' @examples
#' library(CVrisk)
#' ascvd_10y_frs(
#'   gender = "male", age = 55,
#'   hdl = 50, totchol = 213, sbp = 140,
#'   bp_med = 0, smoker = 0, diabetes = 0
#' )
#'
#' # 16.7
#' @references
#' D’agostino, R.B., Vasan, R.S., Pencina, M.J., Wolf, P.A., Cobain, M.,
#' Massaro, J.M. and Kannel, W.B., 2008. General cardiovascular risk
#' profile for use in primary care: the Framingham Heart Study.
#' Circulation, 117(6), pp.743-753.

ascvd_10y_frs <- function(gender = c("male", "female"),
                          age, hdl, totchol, sbp,
                          bp_med, smoker, diabetes, ...) {
  gender <- tolower(gender)
  gender <- ifelse(gender == "m", "male", gender)
  gender <- ifelse(gender == "f", "female", gender)

  if (!all(gender %in% c("male", "female")) | missing(gender)) {
    stop("gender must be either 'male' or 'female'")
  }

  if (!is.numeric(age) | missing(age)) {
    stop("age must be a valid numeric value'")
  }

  age <- ifelse(age < 30 | age > 74, NA, age)

  if (missing(hdl)) {
    hdl <- NA
  }

  if (missing(totchol)) {
    totchol <- NA
  }

  if (missing(sbp)) {
    sbp <- NA
  }

  if (missing(bp_med)) {
    bp_med <- NA
  }

  if (missing(smoker)) {
    smoker <- NA
  }

  if (missing(diabetes)) {
    diabetes <- NA
  }

  # retrieve model coefficients
  frs_coef <- NULL
  utils::data(frs_coef, envir = environment())

  # Generate data.frame of coefficients based on input `gender` vector.
  # We lose the original order after the merge operation, so will need
  # to re-sort the output based on the original order of `sex_df`.
  sex_df <- data.frame(gender)
  sex_df$id <- as.numeric(row.names(sex_df))

  model_coef <- merge(sex_df, frs_coef)
  model_coef <- model_coef[order(model_coef$id), ]

  sbp_treated <- ifelse(bp_med == 1, sbp, 1)
  sbp_untreated <- ifelse(bp_med == 0, sbp, 1)

  indv_sum <- log(age) * model_coef$ln_age +
    log(hdl) * model_coef$ln_hdl +
    log(totchol) * model_coef$ln_totchol +
    log(sbp_treated) * model_coef$ln_treated_sbp +
    log(sbp_untreated) * model_coef$ln_untreated_sbp +
    smoker * model_coef$smoker +
    diabetes * model_coef$diabetes

  risk_score <- round((1 - (model_coef$baseline_survival^
    exp(indv_sum - model_coef$group_mean))) * 100.000, 2)

  #ifelse(risk_score < 1, 1, ifelse(risk_score > 30, 30, risk_score))
  
    ifelse(risk_score < 1, 1, risk_score)
}
