import QtQuick 2.15

// import singletons (qmldir), and Variables with it
import ".."

FocusScope {

    // [...] Careful this file is just a snippet
    
    property int currentSettingsPage: 0
    property var settings: Variables.settings
    
    states: [
        State { name: "menu"; PropertyChanges { target: navBar; focus: true } },
        State { name: "settings"; PropertyChanges { target: settingsList; focus: true } }
    ]
    state: "menu"
    
    // Menu
    Component {
        id: delegate_navBar
        // Use <modelData.name> to display category names
    }
    
    ListView {
        id: navBar
        
        focus: false
        orientation: ListView.Horizontal
        model: settings
        delegate: delegate_navBar
        
        currentIndex: currentSettingsPage
        onCurrentIndexChanged: currentSettingsPage = currentIndex

        Keys.onLeftPressed: decrementCurrentIndex()
        Keys.onRightPressed: incrementCurrentIndex()
        Keys.onDownPressed: {
            root.state = "settings"
        }
    }
    
    // Settings categories
    Component {
        id: delegate_settings
        
        Item {
            readonly property alias category: category
            
            // Section/Sub-categories base on the model
            Component {
                id: sectionHeading
                // Example...
                Text {
                    text: section
                    color: "red"
                }
            }
        
            // Settings row by row
            ListView {
                id: category
                
                focus: true
                orientation: ListView.Vertical
                model: modelData.model
                delegate: <YOUR FINAL DELEGATE TO DISPLAY THE ROWS>
                
                section.property: "modelData.subcategory"
                section.criteria: ViewSection.FullString
                section.delegate: sectionHeading
            }
        }
    }
    
    ListView {
        id: settingsList
        
        focus: false
        orientation: ListView.Horizontal
        model: settings
        delegate: delegate_settings
        
        currentIndex: currentSettingsPage
        onCurrentIndexChanged: currentSettingsPage = currentIndex
        
        //=> Decrement setting value
        Keys.onLeftPressed: {
            settings[currentIndex].model[currentItem.axis.currentIndex].decrement()
        }
        //=> Increment setting value
        Keys.onRightPressed: {
            settings[currentIndex].model[currentItem.axis.currentIndex].increment()
        }
        //=> Increment row OR Focus menu
        Keys.onUpPressed: {
            if (currentItem.axis.currentIndex == 0) {
                root.state = "menu"
            }
            else {
                currentItem.axis.decrementCurrentIndex()
            }
        }
        //=> Decrement row
        Keys.onDownPressed: {
            currentItem.axis.incrementCurrentIndex()
        }

        Keys.onPressed: {
            //=> Increment setting value only if value is a boolean
            if (api.keys.isAccept(event)) {
                event.accepted = true
                if (typeof settings[currentIndex].model[currentItem.axis.currentIndex].value == "boolean") {
                    settings[currentIndex].model[currentItem.axis.currentIndex].increment()
                }
            }
        }
    }
        
    
    // [...]

}
