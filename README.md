# Telecom-churn-prediction
## Goals: To prevent the customers who are likely to churn using different techniques and methods.
## Objectives: To Predict and study the reason of customer Churning.
## Techniques Used: random forest, decision tree and logistic regression.
# Industry Analysis 
## The US Telecom market is majorly operated by 3 Tier-1 national players: AT&T, Verizon and T-Mobile, catering to an overall 96% of the mobile subscriber base
## DISH, an MVNO and the newest entrant in the mobile service market post the merger of Sprint and T-Mobile holds 2.3% of the overall subs
# Inference from the cost analysis across our models
## Upon comparing the multiple models that we used to Predict the Churn Rate, we observe and infer that the model deploying Logistic Regression with a cutoff of 0.3 produces the least cost of mis-identifying the customers who Churn.
# Limitations in the Model
## Logistic regression model is sensitive to outliers.
## The minority class of Churn variable in our dataset is Yes which is only 29%,if there was slightly more data of the customers who churned, our model would have achieved a better accuracy and the cost of misidentifying false prediction would be comparatively less.
## It is required that each training example be independent of all the other examples in the dataset. If they are related in some way, then the model will try to give more importance to those specific training examples.
# RECOMMENDATIONS TO REDUCE THE CHURN RATE
## Upgrading customer's equipment with a lock-in of more than 365 days  :  Target using Email Marketing
## Special Low Usage Plans for Users who are likely to churn due to high monthly recurring charge : Retention Calls, Email Marketing
## Reward customers on the basis of their loyalty. Provide annual credits for every additional year and provide premium services
## Target customers, who will likely churn through website promotion pop-up, push notifications and in-app notifications. Eg- Low Monthly Minutes Usage Customer be targeted through push notification offers






