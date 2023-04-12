/********* IDMissionSDK_Cordova_Plugin.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import <AppItFramework/AppItSDK.h>
#import "MainViewController.h"

#pragma mark - IDMissionSDK Cordova Plugin Interface

@interface IDMissionSDK_Cordova_Plugin : CDVPlugin{
    
}

- (void)idm_sdk_init:(CDVInvokedUrlCommand*)command;
- (void)idm_sdk_IdFront:(CDVInvokedUrlCommand*)command;
- (void)idm_sdk_IdBack:(CDVInvokedUrlCommand*)command;
- (void)idm_sdk_detectFace:(CDVInvokedUrlCommand*)command;
- (void)idm_sdk_recordVideo:(CDVInvokedUrlCommand*)command;
- (void)idm_sdk_CaptureSignature:(CDVInvokedUrlCommand*)command;
- (void)idm_sdk_CaptureDocument:(CDVInvokedUrlCommand*)command;
- (void)idm_sdk_startVoiceRecording:(CDVInvokedUrlCommand*)command;
- (void)idm_sdk_processImageAndMatchFace:(CDVInvokedUrlCommand*)command;
- (void)idm_sdk_genericApiCall:(CDVInvokedUrlCommand*)command;

@end

#pragma mark - IDMission Cordova Plugin Implementation

@implementation IDMissionSDK_Cordova_Plugin

NSMutableDictionary *englishLabels;
NSMutableDictionary *spanishLabels;
NSMutableDictionary *processConfig;

#pragma mark - Initialize Labels

+ (void)initialize {
    
    englishLabels = [NSMutableDictionary new];
    spanishLabels = [NSMutableDictionary new];
    processConfig = [NSMutableDictionary new];
    
    englishLabels[@"align_document_img_capture"] = @"Place the ID inside the borders of the box";
    spanishLabels[@"align_document_img_capture"] = @"Coloca la Identificación dentro de los bordes del recuadro";

    englishLabels[@"subject_is_too_dark_img_capture"] = @"It's too dark to take a good image. Find a place with better lighting";
    spanishLabels[@"subject_is_too_dark_img_capture"] = @"Está demasiado oscuro para tomar una buena imagen. Encuentra un lugar con mejor iluminación";

    englishLabels[@"out_of_focus_img_capture"] = @"Tap screen to focus or move camera closer/away";
    spanishLabels[@"out_of_focus_img_capture"] = @"Toque la pantalla para enfocar o acercar / alejar la cámara";

    englishLabels[@"too_much_glare_img_capture"] = @"Too much light, move document away from direct light";
    spanishLabels[@"too_much_glare_img_capture"] = @"Demasiada luz, aleje el documento de la luz directa";

    englishLabels[@"subject_is_too_dark_fc_detect"] = @"It's too dark to take a good image. Find a place with better lighting";
    spanishLabels[@"subject_is_too_dark_fc_detect"] = @"Está demasiado oscuro para tomar una buena imagen. Encuentra un lugar con mejor iluminación";

    englishLabels[@"out_of_focus_fc_detect"] = @"Tap screen to focus or move camera closer/away";
    spanishLabels[@"out_of_focus_fc_detect"] = @"Toque la pantalla para enfocar o acercar / alejar la cámara";

    englishLabels[@"move_camera_closer_to_your_face"] = @"Move camera closer to face and look towards light";
    spanishLabels[@"move_camera_closer_to_your_face"] = @"Acerque la cámara a la cara y mire hacia la luz";

    englishLabels[@"camera_movement_fc_detect"] = @"Hold camera steady";
    spanishLabels[@"camera_movement_fc_detect"] = @"Mantenga la cámara estable";

    englishLabels[@"keep_face_steady"] = @"Keep your face steady";
    spanishLabels[@"keep_face_steady"] = @"Mantén la cara firme";

    englishLabels[@"smile_please"] = @"Hold camera steady and smile please";
    spanishLabels[@"smile_please"] = @"Mantenga la cámara firme y sonríe por favor";

    englishLabels[@"face_detected"] = @"Face detected";
    spanishLabels[@"face_detected"] = @"Cara detectada";

    englishLabels[@"light"] = @"Light %";
    spanishLabels[@"light"] = @"% Luz";

    englishLabels[@"focus"] = @"Focus %";
    spanishLabels[@"focus"] = @"% Foco";

    englishLabels[@"glare"] = @"Glare %";
    spanishLabels[@"glare"] = @"% Deslumbramiento";

    englishLabels[@"smile"] = @"Smile %";
    spanishLabels[@"smile"] = @"% Sonrisa";

    englishLabels[@"page_title_image_capture"] = @"Capturing identification";
    spanishLabels[@"page_title_image_capture"] = @"Capturando identificación";

    englishLabels[@"page_title_face_detection"] = @"Detecting face";
    spanishLabels[@"page_title_face_detection"] = @"Detectando cara";

    englishLabels[@"barcode_detected_error_message"] = @"Barcode is not detected please try again";
    spanishLabels[@"barcode_detected_error_message"] = @"Código de barras no detectado, por favor intente de nuevo";

    englishLabels[@"capturing_id_scanbarcode"] = @"Scan Barcode";
    spanishLabels[@"capturing_id_scanbarcode"] = @"Escanee código de barras";

    englishLabels[@"capturing_id_scanbarcode_msg"] = @"Align barcode inside the rectangle and wait";
    spanishLabels[@"capturing_id_scanbarcode_msg"] = @"Alinee el código de barras dentro del rectángulo y espere";

    englishLabels[@"id_capture_instruction"] = @"Hold your ID straight and steady in front of the camera so the entire image is in view. Avoid excessive backlighting and glare";
    spanishLabels[@"id_capture_instruction"] = @"Ubique su ID derecha y fija enfrente de la cámara para que la imagen completa sea visible. Evite el exceso de luz en el fondo y reflejo de luz en la imagen";

    englishLabels[@"align_id_and_mrz_inside_rectangle"] = @"Align document and MRZ inside rectangle";
    spanishLabels[@"align_id_and_mrz_inside_rectangle"] = @"Alinee el documento y MRZ dentro del rectángulo";

    englishLabels[@"align_barcode_inside_rectangle"] = @"Align BARCODE inside rectangle";
    spanishLabels[@"align_barcode_inside_rectangle"] = @"Alinee código de barras dentro del rectángulo";

    englishLabels[@"barcode_mrz_not_found"] = @"BARCODE or MRZ not found for the selected id";
    spanishLabels[@"barcode_mrz_not_found"] = @"No se encontró código de barras o MRZ para la ID seleccionada";

    englishLabels[@"capturing_id_scanbarcode_pdf_417_msg"] = @"Align PDF 417 barcode inside the rectangle and wait";
    spanishLabels[@"capturing_id_scanbarcode_pdf_417_msg"] = @"Alinee el código de barras PDF 417 dentro del rectángulo y espere";

    englishLabels[@"move_id_closer"] = @"Move ID closer";
    spanishLabels[@"move_id_closer"] = @"Acerque su ID";
    
    englishLabels[@"move_id_away"] = @"Move ID away";
    spanishLabels[@"move_id_away"] = @"Aleje su ID";

    englishLabels[@"align_document_inside_rectangle"] = @"Align document inside rectangle";
    spanishLabels[@"align_document_inside_rectangle"] = @"Alinee el documento dentro del rectángulo";
    
    englishLabels[@"id_capture_preview_header"] = @"Check readability";
    spanishLabels[@"id_capture_preview_header"] = @"Verifique legibilidad";

    englishLabels[@"id_capture_preview_message"] = @"Verify to ensure complete ID is visible with edges and there is no glare or blurred text";
    spanishLabels[@"id_capture_preview_message"] = @"Asegure que su ID completa es visible  con los bordes y que no hay reflejo de luz o texto borroso";

    englishLabels[@"barcode_error_message"] = @"Barcode is not detected please try again";
    spanishLabels[@"barcode_error_message"] = @"Código de barras no detectado, por favor intente de nuevo";

    englishLabels[@"mrz_error_message"] = @"MRZ is not detected please try again";
    spanishLabels[@"mrz_error_message"] = @"MRZ no detectado, por favor intente de nuevo";

    englishLabels[@"barcode_mrz_error_message"] = @"MRZ or Barcode is not detected please try again";
    spanishLabels[@"barcode_mrz_error_message"] = @"MRZ o código de barras no detectado, por favor intente de nuevo";

    englishLabels[@"id_capture_success_message"] = @"Success";
    spanishLabels[@"id_capture_success_message"] = @"Éxito";

    englishLabels[@"id_capture_instruction_continue"] = @"Continue";
    spanishLabels[@"id_capture_instruction_continue"] = @"Continuar";

}

#pragma mark - Cordova Methods

- (void)idm_sdk_init:(CDVInvokedUrlCommand*)command
{
    ((MainViewController *) self.viewController).scanCallbackId = command.callbackId;
    NSString* commandJsonString = [command.arguments objectAtIndex:0];
    NSData *commandData = [commandJsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *commandJson = [NSJSONSerialization JSONObjectWithData:commandData options:0 error:nil];
    
    NSString *url = [commandJson objectForKey:@"url"];
    NSString *loginId = [commandJson objectForKey:@"loginId"];
    NSString *password = [commandJson objectForKey:@"password"];
    NSString *merchantID = [commandJson objectForKey:@"merchantID"];
    NSString *productID = [commandJson objectForKey:@"productID"];
    NSString *productName = [commandJson objectForKey:@"productName"];
    NSString *Language = [commandJson objectForKey:@"Language"];
    BOOL EnableDebug = [[commandJson objectForKey:@"EnableDebug"] boolValue];
    BOOL enableGPS = [[commandJson objectForKey:@"enableGPS"] boolValue];
    
    NSString *countryCode = [commandJson objectForKey:@"countryCode"];
    processConfig[@"countryCode"] = countryCode;
    NSString *typeID = [commandJson objectForKey:@"idType"];
    processConfig[@"typeID"] = typeID;
    NSString *serviceID = [commandJson objectForKey:@"Service_ID"];
    processConfig[@"serviceID"] = serviceID;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"evolv_ui_customization" ofType:@"json"];
    if([Language isEqual: @"es"]) {
        path = [[NSBundle mainBundle] pathForResource:@"evolv_ui_customization_es" ofType:@"json"];
    }
    if([Language isEqual: @"my"]) {
        path = [[NSBundle mainBundle] pathForResource:@"evolv_ui_customization_my" ofType:@"json"];
    }
    if([Language isEqual: @"ar"]) {
        path = [[NSBundle mainBundle] pathForResource:@"evolv_ui_customization_ar" ofType:@"json"];
    }
    //NSData *data = [NSData dataWithContentsOfFile:path];
    //NSMutableDictionary *config = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    [AppItSDK initializeAppItSDK:self.viewController url:url loginId:loginId password:password merchantID:merchantID productID:productID productName:productName Language:Language EnableDebug:EnableDebug enableGPS:enableGPS];
//    [AppItSDK initializeLabels:englishLabels spanishLabels:spanishLabels];
    //[AppItSDK customizeUserInterface:config];
    
}

- (void)idm_sdk_IdFront:(CDVInvokedUrlCommand*)command
{
    ((MainViewController *) self.viewController).scanCallbackId = command.callbackId;
    NSString* commandJsonString = [command.arguments objectAtIndex:0];
    NSData *commandData = [commandJsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *commandJson = [NSJSONSerialization JSONObjectWithData:commandData options:0 error:nil];
    
    NSMutableDictionary* uiconfig = [NSMutableDictionary new];
    uiconfig[@"country_code"] = @"USA";
    uiconfig[@"id_type"] = @"PP";
    uiconfig[@"id_enable_real_id_check"] = @"N";
    
    if([commandJson count] > 0) {
        uiconfig[@"id_capture_portrait"] = [commandJson objectForKey:@"id_capture_portrait"];
        uiconfig[@"id_light_threshold"] = [commandJson objectForKey:@"id_light_threshold"];
        uiconfig[@"id_min_focus"] = [commandJson objectForKey:@"id_min_focus"];
        uiconfig[@"id_max_focus"] = [commandJson objectForKey:@"id_max_focus"];
        uiconfig[@"id_glare_percentage"] = [commandJson objectForKey:@"id_glare_percentage"];
        uiconfig[@"id_enable_capture_button_time"] = [commandJson objectForKey:@"id_enable_capture_button_time"];
        uiconfig[@"id_max_image_size"] = [commandJson objectForKey:@"id_max_image_size"];
        uiconfig[@"id_image_height"] = [commandJson objectForKey:@"id_image_height"];
        uiconfig[@"id_image_width"] = [commandJson objectForKey:@"id_image_width"];
        uiconfig[@"id_capture_enable"] = [commandJson objectForKey:@"id_capture_enable"];
        uiconfig[@"country_code"] = processConfig[@"countryCode"];
        uiconfig[@"id_type"] = processConfig[@"typeID"];
        uiconfig[@"barcode_scan"] = @"Y";
    }
    NSMutableDictionary* additionalDictionary = [NSMutableDictionary new];
    [AppItSDK captureFrontImage:self.viewController additionalDictionary:additionalDictionary uiConfigDictionary:uiconfig];
}

- (void)idm_sdk_IdBack:(CDVInvokedUrlCommand*)command
{
    ((MainViewController *) self.viewController).scanCallbackId = command.callbackId;
    NSString* commandJsonString = [command.arguments objectAtIndex:0];
    NSData *commandData = [commandJsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *commandJson = [NSJSONSerialization JSONObjectWithData:commandData options:0 error:nil];
    
    NSMutableDictionary* uiconfig = [NSMutableDictionary new];
    uiconfig[@"country_code"] = @"USA";
    uiconfig[@"id_type"] = @"PP";
    uiconfig[@"id_enable_real_id_check"] = @"N";
    
    if([commandJson count] > 0) {
        uiconfig[@"id_capture_portrait"] = [commandJson objectForKey:@"id_capture_portrait"];
        uiconfig[@"id_light_threshold"] = [commandJson objectForKey:@"id_light_threshold"];
        uiconfig[@"id_min_focus"] = [commandJson objectForKey:@"id_min_focus"];
        uiconfig[@"id_max_focus"] = [commandJson objectForKey:@"id_max_focus"];
        uiconfig[@"id_glare_percentage"] = [commandJson objectForKey:@"id_glare_percentage"];
        uiconfig[@"id_enable_capture_button_time"] = [commandJson objectForKey:@"id_enable_capture_button_time"];
        uiconfig[@"id_max_image_size"] = [commandJson objectForKey:@"id_max_image_size"];
        uiconfig[@"id_image_height"] = [commandJson objectForKey:@"id_image_height"];
        uiconfig[@"id_image_width"] = [commandJson objectForKey:@"id_image_width"];
        uiconfig[@"id_capture_enable"] = [commandJson objectForKey:@"id_capture_enable"];
        uiconfig[@"country_code"] = processConfig[@"countryCode"];
        uiconfig[@"id_type"] = processConfig[@"typeID"];
        uiconfig[@"barcode_scan"] = @"Y";
    }
    NSMutableDictionary* additionalDictionary = [NSMutableDictionary new];
    [AppItSDK captureBackImage:self.viewController additionalDictionary:additionalDictionary uiConfigDictionary:uiconfig];
}

- (void)idm_sdk_detectFace:(CDVInvokedUrlCommand*)command
{
    ((MainViewController *) self.viewController).scanCallbackId = command.callbackId;
    NSMutableDictionary* faceCaptureConfig = [NSMutableDictionary new];
    [AppItSDK detectFace:self.viewController faceCaptureConfig:faceCaptureConfig];
}

- (void)idm_sdk_recordVideo:(CDVInvokedUrlCommand*)command
{
    ((MainViewController *) self.viewController).scanCallbackId = command.callbackId;
    NSString* commandJsonString = [command.arguments objectAtIndex:0];
    NSData *commandData = [commandJsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *commandJson = [NSJSONSerialization JSONObjectWithData:commandData options:0 error:nil];
    
    int recordingTime = [[commandJson valueForKey:@"recordingTime"] intValue];
    NSString *textDatatoScrolled = [commandJson objectForKey:@"textDatatoScrolled"];
    NSMutableDictionary *mutableCommandJson = [commandJson mutableCopy];
    [AppItSDK startVideoRecording:self.viewController recordingTime:recordingTime additionalDictionary:mutableCommandJson textDatatoScrolled:textDatatoScrolled ];
}

- (void)idm_sdk_CaptureSignature:(CDVInvokedUrlCommand*)command
{
    ((MainViewController *) self.viewController).scanCallbackId = command.callbackId;
    [AppItSDK captureSignature:self.viewController];
}

- (void)idm_sdk_CaptureDocument:(CDVInvokedUrlCommand*)command
{
    ((MainViewController *) self.viewController).scanCallbackId = command.callbackId;
    NSString* commandJsonString = [command.arguments objectAtIndex:0];
    NSData *commandData = [commandJsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *commandJson = [NSJSONSerialization JSONObjectWithData:commandData options:0 error:nil];
    
    NSMutableDictionary* uiconfig = [NSMutableDictionary new];
    if([commandJson count] > 0) {
        uiconfig[@"id_capture_portrait"] = [commandJson objectForKey:@"id_capture_portrait"];
        uiconfig[@"id_light_threshold"] = [commandJson objectForKey:@"id_light_threshold"];
        uiconfig[@"id_min_focus"] = [commandJson objectForKey:@"id_min_focus"];
        uiconfig[@"id_max_focus"] = [commandJson objectForKey:@"id_max_focus"];
        uiconfig[@"id_glare_percentage"] = [commandJson objectForKey:@"id_glare_percentage"];
        uiconfig[@"id_enable_capture_button_time"] = [commandJson objectForKey:@"id_enable_capture_button_time"];
        uiconfig[@"id_max_image_size"] = [commandJson objectForKey:@"id_max_image_size"];
        uiconfig[@"id_image_height"] = [commandJson objectForKey:@"id_image_height"];
        uiconfig[@"id_image_width"] = [commandJson objectForKey:@"id_image_width"];
        uiconfig[@"id_capture_enable"] = [commandJson objectForKey:@"id_capture_enable"];
//        uiconfig[@"id_generic_file_upload_enable"] = [commandJson objectForKey:@"id_generic_file_upload_enable"];
    }
    NSMutableDictionary* additionalDictionary = [NSMutableDictionary new];
    [AppItSDK captureGenericDocument:self.viewController additionalDictionary:additionalDictionary uiConfigDictionary:uiconfig fieldName:@"TESTDOCUMET"];
}

- (void)idm_sdk_startVoiceRecording:(CDVInvokedUrlCommand*)command
{
    ((MainViewController *) self.viewController).scanCallbackId = command.callbackId;
    [AppItSDK startVoiceRecording:self.viewController recordingTime:10 additionalDictionary:nil];
}

- (void)idm_sdk_processImageAndMatchFace:(CDVInvokedUrlCommand *)command
{
    ((MainViewController *) self.viewController).scanCallbackId = command.callbackId;
    
    NSString* commandJsonString = [command.arguments objectAtIndex:0];
    NSData *commandData = [commandJsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *commandJson = [NSJSONSerialization JSONObjectWithData:commandData options:0 error:nil];
    
    NSMutableDictionary* additionalDict = [NSMutableDictionary new];
    additionalDict[@"Service_ID"] = [commandJson objectForKey:@"serviceID"];
    [AppItSDK processImageAndMatchFace:self.viewController countryCode:[commandJson objectForKey:@"countryCode"] stateCode:[commandJson objectForKey:@"stateCode"] idType:[commandJson objectForKey:@"typeID"] faceImageType:@"FACE_IMAGE" additionalDictionary:additionalDict finalSubmit:true clearFormKey:true];
}

- (void)idm_sdk_genericApiCall:(CDVInvokedUrlCommand *)command
{
    ((MainViewController *) self.viewController).scanCallbackId = command.callbackId;
    NSMutableDictionary* additionalData = [NSMutableDictionary new];
    additionalData[@"Service_ID"] = processConfig[@"serviceID"];
    additionalData[@"Unique_Customer_Number"] = @"";
    NSMutableDictionary* genericDataDictionary = [NSMutableDictionary new];
    genericDataDictionary[@"country_id"] = processConfig[@"countryCode"];;
    genericDataDictionary[@"id_type"] = processConfig[@"typeID"];
    genericDataDictionary[@"additionalDataJSON"] = additionalData;
    genericDataDictionary[@"clear_form_key"] = @"Y";

    [AppItSDK genericApiCall:self.viewController genericDataDictionary:genericDataDictionary];
}

@end
