#' ACC/AHA 2013 ASCVD risk score
#'
#' Computes 10-year risk for hard ASCVD event (defined as first occurrence of
#' non-fatal myocardial infarction (MI), congestive heart disease (CHD) death,
#' or fatal or nonfatal stroke).
#'
#' @param race patient race (white, aa, other)
#' @param gender patient gender (male, female)
#' @param age patient age (years)
#' @param totchol Total cholesterol (mg/dL)
#' @param hdl HDL cholesterol (mg/dL)
#' @param sbp Systolic blood pressure (mm Hg)
#' @param bp_med Patient is on a blood pressure medication (1=Yes, 0=No)
#' @param smoker Current smoker (1=Yes, 0=No)
#' @param diabetes Diabetes (1=Yes, 0=No)
#' @param ... Additional predictors can be passed and will be ignored
#'
#'
#' @return Estimated 10-Y Risk for hard ASCVD (percent)
#'
#' @export
#'
#' @examples
#' library(CVrisk)
#' ascvd_10y_accaha(
#'   race = "aa", gender = "male", age = 55,
#'   totchol = 213, hdl = 50, sbp = 140,
#'   bp_med = 0, smoker = 0, diabetes = 0
#' )
#' @references
#' Goff, David C., et al. "2013 ACC/AHA guideline on the assessment of
#' cardiovascular risk: a report of the American College of
#' Cardiology/American Heart Association Task Force on Practice
#' Guidelines." Journal of the American College of Cardiology 63.25
#' Part B (2014): 2935-2959.

ascvd_10y_accaha <- function(race = "white", gender = c("male", "female"),
                             age, totchol, hdl, sbp,
                             bp_med, smoker, diabetes, ...) {

  if (!all(gender %in% c("male", "female")) | missing(gender)) {
    stop("gender must be either 'male' or 'female'")
  }

  age <- ifelse(!is.numeric(age) |
      age < 20 | age > 79 | missing(age), NA, age)

  totchol <- ifelse(!is.numeric(totchol) |
      totchol < 130 | totchol > 320 | missing(totchol), NA, totchol)

  hdl <- ifelse(!is.numeric(hdl) |
                   hdl < 20 | hdl > 100 | missing(hdl), NA, hdl)

  sbp <- ifelse(!is.numeric(sbp) |
                   sbp < 90 | sbp > 200 | missing(sbp), NA, sbp)


  ascvd_pooled_coef <- NULL
  utils::data(ascvd_pooled_coef, envir = environment())

  # Generate data.frame of coefficients based on input `race` and `gender`
  # vectors. We lose the original order after the merge operation, so will
  # need to re-sort the output based on the original order of `race_sex`.

  race <- ifelse(race %in% c("white", "aa"), race, "white")

  race_sex <- data.frame(race, gender)
  race_sex$id <- as.numeric(row.names(race_sex))

  pooled_coef <- merge(race_sex, ascvd_pooled_coef)
  pooled_coef <- pooled_coef[order(pooled_coef$id), ]

  sbp_treated <- ifelse(bp_med == 1, sbp, 1)
  sbp_untreated <- ifelse(bp_med == 0, sbp, 1)

  indv_sum <- log(age) * pooled_coef$ln_age +
    log(age)^2 * pooled_coef$ln_age_squared +
    log(totchol) * pooled_coef$ln_totchol +
    log(age) * log(totchol) * pooled_coef$ln_age_totchol +
    log(hdl) * pooled_coef$ln_hdl +
    log(age) * log(hdl) * pooled_coef$ln_age_hdl +
    log(sbp_treated) * pooled_coef$ln_treated_sbp +
    log(sbp_treated) * log(age) * pooled_coef$ln_age_treated_sbp +
    log(sbp_untreated) * pooled_coef$ln_untreated_sbp +
    log(sbp_untreated) * log(age) * pooled_coef$ln_age_untreated_sbp +
    smoker * pooled_coef$smoker +
    smoker * log(age) * pooled_coef$ln_age_smoker +
    diabetes * pooled_coef$diabetes

  risk_score <- round((1 - (pooled_coef$baseline_survival^
    exp(indv_sum - pooled_coef$group_mean))) * 100.000, 2)

  ifelse(risk_score < 1, 1, risk_score)

}
