download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
              destfile = "emissions.zip", method = "curl")
unzip("emissions.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


library(dplyr)
library(ggplot2)
join_sources <- left_join(NEI, SCC, by=c("SCC"))

# Get all rows with motor vehicle related sources
mv_rows <- join_sources$Short.Name %>% 
  as.character(.) %>%
  grep("Motor Vehicle", .)
join_sources <- join_sources[mv_rows,]

# Filter by Baltimore and LA and group by year
join_sources <- filter(join_sources, fips %in% c("24510", "06037")) %>%
  group_by(year, fips) %>% 
  summarise(Total.Emissions = sum(Emissions))

png("plot6.png")

ggplot(join_sources, aes(x=year, y=Total.Emissions, group = fips, col = fips)) +
  geom_line() +
  geom_point() +
  scale_color_discrete(breaks=c("24510", "06037"), 
                       labels=c("Baltimore City", "Los Angeles County"))+
  labs(title="PM2.5 emissions from motor vehicle sources", 
       x = "Year", 
       y = "Total Emissions",
       colour = "Location")

dev.off()
