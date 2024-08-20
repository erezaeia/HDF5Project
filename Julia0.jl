using MAT
using JSON
using Dates
using Base.MathConstants: pi
using Random

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
    uint32Value::UInt32, int64Value::Int64, uint64Value::UInt64, int128Value::Int128, uint128Value::UInt128, float16Value::Float16, float32Value::Float32, boolValue::Bool, charValue::Char, complexValue::Complex,
    decimalValue::BigFloat, fractionValue::Rational{Int}, bigIntValue::BigInt, nanValue::Float64, durationValue::Millisecond, datetimeValue::DateTime)
    

    # Convert Int128 and UInt128 to strings
    int128Str = string(int128Value)
    uint128Str = string(uint128Value)
    # Convert Float16 to Float32 for compatibility with MAT
    float16AsFloat32 = Float32(float16Value)

    # Convert duration to milliseconds as Int
    durationValueAsInt = Int(durationValue.value)
    # Convert DateTime to ISO string
    datetimeValueAsString = Dates.format(datetimeValue, "yyyy-mm-ddTHH:MM:SS")

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
        "complex_data" => string(complexValue),
        "decimal_data" => string(decimalValue),  # BigFloat stored as a string
        "fraction_data" => string(fractionValue),  # Fraction stored as a string
        "bigint_data" => string(bigIntValue),  # BigInt stored as a string
        "nan_data" => nanValue,
        "duration_data" => durationValueAsInt,  # Store as milliseconds
        "datetime_data" => datetimeValueAsString  # Store as ISO string
    ))

    # Deserialize data from the .MAT file
    data = matread(filename)

    # Test the deserialized values
    TestResult(stringValue == data["string_data"], "String")
    TestResult(floatValue == data["float_data"], "Float")
    TestResult(int8Value == data["int8_data"], "Int8")
    TestResult(uint8Value == data["uint8_data"], "UInt8")
    TestResult(int16Value == data["int16_data"], "Int16")
    TestResult(uint16Value == data["uint16_data"], "UInt16")
    TestResult(int32Value == data["int32_data"], "Int32")
    TestResult(uint32Value == data["uint32_data"], "UInt32")
    TestResult(int64Value == data["int64_data"], "Int64")
    TestResult(uint64Value == data["uint64_data"], "UInt64")
    TestResult(int128Value == parse(Int128, data["int128_data"]), "Int128")
    TestResult(uint128Value == parse(UInt128, data["uint128_data"]), "UInt128")
    TestResult(float16Value == Float16(data["float16_data"]), "Float16")
    TestResult(float32Value == data["float32_data"], "Float32")
    TestResult(boolValue == data["bool_data"], "Bool")
    TestResult(charValue == Char(data["char_data"]), "Char")
    TestResult(complexValue == parse(Complex{Float64}, data["complex_data"]), "Complex")
    TestResult(decimalValue == parse(BigFloat, data["decimal_data"]), "Decimal")
    TestResult(fractionValue == parse(Rational{Int}, data["fraction_data"]), "Fraction")
    TestResult(bigIntValue == parse(BigInt, data["bigint_data"]), "BigInt")
    TestResult(isnan(data["nan_data"]), "NaN")
    TestResult(durationValue == Millisecond(data["duration_data"]), "Duration")
    TestResult(datetimeValue == DateTime(data["datetime_data"]), "DateTime")

end
# Function for serialize_data
function serialize_data(filename::String, data_dict::Dict{String, Any})
    try
        # Ensure nan_data is set to NaN
        data_dict["nan_data"] = NaN

        matwrite(filename, data_dict)
        println("The data has been serialized through Julia!")
    catch e
        println("An error occurred: $e")
    end
end
# Function for deserialize_data
function deserialize_data(filename::String, originalString::String, originalFloat::Float64, originalInt8::Int8, originalUInt8::UInt8, originalInt16::Int16, originalUInt16::UInt16, originalInt32::Int32, originalUInt32::UInt32, originalInt64::Int64, originalUInt64::UInt64, originalFloat16::Float16, originalFloat32::Float32, originalBool::Bool, originalChar::Char, originalComplex::Complex, originalDecimal::BigFloat, originalFraction::Rational{Int}, originalBigInt::BigInt, originalNan::Float64, originalDuration::Millisecond, originalDatetime::DateTime)
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
            elseif key == "decimal_data"
                setprecision(256)
                decimalValue = parse(BigFloat, value)
                TestResult(decimalValue == originalDecimal, "Decimal")
            elseif key == "fraction_data"
                fractionValue = parse(Rational{Int}, value)
                TestResult(fractionValue == originalFraction, "Fraction")
            elseif key == "bigint_data"
                # If the string has a decimal point, remove it
                if occursin(".", value)
                    decoded_value = split(value, ".")[1]  # Keep only the part before the decimal point
                end
                # Convert the decoded string to a BigInt
                bigIntValue = parse(BigInt, decoded_value)
                TestResult(bigIntValue == originalBigInt, "BigInt")

            elseif key == "nan_data"
                nanValue = value
                TestResult(isnan(nanValue), "NaN")
            elseif key == "duration_data"
                # Convert the duration value from seconds to milliseconds
                durationValue = Millisecond(Int(round(value * 1000)))
                TestResult(durationValue == originalDuration, "Duration")
            elseif key == "datetime_data"
                datetimeValue = DateTime(value)
                TestResult(datetimeValue == originalDatetime, "DateTime")
            else
                println("Unknown data type for key: $key")
            end
        end
    catch e
        println("An error occurred: $e")
    end
