
library(readr)
cell2celltrain <- read.csv("cell2celltrain.csv")

attach(cell2celltrain)
df <- data.frame(cell2celltrain)

df$Churn <- as.factor(df$Churn)
View(df)


library(rpart) 
library(rpart.plot)
library(caret)
library(e1071)


row.names(df) <- df$CustomerID
df <- df[,-c(1)]
View(df)
#Create a training and validation partition
numberOfRows <- nrow(df)
set.seed(1)#always return the same set of randomly seletced rows
train.index <- sample(numberOfRows, numberOfRows*0.6)

print(train.index)
train.df <- df[train.index, ]
valid.df <- df[-train.index, ]
View(train.df)

View(valid.df)
str(train.df)
summary(train.df)
str(valid.df)

#randomforest
#use random forest to see if it improved prediction
library(randomForest)

#mtry = number of variables randomly sampled  as candidates at each split
#creates ntree number of trees by randomly sampling with replacement
#results are the average of all the trees
rf <- randomForest(as.factor(Churn) ~ ., data = train.df, 
                   ntree = 1000, mtry = 56, nodesize = 1, importance = TRUE, sampsize = 20000) 

#plot the variables by order of importance
varImpPlot(rf, type = 1)

#create a confusion matrix
valid.df$Churn <- factor(valid.df$Churn)
rf.pred <- predict(rf, valid.df)
confusionMatrix(rf.pred, valid.df$Churn)

View(df)


#logisticregression
attach(cell2celltrain)
df.logi <- data.frame(df[,c("CurrentEquipmentDays","MonthsInService","PercChangeMinutes","MonthlyMinutes","OffPeakCallsInOut",
                                   "TotalRecurringCharge","PeakCallsInOut","MonthlyRevenue","ReceivedCalls","UnansweredCalls","Churn")])

df.logi$Churn<-ifelse(df.logi$Churn=="Yes",1,0)
str(df.logi)
numberOfRows <- nrow(df)
set.seed(10)#always return the same set of randomly seletced rows
train.index <- sample(numberOfRows, numberOfRows*0.7)

print(train.index)
train.df <- df.logi[train.index, ]
valid.df <- df.logi[-train.index, ]

logitI.reg <- glm(Churn ~ ., data = train.df, family = "binomial") 
options(scipen=999)
summary(logitI.reg)
confusionMatrix(table(predict(logitI.reg, newdata = valid.df, 
                              type="response") >= 0.4, valid.df$Churn == 1))

confusionMatrix(table(predict(logitI.reg, newdata = valid.df, 
                              type="response") >= 0.3, valid.df$Churn == 1))


#decisiontree

df.decision <- data.frame(df[,c("CurrentEquipmentDays","MonthsInService","PercChangeMinutes","MonthlyMinutes","OffPeakCallsInOut",
                                            "TotalRecurringCharge","PeakCallsInOut","MonthlyRevenue","ReceivedCalls","UnansweredCalls","Churn")])
df.decision$Churn<-ifelse(df.decision$Churn=="Yes",1,0)
df.decision$Churn <- as.factor(df.decision$Churn)

numberOfRows <- nrow(df.decision)
set.seed(1)
train.index <- sample(numberOfRows, numberOfRows*0.6)

print(train.index)
train.df <- df.decision[train.index, ]
valid.df <- df.decision[-train.index, ]

.ct <- rpart(Churn ~ ., data = train.df, method = "class", cp = 0, maxdepth = 5, minsplit = 20)

printcp(.ct)
options(scipen=999)
prp(.ct, type = 1, extra = 1, under = FALSE, split.font = 1, varlen = -10)

ct.pred <- predict(.ct, valid.df, type = "class")

confusionMatrix(ct.pred, as.factor(valid.df$Churn))

#decisiontree2
df.decision2 <- data.frame(df[,c("CurrentEquipmentDays","MonthsInService","PercChangeMinutes","MonthlyMinutes","OffPeakCallsInOut",
                                             "TotalRecurringCharge","PeakCallsInOut","MonthlyRevenue","ReceivedCalls","UnansweredCalls",
                                 "OutboundCalls","PercChangeRevenues","DroppedCalls","DroppedBlockedCalls","InboundCalls","Churn")])

df.decision2 <- na.omit(df.decision2)
df.decision2$Churn<-ifelse(df.decision2$Churn=="Yes",1,0)
df.decision2$Churn <- as.factor(df.decision2$Churn)

numberOfRows <- nrow(df.decision2)
set.seed(1)
train.index <- sample(numberOfRows, numberOfRows*0.6)

print(train.index)
train.df <- df.decision2[train.index, ]
valid.df <- df.decision2[-train.index, ]

.ct2 <- rpart(Churn ~ ., data = train.df, method = "class", cp = 0, maxdepth = 4, minsplit = 20)

printcp(.ct2)
options(scipen=999)
prp(.ct2, type = 1, extra = 1, under = FALSE, split.font = 1, varlen = -10)

ct.pred2 <- predict(.ct2, valid.df, type = "class")

confusionMatrix(ct.pred2, as.factor(valid.df$Churn))

