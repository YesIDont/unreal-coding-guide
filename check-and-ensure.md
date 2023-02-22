check() is like assert() in C. If the condition is false, it will stop your program dead with a log message, an error window and - if a debugger is attached - a break into the debugger. You cannot continue execution after this point. It should be used to trap programmer errors that violate assumptions made by the following code - for example, indexing into a TArray with an invalid index will cause a check failure, because indexing outside of an array is always a programmer error. Additionally, the compiler can optimise code following a check() with the assumption that the condition is guaranteed true.

In contrast, if() should be used to handle conditions that are possible (no matter how unlikely) during the execution of your code.

So in the above code, you should use an if(), as null is a valid result from UGameplayStatics::GetGameMode(), e.g. you’re running on a client.

There is also the ensure() macro which is halfway between the two - i.e. you expect the condition to always be true, you want to handle it if it isn’t, but you also want to be told about it. For example:

```cpp
AMyGameMode* MyGameMode = UGameplayStatics::GetGameMode();
if (ensure(MyGameMode))
{
    MyGameMode->Whatever();
}
```
This should be read in the same way as if (MyGameMode) except that it will log and break into the debugger if MyGameMode is null, i.e. ensure() will return the same thing (converted to bool) as it has been passed. Unlike check(), you may continue execution of your program after this break.

Each use of ensure() will also only fire once, so future failures will not keep popping up in the debugger or log. If you want a message, you can use ensureAlways().

check() and ensure() also come in checkf() and ensureMsgf() flavours which allow you to write out a printf-style helpful message to indicate the nature of the failure, e.g.:

```cpp
if (ensureMsgf(MyGameMode, TEXT("Unexpected null game mode! (SomeState: %d)"), SomeState))
```
