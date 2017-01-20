download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
              destfile = "emissions.zip", method = "curl")
unzip("emissions.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


library(dplyr)
library(ggplot2)
by_type_bmore <- filter(NEI, fips == "24510") %>%
  group_by(year, type) %>% 
  summarise(Total.Emissions = sum(Emissions))

png("plot3.png")

ggplot(by_type_bmore, aes(x=year, y=Total.Emissions, group = type, col=type)) +
  geom_line() +
  geom_point() +
  labs(title="PM2.5 emissions in Baltimore", x = "Year", 
        y = "Total Emissions")

dev.off()
