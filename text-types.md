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

## Q&A

### Q: Is it save to omit FString constructor in favor of schorter TEXT("string") syntax? As if:
```cpp
long syntax:
FString LongSyntax = FString(TEXT("string"));

short syntax:
FString ShortSyntax = TEXT("string");
```

### A:
Yes, in Unreal Engine C++, it is generally safe and common to use the shorter TEXT("string") syntax when assigning a string to an FString. The FString constructor is able to implicitly handle the conversion from a TCHAR array (which is what TEXT macro produces) to an FString.

Here’s a bit more detail:
- FString LongSyntax = FString(TEXT("string")); explicitly calls the FString constructor with a const TCHAR* argument (produced by the TEXT macro).
- FString ShortSyntax = TEXT("string"); relies on the FString's implicit constructor that accepts a const TCHAR*. This is a shorthand and is typically preferred for its brevity and clarity.

Both lines effectively do the same thing, but the shorter syntax is cleaner and more commonly used in Unreal Engine code. It’s also worth noting that Unreal Engine’s FString is designed to work seamlessly with the TEXT macro, making this kind of assignment very natural in UE4 and UE5 codebases.

In summary, you can safely use FString ShortSyntax = TEXT("string"); for a more concise and readable code style in Unreal Engine C++.

In Unreal Engine, whether you can omit the TEXT macro depends on the context and how the string will be used. The TEXT macro is primarily used for two purposes:
- Unicode Compatibility: It ensures that the literal is treated as a Unicode string (UTF-16/32 on Windows, UTF-8 on other platforms) by prefixing it with L on platforms where TCHAR is defined as wchar_t (like Windows). This is important for internationalization and localization-
- Consistency with Unreal's TCHAR Type: Unreal Engine uses TCHAR as its character type, and FString is designed to work with TCHAR. Using TEXT ensures that string literals are of the correct type.
