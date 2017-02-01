from sklearn.datasets import load_iris
from sklearn.neighbors import KNeighborsClassifier
from sklearn.cross_validation import cross_val_score
from sklearn.grid_search import GridSearchCV
from sklearn.grid_search import RandomizedSearchCV
import matplotlib.pyplot as plt

iris_set = load_iris()

X = iris_set.data #features
y = iris_set.target # response

k_range = list(range(1,31))
knn_model_scores = []

#This loop finds the mean accuracy of a KNN model with k values ranging from 1 to 31
for k in k_range:
	knn = KNeighborsClassifier(n_neighbors=k)
	scores = cross_val_score(knn,X,y,cv=10,scoring = 'accuracy')
	knn_model_scores.append(scores.mean())

#Plot the accuracy vs the range of k values to see which k value produces the highest accuracy
plt.plot(k_range,knn_model_scores)
plt.xlabel('Value of K (Number of neighbors to check)')
plt.ylabel('Cross-Validated Accuracy')
plt.show()


#Now use GridSearchSV to create a K Nearest Neighbors model for the Iris Dataset

weight_options = ['uniform', 'distance']
parameters = dict(n_neighbors = k_range, weights = weight_options)
gridsearch = GridSearchCV(knn,parameters,cv=10, scoring='accuracy')
gridsearch.fit(X,y)

print("Best Score using GridSearchCV: ")
print(gridsearch.best_score_)
print("Best Parameters for the KNN Model determined by GridSearchCV: ")
print(gridsearch.best_params_)
print("\n")

#Now use RandomizedSearchCV to create a K Nearest Neighbors Model for the Iris Dataset

randsearch = RandomizedSearchCV(knn,parameters,cv=10,scoring='accuracy',n_iter=10, random_state=0)
randsearch.fit(X,y)
print("Best Score using RandomizedSearchCV: ")
print(randsearch.best_score_)
print("Best Parameters for the KNN Model determined by RandomizedSearchCV: ")
print(randsearch.best_params_)
