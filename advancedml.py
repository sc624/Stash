import json
import urllib
import sys
from collections import Counter
import math

import requests
import operator
import pprint

dimensionsNum = 0
dimensionsString = ""
description  = ""
city = ""
state = ""
myargs = []
curListing = ["", "", 0,0,0,0, "", "", 0, ""]





with open('userinfo.txt', 'r') as data_file:
    myargs = data_file.read()

try:
    myargs1 = myargs.split("*")
    description = myargs1[0]
    
    nums = myargs1[1].replace("x", "*").replace("X", "").split("*")
    num1 =int(nums[0].strip())
    num2 = int(nums[1].strip())
    
    dimensionsNum = num1 * num2
    dimensionsString = myargs1[1]
    
    city = myargs1[2]
    state = myargs1[3]
    curListing = [description, "", num1, num2, 0, 0, city, state, 0, "", 0, ""] #we don't have some data for new listing who calls this page, including the type of place. 
except:
    pass


with open('inputdatafile.txt', 'r') as data_file:
    json_data = data_file.read()
    

#loads the data appropriately. 
data = json.loads(json_data)
listings = []
listingX = []
listingY = []

for entry in data:
  try:
    #print(entry["Dimensions"])
    nums = entry["Dimensions"].replace("x", "*").replace("X", "").split("*")
    num1 =int(nums[0].strip())
    num2 = int(nums[1].strip())
    listing_data = [entry["Description"], "", num1, num2, 0, int(entry["ListingPrice"]), entry["City"], entry["State"], 0,"", int(entry["ListingID"]), entry["ListingType"]]
    listingX.append(num1*num2)
    listingY.append(int(entry["ListingPrice"]))
    listings.append(listing_data)
  except:
         pass



'''
Function to calculate the distance between two listings.
Using NLP cosine similarity  to find the difference between two sentences about a place.
'''
def dist_listings(list1, list2, distances = {}):
    x1 = list1[2]
    x2 = list2[2]
    y1 = list1[3]
    y2 = list2[3]
    #squared difference between storage space dimensions (x1-x2)^2 + (y1-y2)^2
    squared_diff = (x1 - x2)**2  +  (y1 - y2)**2
    diff_horizontal = abs(x1 - x2)
    diff_vertical = abs(y1 - y2)

    
    location1 = list1[6] + "," + list1[7]
    location2 = list2[6] + "," + list2[7]
    diff_zip_codes = 0
    
    #using Google api call to find distance between two towns
    if location1+location2 in distances:
      diff_zip_codes =  distances[location1+location2]
    else:
      diff_zip_codes = get_distance(location1, location2)
      distances[location1+location2] = diff_zip_codes
    
    #print(diff_zip_codes)

    similarity_descriptions = cosine_similarity(list1[0], list2[0])

    #we change this so that exact matches have distance of 0, while
    #completely different values have distance of 1. 
    similarity_descriptions = abs(similarity_descriptions - 1) + 0.01
    
    total_diff = squared_diff + diff_horizontal + diff_vertical + diff_zip_codes
    
    total_diff = total_diff  * similarity_descriptions
    return total_diff


'''
Return an integer representing the distance between two cities in miles. 
'''
  
def get_distance(location1, location2):

    try:

        api_key ='AIzaSyB7Mk3yM7-Qs6jX0vTsZ3S_poK5v8u3JrM'
        r = urllib.requests.get("https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins={place1}&destinations={place2}&key=AIzaSyB7Mk3yM7-Qs6jX0vTsZ3S_poK5v8u3JrM".
                         format(place1 = location1 ,place2 = location2))                      
        # json method of response object 
        # return json format result 
        x = r.json() 
          
        # bydefault driving mode considered 
          
        # #print the vale of x 
        distance = x["rows"][0]["elements"][0]["distance"]["text"].replace("mi", "").strip()
        if "ft" in distance:
          return 0
        else:
            return int(distance)
    except:
        return 0
        


'''
Reference for calculating cosine similarity:
https://www.machinelearningplus.com/nlp/cosine-similarity/
Returns two arrays, one corresponding to the normalized count of words for each sentence. 
'''
def distance_matrices(sentence1, sentence2):
    #form lists of the words from the given sentences. 
    sentence1 = sentence1.lower().split()
    sentence2 = sentence2.lower().split()
    
    #clean up the sentences.
    for  i in range(len(sentence1)):
        sentence1[i] = sentence1[i].strip().replace(",", "")
        sentence1[i] = sentence1[i].strip().replace(".", "")
    for i in range(len(sentence2)):
        sentence2[i] = sentence2[i].strip().replace(",", "")
        sentence2[i] = sentence2[i].strip().replace(".", "")

    all_words = sentence1 + sentence2
    all_words = list(set(all_words))

    #find number of times word in the vocab occurs in a document. 
    sentence1Matrix = []
    sentence2Matrix = []
    sentence1Sum = 0
    sentence2Sum = 0
    
    for word in all_words:
         #count the number of times the word occurs.
         count_word_sentence1 = sentence1.count(word)
         count_word_sentence2 = sentence2.count(word)

         #need to compute the L2 norm
         sentence1Sum += count_word_sentence1 ** 2
         sentence2Sum += count_word_sentence2 ** 2
         

         #add the info to our matrices
         sentence1Matrix.append(count_word_sentence1) 
         sentence2Matrix.append(count_word_sentence2)
         
  
    sentence1Norm = math.sqrt(sentence1Sum)
    sentence2Norm = math.sqrt(sentence2Sum)
    

    for i in range(len(sentence1Matrix)):
        sentence1Matrix[i] = sentence1Matrix[i]/(sentence1Norm + 0.001)
        sentence2Matrix[i]  = sentence2Matrix[i]/(sentence2Norm + 0.001)
 
    return [sentence1Matrix, sentence2Matrix]

