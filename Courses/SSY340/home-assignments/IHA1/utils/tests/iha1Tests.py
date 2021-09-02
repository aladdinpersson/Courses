import numpy as np
import sys
import matplotlib.pyplot as plt

def test_numpy_reshape(numbers):
    assert (len(numbers.shape) == 2), "`numbers` should only have two dimensions!"
    assert (numbers.shape[0] == 6 and numbers.shape[1] == 4), "`numbers` should have the dimension (6,4)"
    print('Test passed')

def test_numpy_neg_ix(numbers):
    assert ((numbers == np.array([[ 0,  1,  2,  3],[ 4,  5,  6,  7],[ 8,  9, 10, 11],[12, 13, 14, 15],[16, 17, 18, 19],[20, 21, 22,  0]])).all()), "Some element(s) of the matrix has the wrong value"
    print('Test passed')

def test_numpy_row_ix(numbers):
    assert ((numbers == np.array([[ 0,  0,  0,  0],[ 4,  5,  6,  7],[ 8,  9, 10, 11],[12, 13, 14, 15],[16, 17, 18, 19],[20, 21, 22,  0]])).all()), "Some element(s) of the matrix has the wrong value"
    print('Test passed')

def test_numpy_append_row(numbers):
    assert ((numbers == np.array([[ 0,  0,  0,  0],[ 4,  5,  6,  7],[ 8,  9, 10, 11],[12, 13, 14, 15],[16, 17, 18, 19],[20, 21, 22,  0],[0,0,0,0]])).all()), "Some element(s) of the matrix has the wrong value"
    assert (numbers.shape[0] ), "The matrix has the wrong shape"
    print('Test passed')

def test_numpy_bool_matrix(numbers):
    assert ((numbers == np.array([[ 0,  0,  0,  0],[ 4,  5,  6,  7],[ 8,  9, 10, 1],[1, 1, 1, 1],[1, 1, 1, 1],[1, 1, 1,  0],[0,0,0,0]])).all()), "Some element(s) of the matrix has the wrong value"
    print('Test passed')

def test_numpy_sum(numbers):
    assert (len(numbers.shape) == 1 and numbers.shape[0] == 7), "The matrix has the wrong shape"
    assert ((numbers == np.array([0,22,28,4,4,3,0])).all()), "Some element(s) of the matrix has the wrong value"
    print('Test passed')

def test_data_shape(X, Y):
    assert(Y.shape[0] == X.shape[0]), "X and Y deosn't have the same number of rows"
    assert(Y.shape[0] == 70000 and Y.shape[1] == 10), "The dimensions of Y are incorrect"
    assert((np.sum(Y, axis=1) == np.ones(70000)).all()), "Y doesn't contain all one-hot vectors"
    print('Test passed')

def test_shuffle_xy_pairs(f):
    # create artificial dataset
    X = np.arange(1000).reshape(-1,5)
    Y = np.arange(1000).reshape(-1,5)

    X_shuffled, Y_shuffled = f(X,Y)
    assert np.any(np.sum(X - X_shuffled, axis=1)), "You are not shuffling your dataset"
    assert not np.any(np.sum(X_shuffled - Y_shuffled, axis=1)), "Your shuffle does not preserve labels"

    print('Test passed')

def test_relu(f):

    for i in np.random.uniform(0,sys.float_info.max, 1000):
        assert(f(np.array([i])) == i), "Positive values for relu function gives wrong output"
    for i in np.random.uniform(-sys.float_info.max, -sys.float_info.min, 1000):
        assert(f(np.array([i])) == 0), "Negative values for relu function gives wrong output"
    assert(f(np.array([sys.float_info.max])) == sys.float_info.max), "float max value give wrong answer for relu"
    assert(f(np.array([sys.float_info.min])) == sys.float_info.min), "float min value give wrong answer for relu"
    assert(f(np.array([-sys.float_info.min])) == 0), "negative float min value give wrong answer for relu"
    
    z_test = np.random.uniform(sys.float_info.min, sys.float_info.max, (100,100))
    assert(f(z_test).shape == (100,100)), "The output shape of relu is not equal to the input"
    print('Test passed')
    
