# Unreal Engine 4.xx with C++ and VS Community Development Guides
My personal list of tips and solutions to issues I have encountered during my adventure with UE4 and VS Community.

## Unreal Engine general tips
- everything in a scene in Unreal Engine is an Actor, containing or not a visual representation
- get random value with FMath::FRandRange()
- make arrays with TArray and use it's Num() method to get array's length
- it's possible to change the class that blueprint was created from after its already created. Open selected blueprint and go to top left main menu of the editor window: File > Repair Blueprint > Select new class.

## Debug logging quick templates
- GEngine->AddOnScreenDebugMessage(-1, 5.0f, FColor::Yellow, TEXT("Message"));
- UE_LOG(LogTemp, Warning, TEXT("Message"));
- UE_LOG(LogTemp, Warning, TEXT("Text, %d %f %s"), intVar, floatVar, *fstringVar );

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
