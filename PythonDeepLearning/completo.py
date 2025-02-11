import numpy
from sklearn.decomposition import PCA
from sklearn.svm import SVC
import numpy as np
import matplotlib.pyplot as plt
from scipy.ndimage import convolve
import csv
import cPickle as pickle
import scipy.ndimage as nd
import pandas as pd
import random
import scipy
import time





COMPONENT_NUM = 50
USE_PICKLE = False
IMAGE_WIDTH = 28



def load_training_data():
    print('Get data...')
    data = pd.read_csv('train.csv')
    Y = data.ix[:, 0].values.astype('int32')
    data = data.ix[:, 1:].values.astype('float32') # trim first classification field
    X = normalize_data(data)
    return X, Y

def normalize_data(X):
    print('Normalize date train...')
    X = X/255.0
    X[X < 0.1] = 0.0
    X[X >= 0.9] = 1.0
    return X



def nudge_dataset(X, Y):
    print ('Expand date train...')
    nudge_size = 1
    direction_matricies = [
        [[0, 1, 0],
         [0, 0, 0],
         [0, 0, 0]],

        [[0, 0, 0],
         [1, 0, 0],
         [0, 0, 0]],

        [[0, 0, 0],
         [0, 0, 1],
         [0, 0, 0]],

        [[0, 0, 0],
         [0, 0, 0],
         [0, 1, 0]]]

        

    scaled_direction_matricies = [[[comp*nudge_size for comp in vect] for vect in matrix] for matrix in direction_matricies]
    shift = lambda x, w: convolve(x.reshape((IMAGE_WIDTH, IMAGE_WIDTH)), mode='constant',
                                  weights=w).ravel()
    X = np.concatenate.ix([X] +
                       [np.apply_along_axis(shift, 1, X, vector)
                        for vector in scaled_direction_matricies]).values.astype('float32')

    Y = np.concatenate.ix([Y for _ in range(5)], axis=0).values.astype('int32')
    return X, Y



def threshold(X):
    X[X < 0.1] = 0.0
    X[X >= 0.9] = 1.0
    return X


def rotate_dataset(X, Y):
    print('Rotation date...')
    rot_X = np.zeros(X.shape)
    for index in range(X.shape[0]):
        sign = random.choice([-1, 1])
        angle = np.random.randint(8, 16)*sign
        rot_X[index, :] = nd.rotate(np.reshape(X[index, :],
            ((28, 28))), angle, reshape=False).ravel()
    XX = np.vstack((X,rot_X))
    YY = np.hstack((Y,Y))
    
    return XX, YY
    
print('Get and normalize date test...')
datateste = (pd.read_csv('test.csv').values).astype('float32')
Z = datateste/255.00






X_train, Y_train = load_training_data()
X_train, Y_train = rotate_dataset(X_train, Y_train)
#X_train, Y_train = nudge_dataset(X_train, Y_train)


pca = PCA(n_components=COMPONENT_NUM, whiten=True)
pca.fit(X_train)
X_train = pca.transform(X_train)

print('Train SVM...')
svc = SVC(kernel='linear', C=1e4)
svc.fit(X_train, Y_train)

print('Read testing data...')

print('Predicting...')
test_data = Z
test_data = pca.transform(test_data)
predict = svc.predict(test_data)

print('Saving...')
with open('predictSVM.csv', 'w') as writer:
    writer.write('"ImageId","Label"\n')
    count = 0
    for p in predict:
        count += 1
        writer.write(str(count) + ',"' + str(p) + '"\n')
