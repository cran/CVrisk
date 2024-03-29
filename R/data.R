#' Sample patient data
#'
#' A data set containing sample patient data
#'
#'
#' @format A data frame with 3 obs. and 10 variables:
#' \describe{
#'   \item{age}{age in years}
#'   \item{gender}{Patient gender}
#'   \item{race}{race}
#'   \item{BMI}{Body mass index (kg/m2)}
#'   \item{sbp}{systolic blood pressure}
#'   \item{hdl}{HDL}
#'   \item{totchol}{Total cholesterol}
#'   \item{bp_med}{Patient is on blood pressure medication}
#'   \item{smoker}{Smoking status}
#'   \item{diabetes}{Diabetes status}
#'   \item{lipid_med}{Patient is on hyperlipidemic medication}
#'   \item{fh_heartattack}{Family history of heart attack}
#'   \item{cac}{Coronary artery calcification score}
#' }
"sample_data"


#' Model coefficients for ASCVD 10y FRS model
#'
#' A data set containing the Framingham risk score coefficients (full model
#' with lab features)
#'
#'
#' @format A data frame with 2 obs. and 10 variables:
#' \describe{
#'   \item{gender}{Patient gender, either female or male}
#'   \item{ln_age}{Natural log of patient age}
#'   \item{ln_totchol}{Natural log of total cholesterol level}
#'   \item{ln_hdl}{Natural log of HDL level}
#'   \item{ln_untreated_sbp}{Natural log of untreated systolic blood pressure}
#'   \item{ln_treated_sbp}{Natural log of treated systolic blood pressure}
#'   \item{smoker}{Smoking status}
#'   \item{diabetes}{Diabetes status}
#'   \item{group_mean}{Grouped mean}
#'   \item{baseline_survival}{Baseline survival}
#' }
#'
#' @references
#' D’agostino, R.B., Vasan, R.S., Pencina, M.J., Wolf, P.A., Cobain, M.,
#' Massaro, J.M. and Kannel, W.B., 2008. General cardiovascular risk
#' profile for use in primary care. Circulation, 117(6), pp.743-753.
"frs_coef"

#' Model coefficients for ASCVD 10y FRS simple model
#'
#' A data set containing the Framingham risk score coefficients (simple model
#' without lab features)
#'
#'
#' @format A data frame with 2 obs. and 10 variables:
#' \describe{
#'   \item{gender}{Patient gender, either female or male}
#'   \item{ln_age}{Natural log of patient age (years)}
#'   \item{ln_bmi}{Natural log of body mass index kg/m2}
#'   \item{ln_untreated_sbp}{Natural log of untreated systolic blood pressure}
#'   \item{ln_treated_sbp}{Natural log of treated systolic blood pressure}
#'   \item{smoker}{Smoking status}
#'   \item{diabetes}{Diabetes status}
#'   \item{group_mean}{Grouped mean}
#'   \item{baseline_survival}{Baseline survival}
#' }
#'
#' @references
#' D’agostino, R.B., Vasan, R.S., Pencina, M.J., Wolf, P.A., Cobain, M.,
#' Massaro, J.M. and Kannel, W.B., 2008. General cardiovascular risk
#' profile for use in primary care. Circulation, 117(6), pp.743-753.
"frs_simple_coef"


#' Model coefficients for ASCVD 10y ACC/AHA model
#'
#' A data set containing the 2013 ACC/AHA ASCVD 10-year risk pooled cohort
#' coefficients
#'
#'
#' @format A data frame with 4 obs. and 17 variables:
#' \describe{
#'   \item{race}{Patient race, either white or aa}
#'   \item{gender}{Patient gender, either female or male}
#'   \item{ln_age}{Natural log of patient age}
#'   \item{ln_age_squared}{Natural log of patient age in years, squared}
#'   \item{ln_totchol}{Natural log of total cholesterol level}
#'   \item{ln_age_totchol}{Natural log of combined age and total cholesterol}
#'   \item{ln_hdl}{Natural log of HDL level}
#'   \item{ln_age_hdl}{Natural log of HDL and age}
#'   \item{ln_treated_sbp}{Natural log of treated systolic blood pressure}
#'   \item{ln_age_treated_sbp}{Natural log of treated systolic blood pressure
#'    and age}
#'   \item{ln_untreated_sbp}{Natural log of untreated systolic blood pressure}
#'   \item{ln_age_untreated_sbp}{Natural log of untreated systolic blood
#'    pressure and age}
#'   \item{smoker}{Smoking status}
#'   \item{ln_age_smoker}{Natural log of smoking status and age}
#'   \item{diabetes}{Diabetes status}
#'   \item{group_mean}{Grouped mean}
#'   \item{baseline_survival}{Baseline survival}
#' }
#'
#' @references
#' Goff, David C., et al. "2013 ACC/AHA guideline on the assessment of
#' cardiovascular risk: a report of the American College of
#' Cardiology/American Heart Association Task Force on Practice
#' Guidelines." Journal of the American College of Cardiology 63.25
#' Part B (2014): 2935-2959.
"ascvd_pooled_coef"
