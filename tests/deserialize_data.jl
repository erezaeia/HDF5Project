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
stringValue = read(file, "stringValue")
floatValue = read(file, "floatValue")
int8Value = read(file, "int8Value")

# Close the file
close(file)

# Initialize the data to be serialized
mystringA = "example_string"
myFloatA = 3.14159
myInt8A = Int8(42)

# Print and test the deserialized values
println("String data: ", stringValue)
TestResult(stringValue == mystringA, "String")

println("Float data: ", floatValue)
TestResult(floatValue == myFloatA, "Float")

println("Int8 data: ", int8Value)
TestResult(int8Value == myInt8A, "Int8")