def test_dRelu(f):
    da_test = np.random.uniform(sys.float_info.min, sys.float_info.max, (100,100))
    z_test = np.random.uniform(sys.float_info.min, sys.float_info.max, (100,100))
    assert(f(da_test, z_test).shape == (100,100) ), "The output shape of dRelu is not equal to the input"
    assert(np.sum(f(da_test, z_test)) == 100*100 ), "The output(s) of positive input value(s) are wrong"
    
    da_test = np.random.uniform(-sys.float_info.max, -sys.float_info.min, (50,100))
    z_test = np.random.uniform(-sys.float_info.min, -sys.float_info.max, (50,100))
    assert(np.sum(f(da_test, z_test)) == 0), "The output(s) of negative input value(s) are wrong"
    
    assert(f(np.zeros((1,1)), np.zeros((1,1)))[0] == 0), "The gradient of zero should be zero"
    print('Test passed')

def test_sigmoid(f):
    test_cases = [
            {
                'input': np.linspace(-10,10,100),
                'expected': np.array( [  
                    4.53978687e-05,   5.55606489e-05,   6.79983174e-05,   8.32200197e-05,
                    1.01848815e-04,   1.24647146e-04,   1.52547986e-04,   1.86692945e-04,
                    2.28478855e-04,   2.79614739e-04,   3.42191434e-04,   4.18766684e-04,
                    5.12469082e-04,   6.27124987e-04,   7.67413430e-04,   9.39055039e-04,
                    1.14904229e-03,   1.40591988e-03,   1.72012560e-03,   2.10440443e-03,
                    2.57431039e-03,   3.14881358e-03,   3.85103236e-03,   4.70911357e-03,
                    5.75728612e-03,   7.03711536e-03,   8.59898661e-03,   1.05038445e-02,
                    1.28252101e-02,   1.56514861e-02,   1.90885420e-02,   2.32625358e-02,
                    2.83228820e-02,   3.44451957e-02,   4.18339400e-02,   5.07243606e-02,
                    6.13831074e-02,   7.41067363e-02,   8.92170603e-02,   1.07052146e-01,
                    1.27951705e-01,   1.52235823e-01,   1.80176593e-01,   2.11963334e-01,
                    2.47663801e-01,   2.87185901e-01,   3.30246430e-01,   3.76354517e-01,
                    4.24816868e-01,   4.74768924e-01,   5.25231076e-01,   5.75183132e-01,
                    6.23645483e-01,   6.69753570e-01,   7.12814099e-01,   7.52336199e-01,
                    7.88036666e-01,   8.19823407e-01,   8.47764177e-01,   8.72048295e-01,
                    8.92947854e-01,   9.10782940e-01,   9.25893264e-01,   9.38616893e-01,
                    9.49275639e-01,   9.58166060e-01,   9.65554804e-01,   9.71677118e-01,
                    9.76737464e-01,   9.80911458e-01,   9.84348514e-01,   9.87174790e-01,
                    9.89496155e-01,   9.91401013e-01,   9.92962885e-01,   9.94242714e-01,
                    9.95290886e-01,   9.96148968e-01,   9.96851186e-01,   9.97425690e-01,
                    9.97895596e-01,   9.98279874e-01,   9.98594080e-01,   9.98850958e-01,
                    9.99060945e-01,   9.99232587e-01,   9.99372875e-01,   9.99487531e-01,
                    9.99581233e-01,   9.99657809e-01,   9.99720385e-01,   9.99771521e-01,
                    9.99813307e-01,   9.99847452e-01,   9.99875353e-01,   9.99898151e-01,
                    9.99916780e-01,   9.99932002e-01,   9.99944439e-01,   9.99954602e-01] )
                }
            ]
    for test_case in test_cases:
        ans = f(test_case['input'])
        assert np.allclose(ans, test_case['expected'], rtol=1e-07, atol=1e-04), "This test case failed: " + str(test_case)
    print('Test passed')

    
