//
// Generated file. Do not edit.
//

// ignore: unused_import
import 'dart:ui';

import 'package:image_picker_for_web/image_picker_for_web.dart';
import 'package:video_player_web/video_player_web.dart';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

// ignore: public_member_api_docs
void registerPlugins(PluginRegistry registry) {
  ImagePickerPlugin.registerWith(registry.registrarFor(ImagePickerPlugin));
  VideoPlayerPlugin.registerWith(registry.registrarFor(VideoPlayerPlugin));
  registry.registerMessageHandler();
}
