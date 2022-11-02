package fl.baidu.mob.stat

import android.content.Context
import com.baidu.mobstat.StatService
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class BaiduMobStatPlugin : FlutterPlugin, MethodChannel.MethodCallHandler {
    private var mContext: Context? = null
    private var channel: MethodChannel? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {

        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "fl_baidu_mob_stat_ys")
        channel!!.setMethodCallHandler(this)
        mContext = flutterPluginBinding.applicationContext
        StatService.setAuthorizedState(mContext, false)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "setApiKey" -> {
                StatService.setAppKey(call.arguments as String)
                StatService.start(mContext)
                StatService.platformType(2)
                StatService.setAuthorizedState(mContext , true);
                result.success(true)
            }
            "setAppChannel" -> {
                StatService.setAppChannel(mContext, call.arguments as String, true)
                result.success(true)
            }
            "setAppVersionName" -> {
                StatService.setAppVersionName(mContext, call.arguments as String)
                result.success(true)
            }
            "setDebug" -> {
                StatService.setDebugOn(call.arguments as Boolean)
                result.success(true)
            }
            "setDebugOn" -> {
                result.success(true)
            }
            "logEvent" -> {
                val eventId = call.argument<String>("eventId")
                val attributes = call.argument<MutableMap<String, String>>("attributes")
                StatService.onEvent(mContext, eventId, "", 1, attributes)
                result.success(true)
            }
            "logDurationEvent" -> {
                val eventId = call.argument<String>("eventId")
                val label = call.argument<String>("label")
                val duration = call.argument<Int>("duration")
                val attributes = call.argument<MutableMap<String, String>?>("attributes")
                if (duration != null) {
                    StatService.onEventDuration(
                            mContext,
                            eventId,
                            label,
                            duration.toLong(),
                            attributes
                    )
                }
                result.success(true)
            }
            "eventStart" -> {
                StatService.onEventStart(mContext, call.argument("eventId"), call.argument("label"))
                result.success(true)
            }
            "eventEnd" -> {
                val eventId = call.argument<String>("eventId")
                val label = call.argument<String>("label")
                val attributes = call.argument<MutableMap<String, String>?>("attributes")
                StatService.onEventEnd(mContext, eventId, label, attributes)
                result.success(true)
            }
            "pageStart" -> {
                StatService.onPageStart(mContext, call.arguments as String)
                result.success(true)
            }
            "pageEnd" -> {
                StatService.onPageEnd(mContext, call.arguments as String)
                result.success(true)
            }
            "getDeviceCuId" -> result.success("")
            "getTestDeviceId" -> result.success(StatService.getTestDeviceId(mContext))

            else -> {
                result.notImplemented()
            }
        }

    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel!!.setMethodCallHandler(null)
    }

}