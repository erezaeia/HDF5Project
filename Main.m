function Main(varargin)
    % Check the number of input arguments
    if length(varargin) < 2
        error('Usage: Main <command> <filename> [args...]');
    end

    command = varargin{1};
    filename = varargin{2};

    % Call the specified function
    if strcmp(command, 'selfTesting')
        if length(varargin) < 23
            error('Usage: Main selfTesting <filename> <stringValue> <floatValue> <int8Value>');
        end
        stringValue = varargin{3};
        floatValue = double(varargin{4});
        int8Value = int8(varargin{5});
        uint8Value = uint8(varargin{6});
        int16Value = int16(varargin{7});
        uint16Value = uint16(varargin{8});
        int32Value = int32(varargin{9});
        uint32Value = uint32(varargin{10});
        int64Value = int64(varargin{11});
        uint64Value = uint64(varargin{12});
        float16Value = single(varargin{13}); % MATLAB does not support float16 directly, using single instead
        float32Value = single(varargin{14});
        boolValue = logical(varargin{15});
        charValue = varargin{16};
        complexValue = varargin{17};
        digits(50);
        decimalValue = vpa(varargin{18}); 
        fractionValue = sym(varargin{19}); 
        bigIntValue = vpa(varargin{20}); 
        nanValue = varargin{21}; % NaN value
        durationValue = seconds(varargin{22}); % Store duration as seconds
        datetimeValue = datetime(varargin{23}, 'InputFormat', 'yyyy-MM-dd''T''HH:mm:ss');
        selfTesting(filename, stringValue, floatValue, int8Value, uint8Value, int16Value, uint16Value, int32Value, uint32Value, int64Value, uint64Value, float16Value, float32Value, boolValue, charValue, complexValue, decimalValue, fractionValue, bigIntValue, nanValue, durationValue, datetimeValue);
       
    elseif strcmp(command, 'serialize_data')
        if length(varargin) < 3
            error('Usage: Main serialize_data <filename> <data_dict>');
        end
        data_dict = varargin{3};
        serialize_data(filename, data_dict);
    elseif strcmp(command, 'deserialize_data')
        if length(varargin) < 23
            error('Usage: Main deserialize_data <filename> <stringValue> <floatValue> <int8Value>');
        end
        stringValue = varargin{3};
        floatValue = double(varargin{4});
        int8Value = int8(varargin{5});
        uint8Value = uint8(varargin{6});
        int16Value = int16(varargin{7});
        uint16Value = uint16(varargin{8});
        int32Value = int32(varargin{9});
        uint32Value = uint32(varargin{10});
        int64Value = int64(varargin{11});
        uint64Value = uint64(varargin{12});
        float16Value = single(varargin{13}); % MATLAB does not support float16 directly, using single instead
        float32Value = single(varargin{14});
        boolValue = logical(varargin{15});
        charValue = varargin{16};
        complexValue = varargin{17};
        digits(50);
        decimalValue = vpa(varargin{18}); 
        fractionValue = sym(varargin{19}); 
        bigIntValue = vpa(varargin{20}); 
        nanValue = varargin{21}; % NaN value
        durationValue = seconds(varargin{22}); % Store duration as seconds
        datetimeValue = datetime(varargin{23}, 'InputFormat', 'yyyy-MM-dd''T''HH:mm:ss');
        deserialize_data(filename, stringValue, floatValue, int8Value, uint8Value, int16Value, uint16Value, int32Value, uint32Value, int64Value, uint64Value, float16Value, float32Value, boolValue, charValue, complexValue, decimalValue, fractionValue, bigIntValue, nanValue, durationValue, datetimeValue);
        
    elseif strcmp(command, 'deserializeSerialize_data')
        if length(varargin) < 23
            error('Usage: Main deserializeSerialize_data <filename> <stringValue> <floatValue> <int8Value>');
        end
        stringValue = varargin{3};
        floatValue = double(varargin{4});
        int8Value = int8(varargin{5});
        uint8Value = uint8(varargin{6});
        int16Value = int16(varargin{7});
        uint16Value = uint16(varargin{8});
        int32Value = int32(varargin{9});
        uint32Value = uint32(varargin{10});
        int64Value = int64(varargin{11});
        uint64Value = uint64(varargin{12});
        float16Value = single(varargin{13}); % MATLAB does not support float16 directly, using single instead
        float32Value = single(varargin{14});
        boolValue = logical(varargin{15});
        charValue = varargin{16};
        complexValue = varargin{17};
        digits(50);
        decimalValue = vpa(varargin{18}); 
        fractionValue = sym(varargin{19}); 
        bigIntValue = vpa(varargin{20}); 
        nanValue = varargin{21}; % NaN value
        durationValue = seconds(varargin{22}); % Store duration as seconds
        datetimeValue = datetime(varargin{23}, 'InputFormat', 'yyyy-MM-dd''T''HH:mm:ss');
        deserializeSerialize_data(filename, stringValue, floatValue, int8Value, uint8Value, int16Value, uint16Value, int32Value, uint32Value, int64Value, uint64Value, float16Value, float32Value, boolValue, charValue, complexValue, decimalValue, fractionValue, bigIntValue, nanValue, durationValue, datetimeValue);
    else
        error('Unknown command: %s', command);
    end
