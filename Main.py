import json
import sys
import numpy as np
import scipy.io
import h5py
import scipy
from numpy import int8
from scipy.io import savemat, loadmat


def TestResult(x, S):
    if x:
        print(f"{S} ---> Successful!")
    else:
        print(f"\033[91m{S} ---> Failed!***\033[0m")
def selfTesting(filename, stringValue, floatValue, int8Value, uint8Value, int16Value, uint16Value, int32Value, uint32Value, int64Value, uint64Value, float16Value, float32Value, boolValue, charValue, complexValue):
    savemat(filename, {
        'string_data': stringValue,
        'float_data': np.array([floatValue], dtype=np.float64),
        'int8_data': np.array([int8Value], dtype=np.int8),
        'uint8_data': np.array([uint8Value], dtype=np.uint8),
        'int16_data': np.array([int16Value], dtype=np.int16),
        'uint16_data': np.array([uint16Value], dtype=np.uint16),
        'int32_data': np.array([int32Value], dtype=np.int32),
        'uint32_data': np.array([uint32Value], dtype=np.uint32),
        'int64_data': np.array([int64Value], dtype=np.int64),
        'uint64_data': np.array([uint64Value], dtype=np.uint64),
        'float16_data': np.array([float16Value], dtype=np.float16),
        'float32_data': np.array([float32Value], dtype=np.float32),
        'bool_data': np.array([boolValue], dtype=np.bool_),
        'char_data': np.array([charValue], dtype=np.str_),
        'complex_data': np.array([complexValue], dtype=np.complex64)
        })

    data = scipy.io.loadmat(filename)

    # Test the deserialized values
    TestResult(stringValue == data['string_data'].item(), "String")
    TestResult(floatValue == data['float_data'].item(), "Float")
    TestResult(int8Value == data['int8_data'].item(), "Int8")
    TestResult(uint8Value == data['uint8_data'].item(), "UInt8")
    TestResult(int16Value == data['int16_data'].item(), "Int16")
    TestResult(uint16Value == data['uint16_data'].item(), "UInt16")
    TestResult(int32Value == data['int32_data'].item(), "Int32")
    TestResult(uint32Value == data['uint32_data'].item(), "UInt32")
    TestResult(int64Value == data['int64_data'].item(), "Int64")
    TestResult(uint64Value == data['uint64_data'].item(), "UInt64")
    TestResult(float16Value == data['float16_data'].item(), "Float16")
    TestResult(float32Value == data['float32_data'].item(), "Float32")
    TestResult(boolValue == data['bool_data'].item(), "Boolean")
    TestResult(charValue == data['char_data'].item(), "Character")
    TestResult(complexValue == data['complex_data'].item(), "Complex")
def serializing_Py(filename, data_dict):
    try:
        data_dict = json.loads(data_dict)
        savemat(filename, data_dict)
        print("The data has been serialized through Python")
    except Exception as e:
        print(f"An error occurred: {e}")
