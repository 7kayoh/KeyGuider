# KeyGuider
KeyGuider is an open-sourced and easy to use utility to guide users to use a keybind combination, such as `Shift` + `W`.

Keybind combinations are extremely helpful in games, but not when they lack guiders to let the user know what to click. That's why I've created KeyGuider, to allow you to guide users to use a specific keybind combination!

## Installation
There's three ways to install KeyGuider. Either submodules, from source or with the built RBXM in the releases section.

### Submodule
Simply run this command in your terminal, assuming that you are in the `Package` directory:
```
git submodule add https://github.com/va1kio/keyguider.git
```

### From source
KeyGuider's repository (the one you are visiting right now!) are done with Rojo, so you can simply serve it as a Rojo project in your game. Simply clone this repository and then run `rojo serve` while in the cloned directory:

```
git clone https://github.com/va1kio/keyguider.git
cd keyguider
rojo serve
```

### RBXM
If you happen to lack the ability to use Rojo, you can also consider using the built RBXM in the releases section, go to the releases section in this repository, and then download the latest RBXMM file.

## Reference
KeyGuider is very easy to use, you just need to know 3 things: **Create a KeyGuider object**, **Add a new key**, **Wait for KeyGuider to finish**

### KeyGuider.new(Parent: instance)
Returns a `KeyGuiderObject`.

### KeyGuiderObject:AddKey(KeyCode: EnumItem)
Adds a new key to the `KeyGuiderObject`

### KeyGuiderObject:Destroy()
Destroys the `KeyGuiderObject` and starts the cleanup process.

### KeyGuiderObject.onComplete
A `BindableEvent`, fires when the key combination was used.

## Examples
You can also find the source code in [/demo](./demo).

The following example creates a new `KeyGuiderObject` with key combination `LeftShift`, `RightAlt` and `Q`:

```lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local KeyGuider = require(ReplicatedStorage:WaitForChild("KeyGuider")).new(script.Parent)

KeyGuider:AddKey(Enum.KeyCode.LeftShift)
KeyGuider:AddKey(Enum.KeyCode.RightAlt)
KeyGuider:AddKey(Enum.KeyCode.Q)

KeyGuider.onComplete.Event:Connect(function(status: boolean)
    if status then
        warn("Combination LeftShift, RightAlt, Q is now pressed")
    end
end)
```

## License
[MIT](./LICENSE)

KeyGuider uses the following libraries:
[Flipper](https://github.com/Reselim/Flipper) (MIT)
