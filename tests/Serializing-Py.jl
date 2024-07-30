using HDF5

# Initialize the data to be serialized
stringValue = "example_string"
floatValue = 3.14159
int8Value = Int8(42)

h5open("/Users/elinarezaeian/PycharmProjects/HDF5-Testing/mydata.h5", "w") do file
  # Create datasets
  write(file, "stringValue", stringValue)
  write(file, "floatValue", floatValue)
  write(file, "int8Value", int8Value)

end
print("The data has been Serialized!")