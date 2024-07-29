import sys
import numpy as np
import scipy.io
import h5py
from numpy import int8
from scipy.io import savemat
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
    # Save each variable separately to a .mat file
    savemat(filename, {'stringValue': originalString, 'floatValue': originalFloat, 'int8Value': np.array([originalInt8], dtype=np.int8)})

    print("The data has been serialized through Python")
def deserializingSerializing_PyMAT(filename, originalString, originalFloat, originalInt8):
    # Open the HDF5 file for reading
    with h5py.File(filename, 'r') as file:
        # Read and decode the string data
        # UTF-16  can handle the null Characters
        stringValueB = file['stringValue'][...].tobytes().decode('utf-16')
        # Read the float data
        floatValueB = file['floatValue'][0][0]
        # Read the int8 data
        int8ValueB = file['int8Value'][0][0]

    TestResult(stringValueB == originalString, "String")
    TestResult(floatValueB == originalFloat, "Float")
    TestResult(int8ValueB == originalInt8, "Int8")

    savemat('mydata.mat', {'stringValue': stringValueB, 'floatValue': floatValueB, 'int8Value': np.array([int8ValueB], dtype=np.int8)})

    print("The data has been serialized back through Python!")
def deserializingSerializing_PyJl(filename, originalString, originalFloat, originalInt8):
    # Open the HDF5 file for reading
    with h5py.File(filename, 'r') as file:
        # Read and decode the string data
        string_value_bytes = file['stringValue'][()]
        stringValue = string_value_bytes.tobytes().decode('utf-8').replace('\x00', '')
        # Read the float data
        floatValue = file['floatValue'][()]
        # Read the int8 data
        int8Value = file['int8Value'][()]

    TestResult(stringValue == originalString, "String")
    TestResult(floatValue == originalFloat, "Float")
    TestResult(int8Value == originalInt8, "Int8")

    # Prepare data for writing back to a .mat file
    mat_data = {
        'loadedStringValue': np.array([stringValue], dtype='S'),
        'loadedFloatValue': np.array([floatValue]),
        'loadedInt8Value': np.array([int8Value], dtype=np.int8)
    }

    savemat(filename, mat_data)
    print("The data has been serialized back through Python!")
def deserializing_PyMAT(filename, originalString, originalFloat, originalInt8):
    # Open the HDF5 file for reading
    with h5py.File(filename, 'r') as file:
        # Read and decode the string data
        # UTF-16  can handle the null Characters
        stringValueB = file['loadedStringValue'][...].tobytes().decode('utf-16')
        # Read the float data
        floatValueB = file['loadedFloatValue'][0][0]
        # Read the int8 data
        int8ValueB = file['loadedInt8Value'][0][0]

    TestResult(stringValueB == originalString, "String")
    TestResult(floatValueB == originalFloat, "Float")
    TestResult(int8ValueB == originalInt8, "Int8")
def deserializing_PyJl(filename, originalString, originalFloat, originalInt8):

    with h5py.File(filename, 'r') as file:
        # Read and decode the string data
        string_value_bytes = file['stringValue'][()]
        stringValue = string_value_bytes.tobytes().decode('utf-8').replace('\x00', '')
        # Read the float data
        floatValue = file['floatValue'][()]
        # Read the int8 data
        int8Value = file['int8Value'][()]

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
