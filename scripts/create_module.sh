#!/bin/bash

# Function to display usage
usage() {
    echo "Usage: $0 -n ModuleName"
    exit 1
}

# Parse the command line arguments
while getopts "n:" opt; do
    case $opt in
        n)
            MODULE_NAME=$OPTARG
            ;;
        *)
            usage
            ;;
    esac
done

if [ -z "$MODULE_NAME" ]; then
    usage
fi

# Check if jq is installed
if ! command -v jq &> /dev/null
then
    echo "jq could not be found. Please install jq manually. Try: choco install jq"
    exit 1
fi

# Define paths
ROOT_DIR=$(pwd)
PROJECT_NAME=${ROOT_DIR##*/}
SOURCE_DIR="$ROOT_DIR/Source"
MODULE_DIR="$SOURCE_DIR/$MODULE_NAME"
PUBLIC_DIR="$MODULE_DIR/Public"
PRIVATE_DIR="$MODULE_DIR/Private"
BUILD_FILE="$MODULE_DIR/${MODULE_NAME}.Build.cs"
MODULE_H_FILE="$PUBLIC_DIR/${MODULE_NAME}Module.h"
MODULE_CPP_FILE="$PRIVATE_DIR/${MODULE_NAME}Module.cpp"
UPROJECT_FILE="$ROOT_DIR/${PROJECT_NAME}.uproject"
PROJECT_BUILD_FILE="$SOURCE_DIR/$PROJECT_NAME/${PROJECT_NAME}.Build.cs"
TARGET_FILE="$SOURCE_DIR/${PROJECT_NAME}.Target.cs"
EDITOR_TARGET_FILE="$SOURCE_DIR/${PROJECT_NAME}Editor.Target.cs"

# Check if necessary files exist
if [ ! -f "$UPROJECT_FILE" ]; then
    echo "Error: $UPROJECT_FILE not found!"
    exit 1
fi

if [ ! -f "$PROJECT_BUILD_FILE" ]; then
    echo "Error: $PROJECT_BUILD_FILE not found!"
    exit 1
fi

if [ ! -f "$TARGET_FILE" ]; then
    echo "Error: $TARGET_FILE not found!"
    exit 1
fi

if [ ! -f "$EDITOR_TARGET_FILE" ]; then
    echo "Error: $EDITOR_TARGET_FILE not found!"
    exit 1
fi

# Create module directories
mkdir -p "$PUBLIC_DIR"
mkdir -p "$PRIVATE_DIR"

# Create the .Build.cs file
cat > "$BUILD_FILE" <<EOL
// Fill out your copyright notice in the Description page of Project Settings.

using UnrealBuildTool;

public class $MODULE_NAME : ModuleRules
{
    public $MODULE_NAME(ReadOnlyTargetRules Target) : base(Target)
    {
        PCHUsage = PCHUsageMode.UseExplicitOrSharedPCHs;

        PublicDependencyModuleNames.AddRange(new string[] { "Core", "CoreUObject", "Engine" });

        PrivateDependencyModuleNames.AddRange(new string[] { });
    }
}
EOL

# Create the Module header file
cat > "$MODULE_H_FILE" <<EOL
#pragma once

#include "CoreMinimal.h"
EOL

# Create the Module cpp file
cat > "$MODULE_CPP_FILE" <<EOL
#include "${MODULE_NAME}Module.h"

#include "Modules/ModuleManager.h"

IMPLEMENT_MODULE(FDefaultModuleImpl, $MODULE_NAME);
EOL

# Add the module to the project's .uproject file
jq --arg MODULE_NAME "$MODULE_NAME" '.Modules += [{"Name":$MODULE_NAME,"Type":"Runtime","LoadingPhase":"Default","AdditionalDependencies":["Engine"]}]' "$UPROJECT_FILE" > tmp.json && mv tmp.json "$UPROJECT_FILE"

# Correctly add the module to the project's Target.cs file
sed -i "/ExtraModuleNames.AddRange/i \    ExtraModuleNames.Add(\"$MODULE_NAME\");" "$TARGET_FILE"

# Correctly add the module to the project's Editor.Target.cs file
sed -i "/ExtraModuleNames.AddRange/i \    ExtraModuleNames.Add(\"$MODULE_NAME\");" "$EDITOR_TARGET_FILE"

# Correctly add the module to the project's .Build.cs file
sed -i "/PublicDependencyModuleNames.AddRange/i \    PublicDependencyModuleNames.Add(\"$MODULE_NAME\");" "$PROJECT_BUILD_FILE"

echo "Module $MODULE_NAME created and added to the project successfully."