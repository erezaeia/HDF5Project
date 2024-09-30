import scipy.io
import numpy as np

# Define a Python dictionary with various data types
original_dict = {
    'key1': 42,
    'key2': [1, 2, 3],
    'key3': np.array([1.1, 2.2, 3.3]),
    'key4': {'nested_key1': 'value1', 'nested_key2': [5, 6, 7]}
}

# Serialize the dictionary to a .mat file
scipy.io.savemat('test_dict.mat', original_dict)

# Deserialize the dictionary from the .mat file
deserialized_data = scipy.io.loadmat('test_dict.mat')
print(deserialized_data)
print(deserialized_data['key1'])
print(type(deserialized_data['key2']))

# Remove metadata added by MATLAB (these are added automatically)
deserialized_data_cleaned = {key: value for key, value in deserialized_data.items() if not key.startswith("__")}
print(deserialized_data_cleaned)

def reconstruct_dict(data):
    if isinstance(data, np.ndarray):
        # If it's an array, check if it's a single-element array
        if data.size == 1:
            return data.item()
        else:
            return data.tolist()
    elif isinstance(data, tuple):
        # If it's a tuple, recursively process each element
        return tuple(reconstruct_dict(item) for item in data)
    elif isinstance(data, dict):
        # If it's a dictionary, recursively reconstruct each value
        return {key: reconstruct_dict(value) for key, value in data.items()}
    else:
        # If it's any other type, return it as is
        return data

# Example usage on your deserialized data
reconstructed_dict = reconstruct_dict(deserialized_data)
deserialized_data_clean = {key: value for key, value in reconstructed_dict.items() if not key.startswith("__")}
print(deserialized_data_clean)
