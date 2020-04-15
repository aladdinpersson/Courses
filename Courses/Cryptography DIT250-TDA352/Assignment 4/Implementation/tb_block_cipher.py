import numpy as np

# Declare 'global' variables, matrices used for function P and also S_boxes
lambd = np.loadtxt(open("matrix.txt", "rb"), delimiter="     ", skiprows=0)
lambd_inv = np.loadtxt(open("matrix_inv.txt", "rb"), delimiter="     ", skiprows=0)

S_box = {'00':'67', '01':'64', '02':'14', '03':'35', '04':'60', '05':'24', '06':'17',
         '07':'54', '10':'01', '11':'42', '12':'47', '13':'15', '14':'41', '15':'23',
         '16':'63', '17':'52', '20':'04', '21':'56', '22':'55', '23':'31', '24':'11',
         '25':'37', '26':'07', '27':'27', '30':'46', '31':'70', '32':'05', '33':'76',
         '34':'22', '35':'43', '36':'71', '37':'77', '40':'57', '41':'36', '42':'33',
         '43':'40', '44':'26', '45':'50', '46':'13', '47':'21', '50':'53', '51':'51',
         '52':'10', '53':'32', '54':'25', '55':'44', '56':'00', '57':'75', '60':'65',
         '61':'74', '62':'06', '63':'03', '64':'12', '65':'02', '66':'34', '67':'20',
         '70':'66', '71':'72', '72':'16', '73':'45', '74':'30', '75':'62', '76':'61',
         '77':'73'}

S_reversible = dict(zip(S_box.values(),S_box.keys()))

# Function converts binary to octal and vice-versa depending on if curr_base is 2 or 8
def base_conv(x, curr_base):
    new_x = ''

    dict2_to_8 = {'000':'0', '001':'1', '010':'2', '011':'3', '100':'4', '101':'5',
                   '110':'6', '111':'7'}

    dict8_to_2 = {'0': '000', '1': '001', '2': '010', '3': '011', '4': '100', '5': '101',
                  '6': '110', '7': '111'}

    # Converts from binary to octal
    if int(curr_base) == 2:
        step = 3
        split_x = [x[i:i+step] for i in range(0, len(x), step)]

        for each_split in split_x:
            new_x += dict2_to_8[str(each_split)]

    # Converts from octal to binary
    elif int(curr_base) == 8:
        for each in x:
            new_x += dict8_to_2[each]

    return new_x

# Given k_i returns k_i+1 using a substitution defined in phi as given in report specification
def key_scheduler(k):
    phi = "35712064"
    new_k = ""

    for each in reversed(k):
        new_k += phi[int(each)]

    return new_k

# Takes two strings s1,s2 and performs xor operation elementwise
def xor(s1,s2):
    xor_result = []

    for i in range(min(len(s1), len(s2))):
        xor_result.append(str(int(s1[i]) ^ int(s2[i]))) # xor

    return ''.join(xor_result)

# Performs operation P(x) = matrix (x) x, where (x) denotes matrix mult. with xor operation as addition
def P(x, matrix):
    lambd = matrix
    x = str(x)
    x = list(x)

    idx = 0
    result = x.copy()

    # Goes through each row in matrix
    for row in lambd:
        # Finds which indices (x_i's) that should be xor'd.
        indices_to_xor = np.where(row==1)[0]

        # Start with xor two of them (if at least two should be xor'd given by the row)
        if len(indices_to_xor) >= 2:
            result[idx] = xor(x[indices_to_xor[0]], x[indices_to_xor[1]])

            # Continue to xor the rest one by one in a loop
            for element in indices_to_xor[2:]:
                result[idx] = xor(str(result[idx]), str(x[element]))

        else:
            result[idx] = x[indices_to_xor[0]]

        idx += 1

    return ''.join(result)

