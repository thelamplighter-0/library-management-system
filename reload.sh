#!/bin/bash

echo "🔄 rebuilding app..."

# stopping the golem server
pkill -f "golem server" || echo "   No server was running"
sleep 1

# starting the golem server
if golem server run --clean -q &
then
    echo "   ✅ Server started"
    sleep 2
else
    echo "   ❌ Failed to start server"
    exit 1
fi

# building the app
if golem app build; then
    echo "   ✅ App built"
else
    echo "   ❌ Failed to build app"
    exit 1
fi

# deploying the app
if golem app deploy; then
    echo "   ✅ App deployed"
else
    echo "   ❌ Failed to deploy app"
    exit 1
fi

echo "✨ App rebuilt!"
