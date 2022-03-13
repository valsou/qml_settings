import QtQuick 2.15

// Setting Array Type
Setting {
    // Mandatory properties
    property var choices // An array [] of choices

    // Internal properties
    property int index: choices.indexOf(value) // Index of current value in choices array

    function increment() {
        // increment only if setting is enabled
        if (enabled) {
            // if next value index is not out of bound
            if (choices[index+1]) {
                // new value is next value in array
                value = choices[index+1]
            }
            else {
                // new value loops to first index
                value = choices[0]
            }
        }
    }

    function decrement() {
        // decrement only if setting is enabled
        if (enabled) {
            if (choices[index-1]) {
                value = choices[index-1]
            }
            else {
                // new value loops to last index
                value = choices[choices.length - 1]
            }
        }
    }
}