def deserializingSerializing_Py(filename, originalString, originalFloat, originalInt8, originalUInt8, originalInt16, originalUInt16, originalInt32, originalUInt32, originalInt64, originalUInt64,originalFloat16, originalFloat32, originalBool, originalChar, originalComplex):
    try:
        # Open the HDF5 file for reading
        with h5py.File(filename, 'r') as file:
            data_dict = {key: file[key][()] for key in file.keys()}

        # Deserialize each item based on its key
        for key, value in data_dict.items():
            if key == 'string_data':
                stringValue = value.tobytes().decode('utf-16')
                TestResult(stringValue == originalString, "String")
                data_dict[key] = stringValue
            elif key == 'float_data':
                floatValue = value
                TestResult(floatValue == originalFloat, "Float")
                data_dict[key] = floatValue
            elif key == 'int8_data':
                int8Value = value
                TestResult(int8Value == originalInt8, "Int8")
                data_dict[key] = int8Value
            elif key == 'uint8_data':
                uint8Value = value
                TestResult(uint8Value == originalUInt8, "UInt8")
                data_dict[key] = uint8Value
            elif key == 'int16_data':
                int16Value = value
                TestResult(int16Value == originalInt16, "Int16")
                data_dict[key] = int16Value
            elif key == 'uint16_data':
                uint16Value = value
                TestResult(uint16Value == originalUInt16, "UInt16")
                data_dict[key] = uint16Value
            elif key == 'int32_data':
                int32Value = value
                TestResult(int32Value == originalInt32, "Int32")
                data_dict[key] = int32Value
            elif key == 'uint32_data':
                uint32Value = value
                TestResult(uint32Value == originalUInt32, "UInt32")
                data_dict[key] = uint32Value
            elif key == 'int64_data':
                int64Value = value
                TestResult(int64Value == originalInt64, "Int64")
                data_dict[key] = int64Value
            elif key == 'uint64_data':
                uint64Value = np.uint64(value)
                TestResult(uint64Value == originalUInt64, "UInt64")
                data_dict[key] = uint64Value
            elif key == 'float16_data':
                float16Value = value.item() if isinstance(value, np.ndarray) else value
                TestResult(float16Value == originalFloat16, "Float16")
                data_dict[key] = float16Value
            elif key == 'float32_data':
                float32Value = value.item() if isinstance(value, np.ndarray) else value
                TestResult(float32Value == originalFloat32, "Float32")
                data_dict[key] = float32Value
            elif key == 'bool_data':
                boolValue = value
                TestResult(boolValue == originalBool, "Bool")
                data_dict[key] = boolValue
            elif key == 'char_data':
                charValue = value.tobytes().decode('utf-16')
                TestResult(charValue == originalChar, "Char")
                data_dict[key] = charValue
            elif key == 'complex_data':
                # Check if the value is a string (likely if serialized directly)
                if isinstance(value, str):
                    # This handles the case where the complex number might have been serialized as a string
                    complexValue = complex(value.tobytes().decode('utf-16'))
                    data_dict[key] = complexValue

                # Check if the value is a MATLAB or Julia-like structure (list/array with real and imaginary parts)
                elif isinstance(value, list) or isinstance(value, np.ndarray):
                    # Handle MATLAB-like serialization (list/array of real and imaginary parts)
                    if len(value) == 1 and isinstance(value[0], np.ndarray):
                        real_part, imag_part = value[0][0]
                        complexValue = complex(real_part, imag_part)
                        TestResult(complexValue == originalComplex, "Complex")
                        data_dict[key] = complexValue
                    # Deserializing from saving through Shell script
                    elif len(value) == 4:
                        complexValue = complex(value.tobytes().decode('utf-16'))
                        TestResult(complexValue == originalComplex, "Complex")
                        data_dict[key] = complexValue

                    # Handle Julia-like serialization (list of tuples with real and imaginary parts)
                    elif len(value) == 1:
                        real_part, imag_part = value[0]
                        complexValue = complex(real_part, imag_part)
                        TestResult(complexValue == originalComplex, "Complex")
                        data_dict[key] = complexValue
            else:
                print(f"Unknown data type for key: {key}")

        # Save the updated dictionary back to the file
        savemat(filename, data_dict)
        print("The data has been serialized back through Python!")
    except Exception as e:
        print(f"An error occurred: {e}")
def deserializing_Py(filename, originalString, originalFloat, originalInt8, originalUInt8, originalInt16, originalUInt16, originalInt32, originalUInt32, originalInt64, originalUInt64,originalFloat16, originalFloat32, originalBool, originalChar, originalComplex):
    try:
        # Open the HDF5 file for reading
        with h5py.File(filename, 'r') as file:
            data_dict = {key: file[key][()] for key in file.keys()}

        # Deserialize each item based on its key
        for key, value in data_dict.items():
            if key == 'string_data':
                stringValue = value.tobytes().decode('utf-16')
                TestResult(stringValue == originalString, "String")
            elif key == 'float_data':
                floatValue = value
                TestResult(floatValue == originalFloat, "Float")
            elif key == 'int8_data':
                int8Value = value
                TestResult(int8Value == originalInt8, "Int8")
            elif key == 'uint8_data':
                uint8Value = value
                TestResult(uint8Value == originalUInt8, "UInt8")
            elif key == 'int16_data':
                int16Value = value
                TestResult(int16Value == originalInt16, "Int16")
            elif key == 'uint16_data':
                uint16Value = value
                TestResult(uint16Value == originalUInt16, "UInt16")
            elif key == 'int32_data':
                int32Value = value
                TestResult(int32Value == originalInt32, "Int32")
            elif key == 'uint32_data':
                uint32Value = value
                TestResult(uint32Value == originalUInt32, "UInt32")
            elif key == 'int64_data':
                int64Value = value
                TestResult(int64Value == originalInt64, "Int64")
            elif key == 'uint64_data':
                uint64Value = value
                TestResult(uint64Value == originalUInt64, "UInt64")
            elif key == 'float16_data':
                float16Value = np.float16(value)
                TestResult(float16Value == originalFloat16, "Float16")
            elif key == 'float32_data':
                float32Value = np.float32(value)
                TestResult(float32Value == originalFloat32, "Float32")
            elif key == 'bool_data':
                boolValue = value
                TestResult(boolValue == originalBool, "Bool")
            elif key == 'char_data':
                charValue = value.tobytes().decode('utf-16')
                TestResult(charValue == originalChar, "Char")
            elif key == 'complex_data':
                # Check if the value is a string (likely if serialized directly)
                if isinstance(value, str):
                    # This handles the case where the complex number might have been serialized as a string
                    complexValue = complex(value.tobytes().decode('utf-16'))

                # Check if the value is a MATLAB or Julia-like structure (list/array with real and imaginary parts)
                elif isinstance(value, list) or isinstance(value, np.ndarray):
                    # Handle MATLAB-like serialization (list/array of real and imaginary parts)
                    if len(value) == 1 and isinstance(value[0], np.ndarray):
                        real_part, imag_part = value[0][0]
                        complexValue = complex(real_part, imag_part)
                        TestResult(complexValue == originalComplex, "Complex")

                    # Handle Julia-like serialization (list of tuples with real and imaginary parts)
                    elif len(value) == 1:
                        real_part, imag_part = value[0]
                        complexValue = complex(real_part, imag_part)
                        TestResult(complexValue == originalComplex, "Complex")

            else:
                print(f"Unknown data type for key: {key}")

    except Exception as e:
        print(f"An error occurred: {e}")

