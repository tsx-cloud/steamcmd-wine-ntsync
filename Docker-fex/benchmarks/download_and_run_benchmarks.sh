#!/bin/bash
if [ ! -f "mini-benchmark.zip" ]; then
  wget -q https://github.com/tsx-cloud/emulation-mini-benchmark/releases/latest/download/mini-benchmark.zip
fi
unzip -q -o mini-benchmark.zip
chmod +x run_benchmarks.sh
export WINEDEBUG=-all
export BOX64_LOG=0
./run_benchmarks.sh
