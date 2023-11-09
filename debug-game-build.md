# Debugging game build
Before going into debuging of any build check build process log and deal with any warnings and errors.

Make sure to:
- select "Include Debug Files" in project's packaging settings
- build package in "DebugGame" mode

Instructions on how to attach debugger to packaged build
[Link](https://unrealcommunity.wiki/debugging-a-packaged-build-o9c2ta8f)

To attach symbols for plugins go to .uplugin file for each of those plugins and set "LoadingPhase" to "PreDefault"
```
"Modules": [
		{
			"Name": "InventoryManager",
			"Type": "Runtime",
			"LoadingPhase": "PreDefault"
		}
	]
```