# Encryption combines all previous functions. S-boxes, P function, base_converter, xor
def encryption(x, k, rounds=512):
    step = 6 # Should split the 18 bit string x into 3 parts each of 6 bits
    K = [] # Store all keys in list which will be used later for decryption
    k = base_conv(k, curr_base=8)
    K.append(k)
    x = xor(x, k)
    print('ct0: ' + x)

    # We should perform S-box(x) -> P(x) -> xor(x,k), a total of 'rounds' times
    for r in range(rounds):
        split_x = [x[i:i + step] for i in range(0, len(x), step)]
        idx = 0

        # Perform s-box on each 6 bit split
        for each in split_x:
            split_x[idx] = base_conv(S_box[base_conv(each, curr_base=2)], curr_base=8)
            idx += 1

        x = ''.join(split_x)
        x = P(x, lambd)

        k = key_scheduler(base_conv(k, curr_base=2))
        k = base_conv(k, curr_base=8)
        K.append(k)
        x = xor(x, k)

        if r == 0 or r == 1 or r == 2 or r == 510:
            print('ct' + str(r+1) + ' : ' + x)

    return x, K

# Decryption performs the reverse of the encryption
# Operations follow from encryption expect we utilize the inverse of S-boxes
# As well as inverse of matrix used in P(x), also the reverse of keys
def decryption(ct, K, rounds=512):
    step = 6
    k = K[-1]
    ct = xor(ct, k)
    K = K[:-1]

    for r in range(rounds):
        ct = P(ct, lambd_inv)

        split_ct = [ct[i:i + step] for i in range(0, len(ct), step)]

        idx = 0
        for each in split_ct:
            split_ct[idx] = base_conv(S_reversible[base_conv(each, curr_base=2)], curr_base=8)
            idx += 1

        ct = ''.join(split_ct)

        k = K[-1]
        ct = xor(ct, k)
        K = K[:-1]


    return ct

def test_vectors():
    K1 = ['000000', '333333', '111111', '555555', '000000', '333333', '111111', '555555', '000000']
    K2 = ['111111', '555555', '000000', '333333', '111111', '555555', '000000', '333333', '111111']
    K3 = ['012345', '021753', '104573', '140235', '017325', '071453', '102543', '120735', '014375']
    K4 = ['120735', '014375', '041253', '107523', '170435', '012345', '021753', '104573', '140235']
    K5 = ['104573', '140235', '017325', '071453', '102543', '120735', '014375', '041253', '107523']
    K6 = ['041253', '107523', '170435', '012345', '021753', '104573', '140235', '017325', '071453']
    K7 = ['017325', '071453', '102543', '120735', '014375', '041253', '107523', '170435', '012345']
    K = [K1,K2,K3,K4,K5,K6,K7]

    # Goes through each separate test
    for ki in K:
        idx = 1
        for each_k in ki[:-1]:
            #Asserts that key scheduler obtains same as the test cases, no error --> everything is working
            assert key_scheduler(each_k) == ki[idx]
            idx+=1

    print('--------- Key scheduler testing passed ---------')

    messages = ['111111111111111111', '000000000000000000', '011111111111111110', '101111111111111101']
    keys = ['123456', '654321', '564321', '777777']

    for i in range(len(messages)):
        m_i = messages[i]
        k_i = keys[i]

        encrypted_message_i, K_i = encryption(m_i, k_i, rounds=512)
        decrypted_message_i = decryption(encrypted_message_i, K_i, rounds=512)

        assert decrypted_message_i == m_i

        print('Original message: ' + m_i + ' and the key was: ' + k_i + ' with the cipher text: ' + encrypted_message_i)

    print('--------- Encryption and decryption testing passed ---------')

    print('\n')
    print('--------- All tests passed! ---------')

def main():
    message = '000000000000000000'
    k0 = '000000'
    amount_of_rounds = 512
    encrypted_message, K = encryption(message, k = k0, rounds=amount_of_rounds)
    decrypted_message = decryption(encrypted_message, K, rounds=amount_of_rounds)

    print('Original message: ' + message)
    print('Encrypted message: ' + encrypted_message)
    print('Decrypted message: ' + decrypted_message)

if __name__ == '__main__':
    # test_vectors() # run test vectors to check if basic functionality is working

    # run main and basic how-to use main code: message 18-bit length message can be edited, k0 can be edited
    # and rounds=512 can be edited to preference
    main()
    print(base_conv(x='001001001011111100', curr_base=2))
