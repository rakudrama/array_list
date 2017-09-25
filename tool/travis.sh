#!/bin/bash

# Copyright (c) 2015, the Dart project authors. Please see the AUTHORS file for
# details. All rights reserved. Use of this source code is governed by a
# BSD-style license that can be found in the LICENSE file.

# Fast fail the script on failures.
set -e

# Verify that the libraries are error and warning-free.
echo "Running dartanalyzer..."
dartanalyzer lib/array_list.dart

# Run the tests.
echo "Running tests..."
#dart -c test/all_tests.dart
