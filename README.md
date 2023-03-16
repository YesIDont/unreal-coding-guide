# Unreal Engine and VS Code Coding Guide
My personal list of tips and solutions to issues I have encountered during my adventure with UE4 and VS Community.

## Debug tips
Use console in the editor/game (tylde key)
- stat fps
- stat unit

## General tips
- Everything in a scene in Unreal Engine is an Actor, containing or not a visual representation.
- Get random value with FMath::FRandRange().
- Make arrays with TArray and use it's Num() method to get array's length.
- It's possible to change the class that blueprint was created from after its already created. Open selected blueprint and go to top left main menu of the editor window: File > Repair Blueprint > Select new class.
- Get current frame delta seconds within character: GetWorld()->GetDeltaSeconds().
- To display in game fps hit \` to open console and type: stat fps.
- Always set game mode for each level, don't use default game mode at all. You will avoid situation where the right level is opened but there is no specyfic modes/controllers/HUD in it.

## Debug logging quick templates
```c++
	// Custom Log lib
	Log::InGame(FString::Printf(TEXT("Text: %f"), SomeFloat));
```
```c++
GEngine->AddOnScreenDebugMessage(-1, 5.0f, FColor::Yellow, TEXT("Message"));
```
```c++
GEngine->
	AddOnScreenDebugMessage(
		-1, 5.0f,
		FColor::Yellow,
		FString::Printf(
			TEXT("Message, d%, f%, s%"),
			VariableNameInteger, VariableNameFloat, VariableString
		)
	);
