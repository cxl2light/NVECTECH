import 'dart:ffi'; // For FFI
import 'dart:io';


final DynamicLibrary libShare = Platform.isAndroid
    ? DynamicLibrary.open('libc++_shared.so')
    : DynamicLibrary.process();

final DynamicLibrary libNetCore = Platform.isAndroid
    ? DynamicLibrary.open('libNetCore_arm64-v8a.so')
    : DynamicLibrary.process();

final DynamicLibrary libNetCore7 = Platform.isAndroid
    ? DynamicLibrary.open('libNetCore_armeabi-v7a.so')
    : DynamicLibrary.process();

final DynamicLibrary libExp = Platform.isAndroid
    ? DynamicLibrary.open('libExp.so')
    : DynamicLibrary.process();

final int Function(int a, int b) expAdd = libExp
    .lookup<NativeFunction<Int32 Function(Int32, Int32)>>('NET_ADD')
    .asFunction();

final int Function() initNetCore = libNetCore
    .lookup<NativeFunction<Int32 Function()>>('NET_CORE_Init')
    .asFunction();

final int Function(Pointer<Int8> url, int port) netCoreLogin = libNetCore
    .lookup<NativeFunction<Int32 Function(Pointer<Int8>, Int32)>>('NET_CORE_LoginV1')
    .asFunction();



// final DynamicLibrary libavfilter = Platform.isAndroid
//     ? DynamicLibrary.open('libavfilter.so')
//     : DynamicLibrary.process();
//
// final DynamicLibrary libavformat = Platform.isAndroid
//     ? DynamicLibrary.open('libavformat.so')
//     : DynamicLibrary.process();
//
// final DynamicLibrary libswscale = Platform.isAndroid
//     ? DynamicLibrary.open('libswscale.so')
//     : DynamicLibrary.process();
//
// final DynamicLibrary libavutil = Platform.isAndroid
//     ? DynamicLibrary.open('libavutil.so')
//     : DynamicLibrary.process();
//
// final DynamicLibrary libswresample = Platform.isAndroid
//     ? DynamicLibrary.open('libswresample.so')
//     : DynamicLibrary.process();
//
// final DynamicLibrary libyuv = Platform.isAndroid
//     ? DynamicLibrary.open('libyuv.so')
//     : DynamicLibrary.process();
//
//
// final DynamicLibrary libmp4v2 = Platform.isAndroid
//     ? DynamicLibrary.open('libmp4v2.so')
//     : DynamicLibrary.process();
//
//
// final DynamicLibrary nativeLib = Platform.isAndroid
//     ? DynamicLibrary.open('libPluginFFmpeg_arm64-v8a.so')
//     : DynamicLibrary.process();
//
// final int Function() sdkInit = nativeLib
//     .lookup<NativeFunction<Int32 Function()>>('IPC_SDK_Init')
//     .asFunction();
//
// final int Function() newRealHandle = nativeLib
//     .lookup<NativeFunction<Int32 Function()>>('IPC_NewRealHandle')
//     .asFunction();
//
// final int Function(int nRealHandle) delRealHandle = nativeLib
//     .lookup<NativeFunction<Int32 Function(Int32)>>('IPC_DelRealHandle')
//     .asFunction();
//
// final int Function(int nRealHandle, Pointer<Int8> url, Pointer<Int8> path) startRecordMp4 = nativeLib
//     .lookup<NativeFunction<Int32 Function(Int32, Pointer<Int8>, Pointer<Int8>)>>('IPC_StartRecordMp4')
//     .asFunction();
//
// final int Function(int nRealHandle) stopRecordMp4 = nativeLib
//     .lookup<NativeFunction<Int32 Function(Int32)>>('IPC_StopRecordMp4')
//     .asFunction();