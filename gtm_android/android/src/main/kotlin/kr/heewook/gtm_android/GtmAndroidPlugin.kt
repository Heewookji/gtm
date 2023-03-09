package kr.heewook.gtm_android

import android.app.Activity
import android.os.Bundle
import android.util.Log
import androidx.annotation.NonNull
import com.google.android.gms.tagmanager.CustomTagProvider
import com.google.firebase.analytics.FirebaseAnalytics
import com.google.firebase.analytics.ktx.analytics
import com.google.firebase.ktx.Firebase
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import org.json.JSONException
import org.json.JSONObject
import io.flutter.plugin.common.MethodChannel.Result as MethodChannelResult

class GtmAndroidPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  companion object {
    @JvmStatic
    lateinit var channel: MethodChannel
    @JvmStatic
    lateinit var activity: Activity
  }
  private lateinit var firebaseAnalytics: FirebaseAnalytics

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    firebaseAnalytics = Firebase.analytics
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "heewook.kr/gtm_android")
    channel.setMethodCallHandler(this)
  }
  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
  }
  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    onAttachedToActivity(binding)
  }
  override fun onDetachedFromActivityForConfigChanges() {}

  override fun onDetachedFromActivity() {}

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannelResult) {
    try {
      val args = decodeArguments(call.arguments as String)
      when (call.method) {
        "push" -> {
          val eventName = args.getString("eventName")
          val eventParameters = jsonToBundle(args.getJSONObject("eventParameters"))
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
  fun jsonToBundle(jsonObject: JSONObject): Bundle? {
    val bundle = Bundle()
    val iterator: Iterator<*> = jsonObject.keys()
    while (iterator.hasNext()) {
      val key = iterator.next() as String
      val value = jsonObject.getString(key)
      bundle.putString(key, value)
    }
    return bundle
  }

}

class CustomTag: CustomTagProvider {
  @Throws(Exception::class)
  private fun encodeArguments(argumentsMap: Map<String, Any>): String {
    return JSONObject(argumentsMap).toString()
  }
  override fun execute(@NonNull parameters: Map<String, Any>) {
    return try {
      GtmAndroidPlugin.activity.runOnUiThread {
        GtmAndroidPlugin.channel.invokeMethod("CustomTag", encodeArguments(parameters))
      }
    } catch (e: Exception) {
      e.message?.let { Log.d("Gtm CustomTag error", it) }
      return
    }
  }
}