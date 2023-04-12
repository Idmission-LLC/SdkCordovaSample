function callIdm_sdk_init() {
	idm_log('callIdm_sdk_init called!');
	var sdkInitiCaller = {
                            url          : 'https://demo.idmission.com/IDS/service/integ/idm/thirdparty/upsert', // mandatory
                            loginId      : '', // mandatory
                            password     : '', // mandatory
                            merchantID   : '', // mandatory
                            productID    : '', // mandatory
                            productName  : 'Identity_Validation_and_Face_Matching', // mandatory
                            Language     : 'en', 
                            EnableDebug  : 'false',
                            enableGPS    : 'false'
                            };
    cordova.plugins.IDMissionSDK_Cordova_Plugin.idm_sdk_init(
            JSON.stringify(sdkInitiCaller),
            function(response){
                //Success Handler.
                idm_log('callIdm_sdk_init - response - ' + response);
                var parentElement = document.getElementById('initResultWrapper');
                var respJson = JSON.parse(response);
                parentElement.innerHTML = "SDK Initialization Status : " + (respJson.StatusMessage ? respJson.StatusMessage : respJson.statusMessage);
            },
            function(error){
                idm_log('callIdm_sdk_init - error - ' + error);
                var parentElement = document.getElementById('initResultWrapper');
                var respJson = JSON.parse(error);
                parentElement.innerHTML = "SDK Initialization Status : " + (respJson.StatusMessage ? respJson.StatusMessage : respJson.statusMessage);
            }
            );
}

function callIdm_sdk_IdFront() {
	idm_log('callIdm_sdk_IdFront called!');
	var sdkConfig = {};
    cordova.plugins.IDMissionSDK_Cordova_Plugin.idm_sdk_IdFront(
            JSON.stringify(sdkConfig),
            function(response){
                //Success Handler.
                idm_log('callIdm_sdk_IdFront - response - ' + response);
                var respJson = JSON.parse(response);
                idm_createImage(respJson.FRONT, 'frontResultWrapper');

            },
            function(error){
                idm_log('callIdm_sdk_IdFront - error - ' + error);
                var parentElement = document.getElementById('frontResultWrapper');
                var respJson = JSON.parse(error);
                parentElement.innerHTML = "ID Front Capture Status : " + respJson.StatusMessage;
            }
            );
}

function callIdm_sdk_IdBack() {
	idm_log('callIdm_sdk_IdBack called!');
	var sdkConfig = {};
    cordova.plugins.IDMissionSDK_Cordova_Plugin.idm_sdk_IdBack(
            JSON.stringify(sdkConfig),
            function(response){
                //Success Handler.
                idm_log('callIdm_sdk_IdBack - response - ' + response);
                var respJson = JSON.parse(response);
                idm_createImage(respJson.BACK, 'backResultWrapper');
            },
            function(error){
                idm_log('callIdm_sdk_IdBack - error - ' + error);
                var parentElement = document.getElementById('backResultWrapper');
                var respJson = JSON.parse(error);
                parentElement.innerHTML = "ID Back Capture Status : " + respJson.StatusMessage;
            }
            );
}

function callIdm_sdk_detectFace() {
	idm_log('callIdm_sdk_detectFace called!');
	var sdkConfig = {};
    cordova.plugins.IDMissionSDK_Cordova_Plugin.idm_sdk_detectFace(
            JSON.stringify(sdkConfig),
            function(response){
                //Success Handler.
                idm_log('callIdm_sdk_detectFace - response - ' + response);
                var respJson = JSON.parse(response);
                idm_createImage(respJson.FACE, 'selfieResultWrapper');
            },
            function(error){
                idm_log('callIdm_sdk_detectFace - error - ' + error);
                var parentElement = document.getElementById('selfieResultWrapper');
                var respJson = JSON.parse(error);
                parentElement.innerHTML = "Selfie Capture Status : " + respJson.StatusMessage;
            }
            );
}

