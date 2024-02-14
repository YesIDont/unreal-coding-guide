// Fill out your copyright notice in the Description page of Project Settings.

#pragma once

#include "CoreMinimal.h"
#include "GameFramework/GameModeBase.h"
#include "GameModeCommands.generated.h"

/**
 *
 */
UCLASS()
class COMMAND_API AGameModeCommands : public AGameModeBase
{
  GENERATED_BODY()

  /* The path should use / symbol as directory delimiter to work. */
  UFUNCTION(BlueprintCallable)
  FString ExecuteProcess(const FString& Path)
  {
    UE_LOG(LogTemp, Warning, TEXT("Attempting to execute process on path: "));
    FString Output;
    FString Errors;

    //Execute the command
    bool bSuccess = FPlatformProcess::ExecProcess(*Path, nullptr, nullptr, &Output, &Errors);

    if (!bSuccess)
    {
      GEngine->AddOnScreenDebugMessage(-1, 10.f, FColor::Yellow, *Errors);
      return Errors;
    }

    GEngine->AddOnScreenDebugMessage(-1, 10.f, FColor::Yellow, TEXT("Success"));
    return Output;
  }

  /* Returns the directory the application was launched from. */
  UFUNCTION(BlueprintCallable, BlueprintPure)
  FString GetLunchPath()
  {
    return FPaths::LaunchDir();
  }

  /* Returns the directory the application was launched from. */
  UFUNCTION(BlueprintCallable, BlueprintPure)
  FString GetSourcePath()
  {
    return FPaths::GameSourceDir();
  }

  /* Returns the directory the application was launched from. */
  UFUNCTION(BlueprintCallable, BlueprintPure)
  FString ProjectDir()
  {
    return FPaths::ProjectDir();
  }
};
