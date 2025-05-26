#!/bin/bash
set -e

# Import test utilities
source "$(dirname "$0")/../_global/test-utils.sh"

echo "Testing hello-world feature..."

# Test 1: Check if hello-world command is installed
echo "Test 1: Checking if hello-world command is available"
check_command "hello-world"

# Test 2: Check version output
echo "Test 2: Checking version output"
VERSION_OUTPUT=$(hello-world --version)
if echo "$VERSION_OUTPUT" | grep -q "hello-world 1.0.0"; then
    echo "✓ Version output is correct"
else
    echo "ERROR: Version output is incorrect: $VERSION_OUTPUT"
    exit 1
fi

# Test 3: Check basic functionality
echo "Test 3: Checking basic functionality"
BASIC_OUTPUT=$(hello-world)
if echo "$BASIC_OUTPUT" | grep -q "Hello, World!"; then
    echo "✓ Basic greeting works"
else
    echo "ERROR: Basic greeting failed: $BASIC_OUTPUT"
    exit 1
fi

# Test 4: Check help output
echo "Test 4: Checking help output"
HELP_OUTPUT=$(hello-world --help)
if echo "$HELP_OUTPUT" | grep -q "Usage: hello-world"; then
    echo "✓ Help output is correct"
else
    echo "ERROR: Help output is incorrect"
    exit 1
fi

# Test 5: Check custom greeting option
echo "Test 5: Checking custom greeting option"
CUSTOM_OUTPUT=$(hello-world --greeting "Hi" --name "Tester")
if echo "$CUSTOM_OUTPUT" | grep -q "Hi, Tester!"; then
    echo "✓ Custom greeting works"
else
    echo "ERROR: Custom greeting failed: $CUSTOM_OUTPUT"
    exit 1
fi

# Test 6: Check date option
echo "Test 6: Checking date option"
DATE_OUTPUT=$(hello-world --date)
if echo "$DATE_OUTPUT" | grep -q "at [0-9]"; then
    echo "✓ Date option works"
else
    echo "ERROR: Date option failed: $DATE_OUTPUT"
    exit 1
fi

# Test 7: Check environment variable
echo "Test 7: Checking environment variable"
check_env_var "HELLO_WORLD_INSTALLED" "true"

# Test 8: Check file permissions
echo "Test 8: Checking file permissions"
if [ -x "/usr/local/bin/hello-world" ]; then
    echo "✓ hello-world script is executable"
else
    echo "ERROR: hello-world script is not executable"
    exit 1
fi

# Test 9: Check idempotency (simulate re-installation)
echo "Test 9: Testing idempotency"
# This would normally be tested by running the install script again
# For now, we just verify the command still works after multiple calls
hello-world >/dev/null
hello-world >/dev/null
echo "✓ Command works after multiple calls"

echo ""
echo "✅ All hello-world tests passed!" 