library('arules')
library('arulesViz')
library('dplyr')

#review the overall dataset information
data("AdultUCI")
str(AdultUCI)
dim(AdultUCI)
AdultUCI[1:2,]

#get a sense of the hours per work 
mean(AdultUCI$`hours-per-week`)
sd(AdultUCI$`hours-per-week`)
var(AdultUCI$`hours-per-week`)
median(AdultUCI$`hours-per-week`)


#Data Cleaning
## remove attributes or convert into factor data
AdultUCI[["fnlwgt"]] <- NULL
AdultUCI[["education-num"]] <- NULL

## map metric attributes
AdultUCI[[ "age"]] <- ordered(cut(AdultUCI[[ "age"]], c(15,25,45,65,100)),
                              labels = c("Young", "Middle-aged", "Senior", "Old"))

AdultUCI[[ "hours-per-week"]] <- ordered(cut(AdultUCI[[ "hours-per-week"]],
                                             c(0,25,40,60,168)),
                                         labels = c("Part-time", "Full-time", "Over-time", "Workaholic"))

AdultUCI[[ "capital-gain"]] <- ordered(cut(AdultUCI[[ "capital-gain"]],
                                           c(-Inf,0,median(AdultUCI[[ "capital-gain"]][AdultUCI[[ "capital-gain"]]>0]),
                                             Inf)), labels = c("None", "Low", "High"))

AdultUCI[[ "capital-loss"]] <- ordered(cut(AdultUCI[[ "capital-loss"]],
                                           c(-Inf,0, median(AdultUCI[[ "capital-loss"]][AdultUCI[[ "capital-loss"]]>0]),
                                             Inf)), labels = c("None", "Low", "High"))

## create transactions
tData <- as(AdultUCI, "transactions")
tData

# calculates support for frequent items
frequentItems <- eclat(tData, parameter = list(supp = 0.07, maxlen = 10))
inspect(frequentItems)

# plot frequent items
itemFrequencyPlot(tData, topN=10, type="absolute", main="Item Frequency")

#___Setting Rules____
rules <- apriori(tData, parameter = list(support = 0.0001, confidence = 0.7, maxlen = 9))

# 'high-confidence' rules.
rules_conf <- sort(rules, by="confidence", decreasing=TRUE, maxlen = 5)
options(digits=2)#show 2 digit rules

# show the support, lift and confidence for all rules
inspect(head(rules_conf))

# 'high-lift' rules
rules_lift <- sort (rules, by="lift", decreasing=TRUE,  maxlen = 9) 

# show the support, lift and confidence for all rules
inspect(head(rules_lift))

#looking for rules leading to specific results
#get rules that lhs 'hours-per-week=Workaholic' lead to
rules <- apriori (data=tData, parameter=list(supp=0.001,conf = 0.07), 
                  appearance = list(default="rhs",lhs="hours-per-week=Workaholic"), 
                  control = list(verbose=F))

#prepare the datat for plotting
rules <- sort(rules, dereasing=True, by="confidence")
inspect(rules[1:9]) #review the top 9 rules
rules_workaholic <- rules[1:9]

#plot the rules based off of hours-per-week=Workaholic
plot(rules_workaholic, method="graph", interactive=TRUE,shading=NA)

#now lets look at what can lead us to a large income demographic wise
#get rules that lead to rhs 'income=large'
rules <- apriori (data=tData, parameter=list(supp=0.001,conf = 0.07), 
                  appearance = list(default="lhs",rhs="income=large"), 
                  control = list(verbose=F))

#prepare the rules for plotting
rules <- sort(rules, dereasing=True,by="confidence")
inspect(rules[1:9]) #review the top 9 rules
rules_largeIncome <- rules[1:9]

#plot demographics that can lead to a higher income
plot(rules_largeIncome, method="graph", interactive=TRUE,shading=NA)
