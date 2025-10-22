#!/usr/bin/env bash
# Build script for Render deployment

set -e

echo "Starting build process..."

# Make gradlew executable
chmod +x ./gradlew

# Clean and build the JAR
echo "Building JAR file..."
./gradlew clean bootJar --no-daemon

echo "Build completed successfully!"
echo "JAR location: build/libs/coffee-shop-telegram-bot-0.0.1-SNAPSHOT.jar"
