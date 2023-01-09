# How to rename Unreal Engine project

0. Create backup of the entire project.
1. Duplicate the OldName project folder. Rename the duplicate folder to NewName.
2. Open the NewName folder.
3. Rename OldName.uproject to NewName.uproject.
4. Open NewName.uproject in a text editor, and replace all instances of OldName with NewName. Save and close the file.
5. If you have an OldName.png thumbnail, rename it to NewName.png.
6. Open the Source folder.
7. Rename OldName.Target.cs to NewName.Target.cs.
8. Open NewName.Target.cs. Find all instances of OldName in this file with NewName. There may be some partial word matches. Save and close the file.
9. Repeat step 7 and 8 for OldNameEditor.Target.cs (renaming it to NewNameEditor.Target.cs.
10. Rename this OldName folder to NewName as well.
11. Open the NewName folder.
12. Rename OldName.Build.cs to NewName.Build.cs.
13. Open NewName.Build.cs. Find all instances of OldName in this file with NewName. Save and close the file.
14. Go back to the main project folder, and right-click on the NewName.uproject file. Select Generate Visual Studio Project files. (If you don’t have this option, run Engine/Binaries/Win64/UnrealVersionSelector-Win64-Shipping.exe once).
15. Open NewName.sln.
16. Open OldName.cpp
17. Change IMPLEMENT_PRIMARY_GAME_MODULE( FDefaultGameModuleImpl, OldName, "OldName" ); to IMPLEMENT_PRIMARY_GAME_MODULE( FDefaultGameModuleImpl, NewName, "NewName" );
18. Open the Config folder, and check all the configuration files for OldName references to change to NewName. For example, change GlobalDefaultGameMode=/Script/OldName.OldNameGameMode to GlobalDefaultGameMode=/Script/NewName.OldNameGameMode.
19. Add the following to DefaultEngine.ini (under an existing or new [/Script/Engine.Engine] header): +ActiveGameNameRedirects=(OldGameName="/Script/OldName", NewGameName="/Script/NewName")
20. If you have any OLDNAME_API in your project’s header files, change those instances to NEWNAME_API.
21. Delete Saved and Intermediate folders in your project directory.
22. Compile, and your project should now open without errors.