def test_softmax(f):
    test_cases = [
      {
        'input': np.array([[0, 0]]),
        'expected': np.array([[0.5, 0.5]])
      },
      {
        'input': np.array([[1, 1]]),
        'expected': np.array([[0.5, 0.5]])
      },
      {
        'input': np.array([[1.0, 1e-3]]),
        'expected': np.array([[0.7308619, 0.26913807]])
      },
      {
        'input': np.array([[3.0, 1.0, 0.2]]),
        'expected': np.array([[ 0.8360188, 0.11314284, 0.05083836]])
      },
      {
        'input': np.array(
          [[1, 2, 3, 6],
           [2, 4, 5, 6],
           [3, 8, 7, 6]]),
        'expected': np.array(
          [[ 0.006269,  0.01704 ,  0.04632 ,  0.93037 ],
           [ 0.012038,  0.088947,  0.241783,  0.657233],
           [ 0.004462,  0.662272,  0.243636,  0.089629]])
      },
      {
        'input': np.array(
          [[ 0.31323624,  0.7810351 ,  0.26183059,  0.09174578,  0.09806706],
           [ 0.28981829,  0.03154328,  0.99442807,  0.4591928 ,  0.42556593],
           [ 0.06799825,  0.89438807,  0.68276332,  0.89185543,  0.37638809],
           [ 0.49131144,  0.03873597,  0.91306311,  0.2533448 ,  0.24115072],
           [ 0.38297911,  0.23184308,  0.88202174,  0.42546236,  0.78325552]]),
        'expected': np.array(
          [[ 0.19402037,  0.30974891,  0.18429864,  0.15547309,  0.15645899],
           [ 0.16325474,  0.12609515,  0.33027366,  0.19338564,  0.18699081],
           [ 0.11396294,  0.26041151,  0.21074279,  0.25975282,  0.15512995],
           [ 0.21152728,  0.13452883,  0.32250081,  0.16673194,  0.16471114],
           [ 0.16549414,  0.1422804 ,  0.27259261,  0.17267635,  0.2469565 ]])
    } ]
    for test_case in test_cases:
        ans = f(test_case['input'])
        assert np.allclose(ans, test_case['expected'], rtol=1e-07, atol=1e-06), "This test case failed: " + str(test_case)

    print('Test passed')

def test_backward_cross_entropy_and_softmax(f):
    test_cases = [
        {
            'y_pred': np.array([3.0, 1.0, 0.2]),
            'y': np.array([ 0.8360188, 0.11314284, 0.05083836]),
            'expected': np.array([ 2.1639812, 0.88685716, 0.14916164])
        },{

            'y_pred': np.array(
              [[ 0.31323624,  0.7810351 ,  0.26183059,  0.09174578,  0.09806706],
               [ 0.28981829,  0.03154328,  0.99442807,  0.4591928 ,  0.42556593],
               [ 0.06799825,  0.89438807,  0.68276332,  0.89185543,  0.37638809],
               [ 0.49131144,  0.03873597,  0.91306311,  0.2533448 ,  0.24115072],
               [ 0.38297911,  0.23184308,  0.88202174,  0.42546236,  0.78325552]]),
            'y': np.array(
              [[ 0.19402037,  0.30974891,  0.18429864,  0.15547309,  0.15645899],
               [ 0.16325474,  0.12609515,  0.33027366,  0.19338564,  0.18699081],
               [ 0.11396294,  0.26041151,  0.21074279,  0.25975282,  0.15512995],
               [ 0.21152728,  0.13452883,  0.32250081,  0.16673194,  0.16471114],
               [ 0.16549414,  0.1422804 ,  0.27259261,  0.17267635,  0.2469565 ]]),
            'expected': np.array(
                [[ 0.11921587, 0.47128619, 0.07753195, -0.06372731, -0.05839193],
                 [ 0.12656355, -0.09455187, 0.66415441,  0.26580716,  0.23857512],
                 [-0.04596469,  0.63397656,  0.47202053,  0.63210261,  0.22125814],
                 [ 0.27978416, -0.09579286,  0.5905623,   0.08661286,  0.07643958],
                 [ 0.21748497,  0.08956268,  0.60942913,  0.25278601,  0.53629902]])
        }
    ]
    for test_case in test_cases:
        ans = f(test_case['y_pred'], test_case['y'])
        
    print('Test passed')
        
