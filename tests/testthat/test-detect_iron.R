library(nutricheckr)

#  Based on inflammation status defined by acute-phase protein
## Create testing data

### identify the inflammation status and perform ferritin value correction
inflam_crp_yes <- def_crp(6)
inflam_crp_no <- def_crp(5)
inflam_crp_na <- def_crp(NA)

### identify the inflammation status and perform ferritin value correction
inflam_agp_yes <- def_agp(1.5)
inflam_agp_no <- def_agp(1)
inflam_agp_na <- def_agp(NA)

### identify the inflammation status and perform ferritin value correction
inflam_all_incu <- detect_inflammation(6, 1)
inflam_all_late <- detect_inflammation(5, 1.5)
inflam_all_early <- detect_inflammation(6, 1.5)
inflam_all_no <- detect_inflammation(4, 1)
inflam_all_na1 <- detect_inflammation(NA, 2)
inflam_all_na2 <- detect_inflammation(1, NA)
inflam_all_na3 <- detect_inflammation(NA, NA)


## check for the output class
test_that("The output objects of individual inflammation detection function have correct variable types", {

  expect_type(inflam_crp_yes, "character")
  expect_type(inflam_crp_no, "character")

  expect_type(inflam_agp_yes, "character")
  expect_type(inflam_agp_no, "character")

  expect_type(inflam_all_incu, "character")
  expect_type(inflam_all_late, "character")
  expect_type(inflam_all_early, "character")
  expect_type(inflam_all_no, "character")

})

# check for the output result
test_that("Individual inflammation detection functions define anaema category correctly", {

  expect_equal(inflam_crp_yes, "inflammation")
  expect_equal(inflam_crp_no, "No Inflammation")
  expect_equal(is.na(inflam_crp_na), TRUE)

  expect_equal(inflam_agp_yes, "inflammation")
  expect_equal(inflam_agp_no, "No Inflammation")
  expect_equal(is.na(inflam_agp_na), TRUE)

  expect_equal(inflam_all_incu, "Incubation")
  expect_equal(inflam_all_late, "Late Convalescence")
  expect_equal(inflam_all_early, "Early Convalescence")
  expect_equal(inflam_all_no, "No Inflammation")

  expect_equal(is.na(inflam_all_na1), TRUE)
  expect_equal(is.na(inflam_all_na2), TRUE)
  expect_equal(is.na(inflam_all_na3), TRUE)

})


#  Ferritin Correction
## check for the output class

test_that("The output objects of ferritine correction function has correct variable types", {

  # correction with either CRP or AGP only
  expect_type(correct_ferritin_crp(30, "inflammation"), "double")
  expect_type(correct_ferritin_crp(30, "No Inflammation"), "double")
  expect_type(correct_ferritin_agp(30, "inflammation"), "double")
  expect_type(correct_ferritin_agp(30, "No Inflammation"), "double")

  # correction with both CRP and AGP
  expect_type(correct_ferritin(30, "No Inflammation"), "double")
  expect_type(correct_ferritin(30, "Incubation"), "double")
  expect_type(correct_ferritin(30, "Late Convalescence"), "double")
  expect_type(correct_ferritin(30, "Early Convalescence"), "double")

})