```
```c++
UE_LOG(LogTemp, Warning, TEXT("Message"));
```
```c++
UE_LOG(LogTemp, Warning, TEXT("Text, %d %f %s"), intVar, floatVar, *fstringVar );
```

## Unreal Engine > Paper2D
### fill PaperFlipbookComponent with flipbook by its path:
  - initialize flipbook component in header file:
    ```c++
    UPROPERTY(EditAnywhere, BlueprintReadWrite, Category = Animations)
	class UPaperFlipbookComponent* Flipbook;
    ```
  - in cpp file set flipbook's content like so:
    ```c++
    Flipbook->SetFlipbook(ConstructorHelpers::FObjectFinder<UPaperFlipbook>(TEXT("/Game/Path/ToYour/File/FileName.FileName")).Object);
    ```
  
### fill PaperSpriteComponent with flipbook by its path:
  - initialize sprite component in header file:
    UPROPERTY(EditAnywhere, BlueprintReadWrite, Category = Animations)
	class UPaperSpriteComponent* Sprite;
  - in cpp file set flipbook's content like so:
    Sprite->SetSprite(ConstructorHelpers::FObjectFinder<UPaperSprite>(TEXT("/Game/Path/ToYour/File/FileName.FileName")).Object);

## VS Community shortcuts:
- switch lines: ALT + arrow
- duplicate line: CTRL + D
- remove line: CTRL + SHIFT + L or CTRL + L
- switch on/off comments: default is Ctrl-K, Ctrl-C to switch comment on and Ctrl-K, Ctrl-U to switch it off. To change it go to Tools > Options > Environmet > Keyboard and search for "Edit.ToggleBlockComment" or "Edit.ToggleLineComment" and change it to whatever you like (personaly I have doing it with default shortcuts since it requires to do two shortucts one by one for each action, why...)

## C++ Common issues and solutions

### Header file not found.
Solution: If including only file's name isn't working copy the file's name and search for it in the Solution Explorer and try to inlcude it by preciding its name with the name of the directory in which the file is located.

### Method/Function fails to compile with message: "Cannot convert [type1] to [type2]
Solution: Find method/function definition and check if it wasn't rewriten into template.

### Error: cannot convert argument1 from 'T' to 'UObject' (alt: to 'WChar')
Solution: It can come up with few different scenerios but usually it means your cpp file is missing import of the class you want to use, e.g:
  ```c++
  GetMesh()->SetRelativeLocation(FVector(0, 0.0f, -92.5f));
  ```
  Above code invokes GetMesh method that should return pointer to USkeletalMeshComponent. It will throw error if USkeletalMeshComponent won't be imported on top of the file.

## VS Code Defines
Below are settings from c_cpp_properties.json file for VS Code workspace, make sure to replace paths with the ones on your machine. Sometimes setup requries removing/commening out "compileCommands" and "compilerPath" for the workspace to work correctly.
```
{
    "configurations": [
        {
            "name": "SoltakenEditor Editor Win64 Development (Soltaken)",
            "intelliSenseMode": "msvc-x64",
            // "compileCommands": "${workspaceFolder}\\.vscode\\compileCommands_Soltaken.json",
            // "compilerPath": "C:\\ProgramFiles\\MicrosoftVisualStudio\\2022\\Community\\VC\\Tools\\MSVC\\14.31.31103\\bin\\Hostx64\\x64\\cl.exe",
            "cStandard": "c17",
            "cppStandard": "c++17",
            "includePath": [
                "${workspaceFolder}\\**",
                "${workspaceFolder}\\Intermediate\\Build\\Win64\\UE4Editor\\Inc\\Soltaken",
                "D:\\Unreal\\Engine\\UE_4.27\\Engine\\**"
            ],
            "defines": [
              "IS_PROGRAM=0",
              "UE_EDITOR=1",
              "ENABLE_PGO_PROFILE=0",
              "USE_VORBIS_FOR_STREAMING=1",
              "USE_XMA2_FOR_STREAMING=1",
              "WITH_DEV_AUTOMATION_TESTS=1",
              "WITH_PERF_AUTOMATION_TESTS=1",
              "UNICODE",
              "_UNICODE",
              "__UNREAL__",
              "IS_MONOLITHIC=0",
              "WITH_ENGINE=1",
              "WITH_UNREAL_DEVELOPER_TOOLS=1",
              "WITH_APPLICATION_CORE=1",
              "WITH_COREUOBJECT=1",
              "USE_STATS_WITHOUT_ENGINE=0",
              "WITH_PLUGIN_SUPPORT=0",
              "WITH_ACCESSIBILITY=1",
              "WITH_PERFCOUNTERS=1",
              "USE_LOGGING_IN_SHIPPING=0",
              "WITH_LOGGING_TO_MEMORY=0",
              "USE_CACHE_FREED_OS_ALLOCS=1",
              "USE_CHECKS_IN_SHIPPING=0",
              "WITH_EDITOR=1",
              "WITH_SERVER_CODE=1",
              "WITH_CEF3=1",
              "WITH_LIVE_CODING=1",
              "WITH_XGE_CONTROLLER=1",
              "UBT_MODULE_MANIFEST=\"UE4Editor.modules\"",
              "UBT_MODULE_MANIFEST_DEBUGGAME=\"UE4Editor-Win64-DebugGame.modules\"",
              "UBT_COMPILED_PLATFORM=Win64",
              "UBT_COMPILED_TARGET=Editor",
              "UE_APP_NAME=\"UE4Editor\"",
              "NDIS_MINIPORT_MAJOR_VERSION=0",
              "WIN32=1",
              "_WIN32_WINNT=0x0601",
              "WINVER=0x0601",
              "PLATFORM_WINDOWS=1",
              "OVERRIDE_PLATFORM_HEADER_NAME=Windows",
              "NDEBUG=1",
              "UE_BUILD_DEVELOPMENT=1",
              "UE_IS_ENGINE_MODULE=0",
              "IMPLEMENT_ENCRYPTION_KEY_REGISTRATION()=",
              "IMPLEMENT_SIGNING_KEY_REGISTRATION()=",
              "DEPRECATED_FORGAME=DEPRECATED",
              "UE_DEPRECATED_FORGAME=UE_DEPRECATED",
              "INCLUDE_CHAOS=0",
              "WITH_PHYSX=1",
              "WITH_CHAOS=0",
              "WITH_CHAOS_CLOTHING=0",
              "WITH_CHAOS_NEEDS_TO_BE_FIXED=0",
              "PHYSICS_INTERFACE_PHYSX=1",
              "WITH_APEX=1",
              "WITH_APEX_CLOTHING=1",
              "WITH_CLOTH_COLLISION_DETECTION=1",
              "WITH_PHYSX_COOKING=1",
              "WITH_NVCLOTH=1",
              "WITH_CUSTOM_SQ_STRUCTURE=0",
              "WITH_IMMEDIATE_PHYSX=0",
              "GPUPARTICLE_LOCAL_VF_ONLY=0",
              "ENGINE_VTABLE=DLLIMPORT_VTABLE",
              "ENGINE_API=",
              "UE_ENABLE_ICU=1",
              "WITH_VS_PERF_PROFILER=0",
              "WITH_DIRECTXMATH=0",
              "WITH_MALLOC_STOMP=1",
              "CORE_VTABLE=DLLIMPORT_VTABLE",
              "CORE_API=",
              "TRACELOG_VTABLE=DLLIMPORT_VTABLE",
              "TRACELOG_API=",
              "COREUOBJECT_VTABLE=DLLIMPORT_VTABLE",
              "COREUOBJECT_API=",
              "NETCORE_VTABLE=DLLIMPORT_VTABLE",
              "NETCORE_API=",
              "APPLICATIONCORE_VTABLE=DLLIMPORT_VTABLE",
              "APPLICATIONCORE_API=",
              "RHI_VTABLE=DLLIMPORT_VTABLE",
              "RHI_API=",
              "JSON_VTABLE=DLLIMPORT_VTABLE",
              "JSON_API=",
              "WITH_FREETYPE=1",
              "SLATECORE_VTABLE=DLLIMPORT_VTABLE",
              "SLATECORE_API=",
              "INPUTCORE_VTABLE=DLLIMPORT_VTABLE",
              "INPUTCORE_API=",
              "SLATE_VTABLE=DLLIMPORT_VTABLE",
              "SLATE_API=",
              "WITH_UNREALPNG=1",
              "WITH_UNREALJPEG=1",
              "WITH_UNREALEXR=1",
              "IMAGEWRAPPER_VTABLE=DLLIMPORT_VTABLE",
              "IMAGEWRAPPER_API=",
              "MESSAGING_VTABLE=DLLIMPORT_VTABLE",
              "MESSAGING_API=",
              "MESSAGINGCOMMON_VTABLE=DLLIMPORT_VTABLE",
              "MESSAGINGCOMMON_API=",
              "RENDERCORE_VTABLE=DLLIMPORT_VTABLE",
              "RENDERCORE_API=",
              "SOCKETS_PACKAGE=1",
              "SOCKETS_VTABLE=DLLIMPORT_VTABLE",
              "SOCKETS_API=",
              "ASSETREGISTRY_VTABLE=DLLIMPORT_VTABLE",
              "ASSETREGISTRY_API=",
              "ENGINEMESSAGES_VTABLE=DLLIMPORT_VTABLE",
              "ENGINEMESSAGES_API=",
              "ENGINESETTINGS_VTABLE=DLLIMPORT_VTABLE",
              "ENGINESETTINGS_API=",
              "SYNTHBENCHMARK_VTABLE=DLLIMPORT_VTABLE",
              "SYNTHBENCHMARK_API=",
              "RENDERER_VTABLE=DLLIMPORT_VTABLE",
              "RENDERER_API=",
              "GAMEPLAYTAGS_VTABLE=DLLIMPORT_VTABLE",
              "GAMEPLAYTAGS_API=",
              "PACKETHANDLER_VTABLE=DLLIMPORT_VTABLE",
              "PACKETHANDLER_API=",
              "RELIABILITYHANDLERCOMPONENT_VTABLE=DLLIMPORT_VTABLE",
              "RELIABILITYHANDLERCOMPONENT_API=",
              "AUDIOPLATFORMCONFIGURATION_VTABLE=DLLIMPORT_VTABLE",
              "AUDIOPLATFORMCONFIGURATION_API=",
              "MESHDESCRIPTION_VTABLE=DLLIMPORT_VTABLE",
              "MESHDESCRIPTION_API=",
              "STATICMESHDESCRIPTION_VTABLE=DLLIMPORT_VTABLE",
              "STATICMESHDESCRIPTION_API=",
              "PAKFILE_VTABLE=DLLIMPORT_VTABLE",
              "PAKFILE_API=",
              "RSA_VTABLE=DLLIMPORT_VTABLE",
              "RSA_API=",
              "NETWORKREPLAYSTREAMING_VTABLE=DLLIMPORT_VTABLE",
              "NETWORKREPLAYSTREAMING_API=",
              "PHYSICSCORE_VTABLE=DLLIMPORT_VTABLE",
              "PHYSICSCORE_API=",
              "COMPILE_WITHOUT_UNREAL_SUPPORT=0",
              "CHAOS_MEMORY_TRACKING=0",
              "CHAOS_VTABLE=DLLIMPORT_VTABLE",
              "CHAOS_API=",
              "CHAOS_CHECKED=0",
              "CHAOSCORE_VTABLE=DLLIMPORT_VTABLE",
              "CHAOSCORE_API=",
              "INTEL_ISPC=1",
              "VORONOI_VTABLE=DLLIMPORT_VTABLE",
              "VORONOI_API=",
              "FIELDSYSTEMCORE_VTABLE=DLLIMPORT_VTABLE",
              "FIELDSYSTEMCORE_API=",
              "WITH_PHYSX_RELEASE=0",
              "UE_PHYSX_SUFFIX=PROFILE",
              "UE_APEX_SUFFIX=PROFILE",
              "APEX_UE4=1",
              "APEX_STATICALLY_LINKED=0",
              "WITH_APEX_LEGACY=1",
              "SIGNALPROCESSING_VTABLE=DLLIMPORT_VTABLE",
              "SIGNALPROCESSING_API=",
              "WITH_RECAST=1",
              "UNREALED_VTABLE=DLLIMPORT_VTABLE",
              "UNREALED_API=",
              "BSPMODE_VTABLE=DLLIMPORT_VTABLE",
              "BSPMODE_API=",
              "DIRECTORYWATCHER_VTABLE=DLLIMPORT_VTABLE",
              "DIRECTORYWATCHER_API=",
              "DOCUMENTATION_VTABLE=DLLIMPORT_VTABLE",
              "DOCUMENTATION_API=",
              "LOAD_PLUGINS_FOR_TARGET_PLATFORMS=1",
              "PROJECTS_VTABLE=DLLIMPORT_VTABLE",
              "PROJECTS_API=",
              "SANDBOXFILE_VTABLE=DLLIMPORT_VTABLE",
              "SANDBOXFILE_API=",
              "EDITORSTYLE_VTABLE=DLLIMPORT_VTABLE",
              "EDITORSTYLE_API=",
              "SOURCE_CONTROL_WITH_SLATE=1",
              "SOURCECONTROL_VTABLE=DLLIMPORT_VTABLE",
              "SOURCECONTROL_API=",
              "UNREALEDMESSAGES_VTABLE=DLLIMPORT_VTABLE",
              "UNREALEDMESSAGES_API=",
              "GAMEPLAYDEBUGGER_VTABLE=DLLIMPORT_VTABLE",
              "GAMEPLAYDEBUGGER_API=",
              "BLUEPRINTGRAPH_VTABLE=DLLIMPORT_VTABLE",
              "BLUEPRINTGRAPH_API=",
              "EDITORSUBSYSTEM_VTABLE=DLLIMPORT_VTABLE",
              "EDITORSUBSYSTEM_API=",
              "HTTP_PACKAGE=1",
              "CURL_ENABLE_DEBUG_CALLBACK=1",
              "CURL_ENABLE_NO_TIMEOUTS_OPTION=1",
              "HTTP_VTABLE=DLLIMPORT_VTABLE",
              "HTTP_API=",
              "UNREALAUDIO_VTABLE=DLLIMPORT_VTABLE",
              "UNREALAUDIO_API=",
              "FUNCTIONALTESTING_VTABLE=DLLIMPORT_VTABLE",
              "FUNCTIONALTESTING_API=",
              "AUTOMATIONCONTROLLER_VTABLE=DLLIMPORT_VTABLE",
              "AUTOMATIONCONTROLLER_API=",
              "LOCALIZATION_VTABLE=DLLIMPORT_VTABLE",
              "LOCALIZATION_API=",
              "WITH_SNDFILE_IO=1",
              "AUDIOEDITOR_VTABLE=DLLIMPORT_VTABLE",
              "AUDIOEDITOR_API=",
              "AUDIOMIXER_VTABLE=DLLIMPORT_VTABLE",
              "AUDIOMIXER_API=",
              "TARGETPLATFORM_VTABLE=DLLIMPORT_VTABLE",
              "TARGETPLATFORM_API=",
              "UELIBSAMPLERATE_VTABLE=DLLIMPORT_VTABLE",
              "UELIBSAMPLERATE_API=",
              "LEVELEDITOR_VTABLE=DLLIMPORT_VTABLE",
              "LEVELEDITOR_API=",
              "SETTINGS_VTABLE=DLLIMPORT_VTABLE",
              "SETTINGS_API=",
              "INTROTUTORIALS_VTABLE=DLLIMPORT_VTABLE",
              "INTROTUTORIALS_API=",
              "HEADMOUNTEDDISPLAY_VTABLE=DLLIMPORT_VTABLE",
              "HEADMOUNTEDDISPLAY_API=",
              "VREDITOR_VTABLE=DLLIMPORT_VTABLE",
              "VREDITOR_API=",
              "COMMONMENUEXTENSIONS_VTABLE=DLLIMPORT_VTABLE",
              "COMMONMENUEXTENSIONS_API=",
              "LANDSCAPE_VTABLE=DLLIMPORT_VTABLE",
              "LANDSCAPE_API=",
              "PROPERTYEDITOR_VTABLE=DLLIMPORT_VTABLE",
              "PROPERTYEDITOR_API=",
              "ACTORPICKERMODE_VTABLE=DLLIMPORT_VTABLE",
              "ACTORPICKERMODE_API=",
              "SCENEDEPTHPICKERMODE_VTABLE=DLLIMPORT_VTABLE",
              "SCENEDEPTHPICKERMODE_API=",
              "DETAILCUSTOMIZATIONS_VTABLE=DLLIMPORT_VTABLE",
              "DETAILCUSTOMIZATIONS_API=",
              "CLASSVIEWER_VTABLE=DLLIMPORT_VTABLE",
              "CLASSVIEWER_API=",
              "GRAPHEDITOR_VTABLE=DLLIMPORT_VTABLE",
              "GRAPHEDITOR_API=",
              "STRUCTVIEWER_VTABLE=DLLIMPORT_VTABLE",
              "STRUCTVIEWER_API=",
              "CONTENTBROWSER_VTABLE=DLLIMPORT_VTABLE",
              "CONTENTBROWSER_API=",
              "ENABLE_HTTP_FOR_NFS=1",
              "NETWORKFILESYSTEM_VTABLE=DLLIMPORT_VTABLE",
              "NETWORKFILESYSTEM_API=",
              "UMG_VTABLE=DLLIMPORT_VTABLE",
              "UMG_API=",
              "MOVIESCENE_VTABLE=DLLIMPORT_VTABLE",
              "MOVIESCENE_API=",
              "TIMEMANAGEMENT_VTABLE=DLLIMPORT_VTABLE",
              "TIMEMANAGEMENT_API=",
              "MOVIESCENETRACKS_VTABLE=DLLIMPORT_VTABLE",
              "MOVIESCENETRACKS_API=",
              "ANIMATIONCORE_VTABLE=DLLIMPORT_VTABLE",
              "ANIMATIONCORE_API=",
              "PROPERTYPATH_VTABLE=DLLIMPORT_VTABLE",
              "PROPERTYPATH_API=",
              "NAVIGATIONSYSTEM_VTABLE=DLLIMPORT_VTABLE",
              "NAVIGATIONSYSTEM_API=",
              "MESHDESCRIPTIONOPERATIONS_VTABLE=DLLIMPORT_VTABLE",
              "MESHDESCRIPTIONOPERATIONS_API=",
              "MESHBUILDER_VTABLE=DLLIMPORT_VTABLE",
              "MESHBUILDER_API=",
              "MATERIALSHADERQUALITYSETTINGS_VTABLE=DLLIMPORT_VTABLE",
              "MATERIALSHADERQUALITYSETTINGS_API=",
              "INTERACTIVETOOLSFRAMEWORK_VTABLE=DLLIMPORT_VTABLE",
              "INTERACTIVETOOLSFRAMEWORK_API=",
              "TOOLMENUSEDITOR_VTABLE=DLLIMPORT_VTABLE",
              "TOOLMENUSEDITOR_API=",
              "WITH_OGGVORBIS=1",
              "XAUDIO2_VTABLE=DLLIMPORT_VTABLE",
              "XAUDIO2_API=",
              "AUDIOMIXERXAUDIO2_VTABLE=DLLIMPORT_VTABLE",
              "AUDIOMIXERXAUDIO2_API=",
              "ASSETTAGSEDITOR_VTABLE=DLLIMPORT_VTABLE",
              "ASSETTAGSEDITOR_API=",
              "COLLECTIONMANAGER_VTABLE=DLLIMPORT_VTABLE",
              "COLLECTIONMANAGER_API=",
              "ADDCONTENTDIALOG_VTABLE=DLLIMPORT_VTABLE",
              "ADDCONTENTDIALOG_API=",
              "USE_EMBREE=1",
              "MESHUTILITIES_VTABLE=DLLIMPORT_VTABLE",
              "MESHUTILITIES_API=",
              "MESHMERGEUTILITIES_VTABLE=DLLIMPORT_VTABLE",
              "MESHMERGEUTILITIES_API=",
              "HIERARCHICALLODUTILITIES_VTABLE=DLLIMPORT_VTABLE",
              "HIERARCHICALLODUTILITIES_API=",
              "MESHREDUCTIONINTERFACE_VTABLE=DLLIMPORT_VTABLE",
              "MESHREDUCTIONINTERFACE_API=",
              "ASSETTOOLS_VTABLE=DLLIMPORT_VTABLE",
              "ASSETTOOLS_API=",
              "KISMETCOMPILER_VTABLE=DLLIMPORT_VTABLE",
              "KISMETCOMPILER_API=",
              "GAMEPLAYTASKS_VTABLE=DLLIMPORT_VTABLE",
              "GAMEPLAYTASKS_API=",
              "WITH_GAMEPLAY_DEBUGGER=1",
              "AIMODULE_VTABLE=DLLIMPORT_VTABLE",
              "AIMODULE_API=",
              "KISMET_VTABLE=DLLIMPORT_VTABLE",
              "KISMET_API=",
              "PHYSICSSQ_VTABLE=DLLIMPORT_VTABLE",
              "PHYSICSSQ_API=",
              "CHAOSSOLVERS_VTABLE=DLLIMPORT_VTABLE",
              "CHAOSSOLVERS_API=",
              "GEOMETRYCOLLECTIONCORE_VTABLE=DLLIMPORT_VTABLE",
              "GEOMETRYCOLLECTIONCORE_API=",
              "GEOMETRYCOLLECTIONSIMULATIONCORE_VTABLE=DLLIMPORT_VTABLE",
              "GEOMETRYCOLLECTIONSIMULATIONCORE_API=",
              "CLOTHINGSYSTEMRUNTIMEINTERFACE_VTABLE=DLLIMPORT_VTABLE",
              "CLOTHINGSYSTEMRUNTIMEINTERFACE_API=",
              "AUDIOMIXERCORE_VTABLE=DLLIMPORT_VTABLE",
              "AUDIOMIXERCORE_API=",
                "UE_PROJECT_NAME=Soltaken",
                "SOLTAKEN_VTABLE=DLLEXPORT_VTABLE",
                "SOLTAKEN_API="
            ]
        },
        {
            "name": "Win32",
            "intelliSenseMode": "msvc-x64",
            "compileCommands": "D:\\Unreal\\Games\\Soletaken\\project\\.vscode\\compileCommands_Default.json",
            "cStandard": "c17",
            "cppStandard": "c++17"
        }
    ],
    "version": 4
}
```
