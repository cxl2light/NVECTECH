package com.example.plugins;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import android.content.Context;
import com.example.plugins.NetworkUtils;

import java.io.IOException;

import okhttp3.Call;
import okhttp3.Callback;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

/** PluginsPlugin */
public class PluginsPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private String url = "http://192.168.1.73/cgi-bin/protocol.cgi?action=getCamera";
//  private String url = "https://www.baidu.com";
  private String result = "";
  private Context mContext;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    mContext = flutterPluginBinding.getApplicationContext();
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "plugins");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else if ((call.method.equals("callJavaMethod"))){
      System.out.println("CallJavaMethod Success!");
      System.out.println(mContext.getExternalCacheDir().getPath());
      test();
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

  public void test(){
//    for (int i = 0; i < 255; i ++){
//      if (i == 73){
        initData();
//      }
//    }
  }

  private void initData(){
    //1.创建OkHttpClient对象
    OkHttpClient okHttpClient = new OkHttpClient();
    //2.创建Request对象，设置一个url地址,设置请求方式。
    Request request = new Request.Builder().url(url).method("GET",null).build();
    //3.创建一个call对象,参数就是Request请求对象
    Call call = okHttpClient.newCall(request);
    //4.请求加入调度，重写回调方法
    call.enqueue(new Callback() {
      //请求失败执行的方法
      @Override
      public void onFailure(Call call, IOException e) {
        System.out.println("CallJavaMethod onFailure!" + e);
      }
      //请求成功执行的方法
      @Override
      public void onResponse(Call call, Response response) throws IOException {
        System.out.println("CallJavaMethod response=" + response);
      }
    });
  }


}
