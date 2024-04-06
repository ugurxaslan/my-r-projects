library(testthat)
#ön hazırlık
#2.1 bu dosyayı oluşturdum
#2.2
rm(list = ls())
if (file.exists("MapsThatChangedOurWorld_StoryMap_Data.csv")) {
  file.remove("MapsThatChangedOurWorld_StoryMap_Data.csv")
}
# 2.3 
source("Labex1_Q1_210401057_ugur_aslan.R")
#1.1 testleri
# 2.4
test_that("MapsThatChangedOurWorld_StoryMap_Data.csv dosyası mevcut", {
  testthat::expect_true(file.exists("MapsThatChangedOurWorld_StoryMap_Data.csv"))
})
#1.2 testleri
# 2.5
test_that("maps adlı değiken Global Workspace’de mevcuttur", {
  testthat::expect_true(exists("maps"))
})
# 2.6
test_that("maps nesnesi bir data.frame’dir", {
  testthat::expect_true(is.data.frame(maps))
})
#2.7
test_that("maps adlı data.frame’in ilk sütunun adı “City” olmalıdır",{
  testthat::expect_equal(names(maps)[1], "City")
})
#2.8
test_that("maps adlı data.frame’in 5. sütunun adında “Title” kelimesi geçmelidir.",{
  testthat::expect_true(grepl("Title",names(maps)[5]))
})
#1.3 testleri
#2.9
test_that("Latitude adlı sütün numeric değerlerden oluşmalıdır.",{
  testthat::expect_true(all(is.numeric(maps$Latitude)))
})
#1.4 testleri
#2.11
test_that("idx nesnesi Global Workspace’de mevcuttur",{
  testthat::expect_true(exists("idx"))
})
#2.12
test_that("idx nesnesinin tipi (class’ı) integer’dir.",{
  testthat::expect_true(is.integer(idx))
})
#1.5 testleri
#2.13
test_that("Longitude adlı sütün numeric değerlerden oluşmalıdır.",{
  testthat::expect_true(all(is.numeric(maps$Longitude)))
})
#1.6 testleri
##2.13
test_that("Year adlı adlı sütün numeric değerlerden oluşmalıdır.",{
  testthat::expect_true(all(is.numeric(maps$Year)))
})
#1.7 testleri
#bunla ilgili testler tamamlanmıştır sırası karışık verilmiş hoca tarafından
#2.9
test_that("Latitude adlı sütün numeric değerlerden oluşmalıdır.",{
  testthat::expect_true(all(is.numeric(maps$Latitude)))
})
#2.13
test_that("Longitude adlı sütün numeric değerlerden oluşmalıdır.",{
  testthat::expect_true(all(is.numeric(maps$Longitude)))
})
#1.8 testleri
#bunla ilgili test yoktur 
#1.9 testleri
#2.14
test_that("BONUS Longitude adlı sütunun 3.,  9. ve 10. elementleri negatif 
          numeric değerler içermelidir",{
  selected_elements <- maps$Longitude[c(3, 9, 10)]
  testthat::expect_true(all(selected_elements < 0))
  testthat::expect_true(all(is.numeric(selected_elements)))
})
#1.10 testleri
#2.15
test_that("finalResult değişkeni var mı?", {
  expect_true(exists("finalResult"))
})
test_that("finalResult bir data.frame mi?", {
  expect_true(is.data.frame(finalResult))
})
test_that("finalResult 3 sütundan oluşmalı", {
  expect_equal(ncol(finalResult), 3)
})
test_that("finalResult'ın sütun isimleri doğru mu?", {
  expect_identical(colnames(finalResult), c("Longitude", "Latitude", "Year"))
})