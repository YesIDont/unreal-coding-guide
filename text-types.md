FText is 40 bytes ~ (more than 2x size of FString, more than 4x the size of an FName)

FString is 16 bytes ~ (2x size of FName, 4x the size of a float/int32)

FName is 8 bytes ~ (smallest! Twice the size of a float/int32)

So whenever you dont need the extra bytes you can use FName, and you should only use FText for visible displayed text that actually matters to be different, region to region, thus requiring Localization.

Your internal naming scheme in code can be be FString or FName

Advantage of FString is all the handy functions in UnrealString.h

FString is the easiest type to manipulate, modify, search and replace, concatenate, etc etc.

Strings you save to hard disk or send over the network should be FName to minimize data storage / data transfer

Remember, with FName you are sending half the bytes across the network but you can still reconstruct into an FString on the other side!

Reconstruct an FName to FString like this:

```cpp
YourFName.ToString()
 ```
convert FString to FName like this

```cpp
FString Str = "Yay";
FName NewName = FName(*Str);
 ```

Create FText from FName and FString using static methods:

```cpp
FText::FromName();
FText::FromString();
 ```
