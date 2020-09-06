download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
              destfile = "emissions.zip", method = "curl")
unzip("emissions.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)
by_year_bmore <- filter(NEI, fips == "24510") %>%
  group_by(year) %>% 
  summarise(Total.Emissions = sum(Emissions))

png("plot2.png")
plot(by_year_bmore$year, by_year_bmore$Total.Emissions, type="b",
     xlab="Year", ylab="Total Emissions",
     main="Total PM2.5 emissions in Baltimore")
dev.off()