end

function selfTesting(filename, stringValue, floatValue, int8Value, uint8Value, int16Value, uint16Value, int32Value, uint32Value, int64Value, uint64Value, float16Value, float32Value, boolValue, charValue, complexValue, decimalValue, fractionValue, bigIntValue, nanValue, durationValue, datetimeValue)
    bigIntValue = string(bigIntValue);
    decimalValue = string(decimalValue);
    fractionValue = string(fractionValue);
    % Saving the data
    save(filename, 'floatValue', 'stringValue', 'int8Value','uint8Value','int16Value','uint16Value','int32Value','uint32Value','int64Value','uint64Value', 'float16Value', 'float32Value', 'boolValue', 'charValue', 'complexValue', 'decimalValue', 'fractionValue', 'bigIntValue', 'nanValue', 'durationValue', 'datetimeValue', '-v7.3');
    
    bigIntValue = vpa(bigIntValue);
    decimalValue = vpa(decimalValue);
    fractionValue = sym(fractionValue);

    % Loading the data
    data = load(filename);

    % Extract the loaded data
    loadedFloatValue = data.floatValue;
    loadedStringValue = data.stringValue;
    loadedInt8Value = data.int8Value;
    loadedUInt8Value = data.uint8Value;
    loadedInt16Value = data.int16Value;
    loadedUInt16Value = data.uint16Value;
    loadedInt32Value = data.int32Value;
    loadedUInt32Value = data.uint32Value;
    loadedInt64Value = data.int64Value;
    loadedUInt64Value = data.uint64Value;
    loadedFloat16Value = data.float16Value;
    loadedFloat32Value = data.float32Value;
    loadedBoolValue = data.boolValue;
    loadedCharValue = data.charValue;
    loadedComplexValue = data.complexValue;
    loadedDecimalValue = data.decimalValue;
    loadedFractionValue = data.fractionValue;
    loadedBigIntValue = data.bigIntValue;
    loadedNanValue = data.nanValue;
    loadedDurationValue = data.durationValue;
    loadedDatetimeValue = data.datetimeValue;
    loadedDatetimeValue = datetime(loadedDatetimeValue, 'InputFormat', 'yyyy-MM-dd''T''HH:mm:ss');

    TestResult(strcmp(loadedStringValue, stringValue), 'String');
    TestResult(loadedFloatValue == floatValue, 'Float');
    TestResult(loadedInt8Value == int8Value, 'Int8');
    TestResult(loadedUInt8Value == uint8Value, 'UInt8');
    TestResult(loadedInt16Value == int16Value, 'Int16');
    TestResult(loadedUInt16Value == uint16Value, 'UInt16');
    TestResult(loadedInt32Value == int32Value, 'Int32');
    TestResult(loadedUInt32Value == uint32Value, 'UInt32');
    TestResult(loadedInt64Value == int64Value, 'Int64');
    TestResult(loadedUInt64Value == uint64Value, 'UInt64');
    TestResult(loadedFloat16Value == float16Value, 'Float16');
    TestResult(loadedFloat32Value == float32Value, 'Float32');
    TestResult(loadedBoolValue == boolValue, 'Bool');
    TestResult(strcmp(loadedCharValue, charValue), 'Char');
    TestResult(loadedComplexValue == complexValue, 'Complex');
    TestResult(vpa(loadedDecimalValue) == decimalValue, 'Decimal');
    TestResult(sym(loadedFractionValue) == fractionValue, 'Fraction');
    TestResult(vpa(loadedBigIntValue) == bigIntValue, 'BigInt');
    TestResult(isnan(loadedNanValue), 'NaN');
    TestResult(loadedDurationValue == durationValue, 'Duration');
    TestResult(loadedDatetimeValue == datetimeValue, 'Datetime');
    
end

function serialize_data(filename, data_dict)
    try
        % Decode JSON string to a structure
        data_struct = jsondecode(data_dict);

        % Ensure that uint64 and int64 types are correctly preserved
        data_struct.uint64_data = uint64(data_struct.uint64_data);
        data_struct.int64_data = int64(data_struct.int64_data);
        data_struct.nan_data = NaN;

        % Save data to .mat file
        save(filename, '-struct', 'data_struct', '-v7.3');
        disp('The data has been serialized through MATLAB');
    catch e
        disp(['An error occurred: ', e.message]);
    end