def test_cross_entropy(f):
    test_cases = [
        {
            'y_pred': np.array([[0, 0, 0]]),
            'y': np.array([[ 0, 1, 0]]),
            'expected': 18.420680744
        },{
            'y_pred': np.array([[3.0, 1.0, 0.2]]),
            'y': np.array([[ 0, 0, 1]]),
            'expected': 1.60943786243
        },{

            'y_pred': np.array(
              [[ 0.31323624,  0.7810351 ,  0.26183059,  0.09174578,  0.09806706],
               [ 0.28981829,  0.03154328,  0.99442807,  0.4591928 ,  0.42556593],
               [ 0.06799825,  0.89438807,  0.68276332,  0.89185543,  0.37638809],
               [ 0.49131144,  0.03873597,  0.91306311,  0.2533448 ,  0.24115072],
               [ 0.38297911,  0.23184308,  0.88202174,  0.42546236,  0.78325552]]),
            'y': np.array(
              [[ 0,  0,  0,  0,  1],
               [ 0,  0,  0,  1,  0],
               [ 0,  0,  1,  0,  0],
               [ 0,  1,  0,  0,  0],
               [ 1,  0,  0,  0,  0]]),
            'expected': 1.53855138732
        }
    ]
    ans = f(test_cases[0]['y_pred'], test_cases[0]['y'])
    assert ans != np.inf and ans != -np.inf, "Your output is infinity, you are performing np.log with zero. Add a small error term to correct this"

    for test_case in test_cases:
        ans = f(test_case['y_pred'], test_case['y'])
        assert np.allclose(ans, test_case['expected'], rtol=1e-07, atol=1e-06), "This test case failed: " + str(test_case) + " Actual output: " + str(ans)
        
    print('Test passed')

def test_initialize_weights(f):
    shape = (10,15)
    w, b = f(shape)
    assert b.shape == (1,shape[1]), "The bias has the wrong shape"
    assert np.sum(b) == 0, "The bias isn't initialized to all zeros"
    
    assert w.shape == shape, "The weight matrix has the wrong shape"
    s = 0
    stds = 0
    for i in range(1000):
        w, _ = f(shape)
        s += np.mean(w)
        stds += np.std(w)
    assert np.abs(s/1000) < 0.1, "The mean of the weight matrix is not close to 0"
    assert np.abs(stds/1000 - 2) < 0.05, "The std dev of the weight matrix is not close to 2"

    print('Test passed')


def test_layer(Class, relu, sigmoid, softmax):
    
    # forward check
    
    # relu layer
    
    test_case = {
       'input': np.transpose(np.array(
              [[ 0.31323624,  0.7810351 ,  0.26183059 ],
               [ 0.38297911,  0.23184308,  0.88202174 ]])) ,
        'expected': np.transpose(np.array([
            [ 1.68047376,  2.93861903,  2.3772233 ],
            [ 0.,          0.,          0.,       ],
            [ 1.00556785,  0.,          2.80134077],
            [ 0.,          0.,          0.        ]
        ]))
    }
    np.random.seed(1)
    layer = Class(2,4, activation_fn=relu)
    a = layer.forward_prop(test_case['input'])
    assert a.shape == (3, 4), "The shape of the output of forward_prop with relu activation function is not right. Expected: (3,4). Actual: {0}".format(a.shape)
    assert np.allclose(a, test_case['expected'], rtol=1e-07, atol=1e-06), "Forward prop with relu returned the right dimensions, but the wrong output. \nInput: \n{0}\nExpected: \n{1}\nActual: \n{2}".format(test_case['input'], test_case['expected'], a)

    # sigmoid layer
    
    test_case_sm = {
        'input': np.transpose(np.array(
            [[ 0.31323624,  0.7810351 ,  0.26183059 ],
            [ 0.38297911,  0.23184308,  0.88202174 ]])) ,
        'expected': np.transpose(np.array([
            [ 0.63391001,  0.90496736,  0.44310787]
        ]))
    }
    np.random.seed(1)
    layer_sm = Class(2,1, activation_fn=sigmoid)
    a_sm = layer_sm.forward_prop(test_case_sm['input'])
    assert a_sm.shape == (3,1), "The shape of the output of forward_prop with softmax activation function is not right. Expected: (3,1). Actual: {0}".format(a_sm.shape)
    assert np.allclose(a_sm, test_case_sm['expected'], rtol=1e-05, atol=1e-05), "Forward prop with softmax returned the right dimensions, but the wrong output. \nExpected: {0}\nActual: \n{1}".format(test_case_sm['expected'], a_sm)

    
    # softmax layer
    
    test_case_sm = {
        'input': np.transpose(np.array(
            [[ 0.31323624,  0.7810351 ,  0.26183059 ],
            [ 0.38297911,  0.23184308,  0.88202174 ]])) ,
        'expected': np.transpose(np.array([
            [  6.31280971e-01,   9.38032362e-01,   3.93202386e-01],
            [  1.37514771e-02,   6.56903747e-03,   4.56911181e-04],
            [  3.21451004e-01,   4.88702650e-02,   6.00908053e-01],
            [  3.35165481e-02,   6.52833548e-03,   5.43265016e-03]
        ]))
    }
    np.random.seed(1)
    layer_sm = Class(2,4, activation_fn=softmax)
    a_sm = layer_sm.forward_prop(test_case_sm['input'])
    assert a_sm.shape == (3,4), "The shape of the output of forward_prop with softmax activation function is not right. Expected: (3,4). Actual: {0}".format(a_sm.shape)
    assert np.allclose(a_sm, test_case_sm['expected'], rtol=1e-07, atol=1e-06), "Forward prop with softmax returned the right dimensions, but the wrong output. \nExpected: {0}\nActual: \n{1}".format(test_case_sm['expected'], a_sm)

    print('Test passed')
    



