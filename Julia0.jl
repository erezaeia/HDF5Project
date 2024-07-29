using MAT
# Function to print the result of a test
function TestResult(x::Bool, S::String)
    if x
        println("Our test for $S was Successful!")
    else
        println("***Our test for $S Failed!***")
    end
end
# Function for selfTesting
function selfTesting(filename::String, stringValue::String, floatValue::Float64, int8Value::Int8)
    # Serialize data to a .MAT file
    matwrite(filename, Dict(
        "string_data" => stringValue,
        "float_data" => floatValue,
        "int8_data" => int8Value
    ))

    # Deserialize data from the .MAT file
    data = matread(filename)

    # Deserialize and test the string
    mystringB = data["string_data"]
    TestResult(stringValue == mystringB, "String")

    # Deserialize and test the float
    myFloatB = data["float_data"]
    TestResult(myFloatB == floatValue, "Float")

    # Deserialize and test the int8
    myInt8B = data["int8_data"]
    TestResult(myInt8B == int8Value, "Int8")
end
# Function for serialize_data
function serialize_data(filename::String, stringValue::String, floatValue::Float64, int8Value::Int8)
    # Create and write to a .mat file
    matopen(filename, "w") do file
        write(file, "stringValue", stringValue)
        write(file, "floatValue", floatValue)
        write(file, "int8Value", int8Value)
    end
    println("The data has been serialized through Julia! ")
end
# Function for deserialize_data
function deserialize_data(filename::String, stringValue::String, floatValue::Float64, int8Value::Int8)
    # Open the .mat file for reading
    file = matopen(filename, "r")

    # Read the variables
    loadedStringValue = read(file, "loadedStringValue")
    loadedFloatValue = read(file, "loadedFloatValue")
    loadedInt8Value = read(file, "loadedInt8Value")

    # Close the file
    close(file)

    # Test the deserialized values
    TestResult(loadedStringValue == stringValue, "String")
    TestResult(loadedFloatValue == floatValue, "Float")
    TestResult(loadedInt8Value == int8Value, "Int8")
end
# Function for deserializeSerialize_data
function deserializeSerialize_data(filename::String, stringValue::String, floatValue::Float64, int8Value::Int8)
    # Open the .mat file for reading
    file = matopen(filename, "r")

    # Read the variables
    loadedStringValue = read(file, "stringValue")
    loadedFloatValue = read(file, "floatValue")
    loadedInt8Value = read(file, "int8Value")

    # Close the file
    close(file)

    # Test the deserialized values
    TestResult(loadedStringValue == stringValue, "String")
    TestResult(loadedFloatValue == floatValue, "Float")
    TestResult(loadedInt8Value == int8Value, "Int8")

    # Serialize the data back to the .mat file
    matopen(filename, "w") do file
        write(file, "stringValue", loadedStringValue)
        write(file, "floatValue", loadedFloatValue)
        write(file, "int8Value", loadedInt8Value)
    end

    println("The data has been serialized back through Julia! ")
end
# Function to handle command-line arguments and call the appropriate function
function MainFunction()
    if length(ARGS) < 5
        println("Usage: julia combined_functions.jl <command> <filename> <stringValue> <floatValue> <int8Value>")
        return
    end
    command = ARGS[1]
    filename = ARGS[2]
    stringValue = ARGS[3]
    floatValue = parse(Float64, ARGS[4])
    int8Value = Int8(parse(Int, ARGS[5]))

    if command == "selfTesting"
        selfTesting(filename, stringValue, floatValue, int8Value)
    elseif command == "serialize_data"
        serialize_data(filename, stringValue, floatValue, int8Value)
    elseif command == "deserialize_data"
        deserialize_data(filename, stringValue, floatValue, int8Value)
    elseif command == "deserializeSerialize_data"
        deserializeSerialize_data(filename, stringValue, floatValue, int8Value)
    else
        println("Unknown command: $command")
    end
end
# Execute the run_function if the script is run from the command line
if abspath(PROGRAM_FILE) == @__FILE__
    MainFunction()
end
