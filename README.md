# HDF5Project
# Integration of MATLAB, Python, and Julia for HDF5 File Operations

## Project Overview

This project is a collaborative effort at the Laboratory for Intelligent Integrated Networks of Engineering Systems (LIINES) under the guidance of Dr. Amro Farid. I am Elina Rezaeian, an undergraduate student in computer science at Stevens Institute of Technology, working as an undergraduate Research Assistant (RA) for Dr. Amro Farid. The primary goal of this project is to achieve seamless integration between MATLAB, Python, and Julia for handling HDF5 files.

The project focuses on the serialization and deserialization of various data types across these three programming languages. Given the limitations of MATLAB in handling certain data types, we aim to test and document the compatibility and performance of HDF5 operations across MATLAB, Python, and Julia.

## Objectives

1. **Integration of HDF5 Operations**: Ensure that data serialized in one language can be deserialized and used in another language.
2. **Data Type Compatibility**: Identify and document the data types supported by MATLAB, Python, and Julia, and address any compatibility issues.
3. **Automation and User-Friendliness**: Develop scripts to automate the testing process and make it user-friendly.

## Project Components

### Main Scripts

1. **Main.m**: MATLAB script for serializing and deserializing data.
2. **Main.py**: Python script for performing similar operations as the MATLAB script.
3. **Julia0.jl**: Julia script for handling HDF5 file operations.
4. **run.sh**: Shell script to run the above scripts sequentially in a UNIX shell, providing an automated workflow.

### Data Type Compatibility

There are several data types that MATLAB does not natively support, such as:
- `decimal.Decimal`
- `fractions.Fraction`
- `set`, `frozenset`
- `tuple`, `namedtuple`

For these data types, we found specific solutions. The main solution involves serializing all data types as dictionaries, with the key indicating the data type. This approach was initially used for sets, tuples, and lists, but we found it more functional for all data types when working across multiple languages.

For Python-Python, Julia-Julia, and MATLAB-MATLAB tests, we save the data types manually without converting them to dictionaries. However, for cross-language operations, converting to dictionaries ensures compatibility and integrity.

### Testing Scenarios

We are conducting tests across various scenarios, including:
- MATLAB to MATLAB
- Python to Python
- Julia to Julia
- MATLAB to Python
- Python to MATLAB
- Julia to MATLAB
- MATLAB to Julia
- And other cross-language operations

These tests help us ensure that data integrity is maintained and identify any compatibility issues.

### Key Findings

- **Supported Data Types**: Most data types are successfully handled across all three languages.
- **Unsupported Data Types**: The only failed cases identified so far are `Int128` and `UInt128`, which are not supported by MATLAB.

## How to Run the Project

1. **Prerequisites**:
   - Ensure MATLAB, Python, and Julia are installed on your system.
   - Install necessary packages and libraries for HDF5 operations in each language.

2. **Update the Script Paths**:
   - Edit the `run.sh` script and update the paths to the `Main.m`, `Main.py`, and `Julia0.jl` scripts after saving them in the correct locations.

3. **Make the `run.sh` File Executable**:
   - Open the terminal and navigate to the project directory.
   - Make the `run.sh` file executable:
     ```sh
     chmod +x run.sh
     ```

4. **Run the `run.sh` Script**:
   - Execute the `run.sh` script in the terminal:
     ```sh
     ./run.sh
     ```

### How the `run.sh` Script Works

In the `run.sh` script, we call functions from each file (`Main.m`, `Main.py`, `Julia0.jl`) to perform serialization and deserialization operations on the tests separately. This ensures that all operations are automated and run sequentially.

## Results and Discussion

The project aims to provide a comprehensive understanding of how HDF5 file operations can be seamlessly integrated across MATLAB, Python, and Julia. Our initial tests have shown promising results, except for the noted limitations with `Int128` and `UInt128` data types in MATLAB.

## Future Work

- **Expand Data Type Testing**: Include more complex and custom data types.
- **Performance Benchmarking**: Analyze the performance of HDF5 operations across the three languages.
- **Enhanced Automation**: Develop more robust automation scripts and error handling.

## Acknowledgments

This project is conducted at the Laboratory for Intelligent Integrated Networks of Engineering Systems (LIINES) under the guidance of Dr. Amro Farid. Special thanks to the LIINES team for their support and collaboration.

For more information about LIINES, visit [LIINES Lab](https://liines.net).

## Contact

For any questions or suggestions, please contact:
- **Elina Rezaeian**: [erezaeia@stevens.edu](mailto:erezaeia@stevens.edu)
- **LinkedIn**: [Elina Rezaeian](https://www.linkedin.com/in/elina-rezaeian-714b94271/)

## Project Structure

```plaintext
project-root/
├── Main.m               # MATLAB script for HDF5 operations
├── Main.py              # Python script for HDF5 operations
├── Julia0.jl            # Julia script for HDF5 operations
├── run.sh               # Shell script to run the above scripts
├── README.md            # Project documentation (this file)
└── tests/               # Directory containing test scripts and data (not part of the main project)
    ├── Deserializing-MAT.jl
    ├── Deserializing-Py.jl
    ├── DeserializingSerializing-Mat.jl
    ├── DeserializingSerializing-Py.jl
    ├── SelfTest.jl
    ├── SelfTesting.jl
    ├── Serializing-Mat.jl
    ├── Serializing-Py.jl
    ├── deserializeSerialize_data.jl
    ├── deserialize_data.jl
    ├── example.h5
    ├── serialize_data.jl