def test_layer_with_backprop(Class):
    
    # forward check
    
    # relu layer
    
    test_case = {
       'input': np.array(
              [[ 0.31323624,  0.7810351 ,  0.26183059 ],
               [ 0.38297911,  0.23184308,  0.88202174 ]]) ,
        'expected': np.array([
            [ 1.68047376,  2.93861903,  2.3772233 ],
            [ 0.,          0.,          0.,       ],
            [ 1.00556785,  0.,          2.80134077],
            [ 0.,          0.,          0.        ]
        ]),
        'da': np.array([
            [ 0.63807819, -0.49874075,  2.92421587],
            [-4.12028142, -0.64483441, -0.76810871],
            [ 2.26753888, -2.19978253, -0.34485642],
            [-1.75571684,  0.08442749,  1.16563043]]),
        'da_prev': np.array([
            [-0.32238127, -1.62025445,  9.86415982],
            [ 9.01725249, -0.8632281,   3.85785837]]),
        'dw': np.array([
            [ 0.19199478,  0.        ,  0.20666046,  0.        ],
            [ 0.90265433,  0.        ,  0.18808305,  0.        ]]),
        'db': np.array([
            [ 1.02118444],
            [ 0.        ],
            [ 0.64089415],
            [ 0.        ]])
    }
    np.random.seed(1)
    layer = Class(2,4)
    a = layer.forward_prop(test_case['input'])
    assert a.shape == (4, 3), "The shape of the output of forward_prop with relu activation function is not right. Expected: (4,3). Actual: {0}".format(a.shape)
    assert np.allclose(a, test_case['expected'], rtol=1e-07, atol=1e-06), "Forward prop with relu returned the right dimensions, but the wrong output. \nInput: \n{0}\nExpected: \n{1}\nActual: \n{2}".format(test_case['input'], test_case['expected'], a)
    
    # softmax layer
    
    test_case_sm = {
        'input': np.array(
            [[ 0.31323624,  0.7810351 ,  0.26183059 ],
            [ 0.38297911,  0.23184308,  0.88202174 ]]) ,
        'expected': np.array([
            [  6.31280971e-01,   9.38032362e-01,   3.93202386e-01],
            [  1.37514771e-02,   6.56903747e-03,   4.56911181e-04],
            [  3.21451004e-01,   4.88702650e-02,   6.00908053e-01],
            [  3.35165481e-02,   6.52833548e-03,   5.43265016e-03]
        ]),
        'da': np.array([
            [ 0.63807819, -0.49874075,  2.92421587],
            [-4.12028142, -0.64483441, -0.76810871],
            [ 2.26753888, -2.19978253, -0.34485642],
            [-1.75571684,  0.08442749,  1.16563043]]),
        'da_prev': np.array([
            [  8.48649406,   1.31125861,   8.30258093],
            [ 30.6561543 ,  -5.69995185,   5.61895035]]),
        'dw': np.array([
            [ 0.19199478, -0.66512471, -0.36604199, -0.0596052 ],
            [ 0.90265433, -0.8016569 ,  0.0180816 ,  0.12509415]]),
        'db': np.array([
            [ 1.02118444],
            [-1.84440818],
            [-0.09236669],
            [-0.16855297]])
    }
    np.random.seed(1)
    layer_sm = Class(2,4, activation_fn='softmax')
    a_sm = layer_sm.forward_prop(test_case_sm['input'])
    assert a_sm.shape == (4, 3), "The shape of the output of forward_prop with softmax activation function is not right. Expected: (4,3). Actual: {0}".format(a_sm.shape)
    assert np.allclose(a_sm, test_case_sm['expected'], rtol=1e-07, atol=1e-06), "Forward prop with softmax returned the right dimensions, but the wrong output. \nExpected: {0}\nActual: \n{1}".format(test_case_sm['expected'], a_sm)
    
    # backward check
    
    # relu layer
    
    da_prev, dw, db = layer.backward_prop(test_case['da'])
               
    assert da_prev.shape == test_case['input'].shape, "The shape of da_prev is wrong in the backward propagation for relu layer. \nExpected: \n{0}\nActual:\n{1}".format(test_case['input'].shape, da_prev.shape)
    assert dw.shape == layer.w.shape, "The shape of dw is wrong in the backward propagation for relu layer. \nExpected: \n{0}\nActual:\n{1}".format(layer.w.shape, dw.shape)
    assert db.shape == layer.b.shape, "The shape of db is wrong in the backward propagation for relu layer. \nExpected: \n{0}\nActual:\n{1}".format(layer.b.shape, db.shape)
   
    assert np.allclose(da_prev, test_case['da_prev'], rtol=1e-07, atol=1e-06) and \
        np.allclose(dw, test_case['dw'], rtol=1e-07, atol=1e-06) and \
        np.allclose(db, test_case['db'], rtol=1e-07, atol=1e-06), "Backward prop with for the relu layer returned the right dimensions, but the wrong output. \nExpected: \nda_prev:\n{0}\ndw:\n{1}\ndb:\n{2}\nActual: \nda_prev:\n{3}\ndw:\n{4}\ndb:\n{5}".format(test_case['da_prev'], test_case['dw'], test_case['db'], da_prev, dw, db)
        
    # softmax layer
     
    da_prev_sm, dw_sm, db_sm = layer_sm.backward_prop(test_case_sm['da'])
               
    assert da_prev_sm.shape == test_case_sm['input'].shape, "The shape of da_prev is wrong in the backward propagation for softmax layer. \nExpected: \n{0}\nActual:\n{1}".format(test_case_sm['input'].shape, da_prev_sm.shape)
    assert dw_sm.shape == layer_sm.w.shape, "The shape of dw is wrong in the backward propagation for softmax layer. \nExpected: \n{0}\nActual:\n{1}".format(layer_sm.w.shape, dw_sm.shape)
    assert db_sm.shape == layer_sm.b.shape, "The shape of db is wrong in the backward propagation for softmax layer. \nExpected: \n{0}\nActual:\n{1}".format(layer_sm.b.shape, db_sm.shape)
   
    assert np.allclose(da_prev_sm, test_case_sm['da_prev'], rtol=1e-07, atol=1e-06) and \
        np.allclose(dw_sm, test_case_sm['dw'], rtol=1e-07, atol=1e-06) and \
        np.allclose(db_sm, test_case_sm['db'], rtol=1e-07, atol=1e-06), "Backward prop with for the softmax layer returned the right dimensions, but the wrong output. \nExpected: \nda_prev:\n{0}\ndw:\n{1}\ndb:\n{2}\nActual: \nda_prev:\n{3}\ndw:\n{4}\ndb:\n{5}".format(test_case_sm['da_prev'], test_case_sm['dw'], test_case_sm['db'], da_prev_sm, dw_sm, db_sm)
    
    print('Test passed')
    