function callIdm_sdk_CaptureSignature() {
    idm_log('callIdm_sdk_CaptureSignature called!');
    var sdkConfig = {};
    cordova.plugins.IDMissionSDK_Cordova_Plugin.idm_sdk_CaptureSignature(
            JSON.stringify(sdkConfig),
            function(response){
                //Success Handler.
                idm_log('callIdm_sdk_CaptureSignature - response - ' + response);
                var respJson = JSON.parse(response);
                idm_createImage(respJson.signatureImage, 'selfieResultWrapper');
            },
            function(error){
                idm_log('callIdm_sdk_CaptureSignature - error - ' + error);
                var parentElement = document.getElementById('selfieResultWrapper');
                var respJson = JSON.parse(error);
                parentElement.innerHTML = "CaptureSignature Status : " + respJson.StatusMessage;
            }
            );
}

function callIdm_sdk_recordVideo() {
    idm_log('callIdm_sdk_recordVideo called!');
    var sdkConfig = {
        recordingTime : 30,
        textDatatoScrolled : 'Hello world! Please let me know how this is recorded to the end of the video.'
    };
    cordova.plugins.IDMissionSDK_Cordova_Plugin.idm_sdk_recordVideo(
            JSON.stringify(sdkConfig),
            function(response){
                //Success Handler.
                idm_log('callIdm_sdk_recordVideo - response - ' + response);
                var parentElement = document.getElementById('videoResultWrapper');
                var respJson = JSON.parse(response);
                parentElement.innerHTML = "Video Capture Status : " + respJson.statusMessage;
            },
            function(error){
                idm_log('callIdm_sdk_recordVideo - error - ' + error);
                var parentElement = document.getElementById('videoResultWrapper');
                var respJson = JSON.parse(error);
                parentElement.innerHTML = "Video Capture Status : " + respJson.statusMessage;
            }
            );
}

function callIdm_sdk_getPermissions() {
	idm_log('callIdm_sdk_getPermissions called!');
    var e = document.getElementById('permissions');
    var permName = e.options[e.selectedIndex].value;
	var sdkConfig = {
        permissionName : permName
    };
    cordova.plugins.IDMissionSDK_Cordova_Plugin.idm_sdk_getPermissions(
            JSON.stringify(sdkConfig),
            function(response){
                //Success Handler.
                idm_log('callIdm_sdk_getPermissions - response - ' + response);
                var parentElement = document.getElementById('permissionsResultWrapper');
                var respJson = JSON.parse(response);
                parentElement.innerHTML = parentElement.innerHTML + "<br/>Video Capture Status : " + respJson.statusMessage;
            },
            function(error){
                idm_log('callIdm_sdk_getPermissions - error - ' + error);
                var parentElement = document.getElementById('permissionsResultWrapper');
                var respJson = JSON.parse(error);
                parentElement.innerHTML = parentElement.innerHTML + "<br/>callIdm_sdk_getPermissions Capture Status : " + respJson.statusMessage;
            }
            );
}

function callIdm_sdk_processImageAndMatchFace() {
	idm_log('callIdm_sdk_processImageAndMatchFace called!');
	var sdkConfig = {
		countryCode : 'USA',
		stateCode : '',
		idType : 'PP',
        serviceID : '10',
		faceImageType : '',
		finalSubmit : 'true',
		clearFormKey : 'true'
	};
    cordova.plugins.IDMissionSDK_Cordova_Plugin.idm_sdk_processImageAndMatchFace(
            JSON.stringify(sdkConfig),
            function(response){
                //Success Handler.
                idm_log('callIdm_sdk_processImageAndMatchFace - response - ' + response);
                var parentElement = document.getElementById('submitResultWrapper');
                parentElement.innerHTML = "SDK Final Submission Status : " + response;
            },
            function(error){
                idm_log('callIdm_sdk_processImageAndMatchFace - error - ' + error);
                var parentElement = document.getElementById('submitResultWrapper');
                parentElement.innerHTML = "SDK Final Submission Status : " + error;
            }
            );
}


function idm_createImage(imgStr, wrappingIdvId) {
	var imgTag = '<img style="max-height: 50%; max-width: 80%;" src="data:image/jpeg;base64, ' + imgStr + '" />';
	var parentElement = document.getElementById(wrappingIdvId);
	parentElement.innerHTML = imgTag;
}


function idm_log(msg) {
	console.log('-js-log-' + msg);
}
