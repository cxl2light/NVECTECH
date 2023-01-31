import 'dart:ffi'; // For FFI
import 'dart:io'; // For Platform.isX


final DynamicLibrary nativeAddLib = Platform.isAndroid
    ? DynamicLibrary.open('libnative_add.so')
    : DynamicLibrary.process();

final int Function(Pointer<Int8>) initDevice = nativeAddLib
    .lookup<NativeFunction<Int32 Function(Pointer<Int8>)>>('init_device')
    .asFunction();

final int Function(int nChannelNo, Pointer<Int8>) initUpgrade = nativeAddLib
    .lookup<NativeFunction<Int32 Function(Int32, Pointer<Int8>)>>('init_upgrade')
    .asFunction();

final Pointer<Int8> Function() getJsonDev = nativeAddLib
    .lookup<NativeFunction<Pointer<Int8> Function()>>('getJsonDev')
    .asFunction();

final Pointer<Int8> Function() getJsonAnalyseResult = nativeAddLib
    .lookup<NativeFunction<Pointer<Int8> Function()>>('getJsonAnalyseResult')
    .asFunction();

final int Function(int nChannelNo) initGetDeviceConfig = nativeAddLib
    .lookup<NativeFunction<Int32 Function(Int32)>>('init_get_device_config')
    .asFunction();

final int Function(int nChannelNo) initGetCamera = nativeAddLib
    .lookup<NativeFunction<Int32 Function(Int32)>>('init_get_camera')
    .asFunction();

final int Function(int nChannelNo) initGetAnalyseresult = nativeAddLib
    .lookup<NativeFunction<Int32 Function(Int32)>>('init_get_analyseresult')
    .asFunction();

final int Function(int nChannelNo, int index) setPalette = nativeAddLib
    .lookup<NativeFunction<Int32 Function(Int32, Int32)>>('IR_APP_SET_PALETTE')
    .asFunction();

final int Function(int nChannelNo, int index) setZoom = nativeAddLib
    .lookup<NativeFunction<Int32 Function(Int32, Int32)>>('set_zoom')
    .asFunction();

final int Function(int nChannelNo, int index) setSharpness = nativeAddLib
    .lookup<NativeFunction<Int32 Function(Int32, Int32)>>('set_sharpness')
    .asFunction();

final int Function(int nChannelNo, int index) setBrightness = nativeAddLib
    .lookup<NativeFunction<Int32 Function(Int32, Int32)>>('set_brightness')
    .asFunction();

final int Function(int nChannelNo, int index) setContrast = nativeAddLib
    .lookup<NativeFunction<Int32 Function(Int32, Int32)>>('set_contrast')
    .asFunction();

final int Function(int nChannelNo, int index) setNoiseReduction = nativeAddLib
    .lookup<NativeFunction<Int32 Function(Int32, Int32)>>('set_noise_reduction')
    .asFunction();

final int Function(int nChannelNo, int index) setReticle = nativeAddLib
    .lookup<NativeFunction<Int32 Function(Int32, Int32)>>('set_reticle')
    .asFunction();

final int Function(int nChannelNo, int index) setTraceEnable = nativeAddLib
    .lookup<NativeFunction<Int32 Function(Int32, Int32)>>('set_trace_enable')
    .asFunction();

final int Function(int nChannelNo, int index) setPIP = nativeAddLib
    .lookup<NativeFunction<Int32 Function(Int32, Int32)>>('set_pip')
    .asFunction();

final int Function(int nChannelNo, int index) setDistanceEnable = nativeAddLib
    .lookup<NativeFunction<Int32 Function(Int32, Int32)>>('set_distance_enable')
    .asFunction();







