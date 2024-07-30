using HDF5

# Function to print the result of a test
function TestResult(x::Bool, S::String)
    if x
        println("Our test for $S was Successful!\n")
    else
        println("Our test for $S Failed!\n")
    end
end

# Initialize the data to be serialized
stringValue = "example_string"
floatValue = 3.14159
int8Value = Int8(42)

# Open an HDF5 file for writing
h5open("example.h5", "w") do file
    # Create datasets
    write(file, "string_data", stringValue)
    write(file, "float_data", floatValue)
    write(file, "int8_data", int8Value)
end

# Store original values for comparison after deserialization
mystringA = stringValue
myFloatA = floatValue
myInt8A = int8Value

# Open the HDF5 file for reading
h5file = h5open("example.h5", "r") do file
    # Deserialize and print the string
    mystringB = read(file["string_data"], String)
    println("String data: ", mystringB)
    TestResult(mystringA == mystringB, "String")

    # Deserialize and print the float
    myFloatB = read(file["float_data"])
    println("Float data: ", myFloatB)
    TestResult(myFloatB == myFloatA, "Float")

    # Deserialize and print the int8
    myInt8B = read(file["int8_data"])
    println("Int8 data: ", myInt8B)
    TestResult(myInt8B == myInt8A, "Int8")
end