def main():
    if len(sys.argv) < 2:
        print("Usage: python Main.py <function_name> [args...]")
        sys.exit(1)

    command = sys.argv[1]
    filename = sys.argv[2]

    if command == 'selfTesting':
        if len(sys.argv) < 17:
            print(f"Usage: python Main.py {command} <filename> <stringValue> <floatValue> <int8Value>")
            sys.exit(1)
        stringValue = sys.argv[3]
        floatValue = np.float64(sys.argv[4])
        int8Value = np.int8(int(sys.argv[5]))
        uint8Value = np.uint8(int(sys.argv[6]))
        int16Value = np.int16(int(sys.argv[7]))
        uint16Value = np.uint16(int(sys.argv[8]))
        int32Value = np.int32(int(sys.argv[9]))
        uint32Value = np.uint32(int(sys.argv[10]))
        int64Value = np.int64(int(sys.argv[11]))
        uint64Value = np.uint64(int(sys.argv[12]))
        # int128Value = np.int64(int(sys.argv[13]))  # int128 is not directly supported
        # uint128Value = np.uint64(int(sys.argv[14]))  # uint128 is not directly supported
        float16Value = np.float16(sys.argv[13])
        float32Value = np.float32(sys.argv[14])
        boolValue = bool(sys.argv[15])
        charValue = sys.argv[16]
        complexValue = complex(sys.argv[17])
        selfTesting(filename, stringValue, floatValue, int8Value, uint8Value, int16Value, uint16Value, int32Value,
                    uint32Value, int64Value, uint64Value, float16Value, float32Value, boolValue, charValue, complexValue)
    elif command == 'serializing_Py':
        if len(sys.argv) < 3:
            print(f"Usage: python Main.py {command} <filename> <data_dict>")
            sys.exit(1)
        data_dict = sys.argv[3]
        serializing_Py(filename, data_dict)
    elif command == 'deserializingSerializing_Py':
        if len(sys.argv) < 17:
            print(f"Usage: python Main.py {command} <filename> <stringValue> <floatValue> <int8Value>")
            sys.exit(1)
        stringValue = sys.argv[3]
        floatValue = np.float64(sys.argv[4])
        int8Value = np.int8(int(sys.argv[5]))
        uint8Value = np.uint8(int(sys.argv[6]))
        int16Value = np.int16(int(sys.argv[7]))
        uint16Value = np.uint16(int(sys.argv[8]))
        int32Value = np.int32(int(sys.argv[9]))
        uint32Value = np.uint32(int(sys.argv[10]))
        int64Value = np.int64(int(sys.argv[11]))
        uint64Value = np.uint64(int(sys.argv[12]))
        float16Value = np.float16(sys.argv[13])
        float32Value = np.float32(sys.argv[14])
        boolValue = bool(sys.argv[15])
        charValue = sys.argv[16]
        complexValue = complex(sys.argv[17])
        deserializingSerializing_Py(filename, stringValue, floatValue, int8Value, uint8Value, int16Value, uint16Value, int32Value,
                                    uint32Value, int64Value, uint64Value, float16Value, float32Value, boolValue, charValue, complexValue)

    elif command == 'deserializing_Py':
        if len(sys.argv) < 17:
            print(f"Usage: python Main.py {command} <filename> <stringValue> <floatValue> <int8Value>")
            sys.exit(1)
        stringValue = sys.argv[3]
        floatValue = np.float64(sys.argv[4])
        int8Value = np.int8(int(sys.argv[5]))
        uint8Value = np.uint8(int(sys.argv[6]))
        int16Value = np.int16(int(sys.argv[7]))
        uint16Value = np.uint16(int(sys.argv[8]))
        int32Value = np.int32(int(sys.argv[9]))
        uint32Value = np.uint32(int(sys.argv[10]))
        int64Value = np.int64(int(sys.argv[11]))
        uint64Value = np.uint64(int(sys.argv[12]))
        float16Value = np.float16(sys.argv[13])
        float32Value = np.float32(sys.argv[14])
        boolValue = bool(sys.argv[15])
        charValue = sys.argv[16]
        complexValue = complex(sys.argv[17])
        deserializing_Py(filename, stringValue, floatValue, int8Value, uint8Value, int16Value, uint16Value, int32Value,
                         uint32Value, int64Value, uint64Value, float16Value, float32Value, boolValue, charValue, complexValue)

    else:
        print(f"Unknown function: {command}")
        sys.exit(1)
if __name__ == "__main__":
    main()
