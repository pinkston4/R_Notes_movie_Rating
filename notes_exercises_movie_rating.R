#class notes/exericise

library(ggplot2)

#setting working directory
setwd("/Users/johnpinkston/workspace/R_programming/movie_rating")

#the data layer
movie_data <- read.csv("Movie-Ratings.csv")
colnames(movie_data) <- c("Movie", "Genre", "Critic.Rating", "Audience.Rating",
                          "Budget.In.Millions", "Year.Released")

#converting numeric variable year to factor
movie_data$Year.Released <- factor(movie_data$Year.Released)
str(movie_data)

#the aiesthetic and geometry
p <- ggplot(data=movie_data, aes(x=Critic.Rating, y=Audience.Rating, 
                            colour=Genre, size=Budget.In.Millions))

p + geom_point()

#overiding aiesthetics (not altering object itself, just the instance)
q <- ggplot(data=movie_data, aes(x=Audience.Rating, y=Critic.Rating, 
                                 colour=Genre, size=Budget.In.Millions))

q + geom_point(aes(size=Critic.Rating))
q + geom_point(aes(colour=Budget.In.Millions))
q + geom_point(aes(x=Budget.In.Millions, size=Audience.Rating, alpha=0.5)) +
  xlab("Budget in Millions")

#MAPPING VS SETTING

#example 1
r <- ggplot(data=movie_data, aes(x=Critic.Rating, y=Audience.Rating))
#1. adding color with mapping
r + geom_point(aes(colour=Genre))
#2 adding color with setting
r + geom_point(colour="DarkGreen")
#NOTE: ERROR:
# r + geom_point(aes(colour="DarkGreen")) 
#this would not work, when mapping you target something and it styles that variable or factor accourdingly
#setting implies that you are not mapping to a desired factor or variable but rather are setting that style
#for the points themselves as a whole

#example 2
#mapping 
r + geom_point(aes(size=Budget.In.Millions))
#setting
r + geom_point(size=10)
#NOTE: ERROR:
# r + geom_point(aes(size=10))
#this would not work appropriately, it would try to map to 10, it would create a legend, all points would be
#the same size

#HISTOGRAMS AND DENSITY CHARTS

#histograms
s <-  ggplot(data=movie_data, aes(x=Budget.In.Millions))
s + geom_histogram(binwidth=10)
#add color
s + geom_histogram(binwidth=10, aes(fill=Genre))
#add a border
s + geom_histogram(binwidth=10, aes(fill=Genre), colour="Black")

#density charts
s + geom_density(aes(fill=Genre))
s + geom_density(aes(fill=Genre), position="stack")

#LAYERTIPS
t <- ggplot(data=movie_data, aes(x=Audience.Rating))
t + geom_histogram(binwidth=10, fill='White', colour = "Blue")
#another way/ now overwriting audience with critic
#note how audience is more normally distributed
#note how critic is more uniformally distributed
t <- ggplot(data=movie_data)
t + geom_histogram(binwidth=10, 
                   aes(x=Critic.Rating),
                   fill="White", colour="blue")

#the skeleton approach
#when you want to create a plot out of different data sets
t <- ggplot()

#statistical transformations
u <- ggplot(data=movie_data, aes(x=Critic.Rating, y=Audience.Rating, colour=Genre))
u + geom_point() + geom_smooth(fill=NA)

#boxplots
d <- ggplot(data=movie_data, aes(x=Genre, y=Audience.Rating, colour=Genre))
d + geom_boxplot(size=1.2) + geom_point()
#tip/hack for visual
d + geom_boxplot(size=1.2) + geom_jitter()
#anotherway
d + geom_jitter() + geom_boxplot(size=1.2, alpha=0.5)
#now for critic
z <- ggplot(data=movie_data, aes(x=Genre, y=Critic.Rating, colour=Genre))
z + geom_jitter() + geom_boxplot(size=1.2, alpha=0.5)

#FACETS
v <- ggplot(data=movie_data, aes(x=Budget.In.Millions))
v + geom_histogram(binwidth=10, aes(fill=Genre),
                   colour="Black")
#facet
v + geom_histogram(binwidth=10, aes(fill=Genre),
                   colour="Black") +
  facet_grid(Genre~., scales="free")
#scatterplot facets
w <- ggplot(data=movie_data, aes(x=Critic.Rating, y=Audience.Rating, colour=Genre))
w + geom_point(size=3) +
  facet_grid(Genre~.)
#by year
w + geom_point(size=3) +
  facet_grid(.~Year.Released)
#
w + geom_point(size=3) +
  geom_smooth() +
  facet_grid(Genre~Year.Released)
#
w + geom_point(aes(size=Budget.In.Millions)) +
  geom_smooth() +
  facet_grid(Genre~Year.Released)

#LIMITS AND ZOOMING
m <- ggplot(data=movie_data, aes(x=Critic.Rating, y=Audience.Rating,
                                 Budget.In.Millions, colour=Genre))
m + geom_point() + 
  xlim(50, 100) +
  ylim(50, 100)
#wont work well always
#doesnt just zoom in but cuts off the data, squeying results if not careful

#instead zoom
n <- ggplot(data=movie_data, aes(x=Budget.In.Millions))
n + geom_histogram(binwidth=10, aes(fill=Genre), colour="Black") +
  coord_cartesian(ylim=c(0,50))

#cleaning up W
w + geom_point(aes(size=Budget.In.Millions)) +
  geom_smooth() +
  facet_grid(Genre~Year.Released) +
  coord_cartesian(ylim=c(0, 100))