# check for the output result
test_that("iron deficiency detection function defines anaema category correctly", {

  # correction with either CRP or AGP only
  expect_equal(correct_ferritin_crp(30, "inflammation"), 30 * 0.65)
  expect_equal(correct_ferritin_crp(30, "No Inflammation"), 30)
  expect_equal(correct_ferritin_agp(30, "inflammation"), 30 * 0.72)
  expect_equal(correct_ferritin_agp(30, "No Inflammation"), 30)

  expect_equal(is.na(correct_ferritin_crp(30, NA)), TRUE)
  expect_equal(is.na(correct_ferritin_crp(NA, "inflammation")), TRUE)
  expect_equal(is.na(correct_ferritin_crp(NA, "No Inflammation")), TRUE)
  expect_equal(is.na(correct_ferritin_agp(30, NA)), TRUE)
  expect_equal(is.na(correct_ferritin_agp(NA, "inflammation")), TRUE)
  expect_equal(is.na(correct_ferritin_agp(NA, "No Inflammation")), TRUE)

  # correction with both CRP and AGP
  expect_equal(correct_ferritin(30, "No Inflammation"), 30)
  expect_equal(correct_ferritin(30, "Incubation"), 30 * 0.77)
  expect_equal(correct_ferritin(30, "Late Convalescence"), 30 * 0.53)
  expect_equal(correct_ferritin(30, "Early Convalescence"), 30 * 0.75)

  expect_equal(is.na(correct_ferritin(30, NA)), TRUE)
  expect_equal(is.na(correct_ferritin(NA, "No Inflammation")), TRUE)
  expect_equal(is.na(correct_ferritin(NA, "Incubation")), TRUE)
  expect_equal(is.na(correct_ferritin(NA, "Late Convalescence")), TRUE)
  expect_equal(is.na(correct_ferritin(NA, "Early Convalescence")), TRUE)

})



#  Iron storage status identification
## check for the output class
test_that("The output objects of iron deficiency detection function has correct variable types", {

  # for under 5 pop
  expect_type(detect_iron(12, "under 5 years"), "character")
  expect_type(detect_iron(12, "5 years and older"), "character")
  expect_type(detect_iron(11, "under 5 years"), "character")
  expect_type(detect_iron(11, "5 years and older"), "character")

  # for over 5 pop
  expect_type(detect_iron(15, "under 5 years"), "character")
  expect_type(detect_iron(15, "5 years and older"), "character")
  expect_type(detect_iron(14, "under 5 years"), "character")
  expect_type(detect_iron(14, "5 years and older"), "character")

})


# check for the output result
test_that("iron deficiency detection function defines anaema category correctly", {

  # for under 5 pop
  expect_equal(detect_iron(12, "under 5 years"), "no deficiency")
  expect_equal(detect_iron(12, "5 years and older"), "deficiency")
  expect_equal(detect_iron(11, "under 5 years"), "deficiency")
  expect_equal(detect_iron(11, "5 years and older"), "deficiency")
  expect_equal(is.na(detect_iron(12, NA)), TRUE)
  expect_equal(is.na(detect_iron(11, NA)), TRUE)
  expect_equal(is.na(detect_iron(NA, "under 5 years")), TRUE)
  expect_equal(is.na(detect_iron(NA, "5 years and older")), TRUE)

  # for over 5 pop
  expect_equal(detect_iron(15, "under 5 years"), "no deficiency")
  expect_equal(detect_iron(15, "5 years and older"), "no deficiency")
  expect_equal(detect_iron(14, "under 5 years"), "no deficiency")
  expect_equal(detect_iron(14, "5 years and older"), "deficiency")
  expect_equal(is.na(detect_iron(15, NA)), TRUE)
  expect_equal(is.na(detect_iron(14, NA)), TRUE)
  expect_equal(is.na(detect_iron(NA, "under 5 years")), TRUE)
  expect_equal(is.na(detect_iron(NA, "5 years and older")), TRUE)

})


## Based on the qualitative information of infection or inflammation
## check for the output class
test_that("The output objects of iron deficiency detection function has correct variable types", {

  expect_type(detect_iron_quali(30, 1), "character")
  expect_type(detect_iron_quali(30, 0), "character")
  expect_type(detect_iron_quali(29, 1), "character")
  expect_type(detect_iron_quali(29, 0), "character")

})

# check for the output result
test_that("iron deficiency detection function defines anaema category correctly", {

  expect_equal(detect_iron_quali(30, 1), "no deficiency")
  expect_equal(detect_iron_quali(30, 0), "no deficiency")
  expect_equal(detect_iron_quali(29, 1), "deficiency")
  expect_equal(detect_iron_quali(29, 0), "no deficiency")
  expect_equal(is.na(detect_iron_quali(29, NA)), TRUE)
  expect_equal(is.na(detect_iron_quali(30, NA)), TRUE)
  expect_equal(is.na(detect_iron_quali(NA, 1)), TRUE)
  expect_equal(is.na(detect_iron_quali(NA, 0)), TRUE)

})