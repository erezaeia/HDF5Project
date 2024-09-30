import scipy.io
import numpy as np

# Generate a complex array with various data types
complex_array = [1, 2, 3.13 , 4, 'hello', 3456789098765, True]

# Serialize the array to a .mat file
scipy.io.savemat('complex_array.mat', {'complex_array': complex_array})

# Deserialize the array from the .mat file
deserialized_data = scipy.io.loadmat('complex_array.mat')
print(deserialized_data['complex_array'])
print(type(deserialized_data['complex_array'][0]))

# Extract the deserialized array from the loaded data
deserialized_array = deserialized_data['complex_array']

# Compare the original and deserialized arrays
arrays_equal = np.array_equal(complex_array, deserialized_array)
print(arrays_equal)