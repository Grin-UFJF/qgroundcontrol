import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import QGroundControl
import QGroundControl.Controls
import QGroundControl.FactControls

// Camera section for mission item editors
Column {
    property alias buttonGroup: cameraSectionHeader.buttonGroup
    property alias showSpacer:  cameraSectionHeader.showSpacer
    property alias checked:     cameraSectionHeader.checked

    spacing: _margin

    property var    _camera:        missionItem.cameraSection
    property real   _fieldWidth:    ScreenTools.defaultFontPixelWidth * 16
    property real   _margin:        ScreenTools.defaultFontPixelWidth / 2

    SectionHeader {
        id:             cameraSectionHeader
        width:          parent.width
        text:           qsTr("Camera")
        checked:        false
    }

    Column {
        width:      parent.width
        spacing:    _margin
        visible:    cameraSectionHeader.checked

        LabelledFactComboBox {
            id:         cameraActionCombo
            width:      parent.width
            label:      qsTr("Action")
            fact:       _camera.cameraAction
            indexModel: false
        }

        LabelledFactTextField {
            width:      parent.width
            label:      qsTr("Time")
            fact:       _camera.cameraPhotoIntervalTime
            visible:    _camera.cameraAction.rawValue === 1
        }

        LabelledFactTextField {
            width:      parent.width
            label:      qsTr("Distance")
            fact:       _camera.cameraPhotoIntervalDistance
            visible:    _camera.cameraAction.rawValue === 2
        }

        Component.onCompleted: {
            _camera.specifyGimbal = true
            _camera.specifyCameraMode = true
            _camera.cameraMode.rawValue = 0 // Force Photo mode
        }

        LabelledFactComboBox {
            width:      parent.width
            label:      qsTr("Objeto")
            fact:       _camera.objectType
            indexModel: false
        }

        FactTextFieldSlider {
            width:          parent.width
            label:          qsTr("Zoom")
            fact:           _camera.zoom
        }

        FactTextFieldSlider {
            width:          parent.width
            label:          qsTr("Pitch")
            fact:           _camera.gimbalPitch
            enabled:        true
        }

        FactTextFieldSlider {
            width:          parent.width
            label:          qsTr("Yaw")
            fact:           _camera.gimbalYaw
            enabled:        true
        }
    }
}
