# Settings workflow for your theme [QML]

## What you can do
- Create and manage settings in one file only
- Interact with three (as of now) different types : Integers, Booleans & Arrays
- Two simple methods to edit settings : increment() & decrement()
- Categorize & sub-categorize your settings
- Enable/disable a setting depending on the value of other settings

## Demo
[![Watch the video](https://img.youtube.com/vi/vHhhabZrEZo/hqdefault.jpg)](https://youtu.be/vHhhabZrEZo)

## Quick explanation

All files in this repository are **mandatory** (except this README and LICENSE file of course).

### 1. Create your desired settings in `Models/Variables.qml`.

For example :

```
property var general_darkTheming: SettingBool {
    title: "Dark theme"
    subcategory: "Internal"
    description: "Enable a nice and dark looking UI"
    value: api.memory.get("general_darkTheming") ?? false
}
```

Complete `settings` variable accordingly, the order is of **NO** importance. The settings will be sorted by subcategory names, then by sortTitle/title.

```
property var settings: [
    {
        name: "General",
        model: [    general_darkTheming ].sort(sorting)
    }
]
```

### 2. Declare your variables in `theme.qml` (optional)

Import the Variables.
```
import "."
```

Choose the correct property type (int, bool, var).
```
property bool general_darkTheming: Variables.general_darkTheming.value
```

When you quit/launch a game, Pegasus will memorize the value that will later be used in `Models/Variables.qml` file.
```
Component.onDestruction: {
    api.memory.set("general_darkTheming", general_darkTheming)
}
```

> If you want, you can directly access the settings objects with this syntax : `Variables.general_darkTheming`.
> 
> Then `Variables.general_darkTheming.value`, `[...].title`, `[...].increment()`, etc.
> 
> But beware that you will need to import Variables (i.e. qmldir singletons) in each file you do that.

### 3. Display the settings (View)

In the demo you can see below, i used a ListView in a ListView (and a decoupled ListView for the menu).
To be short, `settings` or `Variables.settings` is normally the model, but when you alter a setting (and the model) the ListView will refresh and set its currentIndex to 0; resulting in a weird transition animation and the lost of your current position.

The trick to avoid this situation is to use the model in the second ListView, not in the first. That's why the first ListView use only the length (number) of settings as a Flickable "Repeater". In each delegate there is a ListView that takes for model `settings[currentIndex].model`.

Take a look at the `View/Settings.qml` file.

## Settings types
|                | **title** | sortTitle | description | **value** | subcategory | enabled | **choices** | **min** | **max** | **step** |
|----------------|-----------|-----------|-------------|-----------|-------------|---------|-------------|---------|---------|----------|
| SettingBoolean | :white_check_mark:       | :white_check_mark:       | :white_check_mark:         | :white_check_mark:       | :white_check_mark:         | :white_check_mark:     | :x:          | :x:      | :x:      | :x:       |
| SettingArray   | :white_check_mark:       | :white_check_mark:       | :white_check_mark:         | :white_check_mark:       | :white_check_mark:         | :white_check_mark:     | :white_check_mark:         | :x:      | :x:      | :x:       |
| SettingInteger | :white_check_mark:       | :white_check_mark:       | :white_check_mark:         | :white_check_mark:       | :white_check_mark:         | :white_check_mark:     | :x:          | :white_check_mark:     | :white_check_mark:     | :white_check_mark:      |

