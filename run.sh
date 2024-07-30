# Executable Paths
PYTHON_EXEC="python3"
JULIA_EXEC="julia"
MATLAB_EXEC="/Applications/MATLAB_R2024a.app/bin/matlab"

# SCRIPT PATHS
PYTHON_SCRIPT="/Users/elinarezaeian/PycharmProjects/HDF5Project/Main.py"
JULIA_SCRIPT="/Users/elinarezaeian/Julia/Julia0.jl"
MATLAB_SCRIPT="/Users/elinarezaeian/MATLAB/Projects/MainProject/"
MATLAB_DIR="/Users/elinarezaeian/MATLAB/Projects/MainProject/"


# Arguments
FILENAME="/Users/elinarezaeian/PycharmProjects/HDF5-Testing/example.mat"
STRING_VALUE="example_string"
FLOAT_VALUE=3.14159
INT8_VALUE=42

echo "--------------------------------"
echo "Python-Python:"
$PYTHON_EXEC $PYTHON_SCRIPT selfTesting $FILENAME $STRING_VALUE $FLOAT_VALUE $INT8_VALUE
echo "--------------------------------"

echo "Julia-Julia"
$JULIA_EXEC  $JULIA_SCRIPT selfTesting $FILENAME $STRING_VALUE $FLOAT_VALUE $INT8_VALUE
echo "--------------------------------"

echo "MATLAB-MATLAB"
# change the current working directory to the directory specified by the $MATLAB_SCRIPT
cd $MATLAB_DIR
$MATLAB_EXEC -batch "Main('selfTesting', '$FILENAME', '$STRING_VALUE', $FLOAT_VALUE, $INT8_VALUE); exit;" 2>/dev/null
echo "--------------------------------"

echo "Python-MATLAB:"
$PYTHON_EXEC $PYTHON_SCRIPT serializing_Py $FILENAME $STRING_VALUE $FLOAT_VALUE $INT8_VALUE
cd $MATLAB_DIR
$MATLAB_EXEC -batch "Main('deserializeSerialize_data', '$FILENAME', '$STRING_VALUE', $FLOAT_VALUE, $INT8_VALUE); exit;" 2>/dev/null
$PYTHON_EXEC $PYTHON_SCRIPT deserializing_PyMAT $FILENAME $STRING_VALUE $FLOAT_VALUE $INT8_VALUE
echo "--------------------------------"

echo "MATLAB-Python:"
cd $MATLAB_DIR
$MATLAB_EXEC -batch "Main('serialize_data', '$FILENAME', '$STRING_VALUE', $FLOAT_VALUE, $INT8_VALUE); exit;" 2>/dev/null
$PYTHON_EXEC $PYTHON_SCRIPT deserializingSerializing_PyMAT $FILENAME $STRING_VALUE $FLOAT_VALUE $INT8_VALUE
cd $MATLAB_DIR
$MATLAB_EXEC -batch "Main('deserialize_data', '$FILENAME', '$STRING_VALUE', $FLOAT_VALUE, $INT8_VALUE); exit;" 2>/dev/null
echo "--------------------------------"

echo "Python-Julia:"
$PYTHON_EXEC $PYTHON_SCRIPT serializing_Py $FILENAME $STRING_VALUE $FLOAT_VALUE $INT8_VALUE
$JULIA_EXEC  $JULIA_SCRIPT deserializeSerialize_data $FILENAME $STRING_VALUE $FLOAT_VALUE $INT8_VALUE
$PYTHON_EXEC $PYTHON_SCRIPT deserializing_PyJl $FILENAME $STRING_VALUE $FLOAT_VALUE $INT8_VALUE
echo "--------------------------------"

echo "Julia-Python:"
$JULIA_EXEC  $JULIA_SCRIPT serialize_data $FILENAME $STRING_VALUE $FLOAT_VALUE $INT8_VALUE
$PYTHON_EXEC $PYTHON_SCRIPT deserializingSerializing_PyJl $FILENAME $STRING_VALUE $FLOAT_VALUE $INT8_VALUE
$JULIA_EXEC  $JULIA_SCRIPT deserialize_data $FILENAME $STRING_VALUE $FLOAT_VALUE $INT8_VALUE
echo "--------------------------------"

echo "Julia-MATLAB:"
$JULIA_EXEC  $JULIA_SCRIPT serialize_data $FILENAME $STRING_VALUE $FLOAT_VALUE $INT8_VALUE
cd $MATLAB_DIR
$MATLAB_EXEC -batch "Main('deserializeSerialize_data', '$FILENAME', '$STRING_VALUE', $FLOAT_VALUE, $INT8_VALUE); exit;" 2>/dev/null
$JULIA_EXEC  $JULIA_SCRIPT deserialize_data $FILENAME $STRING_VALUE $FLOAT_VALUE $INT8_VALUE
echo "--------------------------------"

echo "MATLAB-Julia:"
cd $MATLAB_DIR
$MATLAB_EXEC -batch "Main('serialize_data', '$FILENAME', '$STRING_VALUE', $FLOAT_VALUE, $INT8_VALUE); exit;" 2>/dev/null
$JULIA_EXEC  $JULIA_SCRIPT deserializeSerialize_data $FILENAME $STRING_VALUE $FLOAT_VALUE $INT8_VALUE
cd $MATLAB_DIR
$MATLAB_EXEC -batch "Main('deserialize_data', '$FILENAME', '$STRING_VALUE', $FLOAT_VALUE, $INT8_VALUE); exit;" 2>/dev/null
echo "--------------------------------"

# chmod +x /Users/elinarezaeian/PycharmProjects/HDF5-Testing/run.sh
# /Users/elinarezaeian/PycharmProjects/HDF5-Testing/run.sh
