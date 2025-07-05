#!/bin/bash
echo "------------Run benchmark on ARM64-----------"
./benchmark_arm64
echo " "
echo "------------Run benchmark on x86_64-----------"
$runx64 ./benchmark_x64
echo " "
echo "------------Run benchmark on wine x86_64.exe-----------"
wine benchmark_x64.exe
echo " "
echo "------------Run benchmark on wine ARM64.exe (hangover only)-----------"
wine benchmark_arm64.exe
echo " "
