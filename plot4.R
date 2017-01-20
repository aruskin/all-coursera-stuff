download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
              destfile = "emissions.zip", method = "curl")
unzip("emissions.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


library(dplyr)
library(ggplot2)
join_sources <- left_join(NEI, SCC, by=c("SCC"))

# Get all rows with combustion related sources
combustion_rows_1 <- join_sources$SCC.Level.One %>% 
  as.character(.) %>%
  grep("Combustion", .)
combustion_rows_2 <- join_sources$SCC.Level.Two %>% 
  as.character(.) %>%
  grep("Combustion", .)
join_sources <- join_sources[c(combustion_rows_1, combustion_rows_2),]

# Get all rows with coal related sources
coal_rows_1 <- join_sources$SCC.Level.Three %>% 
  as.character(.) %>%
  grep("Coal", .)
coal_rows_2 <- join_sources$SCC.Level.Four %>% 
  as.character(.) %>%
  grep("Coal", .)
join_sources <- join_sources[c(coal_rows_1, coal_rows_2),]

# Group by year
join_sources <- group_by(join_sources, year) %>% 
  summarise(Total.Emissions = sum(Emissions))

png("plot4.png")

ggplot(join_sources, aes(x=year, y=Total.Emissions)) +
  geom_line() +
  geom_point() +
  labs(title="PM2.5 emissions from coal combustion-related sources", 
       x = "Year", 
       y = "Total Emissions")

dev.off()
