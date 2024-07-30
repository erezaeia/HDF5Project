function Main(varargin)
    % Check the number of input arguments
    if length(varargin) < 5
        error('Usage: Main <command> <filename> <stringValue> <floatValue> <int8Value>');
    end

    command = varargin{1};
    filename = varargin{2};
    stringValue = varargin{3};
    floatValue = double(varargin{4});
    int8Value = int8(varargin{5});

    % Call the specified function
    if strcmp(command, 'selfTesting')
        selfTesting(filename, stringValue, floatValue, int8Value);
    elseif strcmp(command, 'serialize_data')
        serialize_data(filename, stringValue, floatValue, int8Value);
    elseif strcmp(command, 'deserialize_data')
        deserialize_data(filename, stringValue, floatValue, int8Value);
    elseif strcmp(command, 'deserializeSerialize_data')
        deserializeSerialize_data(filename, stringValue, floatValue, int8Value);
    else
        error('Unknown command: %s', command);
    end
end

function selfTesting(filename, stringValue, floatValue, int8Value)
    % Saving the data
    save(filename, 'floatValue', 'stringValue', 'int8Value', '-v7.3');

    % Loading the data
    data = load(filename);

    % Extract the loaded data
    loadedFloatValue = data.floatValue;
    loadedStringValue = data.stringValue;
    loadedInt8Value = data.int8Value;

    TestResult(strcmp(loadedStringValue, stringValue), 'String');
    TestResult(loadedFloatValue == floatValue, 'Float');
    TestResult(loadedInt8Value == int8Value, 'Int8');
end

function serialize_data(filename, stringValue, floatValue, int8Value)
    % Save data to .mat file
    data_dict = struct('string_data', stringValue, 'float_data', floatValue, 'int8_data', int8Value);
    save(filename, '-struct', 'data_dict', '-v7.3');
    disp("The data has been serialized through MATLAB");
end

function deserialize_data(filename, sValue, fValue, i8Value)
    % Load data from .mat file
    data = load(filename);

    loadedStringValue = data.string_data;
    loadedFloatValue = data.float_data;
    loadedInt8Value = data.int8_data;

    TestResult(strcmp(loadedStringValue, sValue), 'String');
    TestResult(loadedFloatValue == fValue, 'Float');
    TestResult(loadedInt8Value == i8Value, 'Int8');
end

function deserializeSerialize_data(filename, sValue, fValue, i8Value)
    % Load data from .mat file
    data = load(filename);

    loadedStringValue = data.string_data;
    loadedFloatValue = data.float_data;
    loadedInt8Value = data.int8_data;

    TestResult(strcmp(loadedStringValue, sValue), 'String');
    TestResult(loadedFloatValue == fValue, 'Float');
    TestResult(loadedInt8Value == i8Value, 'Int8');

    % Save data back to .mat file
    data_dict = struct('string_data', loadedStringValue, 'float_data', loadedFloatValue, 'int8_data', loadedInt8Value);
    save(filename, '-struct', 'data_dict', '-v7.3');
    disp('The data has been serialized back through MATLAB!');
end

function TestResult(x, S)
    % Function to print the result of a test
    if x
        fprintf("Our test for %s was Successful!\n", S);
    else
        fprintf("***Our test for %s was Failed!***\n", S);
    end
end
