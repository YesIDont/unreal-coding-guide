# Unreal Engine 4.xx and VS Community Development Guides

VS Community shortcuts:
- switch lines: ALT + arrow
- duplicate line: CTRL + D
- remove line: CTRL + SHIFT + L

## Common issues and solutions

### Header file not found.
S: If including only file's name isn't working copy the file's name and search for it in the Solution Explorer and try to inlcude it by preciding its name with the name of the directory in which the file is located.

### Method/Function fails to compile with message: "Cannot convert [type1] to [type2]
S: Find method/function definition and check if it wasn't rewriten into template.
