cordova.define("com.idmission.sdk.plugin.IDMissionSDK_Cordova_Plugin", function(require, exports, module) {
var exec = require('cordova/exec');

// exports.coolMethod = function (arg0, success, error) {
//     exec(success, error, 'IDMissionSDK_Cordova_Plugin', 'coolMethod', [arg0]);
// };

exports.idm_sdk_init = function (arg0, success, error) {
    exec(success, error, 'IDMissionSDK_Cordova_Plugin', 'idm_sdk_init', [arg0]);
};

exports.idm_sdk_getPermissions = function (arg0, success, error) {
    exec(success, error, 'IDMissionSDK_Cordova_Plugin', 'idm_sdk_getPermissions', [arg0]);
};

exports.idm_sdk_IdFront = function (arg0, success, error) {
    exec(success, error, 'IDMissionSDK_Cordova_Plugin', 'idm_sdk_IdFront', [arg0]);
};

exports.idm_sdk_IdBack = function (arg0, success, error) {
    exec(success, error, 'IDMissionSDK_Cordova_Plugin', 'idm_sdk_IdBack', [arg0]);
};

exports.idm_sdk_detectFace = function (arg0, success, error) {
    exec(success, error, 'IDMissionSDK_Cordova_Plugin', 'idm_sdk_detectFace', [arg0]);
};

exports.idm_sdk_recordVideo = function (arg0, success, error) {
    exec(success, error, 'IDMissionSDK_Cordova_Plugin', 'idm_sdk_recordVideo', [arg0]);
};

exports.idm_sdk_CaptureSignature = function (arg0, success, error) {
    exec(success, error, 'IDMissionSDK_Cordova_Plugin', 'idm_sdk_CaptureSignature', [arg0]);
};

exports.idm_sdk_CaptureDocument = function (arg0, success, error) {
    exec(success, error, 'IDMissionSDK_Cordova_Plugin', 'idm_sdk_CaptureDocument', [arg0]);
};

exports.idm_sdk_startVoiceRecording = function (arg0, success, error) {
    exec(success, error, 'IDMissionSDK_Cordova_Plugin', 'idm_sdk_startVoiceRecording', [arg0]);
};

// Old call to server
exports.idm_sdk_processImageAndMatchFace = function (arg0, success, error) {
    exec(success, error, 'IDMissionSDK_Cordova_Plugin', 'idm_sdk_processImageAndMatchFace', [arg0]);
};

// New call to the server
exports.idm_sdk_genericApiCall = function (arg0, success, error) {
    exec(success, error, 'IDMissionSDK_Cordova_Plugin', 'idm_sdk_genericApiCall', [arg0]);
};

});
