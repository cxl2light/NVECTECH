// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `NVECTECH`
  String get app_name {
    return Intl.message(
      'NVECTECH',
      name: 'app_name',
      desc: '',
      args: [],
    );
  }

  /// `CONFIRM`
  String get confirm {
    return Intl.message(
      'CONFIRM',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `ABOUT`
  String get about {
    return Intl.message(
      'ABOUT',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `BACK`
  String get back {
    return Intl.message(
      'BACK',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `DELETE`
  String get delete {
    return Intl.message(
      'DELETE',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `CANCEL`
  String get cancel {
    return Intl.message(
      'CANCEL',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `input Rtsp url please`
  String get rtsp_url_hint {
    return Intl.message(
      'input Rtsp url please',
      name: 'rtsp_url_hint',
      desc: '',
      args: [],
    );
  }

  /// `%1$ds SKIP`
  String get count_down_tip {
    return Intl.message(
      '%1\$ds SKIP',
      name: 'count_down_tip',
      desc: '',
      args: [],
    );
  }

  /// `SEARCH DEVICE`
  String get scan_device {
    return Intl.message(
      'SEARCH DEVICE',
      name: 'scan_device',
      desc: '',
      args: [],
    );
  }

  /// `Stop Scan`
  String get scan_device_stop {
    return Intl.message(
      'Stop Scan',
      name: 'scan_device_stop',
      desc: '',
      args: [],
    );
  }

  /// `DeviceList：`
  String get scan_device_list {
    return Intl.message(
      'DeviceList：',
      name: 'scan_device_list',
      desc: '',
      args: [],
    );
  }

  /// `DeviceList`
  String get title_device_list {
    return Intl.message(
      'DeviceList',
      name: 'title_device_list',
      desc: '',
      args: [],
    );
  }

  /// `input address`
  String get title_input_rtsp_url {
    return Intl.message(
      'input address',
      name: 'title_input_rtsp_url',
      desc: '',
      args: [],
    );
  }

  /// `MediaCenter`
  String get title_media_gallery {
    return Intl.message(
      'MediaCenter',
      name: 'title_media_gallery',
      desc: '',
      args: [],
    );
  }

  /// `ftp url(test)`
  String get title_input_ftp_uri {
    return Intl.message(
      'ftp url(test)',
      name: 'title_input_ftp_uri',
      desc: '',
      args: [],
    );
  }

  /// `CONNECT DEVICE`
  String get connect_device {
    return Intl.message(
      'CONNECT DEVICE',
      name: 'connect_device',
      desc: '',
      args: [],
    );
  }

  /// `ENTER DEVICE`
  String get enter_device {
    return Intl.message(
      'ENTER DEVICE',
      name: 'enter_device',
      desc: '',
      args: [],
    );
  }

  /// `Select Connect Device Info`
  String get please_select_connect_device {
    return Intl.message(
      'Select Connect Device Info',
      name: 'please_select_connect_device',
      desc: '',
      args: [],
    );
  }

  /// `    The APP suitable for our handheld Thermal camera , you can got the real thermal image/video via the APP , and can remote control the thermal camera , also can share the image or video via the APP .`
  String get about_software_introduce {
    return Intl.message(
      '    The APP suitable for our handheld Thermal camera , you can got the real thermal image/video via the APP , and can remote control the thermal camera , also can share the image or video via the APP .',
      name: 'about_software_introduce',
      desc: '',
      args: [],
    );
  }

  /// `v%1$s`
  String get version_name_placeholder {
    return Intl.message(
      'v%1\$s',
      name: 'version_name_placeholder',
      desc: '',
      args: [],
    );
  }

  /// `RANGING`
  String get control_left_ranging {
    return Intl.message(
      'RANGING',
      name: 'control_left_ranging',
      desc: '',
      args: [],
    );
  }

  /// `ZOOM`
  String get control_left_zoom {
    return Intl.message(
      'ZOOM',
      name: 'control_left_zoom',
      desc: '',
      args: [],
    );
  }

  /// `IMAGE SET`
  String get control_left_image_setting {
    return Intl.message(
      'IMAGE SET',
      name: 'control_left_image_setting',
      desc: '',
      args: [],
    );
  }

  /// `SYSTEM SET`
  String get control_left_system_setting {
    return Intl.message(
      'SYSTEM SET',
      name: 'control_left_system_setting',
      desc: '',
      args: [],
    );
  }

  /// `COLOR PLATE`
  String get control_right_palette {
    return Intl.message(
      'COLOR PLATE',
      name: 'control_right_palette',
      desc: '',
      args: [],
    );
  }

  /// `FILES`
  String get control_right_file {
    return Intl.message(
      'FILES',
      name: 'control_right_file',
      desc: '',
      args: [],
    );
  }

  /// `Blackhot`
  String get colour_atla_black {
    return Intl.message(
      'Blackhot',
      name: 'colour_atla_black',
      desc: '',
      args: [],
    );
  }

  /// `Whitehot`
  String get colour_atla_white {
    return Intl.message(
      'Whitehot',
      name: 'colour_atla_white',
      desc: '',
      args: [],
    );
  }

  /// `Redhot`
  String get colour_atla_red {
    return Intl.message(
      'Redhot',
      name: 'colour_atla_red',
      desc: '',
      args: [],
    );
  }

  /// `Green`
  String get colour_atla_green {
    return Intl.message(
      'Green',
      name: 'colour_atla_green',
      desc: '',
      args: [],
    );
  }

  /// `golden`
  String get colour_atla_brownness {
    return Intl.message(
      'golden',
      name: 'colour_atla_brownness',
      desc: '',
      args: [],
    );
  }

  /// `Violet`
  String get colour_atla_rust {
    return Intl.message(
      'Violet',
      name: 'colour_atla_rust',
      desc: '',
      args: [],
    );
  }

  /// `ENTER`
  String get base_enter {
    return Intl.message(
      'ENTER',
      name: 'base_enter',
      desc: '',
      args: [],
    );
  }

  /// `Got it`
  String get base_known {
    return Intl.message(
      'Got it',
      name: 'base_known',
      desc: '',
      args: [],
    );
  }

  /// `Refuse`
  String get quit_out {
    return Intl.message(
      'Refuse',
      name: 'quit_out',
      desc: '',
      args: [],
    );
  }

  /// `Click to view the privacy agreement`
  String get click_to_law {
    return Intl.message(
      'Click to view the privacy agreement',
      name: 'click_to_law',
      desc: '',
      args: [],
    );
  }

  /// `User privacy protocol`
  String get laws_title {
    return Intl.message(
      'User privacy protocol',
      name: 'laws_title',
      desc: '',
      args: [],
    );
  }

  /// `We attach great importance to your personal information and privacy protection. In order to effectively protect your personal rights and interests, before using the "Smart Thermal" service, you must carefully read all the terms in the "user privacy agreement". In order to provide you with live view of the thermal camera through the APP and remote control of the thermal camera, we will use the necessary functional information. 1. In order to use the purchased hardware and simply control the hardware, we need access to the network. 2. In order to facilitate recording and storing the audio and video content of the hardware, we will obtain your memory and camera permissions. 3. We will carry out the use / protection of your device files and other rules, as well as your user rights and other provisions. 4. Agree on our limitation of liability and exemption provisions; If you agree to the above agreement and statement, please click "agree" to start using the products and services. If you use it again, you agree to the user privacy agreement by default. Otherwise, please exit the APP and suggest to delete or uninstall the APP.`
  String get laws_content {
    return Intl.message(
      'We attach great importance to your personal information and privacy protection. In order to effectively protect your personal rights and interests, before using the "Smart Thermal" service, you must carefully read all the terms in the "user privacy agreement". In order to provide you with live view of the thermal camera through the APP and remote control of the thermal camera, we will use the necessary functional information. 1. In order to use the purchased hardware and simply control the hardware, we need access to the network. 2. In order to facilitate recording and storing the audio and video content of the hardware, we will obtain your memory and camera permissions. 3. We will carry out the use / protection of your device files and other rules, as well as your user rights and other provisions. 4. Agree on our limitation of liability and exemption provisions; If you agree to the above agreement and statement, please click "agree" to start using the products and services. If you use it again, you agree to the user privacy agreement by default. Otherwise, please exit the APP and suggest to delete or uninstall the APP.',
      name: 'laws_content',
      desc: '',
      args: [],
    );
  }

  /// `SHARE`
  String get operate_share {
    return Intl.message(
      'SHARE',
      name: 'operate_share',
      desc: '',
      args: [],
    );
  }

  /// `DELETE`
  String get operate_delete {
    return Intl.message(
      'DELETE',
      name: 'operate_delete',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Delete File: %1$s?`
  String get delete_tip_placeholder {
    return Intl.message(
      'Confirm Delete File: %1\$s?',
      name: 'delete_tip_placeholder',
      desc: '',
      args: [],
    );
  }

  /// `This device does not support the required DRM scheme`
  String get error_drm_unsupported_scheme {
    return Intl.message(
      'This device does not support the required DRM scheme',
      name: 'error_drm_unsupported_scheme',
      desc: '',
      args: [],
    );
  }

  /// `An unknown DRM error occurred`
  String get error_drm_unknown {
    return Intl.message(
      'An unknown DRM error occurred',
      name: 'error_drm_unknown',
      desc: '',
      args: [],
    );
  }

  /// `This device does not provide a decoder for %1$s`
  String get error_no_decoder {
    return Intl.message(
      'This device does not provide a decoder for %1\$s',
      name: 'error_no_decoder',
      desc: '',
      args: [],
    );
  }

  /// `This device does not provide a secure decoder for %1$s`
  String get error_no_secure_decoder {
    return Intl.message(
      'This device does not provide a secure decoder for %1\$s',
      name: 'error_no_secure_decoder',
      desc: '',
      args: [],
    );
  }

  /// `Unable to query device decoders`
  String get error_querying_decoders {
    return Intl.message(
      'Unable to query device decoders',
      name: 'error_querying_decoders',
      desc: '',
      args: [],
    );
  }

  /// `Unable to instantiate decoder %1$s`
  String get error_instantiating_decoder {
    return Intl.message(
      'Unable to instantiate decoder %1\$s',
      name: 'error_instantiating_decoder',
      desc: '',
      args: [],
    );
  }

  /// `Permission to access storage was denied`
  String get storage_permission_denied {
    return Intl.message(
      'Permission to access storage was denied',
      name: 'storage_permission_denied',
      desc: '',
      args: [],
    );
  }

  /// `EMPTY IMAGE`
  String get empty_picture_file_tip {
    return Intl.message(
      'EMPTY IMAGE',
      name: 'empty_picture_file_tip',
      desc: '',
      args: [],
    );
  }

  /// `EMPTY VIDEO`
  String get empty_video_file_tip {
    return Intl.message(
      'EMPTY VIDEO',
      name: 'empty_video_file_tip',
      desc: '',
      args: [],
    );
  }

  /// `Reticle`
  String get str_reticle {
    return Intl.message(
      'Reticle',
      name: 'str_reticle',
      desc: '',
      args: [],
    );
  }

  /// `X-Y`
  String get str_xy {
    return Intl.message(
      'X-Y',
      name: 'str_xy',
      desc: '',
      args: [],
    );
  }

  /// `PIP`
  String get str_picture_in_picture {
    return Intl.message(
      'PIP',
      name: 'str_picture_in_picture',
      desc: '',
      args: [],
    );
  }

  /// `Tracking`
  String get str_tracking {
    return Intl.message(
      'Tracking',
      name: 'str_tracking',
      desc: '',
      args: [],
    );
  }

  /// `Sharpness`
  String get str_sharpness {
    return Intl.message(
      'Sharpness',
      name: 'str_sharpness',
      desc: '',
      args: [],
    );
  }

  /// `Contrast`
  String get str_contrast {
    return Intl.message(
      'Contrast',
      name: 'str_contrast',
      desc: '',
      args: [],
    );
  }

  /// `Brightness`
  String get str_brightness {
    return Intl.message(
      'Brightness',
      name: 'str_brightness',
      desc: '',
      args: [],
    );
  }

  /// `Denoise`
  String get str_filtering {
    return Intl.message(
      'Denoise',
      name: 'str_filtering',
      desc: '',
      args: [],
    );
  }

  /// `Scanning Device...`
  String get tip_scanning_device {
    return Intl.message(
      'Scanning Device...',
      name: 'tip_scanning_device',
      desc: '',
      args: [],
    );
  }

  /// `Scan Finished, No Device`
  String get tip_scan_finished_no_device {
    return Intl.message(
      'Scan Finished, No Device',
      name: 'tip_scan_finished_no_device',
      desc: '',
      args: [],
    );
  }

  /// `Please Open HotSpot`
  String get tip_open_wi_fi_hotspots {
    return Intl.message(
      'Please Open HotSpot',
      name: 'tip_open_wi_fi_hotspots',
      desc: '',
      args: [],
    );
  }

  /// `Please Connect Wifi or Open HotSpot`
  String get tip_open_net {
    return Intl.message(
      'Please Connect Wifi or Open HotSpot',
      name: 'tip_open_net',
      desc: '',
      args: [],
    );
  }

  /// `Delete  Success`
  String get tip_delete_success {
    return Intl.message(
      'Delete  Success',
      name: 'tip_delete_success',
      desc: '',
      args: [],
    );
  }

  /// `Current IP：%1$s`
  String get tip_cur_ip_addr {
    return Intl.message(
      'Current IP：%1\$s',
      name: 'tip_cur_ip_addr',
      desc: '',
      args: [],
    );
  }

  /// `The hot spot has no connected device`
  String get tip_hot_spot_no_device {
    return Intl.message(
      'The hot spot has no connected device',
      name: 'tip_hot_spot_no_device',
      desc: '',
      args: [],
    );
  }

  /// `The current device IP is getting an exception：`
  String get tip_get_device_ip_exception {
    return Intl.message(
      'The current device IP is getting an exception：',
      name: 'tip_get_device_ip_exception',
      desc: '',
      args: [],
    );
  }

  /// `SAVE SUCCESS`
  String get tip_save_success {
    return Intl.message(
      'SAVE SUCCESS',
      name: 'tip_save_success',
      desc: '',
      args: [],
    );
  }

  /// `CONNECT WITH HOTSPOT`
  String get help_device_wifi {
    return Intl.message(
      'CONNECT WITH HOTSPOT',
      name: 'help_device_wifi',
      desc: '',
      args: [],
    );
  }

  /// `CONNECT WITH WI-FI`
  String get help_phone_wifi {
    return Intl.message(
      'CONNECT WITH WI-FI',
      name: 'help_phone_wifi',
      desc: '',
      args: [],
    );
  }

  /// `CONNECT WITH ROUTER`
  String get help_same_wifi {
    return Intl.message(
      'CONNECT WITH ROUTER',
      name: 'help_same_wifi',
      desc: '',
      args: [],
    );
  }

  /// `We have three ways to connect your phone to your device`
  String get help_search_title {
    return Intl.message(
      'We have three ways to connect your phone to your device',
      name: 'help_search_title',
      desc: '',
      args: [],
    );
  }

  /// `DEVICE SETTING`
  String get help_device_setting {
    return Intl.message(
      'DEVICE SETTING',
      name: 'help_device_setting',
      desc: '',
      args: [],
    );
  }

  /// `PHONE SETTING`
  String get help_phone_setting {
    return Intl.message(
      'PHONE SETTING',
      name: 'help_phone_setting',
      desc: '',
      args: [],
    );
  }

  /// `SEARCH DEVICE`
  String get help_search_device {
    return Intl.message(
      'SEARCH DEVICE',
      name: 'help_search_device',
      desc: '',
      args: [],
    );
  }

  /// `READ THE GUIDE?`
  String get select_hint {
    return Intl.message(
      'READ THE GUIDE?',
      name: 'select_hint',
      desc: '',
      args: [],
    );
  }

  /// `YES`
  String get base_yes {
    return Intl.message(
      'YES',
      name: 'base_yes',
      desc: '',
      args: [],
    );
  }

  /// `NO`
  String get base_no {
    return Intl.message(
      'NO',
      name: 'base_no',
      desc: '',
      args: [],
    );
  }

  /// `Double-click the rocker button to enter Setting menu, enter network by short-press on rocker button, select Hotspot to configure.`
  String get help_search_device_1 {
    return Intl.message(
      'Double-click the rocker button to enter Setting menu, enter network by short-press on rocker button, select Hotspot to configure.',
      name: 'help_search_device_1',
      desc: '',
      args: [],
    );
  }

  /// `Enable Hotspot connection and start to configure.`
  String get help_search_device_2 {
    return Intl.message(
      'Enable Hotspot connection and start to configure.',
      name: 'help_search_device_2',
      desc: '',
      args: [],
    );
  }

  /// `Set name and password, and confirm the setting by OK.`
  String get help_search_device_3 {
    return Intl.message(
      'Set name and password, and confirm the setting by OK.',
      name: 'help_search_device_3',
      desc: '',
      args: [],
    );
  }

  /// `Select the right network on mobile device WLAN setting.`
  String get help_search_device_4 {
    return Intl.message(
      'Select the right network on mobile device WLAN setting.',
      name: 'help_search_device_4',
      desc: '',
      args: [],
    );
  }

  /// `Type the right password.`
  String get help_search_device_5 {
    return Intl.message(
      'Type the right password.',
      name: 'help_search_device_5',
      desc: '',
      args: [],
    );
  }

  /// `Confirm the connection succeeded.`
  String get help_search_device_6 {
    return Intl.message(
      'Confirm the connection succeeded.',
      name: 'help_search_device_6',
      desc: '',
      args: [],
    );
  }

  /// `Make sure WLAN is open but in non-connection before enable the Personal Hotspot.`
  String get help_search_mobile_1 {
    return Intl.message(
      'Make sure WLAN is open but in non-connection before enable the Personal Hotspot.',
      name: 'help_search_mobile_1',
      desc: '',
      args: [],
    );
  }

  /// `Set password.`
  String get help_search_mobile_2 {
    return Intl.message(
      'Set password.',
      name: 'help_search_mobile_2',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Personal Hotspot opened succeeded.`
  String get help_search_mobile_3 {
    return Intl.message(
      'Confirm Personal Hotspot opened succeeded.',
      name: 'help_search_mobile_3',
      desc: '',
      args: [],
    );
  }

  /// `Double-click the rocker button to enter Setting menu, enter network by short-press on rocker button, select Wi-Fi to configure.`
  String get help_search_mobile_4 {
    return Intl.message(
      'Double-click the rocker button to enter Setting menu, enter network by short-press on rocker button, select Wi-Fi to configure.',
      name: 'help_search_mobile_4',
      desc: '',
      args: [],
    );
  }

  /// `Enable Wi-Fi connection, select the Hotspot from smart device.`
  String get help_search_mobile_5 {
    return Intl.message(
      'Enable Wi-Fi connection, select the Hotspot from smart device.',
      name: 'help_search_mobile_5',
      desc: '',
      args: [],
    );
  }

  /// `Type the right password and confirm to Connection.`
  String get help_search_mobile_6 {
    return Intl.message(
      'Type the right password and confirm to Connection.',
      name: 'help_search_mobile_6',
      desc: '',
      args: [],
    );
  }

  /// `Select the wireless network on mobile device WLAN setting.`
  String get help_search_wifi_1 {
    return Intl.message(
      'Select the wireless network on mobile device WLAN setting.',
      name: 'help_search_wifi_1',
      desc: '',
      args: [],
    );
  }

  /// `Connect it by typing the right password.`
  String get help_search_wifi_2 {
    return Intl.message(
      'Connect it by typing the right password.',
      name: 'help_search_wifi_2',
      desc: '',
      args: [],
    );
  }

  /// `Confirm the connection succeeded.`
  String get help_search_wifi_3 {
    return Intl.message(
      'Confirm the connection succeeded.',
      name: 'help_search_wifi_3',
      desc: '',
      args: [],
    );
  }

  /// `Double-click the rocker button to enter Setting menu, enter network by short-press on rocker button, select Wi-Fi to configure.`
  String get help_search_wifi_4 {
    return Intl.message(
      'Double-click the rocker button to enter Setting menu, enter network by short-press on rocker button, select Wi-Fi to configure.',
      name: 'help_search_wifi_4',
      desc: '',
      args: [],
    );
  }

  /// `Enable Wi-Fi connection, select the same wireless network as smart device.`
  String get help_search_wifi_5 {
    return Intl.message(
      'Enable Wi-Fi connection, select the same wireless network as smart device.',
      name: 'help_search_wifi_5',
      desc: '',
      args: [],
    );
  }

  /// `Type the right password and confirm to Connection.`
  String get help_search_wifi_6 {
    return Intl.message(
      'Type the right password and confirm to Connection.',
      name: 'help_search_wifi_6',
      desc: '',
      args: [],
    );
  }

  /// `Connection to your mobile devices with 3 simple steps,\n enable to display view on a bigger screen,\n you can also have a full control from the smart device. `
  String get help_search_total_text {
    return Intl.message(
      'Connection to your mobile devices with 3 simple steps,\n enable to display view on a bigger screen,\n you can also have a full control from the smart device. ',
      name: 'help_search_total_text',
      desc: '',
      args: [],
    );
  }

  /// `IMAGE`
  String get str_picture {
    return Intl.message(
      'IMAGE',
      name: 'str_picture',
      desc: '',
      args: [],
    );
  }

  /// `VIDEO`
  String get str_video {
    return Intl.message(
      'VIDEO',
      name: 'str_video',
      desc: '',
      args: [],
    );
  }

  /// `RETURN TO PREVIOUS`
  String get menu_return_to_previous {
    return Intl.message(
      'RETURN TO PREVIOUS',
      name: 'menu_return_to_previous',
      desc: '',
      args: [],
    );
  }

  /// `CONNECTION GUIDE`
  String get menu_connection_guide {
    return Intl.message(
      'CONNECTION GUIDE',
      name: 'menu_connection_guide',
      desc: '',
      args: [],
    );
  }

  /// `DEVICE MANAGEMENT`
  String get menu_device_management {
    return Intl.message(
      'DEVICE MANAGEMENT',
      name: 'menu_device_management',
      desc: '',
      args: [],
    );
  }

  /// `REAL-TIME VISION`
  String get menu_realtime_vision {
    return Intl.message(
      'REAL-TIME VISION',
      name: 'menu_realtime_vision',
      desc: '',
      args: [],
    );
  }

  /// `LIVE STREAM`
  String get menu_live_stream {
    return Intl.message(
      'LIVE STREAM',
      name: 'menu_live_stream',
      desc: '',
      args: [],
    );
  }

  /// `ABOUT`
  String get menu_about {
    return Intl.message(
      'ABOUT',
      name: 'menu_about',
      desc: '',
      args: [],
    );
  }

  /// `starting point`
  String get starting_point {
    return Intl.message(
      'starting point',
      name: 'starting_point',
      desc: '',
      args: [],
    );
  }

  /// `finishing point`
  String get finishing_point {
    return Intl.message(
      'finishing point',
      name: 'finishing_point',
      desc: '',
      args: [],
    );
  }

  /// `DETECTION ALARM`
  String get detection_alarm {
    return Intl.message(
      'DETECTION ALARM',
      name: 'detection_alarm',
      desc: '',
      args: [],
    );
  }

  /// `SET`
  String get detection_alarm_set {
    return Intl.message(
      'SET',
      name: 'detection_alarm_set',
      desc: '',
      args: [],
    );
  }

  /// `RECORD`
  String get detection_alarm_record {
    return Intl.message(
      'RECORD',
      name: 'detection_alarm_record',
      desc: '',
      args: [],
    );
  }

  /// `OPEN`
  String get detection_alarm_open {
    return Intl.message(
      'OPEN',
      name: 'detection_alarm_open',
      desc: '',
      args: [],
    );
  }

  /// `CLOSE`
  String get detection_alarm_close {
    return Intl.message(
      'CLOSE',
      name: 'detection_alarm_close',
      desc: '',
      args: [],
    );
  }

  /// `Device reminder mode`
  String get detection_alarm_mode {
    return Intl.message(
      'Device reminder mode',
      name: 'detection_alarm_mode',
      desc: '',
      args: [],
    );
  }

  /// `MUTE`
  String get detection_alarm_mode_mute {
    return Intl.message(
      'MUTE',
      name: 'detection_alarm_mode_mute',
      desc: '',
      args: [],
    );
  }

  /// `VIBRATE`
  String get detection_alarm_mode_vibrate {
    return Intl.message(
      'VIBRATE',
      name: 'detection_alarm_mode_vibrate',
      desc: '',
      args: [],
    );
  }

  /// `SOUND`
  String get detection_alarm_mode_sound {
    return Intl.message(
      'SOUND',
      name: 'detection_alarm_mode_sound',
      desc: '',
      args: [],
    );
  }

  /// `Save notification duration`
  String get detection_alarm_save_time {
    return Intl.message(
      'Save notification duration',
      name: 'detection_alarm_save_time',
      desc: '',
      args: [],
    );
  }

  /// `ONE DAY`
  String get detection_alarm_save_one_day {
    return Intl.message(
      'ONE DAY',
      name: 'detection_alarm_save_one_day',
      desc: '',
      args: [],
    );
  }

  /// `A WEEK`
  String get detection_alarm_save_a_week {
    return Intl.message(
      'A WEEK',
      name: 'detection_alarm_save_a_week',
      desc: '',
      args: [],
    );
  }

  /// `ONE MONTH`
  String get detection_alarm_save_one_month {
    return Intl.message(
      'ONE MONTH',
      name: 'detection_alarm_save_one_month',
      desc: '',
      args: [],
    );
  }

  /// `Detection interval`
  String get detection_alarm_interval {
    return Intl.message(
      'Detection interval',
      name: 'detection_alarm_interval',
      desc: '',
      args: [],
    );
  }

  /// `1 SECONDS`
  String get detection_alarm_interval_5_seconds {
    return Intl.message(
      '1 SECONDS',
      name: 'detection_alarm_interval_5_seconds',
      desc: '',
      args: [],
    );
  }

  /// `2 SECONDS`
  String get detection_alarm_interval_1_minute {
    return Intl.message(
      '2 SECONDS',
      name: 'detection_alarm_interval_1_minute',
      desc: '',
      args: [],
    );
  }

  /// `5 SECONDS`
  String get detection_alarm_interval_10_minutes {
    return Intl.message(
      '5 SECONDS',
      name: 'detection_alarm_interval_10_minutes',
      desc: '',
      args: [],
    );
  }

  /// `60 SECONDS`
  String get detection_alarm_interval_30_minutes {
    return Intl.message(
      '60 SECONDS',
      name: 'detection_alarm_interval_30_minutes',
      desc: '',
      args: [],
    );
  }

  /// `ALL`
  String get detection_alarm_all {
    return Intl.message(
      'ALL',
      name: 'detection_alarm_all',
      desc: '',
      args: [],
    );
  }

  /// `ANIMAL`
  String get detection_alarm_animal {
    return Intl.message(
      'ANIMAL',
      name: 'detection_alarm_animal',
      desc: '',
      args: [],
    );
  }

  /// `PERSON`
  String get detection_alarm_person {
    return Intl.message(
      'PERSON',
      name: 'detection_alarm_person',
      desc: '',
      args: [],
    );
  }

  /// `DELETE`
  String get detection_alarm_delete_record {
    return Intl.message(
      'DELETE',
      name: 'detection_alarm_delete_record',
      desc: '',
      args: [],
    );
  }

  /// `DELETE ALL`
  String get detection_alarm_delete_all {
    return Intl.message(
      'DELETE ALL',
      name: 'detection_alarm_delete_all',
      desc: '',
      args: [],
    );
  }

  /// `DEVICE MANAGEMENT`
  String get device_management {
    return Intl.message(
      'DEVICE MANAGEMENT',
      name: 'device_management',
      desc: '',
      args: [],
    );
  }

  /// `REAL-TIME VISION`
  String get realtime_vision {
    return Intl.message(
      'REAL-TIME VISION',
      name: 'realtime_vision',
      desc: '',
      args: [],
    );
  }

  /// `LIVE STREAM`
  String get live_stream {
    return Intl.message(
      'LIVE STREAM',
      name: 'live_stream',
      desc: '',
      args: [],
    );
  }

  /// `Product SN:  \t `
  String get about_product_sn {
    return Intl.message(
      'Product SN:  \t ',
      name: 'about_product_sn',
      desc: '',
      args: [],
    );
  }

  /// `Current Version:  \t`
  String get about_current_version {
    return Intl.message(
      'Current Version:  \t',
      name: 'about_current_version',
      desc: '',
      args: [],
    );
  }

  /// `Product Introduction`
  String get about_product_introduction {
    return Intl.message(
      'Product Introduction',
      name: 'about_product_introduction',
      desc: '',
      args: [],
    );
  }

  /// `Check for Update`
  String get about_version_update_check {
    return Intl.message(
      'Check for Update',
      name: 'about_version_update_check',
      desc: '',
      args: [],
    );
  }

  /// `Got New Version ：%1$s`
  String get about_got_update {
    return Intl.message(
      'Got New Version ：%1\$s',
      name: 'about_got_update',
      desc: '',
      args: [],
    );
  }

  /// `Start Update`
  String get about_start_update {
    return Intl.message(
      'Start Update',
      name: 'about_start_update',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Update`
  String get about_cancel_update {
    return Intl.message(
      'Cancel Update',
      name: 'about_cancel_update',
      desc: '',
      args: [],
    );
  }

  /// `Checking For Update`
  String get about_checking_update {
    return Intl.message(
      'Checking For Update',
      name: 'about_checking_update',
      desc: '',
      args: [],
    );
  }

  /// `NetWork Error，Please Check The NetWork Connection`
  String get error_network {
    return Intl.message(
      'NetWork Error，Please Check The NetWork Connection',
      name: 'error_network',
      desc: '',
      args: [],
    );
  }

  /// `Downloading ：%1$s`
  String get about_update_downloading {
    return Intl.message(
      'Downloading ：%1\$s',
      name: 'about_update_downloading',
      desc: '',
      args: [],
    );
  }

  /// `Transmitting ：%1$s`
  String get about_update_pushing {
    return Intl.message(
      'Transmitting ：%1\$s',
      name: 'about_update_pushing',
      desc: '',
      args: [],
    );
  }

  /// `Update The Machine SoftWare`
  String get about_update_push {
    return Intl.message(
      'Update The Machine SoftWare',
      name: 'about_update_push',
      desc: '',
      args: [],
    );
  }

  /// `Update Success`
  String get about_update_success {
    return Intl.message(
      'Update Success',
      name: 'about_update_success',
      desc: '',
      args: [],
    );
  }

  /// `Upgrade Failed`
  String get error_update {
    return Intl.message(
      'Upgrade Failed',
      name: 'error_update',
      desc: '',
      args: [],
    );
  }

  /// `ReStart`
  String get about_update_restart {
    return Intl.message(
      'ReStart',
      name: 'about_update_restart',
      desc: '',
      args: [],
    );
  }

  /// `Please wait, upgrading`
  String get about_update_upgrading {
    return Intl.message(
      'Please wait, upgrading',
      name: 'about_update_upgrading',
      desc: '',
      args: [],
    );
  }

  /// `New Version Detected`
  String get new_version_detected {
    return Intl.message(
      'New Version Detected',
      name: 'new_version_detected',
      desc: '',
      args: [],
    );
  }

  /// `Already the latest version`
  String get new_version_latest {
    return Intl.message(
      'Already the latest version',
      name: 'new_version_latest',
      desc: '',
      args: [],
    );
  }

  /// `enable a real-time view on App,\n easily share what you seen with friends.`
  String get app_about {
    return Intl.message(
      'enable a real-time view on App,\n easily share what you seen with friends.',
      name: 'app_about',
      desc: '',
      args: [],
    );
  }

  /// `EXIT`
  String get str_exit {
    return Intl.message(
      'EXIT',
      name: 'str_exit',
      desc: '',
      args: [],
    );
  }

  /// `USER MANUAL`
  String get user_manual {
    return Intl.message(
      'USER MANUAL',
      name: 'user_manual',
      desc: '',
      args: [],
    );
  }

  /// `This app. requests device firmware version 2.0.2 or higher; Please download from link %1$s and update the device’s firmware on PC if necessary.`
  String get version_content {
    return Intl.message(
      'This app. requests device firmware version 2.0.2 or higher; Please download from link %1\$s and update the device’s firmware on PC if necessary.',
      name: 'version_content',
      desc: '',
      args: [],
    );
  }

  /// `Access to Download`
  String get version_one {
    return Intl.message(
      'Access to Download',
      name: 'version_one',
      desc: '',
      args: [],
    );
  }

  /// `No Need`
  String get version_two {
    return Intl.message(
      'No Need',
      name: 'version_two',
      desc: '',
      args: [],
    );
  }

  /// `Don't show this again`
  String get version_three {
    return Intl.message(
      'Don\'t show this again',
      name: 'version_three',
      desc: '',
      args: [],
    );
  }

  /// `Please pass in the folder path`
  String get give_file_path {
    return Intl.message(
      'Please pass in the folder path',
      name: 'give_file_path',
      desc: '',
      args: [],
    );
  }

  /// `MapsGpsActivity`
  String get title_activity_maps_gps {
    return Intl.message(
      'MapsGpsActivity',
      name: 'title_activity_maps_gps',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
