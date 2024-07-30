using MAT

# Initialize the data to be serialized
stringValue = "example_string"
floatValue = 3.14159
int8Value = Int8(42)

# Create and write to a .mat file
file = matopen("/Users/elinarezaeian/PycharmProjects/HDF5-Testing/example.mat", "w") do file
  write(file, "stringValue", stringValue)
  write(file, "floatValue", floatValue)
  write(file, "int8Value", int8Value)
end

println("The data has been Serialized! ")
