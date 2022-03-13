import QtQuick 2.15

// Setting Boolean Type
Setting {
    function increment() {
        // increment only if setting is enabled
        if (enabled) {
            // new value is the opposite, false = true / true = false
            value = !value
        }
    }

    function decrement() {
        // decrement only if setting is enabled
        if (enabled) {
            value = !value
        }
    }
}