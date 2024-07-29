using MAT

function TestResult(x::Bool, S::String)
    if x
        println("Our test for $S was Successful!\n")
    else
        println("Our test for $S Failed!\n")
    end
end

# Open the .mat file for reading
file = matopen("/Users/elinarezaeian/PycharmProjects/HDF5-Testing/example.mat", "r")

# Read the variables
loadedStringValue = read(file, "stringValue")
loadedFloatValue = read(file, "floatValue")
loadedInt8Value = read(file, "int8Value")

# Close the file
close(file)

# Initialize the data to be serialized
mystringA = "example_string"
myFloatA = 3.14159
myInt8A = 42

# Print and test the deserialized values
println("String data: ", loadedStringValue)
TestResult(loadedStringValue == mystringA, "String")

println("Float data: ", loadedFloatValue)
TestResult(loadedFloatValue == myFloatA, "Float")

println("Int8 data: ", loadedInt8Value)
TestResult(loadedInt8Value == myInt8A, "Int8")

# Create and write to a .mat file
matopen("/Users/elinarezaeian/PycharmProjects/HDF5-Testing/example.mat", "w") do file
    write(file, "stringValue", loadedStringValue)
    write(file, "floatValue", loadedFloatValue)
    write(file, "int8Value", loadedInt8Value)
end

println("The data has been Serialized back through Julia! ")