end

function deserialize_data(filename, originalString, originalFloat, originalInt8, originalUInt8, originalInt16, originalUInt16, originalInt32, originalUInt32, originalInt64, originalUInt64, originalFloat16, originalFloat32, originalBool, originalChar, originalComplex, originalDecimal, originalFraction, originalBigInt, originalNan, originalDuration, originalDatetime)
    try
        % Load data from the .mat file
        data = load(filename);

        % Deserialize each item based on its key
        keys = fieldnames(data);
        for i = 1:length(keys)
            key = keys{i};
            if strcmp(key, 'string_data')
                stringValue = data.(key);
                TestResult(strcmp(stringValue, originalString), 'String');
            elseif strcmp(key, 'float_data')
                floatValue = data.(key);
                TestResult(floatValue == originalFloat, 'Float');
            elseif strcmp(key, 'int8_data')
                int8Value = data.(key);
                TestResult(int8Value == originalInt8, 'Int8');
            elseif strcmp(key, 'uint8_data')
                uint8Value = data.(key);
                TestResult(uint8Value == originalUInt8, 'UInt8');
            elseif strcmp(key, 'int16_data')
                int16Value = data.(key);
                TestResult(int16Value == originalInt16, 'Int16');
            elseif strcmp(key, 'uint16_data')
                uint16Value = data.(key);
                TestResult(uint16Value == originalUInt16, 'UInt16');
            elseif strcmp(key, 'int32_data')
                int32Value = data.(key);
                TestResult(int32Value == originalInt32, 'Int32');
            elseif strcmp(key, 'uint32_data')
                uint32Value = data.(key);
                TestResult(uint32Value == originalUInt32, 'UInt32');
            elseif strcmp(key, 'int64_data')
                int64Value = int64(data.(key));
                TestResult(isequal(int64Value, originalInt64), 'Int64');
            elseif strcmp(key, 'uint64_data')
                uint64Value = uint64(data.(key));
                TestResult(isequal(uint64Value, originalUInt64), 'UInt64');
            elseif strcmp(key, 'float16_data')
                float16Value = single(data.(key));
                TestResult(float16Value == originalFloat16, 'Float16');
            elseif strcmp(key, 'float32_data')
                float32Value = single(data.(key));
                TestResult(float32Value == originalFloat32, 'Float32');
            elseif strcmp(key, 'bool_data')
                boolValue = data.(key);
                TestResult(boolValue == originalBool, 'Bool');
            elseif strcmp(key, 'char_data')
                charValue = data.(key);
                TestResult(charValue == originalChar, 'Char');
            elseif strcmp(key, 'complex_data')
                complexValue = complex(data.(key));
                TestResult(complexValue == originalComplex, 'Complex');
           elseif strcmp(key, 'decimal_data')
                digits(50);
                decimalValue = vpa(data.(key));
                TestResult(decimalValue == originalDecimal, 'Decimal');
            elseif strcmp(key, 'fraction_data')
                fractionValue = sym(data.(key));
                TestResult(fractionValue == originalFraction, 'Fraction');
            elseif strcmp(key, 'bigint_data')
                digits(50);
                bigIntValue = vpa(data.(key));
                TestResult(bigIntValue == originalBigInt, 'BigInt');
            elseif strcmp(key, 'nan_data')
                nanValue = data.(key);
                TestResult(isnan(nanValue), 'NaN');
            elseif strcmp(key, 'duration_data')
                durationValue = seconds(data.(key));
                TestResult(durationValue == originalDuration, 'Duration');
            elseif strcmp(key, 'datetime_data')
                datetimeValue = datetime(data.(key), 'InputFormat', 'yyyy-MM-dd''T''HH:mm:ss');
                TestResult(datetimeValue == originalDatetime, 'Datetime');
            
            else
                disp(['Unknown data type for key: ', key]);
            end
        end
    catch e
        disp(['An error occurred: ', e.message]);
    end
end