end
# Function for deserializeSerialize_data
function deserializeSerialize_data(filename::String, originalString::String, originalFloat::Float64, originalInt8::Int8, originalUInt8::UInt8, originalInt16::Int16, originalUInt16::UInt16, originalInt32::Int32, originalUInt32::UInt32, originalInt64::Int64, originalUInt64::UInt64, originalFloat16::Float16, originalFloat32::Float32, originalBool::Bool, originalChar::Char, originalComplex::Complex, originalDecimal::BigFloat, originalFraction::Rational{Int}, originalBigInt::BigInt, originalNan::Float64, originalDuration::Millisecond, originalDatetime::DateTime)
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
            elseif key == "decimal_data"
                setprecision(256)
                decimalValue = parse(BigFloat, value)
                TestResult(decimalValue == originalDecimal, "Decimal")
                data["decimal_data"] = string(decimalValue)
            elseif key == "fraction_data"
                fractionValue = parse(Rational{Int}, value)
                TestResult(fractionValue == originalFraction, "Fraction")
                # Convert the fraction back to a string with `/` instead of `//`
                fraction_str = string(numerator(fractionValue)) * "/" * string(denominator(fractionValue))
                
                # Store the fraction as a string in the desired format
                data["fraction_data"] = fraction_str
            elseif key == "bigint_data"
                bigIntValue = parse(BigInt, value)
                TestResult(bigIntValue == originalBigInt, "BigInt")
                data["bigint_data"] = string(bigIntValue)
            elseif key == "nan_data"
                nanValue = value
                TestResult(isnan(nanValue), "NaN")
                data["nan_data"] = nanValue
            elseif key == "duration_data"
                # Convert the duration value from seconds to milliseconds
                durationValue = Millisecond(Int(round(value * 1000)))
                TestResult(durationValue == originalDuration, "Duration")
                data["duration_data"] = durationValue.value / 1000.0
            elseif key == "datetime_data"
                datetimeValue = DateTime(value)
                TestResult(datetimeValue == originalDatetime, "DateTime")
                data["datetime_data"] = string(datetimeValue)
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
        if length(ARGS) < 25
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
        decimalValue = parse(BigFloat, ARGS[20])  # Parse string to BigFloat
        fractionValue = parse(Rational{Int}, ARGS[21])  # Parse string to Rational
        bigIntValue = parse(BigInt, ARGS[22])  # Parse string to BigInt
        nanValue = parse(Float64, ARGS[23])
        durationValue = Millisecond(round(Int, parse(Float64, ARGS[24]) * 1000))  # Convert seconds to milliseconds
        datetimeValue = DateTime(ARGS[25])
        selfTesting(filename, stringValue, floatValue, int8Value, uint8Value, int16Value, uint16Value, int32Value, uint32Value, int64Value, uint64Value, int128Value, uint128Value, float16Value, float32Value, boolValue, charValue, complexValue, decimalValue, fractionValue, bigIntValue, nanValue, durationValue, datetimeValue)
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
        decimalValue = parse(BigFloat, ARGS[18])  # Parse string to BigFloat
        fractionValue = parse(Rational{Int}, ARGS[19])  # Parse string to Rational
        bigIntValue = parse(BigInt, ARGS[20])  # Parse string to BigInt
        nanValue = parse(Float64, ARGS[21])
        durationValue = Millisecond(round(Int, parse(Float64, ARGS[22]) * 1000))  # Convert seconds to milliseconds
        datetimeValue = DateTime(ARGS[23])
        deserialize_data(filename, stringValue, floatValue, int8Value, uint8Value, int16Value, uint16Value, int32Value, uint32Value, int64Value, uint64Value, float16Value, float32Value, boolValue, charValue, complexValue, decimalValue, fractionValue, bigIntValue, nanValue, durationValue, datetimeValue)
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
        decimalValue = parse(BigFloat, ARGS[18])  # Parse string to BigFloat
        fractionValue = parse(Rational{Int}, ARGS[19])  # Parse string to Rational
        bigIntValue = parse(BigInt, ARGS[20])  # Parse string to BigInt
        nanValue = parse(Float64, ARGS[21])
        durationValue = Millisecond(round(Int, parse(Float64, ARGS[22]) * 1000))  # Convert seconds to milliseconds
        datetimeValue = DateTime(ARGS[23])
        deserializeSerialize_data(filename, stringValue, floatValue, int8Value, uint8Value, int16Value, uint16Value, int32Value, uint32Value, int64Value, uint64Value, float16Value, float32Value, boolValue, charValue, complexValue, decimalValue, fractionValue, bigIntValue, nanValue, durationValue, datetimeValue)
    else
        println("Unknown command: $command")
    end
end
# Execute the run_function if the script is run from the command line
if abspath(PROGRAM_FILE) == @__FILE__
    MainFunction()
end
