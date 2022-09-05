library(ggcorrplot)
library(GGally)
library(tidyverse)
library(skimr)
library(ggpubr)
###############
# PART 1: LOADING AND CHECKING DATA
###############
#load tidyverse and the data
phone <-read.csv("dataset.csv")
phone

#Check dataset
skim(phone)
#From skim we see no missing value in this dataset, as well as outliers in 'Time owned current phone'

#Remove outliners, keep the 99.9% quantile (1 record removed)
phone <- phone%>%
    filter(Time.owned.current.phone < quantile(Time.owned.current.phone,0.999))
skim(phone)


###############
# Categorical variable distribution 
###############

#Barchart - exploring gender
#Number of male is around 1/2 of the number of female
ggplot(phone, aes(Gender, fill = Gender)) +
    geom_bar() +
    theme(legend.position = c(0.9, 0.8))+
    labs(title = "Distribution of Gender")+
    coord_flip()

#Barchart - exploring smartphone
#iPhone generally has a higher usage
ggplot(phone, aes(Smartphone, fill = Smartphone)) +
    geom_bar() +
    theme(legend.position = c(0.9, 0.2))+
    labs(title = "Distribution of Smartphone")+
    coord_flip()


###############
# Exploring age group
###############

#Explore the age group among smartphone users
#Age of 18,19,20,21 are the majority of smartphone users
agegroup<- phone %>% group_by(Age) %>% summarise(n=n())
#Histogram
ggplot(phone, aes(Age)) +
    geom_histogram(fill = "mediumorchid3", color="black", bins = 60)+
    labs(title = "Distribution of Age")

#Boxplot to see which age grp tends to have which operation system
#50% of iphone users aged from 20 to 30, with mean around 22
#50% of Android users aged from 20 to 40, with mean around 27
ggplot(phone, aes(x=Age, y=Smartphone, fill = Smartphone)) +
    geom_boxplot()



###############
# Exploring age group with gender
###############

#How about adding the insight of gender?
#Group the data by Smartphone type and Gender
user_gender<- phone%>%
    group_by(Smartphone, Gender)%>%
    summarise(Age)

#Surprisingly, female iPhone users tends to be younger among all groups 
#(iPhone 50% 19-27) (Android 50% 19 - 41)
#Male has similar interest in iPhone and Android with 50% of their age ranged from 20-38
ggplot(user_gender, aes(x=Age, y=Smartphone, fill = Gender)) +
    geom_boxplot() +
    facet_wrap(~Gender)+
    coord_flip()+
    theme_bw()


###############
# Exploring personality
###############
#Make the dataset long by gather()
phone_long <- phone %>%
    gather(Personality, Value, Honesty.Humility:Openness)

#Histogram and faceting with personality 
ggplot(phone_long) +
    geom_histogram(aes(x = Value), fill = "lightblue", color=1, bins = 20) +
    geom_density(aes(x = Value, y=0.25*..count..), colour="red", adjust=4)+
    facet_wrap( ~ Personality) +
    theme_bw()+
    labs(y = "count", title = "Historgrams of 6 personality variables")+
    theme(plot.title = element_text(hjust = 0.5))


###############
# Exploring personalities within each Smartphone group
###############

#6 personalities within one boxplot
phone_long %>%
    ggplot(aes(reorder(Personality, Value), Value, fill = Smartphone)) +
    geom_boxplot()+
    coord_flip() +
    theme_bw(base_size =10) +
    geom_hline(yintercept = 3, linetype=2)+
    labs(x = "Personality", title = "6 personality variables VS Smartphone OS")+
    theme(plot.title = element_text(hjust = 0.5))

#One numerical across another category
#Violin plot
ps1<- ggplot(phone, aes(x=Honesty.Humility, y=Smartphone, fill = Smartphone)) +
    geom_violin(trim = FALSE)+
    geom_boxplot(width = 0.3, fill = "white") +
    #facet_wrap(~Gender)+
    labs(y=NULL, x = "Honesty-Humility")+
    coord_flip()+
    scale_fill_brewer(palette="Dark2") + 
    theme_minimal()+
    theme(legend.position = "none")

ps2<- ggplot(phone, aes(x=Emotionality, y=Smartphone, fill = Smartphone)) +
    geom_violin(trim = FALSE)+
    geom_boxplot(width = 0.3, fill = "white") +
    #facet_wrap(~Gender)+
    labs(y=NULL)+
    coord_flip()+
    scale_fill_brewer(palette="Dark2") + 
    theme_minimal()+
    theme(legend.position = "none")


ps3<- ggplot(phone, aes(x=Extraversion, y=Smartphone, fill = Smartphone)) +
    geom_violin(trim = FALSE)+
    geom_boxplot(width = 0.3, fill = "white") +
    #facet_wrap(~Gender)+
    labs(y=NULL)+
    coord_flip()+
    scale_fill_brewer(palette="Dark2") + 
    theme_minimal()+
    theme(legend.position = "none")