function deserializeSerialize_data(filename, originalString, originalFloat, originalInt8, originalUInt8, originalInt16, originalUInt16, originalInt32, originalUInt32, originalInt64, originalUInt64,originalFloat16, originalFloat32, originalBool, originalChar, originalComplex, originalDecimal, originalFraction, originalBigInt, originalNan, originalDuration, originalDatetime)
    try
        % Load data from the .mat file
        data = load(filename);

        % Deserialize each item based on its key
        keys = fieldnames(data);
        for i = 1:length(keys)
            key = keys{i};
            if strcmp(key, 'string_data')
                stringValue = data.(key);
                TestResult(strcmp(stringValue, originalString), 'String');
                data.string_data = stringValue;
            elseif strcmp(key, 'float_data')
                floatValue = data.(key);
                TestResult(floatValue == originalFloat, 'Float');
                data.float_data = floatValue;
            elseif strcmp(key, 'int8_data')
                int8Value = data.(key);
                TestResult(int8Value == originalInt8, 'Int8');
                data.int8_data = int8Value;
            elseif strcmp(key, 'uint8_data')
                uint8Value = data.(key);
                TestResult(uint8Value == originalUInt8, 'UInt8');
                data.uint8_data = uint8Value;
            elseif strcmp(key, 'int16_data')
                int16Value = data.(key);
                TestResult(int16Value == originalInt16, 'Int16');
                data.int16_data = int16Value;
            elseif strcmp(key, 'uint16_data')
                uint16Value = data.(key);
                TestResult(uint16Value == originalUInt16, 'UInt16');
                data.uint16_data = uint16Value;
            elseif strcmp(key, 'int32_data')
                int32Value = data.(key);
                TestResult(int32Value == originalInt32, 'Int32');
                data.int32_data = int32Value;
            elseif strcmp(key, 'uint32_data')
                uint32Value = data.(key);
                TestResult(uint32Value == originalUInt32, 'UInt32');
                data.uint32_data = uint32Value;
            elseif strcmp(key, 'int64_data')
                int64Value = data.(key);
                TestResult(int64Value == originalInt64, 'Int64');
                data.int64_data = int64Value;
            elseif strcmp(key, 'uint64_data')
                uint64Value = uint64(data.(key));
                TestResult(uint64Value == originalUInt64, 'UInt64');
                data.uint64_data = uint64Value;
            elseif strcmp(key, 'float16_data')
                float16Value = single(data.(key));
                TestResult(isequal(float16Value, originalFloat16), 'Float16');
                data.float16_data = float16Value;
            elseif strcmp(key, 'float32_data')
                float32Value = single(data.(key));
                TestResult(float32Value == originalFloat32, 'Float32');
                data.float32_data = float32Value;
            elseif strcmp(key, 'bool_data')
                boolValue = data.(key);
                TestResult(boolValue == originalBool, 'Bool');
                data.bool_data = boolValue;
            elseif strcmp(key, 'char_data')
                charValue = data.(key);
                TestResult(charValue == originalChar, 'Char');
                data.char_data = charValue;
            elseif strcmp(key, 'complex_data')
                complexValue = str2num(data.(key));
                TestResult(isequal(complexValue, originalComplex), 'Complex');
                data.complex_data = complexValue;
            elseif strcmp(key, 'decimal_data')
                digits(50);
                decimalValue = vpa(data.(key));
                TestResult(decimalValue == originalDecimal, 'Decimal');
                data.decimal_data = char(decimalValue);
            elseif strcmp(key, 'fraction_data')
                 fractionValue = sym(data.(key));
                 TestResult(fractionValue == originalFraction, 'Fraction');
                 data.fraction_data = char(fractionValue);
            elseif strcmp(key, 'bigint_data')
                  digits(50);
                  bigIntValue = vpa(data.(key));
                  TestResult(bigIntValue == originalBigInt, 'BigInt');
                  data.bigint_data = char(bigIntValue);
            elseif strcmp(key, 'nan_data')
                  nanValue = data.(key);
                  TestResult(isnan(nanValue), 'NaN');
                  data.nan_data = nanValue;
            elseif strcmp(key, 'duration_data')
                    durationValue = seconds(data.(key));
                    TestResult(durationValue == originalDuration, 'Duration');
                    data.duration_data = seconds(durationValue);
            elseif strcmp(key, 'datetime_data')
                   datetimeValue = datetime(data.(key), 'InputFormat', 'yyyy-MM-dd''T''HH:mm:ss');
                   TestResult(datetimeValue == originalDatetime, 'Datetime');
                   data.datetime_data = datestr(datetimeValue, 'yyyy-mm-ddTHH:MM:SS');
            else
                disp(['Unknown data type for key: ', key]);
            end
        end

        % Save the updated dictionary back to the file
        save(filename, '-struct', 'data', '-v7.3');
        disp('The data has been serialized back through MATLAB!');
    catch e
        disp(['An error occurred: ', e.message]);
    end
end

function TestResult(x, S)
    % Function to print the result of a test
    if x
        fprintf("%s ---> Successful!\n", S);
    else
        fprintf("            %s ---> Failed!***\n", S);
    end
end
