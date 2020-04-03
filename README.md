# Unreal Engine 4.xx and VS Community Development Guides
My personal list of tips and solutions to issues I have encountered during my adventure with UE4 and VS Community.

## VS Community shortcuts:
- switch lines: ALT + arrow
- duplicate line: CTRL + D
- remove line: CTRL + SHIFT + L
- switch on/off comments: default is Ctrl-K, Ctrl-C to switch comment on and Ctrl-K, Ctrl-U to switch it off. To change it go to Tools > Options > Environmet > Keyboard and search for "Edit.ToggleBlockComment" or "Edit.ToggleLineComment" and change it to whatever you like (personaly I have doing it with default shortcuts since it requires to do two shortucts one by one for each action, why...)

## Common issues and solutions

### Header file not found.
Solution: If including only file's name isn't working copy the file's name and search for it in the Solution Explorer and try to inlcude it by preciding its name with the name of the directory in which the file is located.

### Method/Function fails to compile with message: "Cannot convert [type1] to [type2]
Solution: Find method/function definition and check if it wasn't rewriten into template.