ps4<- ggplot(phone, aes(x=Agreeableness, y=Smartphone, fill = Smartphone)) +
    geom_violin(trim = FALSE)+
    geom_boxplot(width = 0.3, fill = "white") +
    #facet_wrap(~Gender)+
    labs(y=NULL)+
    coord_flip()+
    scale_fill_brewer(palette="Dark2") + 
    theme_minimal()+
    theme(legend.position = "none")


ps5<- ggplot(phone, aes(x=Conscientiousness, y=Smartphone, fill = Smartphone)) +
    geom_violin(trim = FALSE)+
    geom_boxplot(width = 0.3, fill = "white") +
    #facet_wrap(~Gender)+
    labs(y=NULL)+
    coord_flip()+
    scale_fill_brewer(palette="Dark2") + 
    theme_minimal()+
    theme(legend.position = "none")


ps6<- ggplot(phone, aes(x=Openness, y=Smartphone, fill = Smartphone)) +
    geom_violin(trim = FALSE)+
    geom_boxplot(width = 0.3, fill = "white") +
    #facet_wrap(~Gender)+
    labs(y=NULL)+
    coord_flip()+
    scale_fill_brewer(palette="Dark2") + 
    theme_minimal()+
    theme(legend.position = "none")

grid.arrange(ps1, ps2, ps3, ps4, ps5,ps6, nrow = 2, 
             top = "6 personality variables VS Smartphone OS",
             bottom = "Smartphone")
#As shown in the graph, iPhone users generally have a higher index in emotionality, with median of 3.5 compared to Android's 3.2. 
#Android users generally have a higher index in Honesty-Humility and Openness, with median 3.6 and 3.6 respectively compared to that of iPhone's 3.4, 3.4. 
#Similar: Extraversion, Agreeableness, Conscientiousness


###############
# Exploring personalities within each Smartphone group with gender
###############
#From the plot above, we cannot see a high discrepancy on Personalities of 2 groups of smartphone users. Let's also consider the gender 

psg1<-ggplot(phone, aes(x=Honesty.Humility, y=Smartphone, fill = Gender)) +
    geom_boxplot(width = 0.5)+
    labs(y=NULL)+
    coord_flip()+
    labs(y=NULL, x = "Honesty-Humility")+
    scale_fill_brewer(palette="Set3") + 
    theme_bw()
#theme(legend.position = "none")

psg2<-ggplot(phone, aes(x=Emotionality, y=Smartphone, fill = Gender)) +
    geom_boxplot(width = 0.5)+
    labs(y=NULL)+
    coord_flip()+
    labs(y=NULL)+
    scale_fill_brewer(palette="Set3") + 
    theme_bw()
#theme(legend.position = "none")

psg3<-ggplot(phone, aes(x=Extraversion, y=Smartphone, fill = Gender)) +
    geom_boxplot(width = 0.5)+
    labs(y=NULL)+
    coord_flip()+
    labs(y=NULL)+
    scale_fill_brewer(palette="Set3") + 
    theme_bw()
#theme(legend.position = "none")

psg4<-ggplot(phone, aes(x=Agreeableness, y=Smartphone, fill = Gender)) +
    geom_boxplot(width = 0.5)+
    labs(y=NULL)+
    coord_flip()+
    labs(y=NULL)+
    scale_fill_brewer(palette="Set3") + 
    theme_bw()
#theme(legend.position = "none")

psg5<-ggplot(phone, aes(x=Conscientiousness, y=Smartphone, fill = Gender)) +
    geom_boxplot(width = 0.5)+
    labs(y=NULL)+
    coord_flip()+
    labs(y=NULL)+
    scale_fill_brewer(palette="Set3") + 
    theme_bw()
#theme(legend.position = "none")


psg6<-ggplot(phone, aes(x=Openness, y=Smartphone, fill = Gender)) +
    geom_boxplot(width = 0.5)+
    labs(y=NULL)+
    coord_flip()+
    scale_fill_brewer(palette="Set3") + 
    theme_bw()
#theme(legend.position = "none")

#Arrage the plots
plot<-ggarrange(psg1, psg2, psg3, psg4, psg5,psg6, nrow = 2, ncol=3, 
                common.legend = TRUE, legend="right") %>%
    annotate_figure(plot, top = text_grob("6 personality variables VS Smartphone OS"),
                    bottom = text_grob("Smartphone OS"))