def test_neuralnetwork(Class):
    test_case = {
       'input': np.transpose(np.array(
            [[ 0.31323624,  0.26183059 ],
            [ 0.31323624,  0.7810351  ],
            [ 0.38297911,  0.23184308 ]])) ,
        'y_pred': np.transpose(np.array([
            [ 0.9780258,   0.7073134 ],
            [ 0.00112902,  0.08327279],
            [ 0.02084518,  0.20941381]])),
        'y': np.transpose(np.array([
            [ 1, 0 ],
            [ 0, 1 ],
            [ 0, 0 ],
        ]))
    }
    np.random.seed(1)
    dims = [2,3]
    nn = Class(3,dims)
    y_pred = nn.forward_prop(test_case['input'])
    
    # layers dims and order tests
    assert nn.input_n == 3, "`input_n` has the wrong dimensions. Expected: {0}. Actual: {1}".format(3, nn.input_n)
    assert dims == [2,3], "Constructor should not modify its parameters"
    _dims = [3] + dims
    
    for i in range(len(nn.layers)-1):
        assert nn.layers[i].w.shape == (_dims[i], _dims[i+1]), "Hidden layer {0} has the wrong weight matrix shape in a neural network with the hidden dimensions {1}. Expected: {2}. Actual: {3}".format(i+1, dims, (_dims[i], _dims[i+1]), nn.layers[i].w.shape)
        assert nn.layers[i].b.shape == (1,_dims[i+1]), "Hidden layer {0} has the wrong bias shape in a neural network with the hidden dimensions {1}. Expected: {2}. Actual: {3}".format(i+1, dims, (_dims[i+1], 1), nn.layers[i].b.shape)
    # forward prop tests
    assert y_pred.shape == (2,3), "The shape of the output of forward_prop for the neural network is not right. Expected: (2,3). Actual: {0}".format(y_pred.shape)
    assert np.allclose(y_pred, test_case['y_pred'], rtol=1e-07, atol=1e-06), "Forward prop with relu returned the right dimensions, but the wrong output. \nExpected: {0}\nActual: \n{1}".format(test_case['y_pred'], y_pred)
    
    print('Test passed')



