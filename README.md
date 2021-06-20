# Labor_association
The dataset I will be using is AdultUCI data set included in the arules library. This dataset is originally called the Census Income set as the database looks at the demographic an income levels of individuals in 1994 and we will be using this dataset to try to predict if hours worked leads to higher or if not what factors do lead to a large income. Some of the links I used to help me with this dataset are:

https://rdrr.io/cran/arules/man/Adult.html

http://r-statistics.co/Association-Mining-With-R.html

First we need to install the packages we will be using and makes sure we have the libraries selected. The packages we used are the arules, arulesViz, and dplyr packages.
Now we can get a sense of the data we are working with.  Starting with reviewing the overall information about the dataset. Here we can see the dataset contains 48,842 rows and 15 columns as well as getting an overview of how the data should be read. 
 
 
![image](https://user-images.githubusercontent.com/58121111/122681451-5c758b80-d1c2-11eb-9a9d-fc9dd25ef6a5.png)

  
![image](https://user-images.githubusercontent.com/58121111/122681454-63040300-d1c2-11eb-8990-7a8be2bd7c8e.png)


![image](https://user-images.githubusercontent.com/58121111/122681458-69927a80-d1c2-11eb-8972-c610c0a99eb9.png)


Reviewing all columns in the dataset we have a few integers that we are going to have to convert in order to change the data frame to transitional dataset which we can do by either removing attributes or converting them into factors. Since we do not need the education-num and fnlwgt we can remove those by places them as NULL values. For the Age  attribute we will set parameters to categorize the data, (15,25,45,65,100)("Young", "Middle-aged", "Senior", "Old"). We also did this with the Hours per week, 0,25,40,60,168) ("Part-time", "Full-time", "Over-time", "Workaholic"), and the capital-gain/ and capital-loss attributes. Once this is done we can then convert the dataframe into transactions.


![image](https://user-images.githubusercontent.com/58121111/122681467-71521f00-d1c2-11eb-8819-2c5466d09ea4.png)


With the dataset in transactions we can now view the frequency of the demographics displayed, specifically those that appear the most. This will give us a sense of what are the common values we can expect in this dataset. From here we are ready to set rules for the association mining. 
Beside seeing which values had a strong confidence we also wanted to see certain values led to each other specifically how hours-per-week=Workaholic was predicted.  
 
![image](https://user-images.githubusercontent.com/58121111/122681476-7adb8700-d1c2-11eb-837e-0d1fd585a3d1.png)


After seeing the results we are noticing that those who are workaholics do not tend to have a large income we looked at what factors can lead to large income.  Within the results there were no workaholics presented in those with large income however whenever there hours-per-week was listed as a factor for those having a large income it was those who worked overtime but in tandem there were more rules where hours-per-week-worked is not considered.


![image](https://user-images.githubusercontent.com/58121111/122681485-8169fe80-d1c2-11eb-8ff1-d96a3b1e9735.png)

