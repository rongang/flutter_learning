package com.example.flutterdemo

import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.os.PersistableBundle
import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        super.onCreate(savedInstanceState, persistentState)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val channelUtils: MethodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "flutter.io/utils")
        channelUtils.setMethodCallHandler { call, result ->
            when (call.method) {
                "locationSettings" -> {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                        val intentLocation = Intent(Settings.ACTION_LOCATION_SOURCE_SETTINGS).apply {
                            putExtra(Settings.EXTRA_APP_PACKAGE, packageName)
//                            putExtra(Settings.EXTRA_CHANNEL_ID, "com.huawei.android.pushagent")
                        }
                        startActivity(intentLocation,Bundle.EMPTY)
                        result.success("跳转定位设置成功")
                    }
                }
            }
        }
    }
}