def test_neuralnetwork_with_backprop(Class):
    test_case = {
       'input': np.array(
            [[ 0.31323624,  0.26183059 ],
            [ 0.31323624,  0.7810351  ],
            [ 0.38297911,  0.23184308 ]]) ,
        'y_pred': np.array([
            [ 0.9780258,   0.7073134 ],
            [ 0.00112902,  0.08327279],
            [ 0.02084518,  0.20941381]]),
        'y': np.array([
            [ 1, 0 ],
            [ 0, 1 ],
            [ 0, 0 ],
        ])
    }
    np.random.seed(1)
    dims = [2,3]
    nn = Class(3,dims)
    y_pred = nn.forward_prop(test_case['input'])
    grads = nn.backward_prop(y_pred, test_case['y'])
    
    # layers dims and order tests
    assert nn.input_n == 3, "`input_n` has the wrong dimensions. Expected: {0}. Actual: {1}".format(3, nn.input_n)
    _dims = [3] + dims
    for i in range(len(nn.layers)):
        assert nn.layers[i].w.shape == (_dims[i], _dims[i+1]), "Hidden layer {0} has the wrong weight matrix shape in a neural network with the hidden dimensions {1}. Expected: {2}. Actual: {3}".format(i+1, dims, (_dims[i-1], _dims[i]), nn.layers[i].w.shape) 
        assert nn.layers[i].b.shape == (_dims[i+1], 1), "Hidden layer {0} has the wrong bias shape in a neural network with the hidden dimensions {1}. Expected: {2}. Actual: {3}".format(i+1, dims, (_dims[i+1], 1), nn.layers[i].b.shape) 
    
    # forward prop tests
    assert y_pred.shape == (3, 2), "The shape of the output of forward_prop for the neural network is not right. Expected: (3,2). Actual: {0}".format(y_pred.shape)
    assert np.allclose(y_pred, test_case['y_pred'], rtol=1e-07, atol=1e-06), "Forward prop with relu returned the right dimensions, but the wrong output. \nExpected: {0}\nActual: \n{1}".format(test_case['y_pred'], y_pred)
    
    # backward prop shape test. Implementation is tested exhaustively in gradient checking later
    for i in range(len(nn.layers)):
        assert grads[i]['dw'].shape == nn.layers[i].w.shape, "The weight matrix gradient of hidden layer {0} has the wrong shape in a neural network with the hidden dimensions {1}. Expected: {2}. Actual: {3}".format(i+1, dims, nn.layers[i].w.shape, grads[i]['dw'].shape)
        assert grads[i]['db'].shape == nn.layers[i].b.shape, "The bias gradient of hidden layer {0} has the wrong shape in a neural network with the hidden dimensions {1}. Expected: {2}. Actual: {3}".format(i+1, dims, nn.layers[i].b.shape, grads[i]['db'].shape)
    
    print('Test passed')



