package com.example.flutterdemo

import android.app.Activity
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import java.util.*
import kotlin.concurrent.timerTask

class OriginMessageEventChannel(private var activity: Activity, messenger: BinaryMessenger) : EventChannel.StreamHandler {
    private var event: EventChannel.EventSink? = null
    private var channel: EventChannel = EventChannel(messenger, "receiveOriginMessageEventChannel")
    private var index = 0

    init {
        channel.setStreamHandler(this)
    }

    private var timer: Timer? = null
    fun startTimer() {
        index = 0
        timer = Timer()
        timer!!.schedule(timerTask {
            index++
            val data = mapOf("name" to "laomeng$index", "age" to "$index")
            activity.runOnUiThread {
                event?.success(data)
            }
        }, 0, 1000)
    }

    fun cancelTimer() {
        timer?.cancel()
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        this.event = events
    }

    override fun onCancel(arguments: Any?) {
        this.event = null
    }
}