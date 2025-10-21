#!/bin/bash

# ABOUTME: Test script to debug Claude --print mode issues
# ABOUTME: Simple test to understand why Claude hangs in automation

echo "$(date): Testing Claude --print mode..."

# Test 1: Very simple command
echo "Test 1: Simple greeting"
/opt/homebrew/bin/claude --print "Say hello briefly"

echo "Test 1 completed at $(date)"

# Test 2: Working directory test
echo "Test 2: Working directory"
cd /Users/braydon/projects/claude-workspace
/opt/homebrew/bin/claude --print "What directory am I in?"

echo "Test 2 completed at $(date)"