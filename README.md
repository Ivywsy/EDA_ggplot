# Exploratary Data Analysis With Visualizations (ggplot2)
* Written by: [Ivy Wu S.Y.](https://www.linkedin.com/in/ivy-wusumyi)
* Technologies: R, EDA, Exploratory Data Analysis, Data Visulisations, ggplot2


## 1. Introduction
Data exploration is the first step in data analysis by applying data visualizations and statistical techniques to reveal the initial patterns and characteristics of datasets. The process of exploration allows for a deeper understanding of datasets and allow us easier to use the data later. It is also important to know the data we are working with so that an appropriate analysis method can be applied for further modelling and insights extration. In what follows, an EDA was carried out on a sample dataset with extensive visualizations created by ggplot2 in R.

## 2. About the Data
The data contains demograpgics and personality data from a variety of Apple and Android users (n=529). These data contain the following variables:
| Variable       |                |
| -------------- | -------------- |
| Smartphone(OS) | iPhone/ Android|
| Gender         | Female/ Male   |
| Age            |                |
| Personality(HEXACO) | Honesty-Humility<br>Emotionality<br>Extraversion<br>Agreeableness<br>Conscientiousness<br>Openness|
|Avoidance Similarity||
|Phone as status object||
|Socioeconomic status||
|Time owned current phone (months)||


## 3. Data Cleansing
The data provided by SmartphoneTechTM contains 529 records and 13 variables with no missing values. The variable “Time owned current phone” contains 4.16% zeros yet can be reasoned out as a person may own a phone for less than 1 month. An extreme value of 99, however, is observed in this variable. Considering the upper quartiles value of the variable is 18, the outlier is hence removed to prevent misinterpretation of models. Below figures indicates the anomalies captured by the function "anomalies" and "skim" in R.<br/>
<details>
<summary>:point_right: <b>Click to see results from anomalies</b></summary>
<img src="/images/anomalies.png?raw=true" width="900"> <br/>
</details>
<details>
<summary>:point_right: <b>Click to see results from skim</b></summary>
<img src="/images/skim.png?raw=true" width="900"> <br/>
</details>
<br/>

## 4.1 Variation
To better understand the behavior within a variable, several descriptive analyses are carried out to examine their distributions and extract possible insights.  <br/>

### Categorical variables
There are 2 categorical variables namely “Gender” and “Smartphone”. Below visualizations shows that the number of iPhone user is higher than that of Android’s, whereas the number of males is around one-half of the number of females in the dataset. <br/> 
<img src="/images/barchart_categotical.png?raw=true" width="900"> <br/>

### Numerical variables
To gain a deeper insight, it is worth exploring the age and gender of smartphone users. A histogram of age (Figure 1.3) shows left-skewed data that most smartphone users are 18-21 years old. The boxplot (Figure 1.4) indicates that 50% of iPhone users are aged between 20 to 30 whereas 50% of Android users are aged between 20 to 40. In addition, iPhone users are generally younger than Android users with a median of 22 and 27 years old respectively. <br/> 
<img src="/images/chart_numerical.png?raw=true" width="900"> <br/>

An additional boxplot (Figure 1.5) is created with facets of gender to show the tendency of smartphone choices in addition to age. Surprisingly, female iPhone users tend to be the youngest among all groups with 50% of them aged between 19 to 27. Conversely, all males have a similar interest in iPhone and Android with 50% of them aged between 20 to 38 in both groups. <br/> 
<img src="/images/boxplot_smartphone_vs_age.png?raw=true" width="550"> <br/>

As shown in the histograms (Figure 1.6), the 6 HEXACO personalities are normally distributed with the highest density around the value of 3. A boxplot (Figure 1.7) is generated to better understanding the relationship between personality, gender and smartphone choice. In terms of Emotionality, female and male has a high discrepancy no matter their choice of smartphone. Female generally has higher emotionality index compared to that of male, with an average of 3.6 and 3 respectively. On the other hand, male tends to have a lower index in Honesty-Humility, especially for iPhone users. As for Openness, discrepancy can be observed among male and female iPhone users, in which iPhone male users have a higher openness index ranged from 2.9 to 3.6 versus female’s 1.7 to 3.3 respectively. <br/> 
<img src="/images/6HEXACO.png?raw=true" width="550"> <br/>
<img src="/images/6HEXACO_vs_personalities.png?raw=true" width="550"> <br/>

Lastly, some interesting insights can be found between the rest of variables and different smartphone user groups. As shown in the below figure, iPhone users tends to have a higher social economic status, longer time of owning their current phone, and a higher emphasis on phone as a status symbol compared to that of Android users. 
<img src="/images/hist_SES.png?raw=true" width="900"> <br/>


## 4.2 Covariation
Covariation describes the tendency for 2 or more variables’ values to very together in a related way. A correlation matrix is run to measure the degree of relationship between numerical variables. As indicated in Figure 1.9, there are 3 pairs of variables having a moderate level of linear relationship with each other.<br/>
<img src="/images/correlogram.png?raw=true" width="550"><br/>


### To learn more about Ivy Wu S.Y., visit her [LinkedIn profile](https://www.linkedin.com/in/ivy-wusumyi)

All rights reserved 2022. All codes are developed and owned by Ivy Wu S.Y..