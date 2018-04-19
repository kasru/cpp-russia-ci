mkdir build
cd build
conan install .. --build=missing -s compiler="Visual Studio" -s compiler.version=14

cmake -G "Visual Studio 15 Win64" ..
cmake --build .
  