#Returns a cosine similarity value between 0 and 1 for two lists
def cosine_similarity(sentence1, sentence2):
     distanceMatrices = distance_matrices(sentence1, sentence2)
     distanceMatrix1 = distanceMatrices[0]
     distanceMatrix2 = distanceMatrices[1]
     similar_val = 0
     for i in range(len(distanceMatrix1)):
         similar_val += distanceMatrix1[i] * distanceMatrix2[i]
     #print("Similarity between {} and {} is {}".format(sentence1, sentence2, similar_val))
     return similar_val
    
'''
Return the list of nearest neighbors to a particular listing. 
'''
def getNeighbors(trainingSet, testInstance, k):
	distances = []
	length = len(testInstance)-1
	for x in range(len(trainingSet)):
		dist = dist_listings(testInstance, trainingSet[x])
		distances.append((trainingSet[x], dist))
	distances.sort(key=operator.itemgetter(1))
	neighbors = []
	for x in range(k):
		neighbors.append(distances[x][0])
	return neighbors

#test()
#print("Compare neighbors")
#print("first neighbor is {}".format(getNeighbors(listings, listings[8], 2)))


#-----------------------------------------------------------------------
#Calculate regression values



XData = []
Y = [] 
for listing in listings:
    #dimensions of storage space
    XData.append(listing[2] * listing[3])
    #price of the storage space
    Y.append(listing[5])


def compute_mean(xVals):
    sum = 0
    for x  in xVals:
        sum += x
    return (sum * 1.0)/(len(xVals) * 1)


def compute_sum_square(xVals):
    sum = 0
    for x in xVals:
        sum += x ** 2
    return sum

'''
Compute the square error for a variable. 
'''
def SSE_Var(xVals):
    x_mean = compute_mean(xVals)
    sum_error = 0
    for x in xVals:
        sum_error += (x-x_mean) ** 2
    return sum_error

def SSE_cross_product(xVals, yVals):
    x_mean = compute_mean(xVals)
    y_mean = compute_mean(yVals)
    sum = 0
    for i in range(len(xVals)):
        xdiff = xVals[i] - x_mean
        ydiff = yVals[i] - y_mean
        sum += (xdiff * ydiff  * 1.0)
    return sum
        
def compute_weights_and_bias(xVals, yVals):
    #b1 currently represents the slope of the regression line. 
    b1 = SSE_cross_product(xVals, yVals)/SSE_Var(xVals)
    b0 = compute_mean(yVals) - b1*compute_mean(xVals)
    return (b0, b1)





def predict_price(xVals, yVals, newX):
    weights = compute_weights_and_bias(xVals, yVals)

    new_prediction = (weights[1] * newX) + weights[0]
    return new_prediction


def error_variance(xVals, yVals):
    weights = compute_weights_and_bias(xVals, yVals)
    n = len(xVals)
    slope = weights[1]
    intercept = weights[0]
    
    SSE = 0 
    for i in range(len(yVals)):
        predicted_y = (slope *  xVals[i]) + intercept      
        SSE += (predicted_y - yVals[i]) ** 2
    MSE = SSE/(n-2)
    return MSE
           




    
def get_prediction_interval(xVals, yVals, newX, predictedY):
    
    prediction= predict_price(xVals, yVals, newX)
    S_xx = SSE_Var(xVals)
    x_mean = compute_mean(xVals)
    n = len(xVals)
    MSE = math.sqrt(error_variance(xVals, yVals)) #take square root here

   
    SE_internal = 1 + (1.0/n) +  math.pow(x_mean-newX, 2) / (S_xx * (n-1))
    SE_prediction = math.sqrt(SE_internal * MSE)
    
    #t refers to critical value
    #we want sig. level of 0.05 and assuming large degrees of freedom (i.e large sample data)
    #retrieved from t-table online (http://www.sjsu.edu/faculty/gerstman/StatPrimer/t-table.pdf)
    t_val  = 0.52507

    
    lower_bound = predictedY - (t_val * SE_prediction)
    upper_bound = predictedY + (t_val * SE_prediction)
    return (lower_bound, upper_bound)
           
        
           
    

   



#------------------------------------





#get the price
price = predict_price(listingX, listingY, dimensionsNum)
interval = get_prediction_interval(listingX,  listingY, dimensionsNum, price)



#get the closest neighbors. 
closeNeighbors = getNeighbors(listings, curListing, 6)






#assemble all the data. 
data = {}
data['price'] = price
data['low'] = interval[0]
data['high'] = interval[1]
data['neighbor1'] = closeNeighbors[1]
data['neighbor2'] = closeNeighbors[2]
data['neighbor3'] = closeNeighbors[3]
data['neighbor4'] = closeNeighbors[4]




#store the results of the advanced functionality methods in a json file. 
with open('advanceddata.json', 'w') as outfile:
     print(json.dump(data, outfile))









