using MAT

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

# Serialize data to a .MAT file
matwrite("/Users/elinarezaeian/PycharmProjects/HDF5-Testing/example.mat", Dict(
    "string_data" => stringValue,
    "float_data" => floatValue,
    "int8_data" => int8Value
))

# Store original values for comparison after deserialization
mystringA = stringValue
myFloatA = floatValue
myInt8A = int8Value

# Deserialize data from the .MAT file
data = matread("/Users/elinarezaeian/PycharmProjects/HDF5-Testing/example.mat")

# Deserialize and print the string
mystringB = data["string_data"]
println("String data: ", mystringB)
TestResult(mystringA == mystringB, "String")

# Deserialize and print the float
myFloatB = data["float_data"]
println("Float data: ", myFloatB)
TestResult(myFloatB == myFloatA, "Float")

# Deserialize and print the int8
myInt8B = data["int8_data"]
println("Int8 data: ", myInt8B)
TestResult(myInt8B == myInt8A, "Int8")

