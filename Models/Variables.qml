pragma Singleton
import QtQuick 2.15

import "../Settings"

QtObject {

    function sorting(a, b) {
        const subcategory_a = a.subcategory.toUpperCase()
        const subcategory_b = b.subcategory.toUpperCase()

        const title_a = a.sortTitle.toUpperCase()
        const title_b = b.sortTitle.toUpperCase()

        if (subcategory_a < subcategory_b) return -1
        if (subcategory_a > subcategory_b) return 1
        if (title_a < title_b ) return -1
        if (title_a > title_b) return 1
        return 0
    }

    property var settings: [
        {
            name: "General",
            model: [    general_darkTheming,
                        general_language,
                        general_itemsToShow ].sort(sorting)
        },
        {
            name: "Specific",
            model: [    specific_soundVolume,
                        specific_timezone ].sort(sorting)
        },
        {
            name: "Other",
            model: [

            ]
        }
    ]

    // General settings
    property var general_darkTheming: SettingBool {
        title: "Dark theme"
        subcategory: "Internal"
        description: "Enable a nice and dark looking UI"
        value: api.memory.get("general_darkTheming") ?? false
    }

    property var general_language: SettingArray {
        title: "Language"
        subcategory: "Internal"
        description: "Choose your language of preference"
        value: api.memory.get("general_language") || "en"
        choices: ["en", "fr", "es", "it"]
        enabled: general_itemsToShow.value == 7
    }

    property var general_itemsToShow: SettingInteger {
        title: "Items visible"
        description: "Set the number of items you want to see in the ListView"
        value: api.memory.get("general_itemsToShow") ?? 10
        min: 5
        max: 15
    }

    // Specific settings
    property var specific_soundVolume: SettingInteger {
        title: "Sound volume"
        value: api.memory.get("specific_soundVolume") ?? 50
        min: 0
        max: 100
    }

    property var specific_timezone : SettingArray {
        title: "Timezone"
        description: "What timezone do you want to use for the clock"
        value: api.memory.get("specific_timezone") || "Europe/Paris"
        choices: ["Europe/Paris", "Asia/Shanghai", "Europe/Budapest"]
    }

}