#The plots shows a better insight 
#Emotionality: Female no matter Android or iPhone users has higher emotionality
#Honestity-Humility: Male tends to have lower index, especially for iPhone users
#Extraversion: Similar but male tends to have a lower range 
#Agreeableness: Similar, but look at the max&min, Android female user has lower Max index(Max 4.3), but Android male user has higher maximum (Max 4.8)
#Conscientiousness: Similar
#Openness: Almost the same for Android users; Discrpency can be observed among male and female iPhone users - iPhone males users have a higher opernness (3.6) VS female (3.3), Min value for male (2.9) whereas Min value for female (1.7)



###############
# Exploring Social Economic Status/Phone as status/Time owned current phone with Smartphone OS
###############

#Overlay histrogram to show 2 groups of Smartphone users VS the social economic status
#As indicated by the graph, it is clear that iPhone user has a higher social economic status compared to that of Android
#*Do not use gender --> Has bias since the no. of females > male in this data set*

ggplot(phone, aes(x = Social.Economic.Status)) +
    geom_histogram(aes(color = Smartphone, fill = Smartphone), 
                   position = "identity", bins = 10, alpha = 0.3) +
    scale_color_manual(values = c("#E7B800", "#00AFBB")) +
    scale_fill_manual(values = c("#E7B800", "#00AFBB"))+
    labs(x = "Social economic status", title = "Social economic status of different smartphone user group")+
    theme_bw()+
    theme(plot.title = element_text(hjust = 0.5))


#Phone as status
#It is clear that iPhone user usually has a strong phone as status!!!
ggplot(phone, aes(x = Phone.as.status.object)) +
    geom_histogram(aes(color = Smartphone, fill = Smartphone), 
                   position = "identity", bins = 10, alpha = 0.3) +
    scale_color_manual(values = c("#E7B800", "#00AFBB")) +
    scale_fill_manual(values = c("#E7B800", "#00AFBB"))+
    labs(x = "Phone as status", title = "Phone as status of different smartphone user group")+
    theme_bw()+
    theme(plot.title = element_text(hjust = 0.5))


#Time owned current phone
ggplot(phone, aes(x = Time.owned.current.phone)) +
    geom_histogram(aes(color = Smartphone, fill = Smartphone), 
                   position = "identity", bins = 10, alpha = 0.3) +
    scale_color_manual(values = c("#E7B800", "#00AFBB")) +
    scale_fill_manual(values = c("#E7B800", "#00AFBB"))+
    labs(x = "Time owned current phone", title = "Time owned current phone of different smartphone user group")+
    theme_bw()+
    theme(plot.title = element_text(hjust = 0.5))



#################################################################
#################################################################
#Explore Covariation #### 
#Covariation describes the behavior between variables. 
#Visualise the relationship between two or more variables.
#################################################################
#################################################################

###############
# Correlation with numeric variables
###############
#Scatterplot of Time own current phone and Age
#No relationship can be observed
ggplot(phone,aes(x = Time.owned.current.phone, y = Age, color = Gender)) + 
    geom_point() +
    geom_smooth()+
    scale_color_viridis_d() +
    theme_bw()

#Scatterplot of Time own current phone and SES
ggplot(phone,aes(x = Time.owned.current.phone, y = Social.Economic.Status, color = Gender)) + 
    geom_point() +
    geom_smooth()+
    scale_color_viridis_d() +
    theme_bw()

#Scatterplot of age vs Personalities
#No relationship can be observed
ggplot(phone_long,aes(x = Age, y = Value, color = Personality)) + 
    geom_point() +
    geom_smooth(method = 'lm')+
    scale_color_viridis_d() +
    theme_bw()+
    labs(title = "Personality VS Age")+
    theme(plot.title = element_text(hjust = 0.5))


#heatmap for categorical
phone_long$Value.cut <- cut(phone_long$Value, breaks = c(1, 2, 3, 4, 5, Inf),
                            labels = c('1','2','3','4','5'), right = FALSE)

#Than we create heatmap to show frequencies in each category
#Seems only Extraversion has a positive relationship with SES (can reference to corrplot)
test<-phone_long%>%
    group_by(Smartphone,Personality, Social.Economic.Status)%>%
    summarise(value = median(Value))%>%
    ggplot(aes(x=Social.Economic.Status,y=Personality,fill=value)) + 
    geom_tile(color = "white",size=0.1) +
    facet_wrap(~Smartphone,nrow = 1) + 
    scale_fill_viridis_b(name="Median score")+
    scale_x_continuous(breaks = seq(1,10,by=1))+
    labs(x="Social Economic Status")



#Correlation matrix for all the non-categorical variables
#Need a lot of computational time
select(phone, Age:Time.owned.current.phone) %>%
    ggpairs(lower = list(continuous = wrap("points", size=0.1))) +
    theme_bw()

#calculate correlation matrix
corr_phone <- round(cor(phone[,4:13]), 2)
ggcorrplot(corr_phone, hc.order = TRUE, type = "lower", outline.col = "white", lab = TRUE, title="Correlogram of numerical variables",ggtheme=theme_bw)
