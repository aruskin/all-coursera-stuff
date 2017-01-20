download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
              destfile = "emissions.zip", method = "curl")
unzip("emissions.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


library(dplyr)
by_year <- group_by(NEI, year) %>% summarise(Total.Emissions = sum(Emissions))
png("plot1.png")
plot(by_year$year, by_year$Total.Emissions, type="b",
     xlab="Year", ylab="Total Emissions",
     main="Total PM2.5 emissions from all sources")
dev.off()