def gradient_check(X, Y, nn, cross_entropy):
    i = 0
    epsilon = 1e-7
    Y_pred = nn.forward_prop(X)
    
    # make a vector out of all the gradients. Compare later with the approximated gradients
    gradients_list = nn.backward_prop(Y_pred,Y)
    gradients_vec = []
    for grads in gradients_list:
        gradients_vec += grads['dw'].reshape(-1).tolist()
        gradients_vec += grads['db'].reshape(-1).tolist()
    gradients_vec = np.array(gradients_vec).reshape(-1,1)
    
    param_n = gradients_vec.shape[0]
    J_plus = np.zeros((param_n, 1))
    J_minus = np.zeros((param_n, 1))
    gradapprox = np.zeros((param_n, 1))
    
    # iterate over each parameter in each vector/matrix for each layer and compute its approximated gradient
    for l in nn.layers:
        w_shape = l.w.shape
        b_shape = l.b.shape
        
        # param is a reference so adding epsilon to it will change the parameter value in the network
        
        for param in (l.w.reshape(-1,1)):
            param += epsilon
            J_plus[i] = cross_entropy(nn.forward_prop(X), Y)
            
            param -= 2*epsilon
            J_minus[i] = cross_entropy(nn.forward_prop(X), Y)
            
            param += epsilon
            gradapprox[i] = ( J_plus[i] - J_minus[i] ) / (2 * epsilon)
            i += 1
        for param in (l.b.reshape(-1,1)):
            param += epsilon
            J_plus[i] = cross_entropy(nn.forward_prop(X), Y)
            
            param -= 2*epsilon
            J_minus[i] = cross_entropy(nn.forward_prop(X), Y)
            
            param += epsilon
            gradapprox[i] = ( J_plus[i] - J_minus[i] ) / (2 * epsilon)
            i += 1

    numerator = np.linalg.norm(gradients_vec - gradapprox)
    denominator = np.linalg.norm(gradients_vec) + np.linalg.norm(gradapprox)
    difference = numerator/denominator  

    assert difference < 1e-7, "Your backward propagation implementation is not correct!. difference from approximated gradients: {0}. Should be less than 1e-7".format(difference)
    print ("Your backward propagation is implemented correct! difference from approximated gradients: {0}".format(difference))

def test_gradients(Class, cross_entropy):
    np.random.seed(1)
    nn = Class(3,[2,2])
    N = 10
    test_case= {
        'X': np.random.randn(3, N) ,
        'Y': np.zeros((2, N))
    }
    # randomize one-hot labels
    for i in range(N):
        test_case['Y'][np.random.randint(0,1), i] = 1
        
    gradient_check(test_case['X'], test_case['Y'], nn, cross_entropy)
    


def test_logistic(X, Y,layer=None, sigmoid=None):
    """
    """
    f, (ax1, ax2) = plt.subplots(1, 2, figsize=(12,5))
    x_n = X[Y == 0]
    x_p = X[Y == 1]
    
    # plot dataset
    ax1.scatter(X[Y==0,0], X[Y==0,1], c='red', label=0)
    ax1.scatter(X[Y==1,0], X[Y==1,1], c='blue', label=1)
    ax1.set_xlabel('x1')
    ax1.set_ylabel('x2')
    ax1.set_title('plot of data points and their classes')
    ax1.legend()
    
    if layer is not None:
        ax1.set_title('plot of data points and their classes. \nBlue line is the decision boundary')
        # plot classification boundary
        xs = np.linspace(0,8,100)
        ax1.plot(xs,-(layer.w[0]/layer.w[1])*xs - np.reshape(layer.b/layer.w[1], -1))

        # plot output space of layer
        a_n = layer.forward_prop(x_n)
        a_p = layer.forward_prop(x_p)
        z_n = np.matmul(x_n,layer.w) + layer.b
        z_p = np.matmul(x_p,layer.w) + layer.b
        ax2.scatter(z_n,a_n > 0.5, c='red', label=0)
        ax2.scatter(z_p,a_p > 0.5, c='blue', label=1)
        ax2.set_ylabel('predicted class')
        ax2.set_xlabel('wx+b')
        ax2.set_title('Visualization of applying linear transformation (x-axis), \nand predicted class after sigmoid (y-axis) on the data points.\nColors are grount truth labels')
        ax2.legend()

        # plot sigmoid
        xs = np.linspace(np.min([-4,np.min(z_n),np.min(z_p)]),np.max([5,np.max(z_n),np.max(z_p)]),1000)
        ax2.plot(xs, sigmoid(xs))
        
        plt.show()
        
        # test case
        assert np.sum(a_n > 0.5) == 0, "Predictions are not correct for class 0"
        assert np.sum(a_p > 0.5) == 2, "Predictions are not correct for class 1"
        print('test passed!')
        
    else:
        plt.show()
    
def test_predict_and_correct_answer(cls_preds):
    y_gt = np.load('./utils/test_data.npz')['Y']
    wrong = np.not_equal(y_gt, np.array(cls_preds))
    wrong_indices = [ i for i, c in enumerate(wrong) if i != 9 and c]

    assert not len(wrong_indices), "You failed to classify samples at indices {0}".format(wrong_indices)

    print('Test passed, you have implemented your neural network correctly!')
