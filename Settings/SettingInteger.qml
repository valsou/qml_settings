import QtQuick 2.15

// Setting Integer Type
Setting {
    // Mandatory properties
    property int min // Minimum limit for the value
    property int max // Maximum limit for the value

    // Optional properties
    property int step: 1

    function increment() {
        // increment only if setting is enabled
        if (enabled) {
            // if new value doesn't go upper than maximum limit
            if (value+step <= max) {
                // new value is incremented by a <step> integer amount
                value += step
            }
        }
    }

    function decrement() {
        // increment only if setting is enabled
        if (enabled) {
            // if new value doesn't go lower than maximum limit
            if (value-step >= min) {
                // new value is decremented by a <step> integer amount
                value -= step
            }
        }
    }
}