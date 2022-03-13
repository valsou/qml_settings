import QtQuick 2.15

// Setting Type
QtObject {
    // Mandatory properties
    property var title // Title of the setting
    property var value // Value of the setting

    // Optional properties
    property var sortTitle: title // Another title used for sorting
    property var description: "" // Description of the setting (what it does...)
    property var subcategory: "" // Subcategory used as section in a ListView
    property bool enabled: true // Status of the setting locked/disabled or not
}