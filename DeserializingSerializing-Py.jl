using HDF5

# Function to read data from HDF5 file
function read_hdf5_data(filename::String)
    mystringB = ""
    myFloatB = 0.0
    myInt8B = 0
    
    h5open(filename, "r") do file
        mystringB = read(file["stringValue"], String)
        myFloatB = read(file["floatValue"])
        myInt8B = read(file["int8Value"])
    end

    return mystringB, myFloatB, myInt8B
end

# Initialize the data to be serialized
mystringA = "example_string"
myFloatA = 3.14159
myInt8A = Int8(42)

function TestResult(x::Bool, S::String)
    if x
        println("Our test for $S was Successful!\n")
    else
        println("Our test for $S Failed!\n")
    end
end

# Read data from the HDF5 file
mystringB, myFloatB, myInt8B = read_hdf5_data("/Users/elinarezaeian/PycharmProjects/HDF5-Testing/mydata.h5")

# Print and test the deserialized values
println("String data: ", mystringB)
TestResult(mystringA == mystringB, "String")

println("Float data: ", myFloatB)
TestResult(myFloatB == myFloatA, "Float")

println("Int8 data: ", myInt8B)
TestResult(myInt8B == myInt8A, "Int8")

# Open the HDF5 file for writing
h5open("/Users/elinarezaeian/PycharmProjects/HDF5-Testing/mydata.h5", "w") do file
    # Create datasets
    write(file, "stringValue", mystringB)
    println("String data written: ", mystringB)
    write(file, "floatValue", myFloatB)
    println("Float data written: ", myFloatB)
    write(file, "int8Value", myInt8B)
    println("Int8 data written: ", myInt8B)
    print("\nThe data has been Serialized through Julia again!")
end
