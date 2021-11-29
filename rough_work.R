#final proj rough work
```{r}
df1$pgrp<-cut(df1$points,c(80,87,93,100),labels = c('low','medium','high'))
pvc <- table(data.frame(df1$country,df1$pgrp))
pvc <- addmargins(pvc)
pvcH <- data.frame(pvc[,'high']/pvc[,'Sum'])
pvcH$country<-rownames(pvcH)
colnames(pvcH)[1] <- "highPerc"

library(maps)
library(gapminder)
library(countrycode)
#library(countrycode,lib.loc = "/home/neilfa/R/x86_64-pc-linux-gnu-library/4.1")
world_map <- map_data("world")
wine_map <- left_join(pvcH, mosaicData::Countries, 
                      by = c("country" = "gapminder"))
wine_map <- left_join(wine_map, world_map, by = c("maps" = "region"))

as.factor(wine_map$country) %>% levels()
ggplot(wine_map, aes(x = long, y = lat, group = group)) +
  geom_polygon(aes(fill = highPerc), color = "white") +
  scale_fill_viridis_c(option = "C")

#--------
pG <- ggplot(wdsG[1:100,],
             aes(label=wG,color = factor(sample.int(10, 100, replace = TRUE)),size=Freq))+
  geom_text_wordcloud() +
  labs(title = "Word Cloud for Best")+
  theme_minimal()

pB <- ggplot(wdsB[1:100,],
             aes(label=wB,color = factor(sample.int(10, 100, replace = TRUE)),size=Freq))+
  geom_text_wordcloud() +
  labs(title = "Word Cloud for Worst")+
  theme_minimal()  