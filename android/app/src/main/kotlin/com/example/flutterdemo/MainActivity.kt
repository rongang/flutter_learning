package com.example.flutterdemo

import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.os.PersistableBundle
import android.provider.Settings
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        super.onCreate(savedInstanceState, persistentState)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        //event Channel
        val originEvent = OriginMessageEventChannel(this, flutterEngine.dartExecutor.binaryMessenger)

        //methodChannel
        val channelUtils: MethodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "flutter.io/utils")
        channelUtils.setMethodCallHandler { call, result ->
            when (call.method) {
                "locationSettings" -> {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                        val intentLocation = Intent(Settings.ACTION_LOCATION_SOURCE_SETTINGS).apply {
                            putExtra(Settings.EXTRA_APP_PACKAGE, packageName)
//                            putExtra(Settings.EXTRA_CHANNEL_ID, "com.huawei.android.pushagent")
                        }
                        startActivity(intentLocation, Bundle.EMPTY)
                        result.success("跳转定位设置成功")
                    }
                }
                "startTimer" -> {
                    originEvent.startTimer()
                }
                "cancelTimer" -> {
                    originEvent.cancelTimer()
                }
                "createNativeMessage" -> {
                    val myIntent = Intent()
                    myIntent.data = Uri.parse("flutterLearning://test")
                    myIntent.putExtra("route", "hello world")
                    myIntent.action = "com.example.flutterdemo"

                    myIntent.flags = Intent.FLAG_ACTIVITY_CLEAR_TOP
                    myIntent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
                    myIntent.flags = Intent.FLAG_ACTIVITY_EXCLUDE_FROM_RECENTS
                    myIntent.flags = Intent.FLAG_ACTIVITY_NO_HISTORY
                    myIntent.flags = Intent.FLAG_ACTIVITY_SINGLE_TOP


                    val uri = myIntent.toUri(Intent.URI_INTENT_SCHEME)
                    println("MedirecLogcat=====$uri")
                    val pendingIntent: PendingIntent = PendingIntent.getBroadcast(context, 0, myIntent, 0)

                    val builder = NotificationCompat.Builder(this, "open")
//                            .setSmallIcon(R.drawable.splash)
                            .setContentTitle("My notification")
                            .setContentText("hello...")
                            .setStyle(NotificationCompat.BigTextStyle()
                                    .bigText("hi..."))
                            .setPriority(NotificationCompat.PRIORITY_DEFAULT)
                            .setContentIntent(pendingIntent)

                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N)
                        with(NotificationManagerCompat.from(this)) {
                            // notificationId is a unique int for each notification that you must define
                            notify(NotificationManager.IMPORTANCE_MAX, builder.build())
                        }
                }
                else -> {
                    result.notImplemented()
                }
            }
        }


        //eventChannel
        val sendOriginMessageEventChannel: EventChannel = EventChannel(flutterEngine.dartExecutor.binaryMessenger, "ReceiveOriginMessageEventChannel")
        sendOriginMessageEventChannel.setStreamHandler(
                object : EventChannel.StreamHandler {
                    override fun onListen(arguments: Any, events: EventSink) {

                    }

                    override fun onCancel(arguments: Any) {

                    }
                }
        )
    }
}
