using MAT
using JSON

# This is a test change
# Function to print the result of a test
function TestResult(x::Bool, S::String)
    if x
        println("$S ---> Successful!")
    else
        println("\e[31m$S ---> Failed!***\e[0m")
    end
end
# Function for selfTesting
function selfTesting(filename::String, stringValue::String, floatValue::Float64, int8Value::Int8, uint8Value::UInt8, int16Value::Int16, uint16Value::UInt16, int32Value::Int32,
    uint32Value::UInt32, int64Value::Int64, uint64Value::UInt64, int128Value::Int128, uint128Value::UInt128, float16Value::Float16, float32Value::Float32, boolValue::Bool, charValue::Char, complexValue::Complex)

    # Convert Int128 and UInt128 to strings
    int128Str = string(int128Value)
    uint128Str = string(uint128Value)
    # Convert Float16 to Float32 for compatibility with MAT
    float16AsFloat32 = Float32(float16Value)

    # Serialize data to a .MAT file
    matwrite(filename, Dict(
        "string_data" => stringValue,
        "float_data" => floatValue,
        "int8_data" => int8Value,
        "uint8_data" => uint8Value,
        "int16_data" => int16Value,
        "uint16_data" => uint16Value,
        "int32_data" => int32Value,
        "uint32_data" => uint32Value,
        "int64_data" => int64Value,
        "uint64_data" => uint64Value,
        "int128_data" => int128Str,
        "uint128_data" => uint128Str,
        "float16_data" => float16AsFloat32,
        "float32_data" => float32Value,
        "bool_data" => boolValue,
        "char_data" => string(charValue),
        "complex_data" => string(complexValue)
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

    # Deserialize and test the uint8
    myUInt8B = data["uint8_data"]
    TestResult(myUInt8B == uint8Value, "UInt8")

    # Deserialize and test the int16
    myInt16B = data["int16_data"]
    TestResult(myInt16B == int16Value, "Int16")

    # Deserialize and test the uint16
    myUInt16B = data["uint16_data"]
    TestResult(myUInt16B == uint16Value, "UInt16")

    # Deserialize and test the int32
    myInt32B = data["int32_data"]
    TestResult(myInt32B == int32Value, "Int32")

    # Deserialize and test the uint32
    myUInt32B = data["uint32_data"]
    TestResult(myUInt32B == uint32Value, "UInt32")

    # Deserialize and test the int64
    myInt64B = data["int64_data"]
    TestResult(myInt64B == int64Value, "Int64")

    # Deserialize and test the uint64
    myUInt64B = data["uint64_data"]
    TestResult(myUInt64B == uint64Value, "UInt64")

    # Deserialize and test the int128
    myInt128B = parse(Int128, data["int128_data"])
    TestResult(myInt128B == int128Value, "Int128")

    # Deserialize and test the uint128
    myUInt128B = parse(UInt128, data["uint128_data"])
    TestResult(myUInt128B == uint128Value, "UInt128")

    # Deserialize and test the float16
    myFloat16B = data["float16_data"]
    TestResult(myFloat16B == float16Value, "Float16")

    # Deserialize and test the float32
    myFloat32B = data["float32_data"]
    TestResult(myFloat32B == float32Value, "Float32")

    # Deserialize and test the bool
    myBoolB = data["bool_data"]
    TestResult(myBoolB == boolValue, "Bool")

    # Deserialize and test the char
    myCharB = data["char_data"][1]
    TestResult(myCharB == charValue, "Char")

    # Deserialize and test the complex
    myComplexB = parse(Complex{Float64}, data["complex_data"])
    TestResult(myComplexB == complexValue, "Complex")

end
# Function for serialize_data
function serialize_data(filename::String, data_dict::Dict{String, Any})
    try
        matwrite(filename, data_dict)
        println("The data has been serialized through Julia!")
    catch e
        println("An error occurred: $e")
    end
end
# Function for deserialize_data
function deserialize_data(filename::String, originalString::String, originalFloat::Float64, originalInt8::Int8, originalUInt8::UInt8, originalInt16::Int16, originalUInt16::UInt16, originalInt32::Int32, originalUInt32::UInt32, originalInt64::Int64, originalUInt64::UInt64, originalFloat16::Float16, originalFloat32::Float32, originalBool::Bool, originalChar::Char, originalComplex::Complex)
    try
        # Open the .mat file for reading
        data = matread(filename)

        # Deserialize each item based on its key
        for (key, value) in data
            if key == "string_data"
                stringValue = value
                TestResult(stringValue == originalString, "String")
            elseif key == "float_data"
                floatValue = value
                TestResult(floatValue == originalFloat, "Float")
            elseif key == "int8_data"
                int8Value = value
                TestResult(int8Value == originalInt8, "Int8")
            elseif key == "uint8_data"
                uint8Value = value
                TestResult(uint8Value == originalUInt8, "UInt8")
            elseif key == "int16_data"
                int16Value = value
                TestResult(int16Value == originalInt16, "Int16")
            elseif key == "uint16_data"
                uint16Value = value
                TestResult(uint16Value == originalUInt16, "UInt16")
            elseif key == "int32_data"
                int32Value = value
                TestResult(int32Value == originalInt32, "Int32")
            elseif key == "uint32_data"
                uint32Value = value
                TestResult(uint32Value == originalUInt32, "UInt32")
            elseif key == "int64_data"
                int64Value = value
                TestResult(int64Value == originalInt64, "Int64")
            elseif key == "uint64_data"
                uint64Value = value
                println(uint64Value)
                println(originalUInt64)
                TestResult(uint64Value == originalUInt64, "UInt64")
            elseif key == "float16_data"
                float16Value = Float16(value)
                TestResult(float16Value == originalFloat16, "Float16")
            elseif key == "float32_data"
                float32Value = Float32(value)
                TestResult(float32Value == originalFloat32, "Float32")
            elseif key == "bool_data"
                boolValue = value
                TestResult(boolValue == originalBool, "Bool")
            elseif key == "char_data"
                charValue = string(value)
                TestResult(charValue == string(originalChar), "Char")
            elseif key == "complex_data"
                if isa(value, String)
                    # If the value is a string, parse it into a complex number
                    complexValue = parse(Complex{Float64}, value)
                else
                    # If the value is not a string, assume it is already a complex number
                    complexValue = value
                end
                TestResult(complexValue == originalComplex, "Complex")
            else
                println("Unknown data type for key: $key")
            end
        end
    catch e
        println("An error occurred: $e")
    end
end
# Function for deserializeSerialize_data
function deserializeSerialize_data(filename::String, originalString::String, originalFloat::Float64, originalInt8::Int8, originalUInt8::UInt8, originalInt16::Int16, originalUInt16::UInt16, originalInt32::Int32, originalUInt32::UInt32, originalInt64::Int64, originalUInt64::UInt64, originalFloat16::Float16, originalFloat32::Float32, originalBool::Bool, originalChar::Char, originalComplex::Complex)
    try
        # Open the .mat file for reading
        data = matread(filename)

        # Deserialize each item based on its key
        for (key, value) in data
            if key == "string_data"
                stringValue = value
                TestResult(stringValue == originalString, "String")
                data["string_data"] = stringValue
            elseif key == "float_data"
                floatValue = value
                TestResult(floatValue == originalFloat, "Float")
                data["float_data"] = floatValue
            elseif key == "int8_data"
                int8Value = value
                TestResult(int8Value == originalInt8, "Int8")
                data["int8_data"] = int8Value
            elseif key == "uint8_data"
                uint8Value = value
                TestResult(uint8Value == originalUInt8, "UInt8")
                data["uint8_data"] = uint8Value
            elseif key == "int16_data"
                int16Value = value
                TestResult(int16Value == originalInt16, "Int16")
                data["int16_data"] = int16Value
            elseif key == "uint16_data"
                uint16Value = value
                TestResult(uint16Value == originalUInt16, "UInt16")
                data["uint16_data"] = uint16Value
            elseif key == "int32_data"
                int32Value = value
                TestResult(int32Value == originalInt32, "Int32")
                data["int32_data"] = int32Value
            elseif key == "uint32_data"
                uint32Value = value
                TestResult(uint32Value == originalUInt32, "UInt32")
                data["uint32_data"] = uint32Value
            elseif key == "int64_data"
                int64Value = value
                TestResult(int64Value == originalInt64, "Int64")
                data["int64_data"] = int64Value
            elseif key == "uint64_data"
                uint64Value = value
                TestResult(uint64Value == originalUInt64, "UInt64")
                data["uint64_data"] = uint64Value
            elseif key == "float16_data"
                float16Value = Float16(value)
                TestResult(float16Value == originalFloat16, "Float16")
                data["float16_data"] = value
            elseif key == "float32_data"
                float32Value = Float32(value)
                TestResult(float32Value == originalFloat32, "Float32")
                data["float32_data"] = float32Value
            elseif key == "bool_data"
                boolValue = value
                TestResult(boolValue == originalBool, "Bool")
                data["bool_data"] = boolValue
            elseif key == "char_data"
                charValue = string(value)
                TestResult(charValue == string(originalChar), "Char")
                data["char_data"] = charValue
            elseif key == "complex_data"
                complexValue = parse(Complex{Float64}, value)
                TestResult(complexValue == originalComplex, "Complex")
                data["complex_data"] = complexValue
            else
                println("Unknown data type for key: $key")
            end
        end

        # Save the updated dictionary back to the file
        matwrite(filename, data)
        println("The data has been serialized back through Julia!")
    catch e
        println("An error occurred: $e")
    end
end
# Function to handle command-line arguments and call the appropriate function
function MainFunction()
    if length(ARGS) < 2
        println("Usage: julia combined_functions.jl <command> <filename> <stringValue> <floatValue> <int8Value>")
        return
    end
    command = ARGS[1]
    filename = ARGS[2]
    
    if command == "selfTesting"
        if length(ARGS) < 19
            println("Usage: julia combined_functions.jl selfTesting <filename> <stringValue> <floatValue> <int8Value>")
            return
        end
        stringValue = ARGS[3]
        floatValue = parse(Float64, ARGS[4])
        int8Value = Int8(parse(Int8, ARGS[5]))
        uint8Value = UInt8(parse(UInt8, ARGS[6]))
        int16Value = Int16(parse(Int16, ARGS[7]))
        uint16Value = UInt16(parse(UInt16, ARGS[8]))
        int32Value = Int32(parse(Int32, ARGS[9]))
        uint32Value = UInt32(parse(UInt32, ARGS[10]))
        int64Value = Int64(parse(Int64, ARGS[11]))
        uint64Value = UInt64(parse(UInt64, ARGS[12]))
        int128Value = Int128(parse(Int128, ARGS[13]))
        uint128Value = UInt128(parse(UInt128, ARGS[14]))
        float16Value = parse(Float16, ARGS[15])
        float32Value = parse(Float32, ARGS[16])
        boolValue = ARGS[17] == "true" ? true : false
        charValue = ARGS[18][1]
        complexValue = parse(Complex{Float64}, ARGS[19])
        selfTesting(filename, stringValue, floatValue, int8Value, uint8Value, int16Value, uint16Value, int32Value, uint32Value, int64Value, uint64Value, int128Value, uint128Value, float16Value, float32Value, boolValue, charValue, complexValue)
    elseif command == "serialize_data"
        if length(ARGS) < 3
            println("Usage: julia combined_functions.jl serialize_data <filename> <data_dict>")
            return
        end
        data_dict = JSON.parse(ARGS[3])
        
        serialize_data(filename, data_dict)
    elseif command == "deserialize_data"
        if length(ARGS) < 17
            println("Usage: julia combined_functions.jl deserializeSerialize_JlMAT <filename> <stringValue> <floatValue> <int8Value>")
            return
        end
        stringValue = ARGS[3]
        floatValue = parse(Float64, ARGS[4])
        int8Value = Int8(parse(Int, ARGS[5]))
        uint8Value = UInt8(parse(UInt8, ARGS[6]))
        int16Value = Int16(parse(Int16, ARGS[7]))
        uint16Value = UInt16(parse(UInt16, ARGS[8]))
        int32Value = Int32(parse(Int32, ARGS[9]))
        uint32Value = UInt32(parse(UInt32, ARGS[10]))
        int64Value = Int64(parse(Int64, ARGS[11]))
        uint64Value = UInt64(parse(UInt64, ARGS[12]))
        float16Value = parse(Float16, ARGS[13])
        float32Value = parse(Float32, ARGS[14])
        boolValue = ARGS[15] == "true" ? true : false
        charValue = ARGS[16][1]
        complexValue = parse(Complex{Float64}, ARGS[17])
        deserialize_data(filename, stringValue, floatValue, int8Value, uint8Value, int16Value, uint16Value, int32Value, uint32Value, int64Value, uint64Value, float16Value, float32Value, boolValue, charValue, complexValue)
    elseif command == "deserializeSerialize_data"
        if length(ARGS) < 17
            println("Usage: julia combined_functions.jl deserializeSerialize_JlMAT <filename> <stringValue> <floatValue> <int8Value>")
            return
        end
        stringValue = ARGS[3]
        floatValue = parse(Float64, ARGS[4])
        int8Value = Int8(parse(Int, ARGS[5]))
        uint8Value = UInt8(parse(UInt8, ARGS[6]))
        int16Value = Int16(parse(Int16, ARGS[7]))
        uint16Value = UInt16(parse(UInt16, ARGS[8]))
        int32Value = Int32(parse(Int32, ARGS[9]))
        uint32Value = UInt32(parse(UInt32, ARGS[10]))
        int64Value = Int64(parse(Int64, ARGS[11]))
        uint64Value = UInt64(parse(UInt64, ARGS[12]))
        float16Value = parse(Float16, ARGS[13])
        float32Value = parse(Float32, ARGS[14])
        boolValue = ARGS[15] == "true" ? true : false
        charValue = ARGS[16][1]
        complexValue = parse(Complex{Float64}, ARGS[17])
        deserializeSerialize_data(filename, stringValue, floatValue, int8Value, uint8Value, int16Value, uint16Value, int32Value, uint32Value, int64Value, uint64Value, float16Value, float32Value, boolValue, charValue, complexValue)
    else
        println("Unknown command: $command")
    end
end
# Execute the run_function if the script is run from the command line
if abspath(PROGRAM_FILE) == @__FILE__
    MainFunction()
end
