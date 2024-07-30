import sys
import numpy as np
import scipy.io
import h5py
from numpy import int8
from scipy.io import savemat, loadmat


def TestResult(x, S):
    if x:
        print(f"Our test for {S} was Successful!")
    else:
        print(f"***Our test for {S} was Failed!***")
def selfTesting(filename, stringValue, floatValue, int8Value):

    savemat(filename, {'string_data': stringValue, 'float_data': floatValue, 'int8_data': np.array([int8Value],
                                                                                                   dtype=np.int8)})

    data = scipy.io.loadmat(filename)

    mystringB = data['string_data'].item()
    TestResult(stringValue == mystringB, "String")

    myFloatB = data['float_data'].item()
    TestResult(myFloatB == floatValue, "Float")

    myInt8B = data['int8_data'].item()
    TestResult(myInt8B == int8Value, "Int8")
def serializing_Py(filename, originalString, originalFloat, originalInt8):
    # Save all variables as a dictionary to a .mat file
    data_dict = {
        'string_data': originalString,
        'float_data': originalFloat,
        'int8_data': np.array([originalInt8], dtype=np.int8)
    }
    savemat(filename, data_dict)
    print("The data has been serialized through Python")
def deserializingSerializing_PyMAT(filename, originalString, originalFloat, originalInt8):
    # Open the HDF5 file for reading
    with h5py.File(filename, 'r') as file:
        stringValueB = file['string_data'][()].tobytes().decode('utf-16')
        floatValueB = file['float_data'][()]
        int8ValueB = file['int8_data'][()]

    TestResult(stringValueB == originalString, "String")
    TestResult(floatValueB == originalFloat, "Float")
    TestResult(int8ValueB == originalInt8, "Int8")

    data_dict = {
        'string_data': stringValueB,
        'float_data': floatValueB,
        'int8_data': np.array([int8ValueB], dtype=np.int8)
    }

    savemat(filename, data_dict)

    print("The data has been serialized back through Python!")
def deserializingSerializing_PyJl(filename, originalString, originalFloat, originalInt8):
    with h5py.File(filename, 'r') as file:
        string_value_bytes = file['string_data'][()]
        stringValue = string_value_bytes.tobytes().decode('utf-8').replace('\x00', '')
        floatValue = file['float_data'][()]
        int8Value = file['int8_data'][()]

    TestResult(stringValue == originalString, "String")
    TestResult(floatValue == originalFloat, "Float")
    TestResult(int8Value == originalInt8, "Int8")

    data_dict = {
        'string_data': stringValue,
        'float_data': floatValue,
        'int8_data': np.array([int8Value], dtype=np.int8)
    }

    savemat(filename, data_dict)
    print("The data has been serialized back through Python!")
def deserializing_PyMAT(filename, originalString, originalFloat, originalInt8):
    # Load the data from the .mat file
    with h5py.File(filename, 'r') as file:
        stringValueB = file['string_data'][()].tobytes().decode('utf-16')
        floatValueB = file['float_data'][()]
        int8ValueB = file['int8_data'][()]

    # Test the deserialized values
    TestResult(stringValueB == originalString, "String")
    TestResult(floatValueB == originalFloat, "Float")
    TestResult(int8ValueB == originalInt8, "Int8")
def deserializing_PyJl(filename, originalString, originalFloat, originalInt8):
    # Open the HDF5 file for reading
    with h5py.File(filename, 'r') as file:
        string_value_bytes = file['string_data'][()]
        stringValue = string_value_bytes.tobytes().decode('utf-8').replace('\x00', '')
        floatValue = file['float_data'][()]
        int8Value = file['int8_data'][()]

    TestResult(stringValue == originalString, "String")
    TestResult(floatValue == originalFloat, "Float")
    TestResult(int8Value == originalInt8, "Int8")
def main():
    if len(sys.argv) < 2:
        print("Usage: python Main.py <function_name> [args...]")
        sys.exit(1)

    command = sys.argv[1]
    filename = sys.argv[2]
    stringValue = sys.argv[3]
    floatValue = float(sys.argv[4])
    int8Value = np.int8(int(sys.argv[5]))

    if command == 'selfTesting':
        selfTesting(filename, stringValue, floatValue, int8Value)
    elif command == 'serializing_Py':
        serializing_Py(filename, stringValue, floatValue, int8Value)
    elif command == 'deserializingSerializing_PyMAT':
        deserializingSerializing_PyMAT(filename, stringValue, floatValue, int8Value)
    elif command == 'deserializingSerializing_PyJl':
        deserializingSerializing_PyJl(filename, stringValue, floatValue, int8Value)
    elif command == 'deserializing_PyMAT':
        deserializing_PyMAT(filename, stringValue, floatValue, int8Value)
    elif command == 'deserializing_PyJl':
        deserializing_PyJl(filename, stringValue, floatValue, int8Value)
    else:
        print(f"Unknown function: {command}")
        sys.exit(1)
if __name__ == "__main__":
    main()
