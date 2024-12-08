package kr.heewook.gtm_android

import android.app.Activity
import android.os.Bundle
import android.util.Log
import androidx.annotation.Keep
import androidx.annotation.NonNull
import com.google.android.gms.tagmanager.CustomTagProvider
import com.google.firebase.analytics.FirebaseAnalytics
import com.google.firebase.analytics.ktx.analytics
import com.google.firebase.ktx.Firebase
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import org.json.JSONArray
import org.json.JSONException
import org.json.JSONObject
import io.flutter.plugin.common.MethodChannel.Result as MethodChannelResult

class GtmAndroidPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {

    private lateinit var binaryMessenger: BinaryMessenger
    private lateinit var firebaseAnalytics: FirebaseAnalytics
    lateinit var channel: MethodChannel
    lateinit var activity: Activity

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        binaryMessenger = flutterPluginBinding.binaryMessenger
        firebaseAnalytics = Firebase.analytics
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
        channel = MethodChannel(binaryMessenger, "heewook.kr/gtm_android")
        channel.setMethodCallHandler(this)
    }


    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        onAttachedToActivity(binding)
    }

    override fun onDetachedFromActivityForConfigChanges() {}

    override fun onDetachedFromActivity() {}

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        if (!::channel.isInitialized) {
            return // Prevent crash if channel is not initialized
        }
        channel.setMethodCallHandler(null)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannelResult) {
        try {
            val args = decodeArguments(call.arguments as String)
            when (call.method) {
                "push" -> {
                    val eventName = args.getString("eventName")
                    val eventParameters = if (args.has("eventParameters")) {
                        jsonObjectToBundle(args.getJSONObject("eventParameters"))
                    } else {
                        null
                    }
                    firebaseAnalytics.logEvent(eventName, eventParameters)
                    result.success(true)
                }

                else -> result.notImplemented()
            }
        } catch (e: Exception) {
            result.error("EXCEPTION_IN_HANDLE", e.message, null)
        }
    }

    @Throws(Exception::class)
    private fun decodeArguments(arguments: String): JSONObject {
        return JSONObject(arguments)
    }

    @Throws(JSONException::class)
    fun jsonObjectToBundle(jsonObject: JSONObject): Bundle? {
        val bundle = Bundle()
        val iterator: Iterator<*> = jsonObject.keys()
        while (iterator.hasNext()) {
            val key = iterator.next() as String
            val value = jsonObject.get(key)
            when (value) {
                is String -> bundle.putString(key, value)
                is Int -> bundle.putInt(key, value)
                is Double -> bundle.putDouble(key, value)
                is Boolean -> bundle.putBoolean(key, value)
                is JSONArray -> bundle.putString(key, value.toString())
                is JSONObject -> bundle.putString(key, value.toString())
                else -> {
                    Log.w("GTM", "Unsupported data type for key: $key")
                }
            }
        }
        return bundle
    }
}

@Keep
class CustomTag(var activity: Activity, var channel: MethodChannel) : CustomTagProvider {
    override fun execute(
        @NonNull parameters: Map<String, Any>,
    ) {
        val arguments = convertJsonStringsToJsonObject(parameters)
        return try {
            activity.runOnUiThread {
                channel.invokeMethod("CustomTag", encodeArguments(arguments))
            }
        } catch (e: Exception) {
            e.message?.let { Log.d("Gtm CustomTag error", it) }
            return
        }
    }

    fun convertJsonStringsToJsonObject(map: Map<String, Any>): Map<String, Any> {
        val result = mutableMapOf<String, Any>()
        for ((key, value) in map) {
            if (value !is String) {
                result[key] = value
                continue
            }
            val encodedObject = jsonStringToJsonObject(value)
            if (encodedObject != null) {
                result[key] = encodedObject
                continue
            }
            val encodedArray = jsonStringToJsonArray(value)
            if (encodedArray != null) {
                result[key] = encodedArray
                continue
            }
            result[key] = value
        }
        return result
    }

    fun jsonStringToJsonObject(jsonString: String): JSONObject? {
        try {
            return JSONObject(jsonString)
        } catch (e: JSONException) {
            return null
        }
    }

    fun jsonStringToJsonArray(jsonString: String): JSONArray? {
        try {
            return JSONArray(jsonString)
        } catch (e: JSONException) {
            return null
        }
    }

    @Throws(Exception::class)
    private fun encodeArguments(argumentsMap: Map<String, Any>): String {
        return JSONObject(argumentsMap).toString()
    }
}