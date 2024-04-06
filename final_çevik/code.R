library(readr)
library(dplyr)
library(ggplot2)

#googleplaystore.csv dosyasının çalışma dizinide mevcut olması gerekir.
dosya_yolu <- "googleplaystore.csv"
veri <- data.frame(read.csv(dosya_yolu))

veri_temizlenmis <- na.omit(veri)
veri_temizlenmis <- veri_temizlenmis[, c("Category", "Installs","Rating")]
veri_temizlenmis <- subset(veri_temizlenmis, Rating >= 1 & Rating <= 5)
veri_temizlenmis$Installs <- as.numeric(gsub("[+,]", "", veri_temizlenmis$Installs))


veri_filtreli <- subset(veri_temizlenmis, Rating >= 4 & Rating <= 5)
veri_filtreli <- subset(veri_filtreli, Installs > 1000000)
veri_filtreli <- data.frame(veri_filtreli)
gruplu_veri_installs <- aggregate(Installs ~ Category, data = veri_filtreli, 
                                  FUN = function(x) c(Toplam_Indirme = sum(x)/1000000,
                                                      Tum_Indirme_Orani = round(100 * sum(x) / sum(veri_filtreli$Installs), 2)))
gruplu_veri_rating <- aggregate(Rating ~ Category, data = veri_filtreli, 
                                FUN = function(x) c(Ortalama_Rating = round(mean(x),2)))
gruplu_veri_sayilar <- aggregate(Rating ~ Category, data = veri_filtreli, FUN = length)
colnames(gruplu_veri_sayilar)[2] <- "Count"
gruplu_veri <- merge(gruplu_veri_installs, gruplu_veri_rating, by = "Category")
gruplu_veri <- merge(gruplu_veri, gruplu_veri_sayilar, by = "Category")
gruplu_veri$Market_Share<-gruplu_veri$Installs[,2]
gruplu_veri$Installs<-gruplu_veri$Installs[,1]
names(gruplu_veri)[names(gruplu_veri) == "Installs"] <- "Installs_Million"
gruplu_veri$Market_Share_per_App <- round(gruplu_veri$Market_Share/gruplu_veri$Count,2)
rm(gruplu_veri_installs,gruplu_veri_rating,gruplu_veri_sayilar,veri,dosya_yolu)


temp<-gruplu_veri
temp$Category <- ifelse(temp$Market_Share < 5, "Other",temp$Category)
temp <- aggregate(Market_Share ~ Category, data = temp, 
                  FUN = function(x) sum(x))
temp<-temp[order(temp$Market_Share, decreasing = TRUE), ]
temp$Market_Share <- temp$Market_Share / sum(temp$Market_Share) * 100
pasta_grafigi <- pie(temp$Market_Share, labels = sprintf("%s %.1f%%", temp$Category, temp$Market_Share),cex = 0.8, col = rainbow(length(temp$Category)))
title("Kategorilerin Pazar Payıları")


temp <- gruplu_veri %>%
  arrange(desc(Market_Share_per_App))
temp <- head(temp, 10)
par(mar = c(7, 5, 2, 2) + 0.1)  # Alt, üst, sol, sağ marjları ayarla
barplot(height = temp$Market_Share_per_App,
        names.arg = temp$Category,
        main = "İlk 10 Kategorinin Uygulama Başına Pazar Payı",
        ylab = "Pazar Payı (%)",
        col = "pink",
        horiz = FALSE,
        ylim = c(0, 0.15),
        cex.names = 0.6,
        las = 2) 