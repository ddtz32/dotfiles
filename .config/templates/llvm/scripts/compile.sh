#!/usr/bin/env bash

export LLVM_DIR=/path/to/llvm/build
cmake -G Ninja -B build
cmake --build build -j8
