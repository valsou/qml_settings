import QtQuick 2.15

// import singletons (qmldir), and Variables with it
import "."

FocusScope {

    // [...]

    // Properties declarations
    // Can be used within your theme
    property bool general_darkTheming: Variables.general_darkTheming.value
    property var general_language: Variables.general_language.value
    property int general_itemsToShow: Variables.general_itemsToShow.value

    property int specific_soundVolume: Variables.specific_soundVolume.value
    property var specific_timezone: Variables.specific_timezone.value

    Component.onDestruction: {
        api.memory.set("general_darkTheming", general_darkTheming)
        api.memory.set("general_language", general_language)
        api.memory.set("general_itemsToShow", general_itemsToShow)

        api.memory.set("specific_soundVolume", specific_soundVolume)
        api.memory.set("specific_timezone", specific_timezone)
    }

    // [...]

}