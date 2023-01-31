#ifndef  NETCORESDK_H
#define  NETCORESDK_H

#include "NetDataType.h"

#if _WIN32
#ifdef DLL_IMPLEMENT 
#define NETCORE_API extern __declspec(dllexport) 
#else 
#define NETCORE_API extern __declspec(dllimport) 
#endif 
#else
#define NETCORE_API 
#endif


#ifdef __cplusplus
extern "C" 
{
#endif

	NETCORE_API int NET_CORE_GetSDKVersion();

	NETCORE_API int NET_CORE_GetSDKBuildVersion();	

	NETCORE_API int NET_CORE_Init();	

	NETCORE_API int NET_CORE_Cleanup();	

	NETCORE_API int NET_CORE_GetSDKAbility(  NET_CORE_SDKABL*     pSDKABL);

	NETCORE_API int NET_CORE_GetSDKState(  NET_CORE_SDKSTATE*     pSDKSTATE);

	NETCORE_API int NET_CORE_SetConnectTime(  int   nWaitTimeMS );  	////+1

	NETCORE_API int NET_CORE_SetReconnect(int   nIntervalMS,  int nEnableRecon);

	NETCORE_API int NET_CORE_SetRecvTimeOut(  int   nRecvTimeOutMS  );////+1

	NETCORE_API int NET_CORE_SetExceptionCallBack(  ExceptionCallBack   cbExceptionCallBack );

	NETCORE_API int NET_CORE_SearchCameras(const char* localIPv4);

	NETCORE_API int NET_CORE_GetCamerasList(CameraSimpleInfo pCameraSimpleInfo[],   int byteOutBufferSize);

	NETCORE_API int NET_CORE_Login(NET_CORE_USER_LOGIN_INFO* pLoginInfo );

    NETCORE_API int NET_CORE_LoginV1( char* sIpAddr, int nServerPort );

	NETCORE_API int NET_CORE_Logout( int    nUserID);

	NETCORE_API int NET_CORE_GetDeviceAbility(  int  nUserID, NET_CORE_DEVABL*  lpOutBuffer,  int  nOutBufferSize);////+1

	NETCORE_API int NET_CORE_GetDeviceInformation( int  nUserID,  DeviceInformation*  lpOutBuffer,  int  byteOutBufferSize);////+1

	NETCORE_API int NET_CORE_PTZControl(  int  nUserID,  int  nChannel, int  nPTZCommand,  int nStop);

	NETCORE_API int NET_CORE_PTZControlWithSpeed(int  nUserID,  int  nChannel,  int    nPTZCommand,  int    nStop,   int  nSpeed);////+1

	NETCORE_API int NET_CORE_PTZPreset(int     nUserID, int  nChannel, int    nPTZPresetCmd,  int  nPresetIndex,   int  nSpeed);

	NETCORE_API int NET_CORE_PTZCruise(  int     nUserID,  int   nChannel,   int    nPTZCruiseCmd,  int  nCruiseRoute);

	NETCORE_API int NET_CORE_GetPTZPresetsCFG(int   nUserID , int   nChannel,  PTZPresetsCFG*  lpOutBuffer,  int    nBufferSize);

	NETCORE_API int NET_CORE_GetPTZCruisesCFG(int   nUserID , int   nChannel,  PTZCruisesCFG*  lpOutBuffer,  int    nBufferSize);

	NETCORE_API int NET_CORE_GetOneCruiseCFG(int   nUserID , int   nChannel,  int  nCruiseRoute , OneCruiseCFG*  lpOutBuffer,  int    nBufferSize);////+1

	NETCORE_API int NET_CORE_SetOneCruiseCFG(int   nUserID , int   nChannel,   int  nCruiseRoute , OneCruiseCFG*  lpInBuffer,  int    nBufferSize);////+1

	NETCORE_API int NET_CORE_FocusOnePush(  int    nUserID,  int    nChannel);

	NETCORE_API int NET_CORE_RestoreCFG(  int    nUserID);

	NETCORE_API int NET_CORE_Reboot(  int   nUserID);

	NETCORE_API int NET_CORE_HardFactoryReset(  int   nUserID);

	NETCORE_API int NET_CORE_ShutDown(  int   nUserID);

	NETCORE_API int NET_CORE_SetupAlarmChan(  int   nUserID,  AlarmMessageCallBack    fMessageCallBack);	//,  NET_CORE_SETUPALARM_PARAM*   pSetupParam

	NETCORE_API int NET_CORE_CloseAlarmChan(int   nUserID );

	NETCORE_API int NET_CORE_SerialStart(  int   nUserID,  SerialDataCallBack    fSerialDataCallBack);

	NETCORE_API int NET_CORE_SerialStop(  int   nUserID);

	NETCORE_API int NET_CORE_SerialSend(  int     nUserID,  int    nSerialPort,  char     *pSendBuf,  int    nBufSize);

	NETCORE_API int NET_CORE_GetStreamInfo( int     nUserID,  StreamInfo* lpOutBuffer,  int    nBufSize );

	NETCORE_API int NET_CORE_RealPlay(  int   nUserID,  NET_CORE_PREVIEWINFO_EX*    lpPreviewInfo, CALLBACK_REALDATA        fRealDataCallBack);

	NETCORE_API int NET_CORE_StopRealPlay(  int lRealHandle);

#ifdef _WIN32
	NETCORE_API int NET_CORE_Snapshot(int nRealHandle,   const wchar_t* path);	//just *.jpg

	NETCORE_API int NET_CORE_StartRecord(int nRealHandle,  const wchar_t* path);		//just *.mp4
#else
	NETCORE_API int NET_CORE_Snapshot(int nRealHandle,   const char* path);	//just *.jpg

	NETCORE_API int NET_CORE_StartRecord(int nRealHandle,   const char* path);		//just *.mp4
#endif

	NETCORE_API void NET_CORE_StopRecord(int nRealHandle);

	NETCORE_API int NET_CORE_IsRecording(int nRealHandle);

	NETCORE_API int NET_CORE_MakeKeyFrame(int nRealHandle  	);		//I-frame or Key-Frame or Intra-frame

	NETCORE_API int NET_CORE_EnableLowCpu(  int nRealHandle , int enable);		  //Only I frames are decoded to maintain the lowest cpu usage

	NETCORE_API int NET_CORE_GetRecentHeartBeat( int   nUserID);

	NETCORE_API int NET_CORE_MakeChannelKeyFrame(int nUserID,  int     nChannel);

	NETCORE_API int NET_CORE_GetNetworkInterfaceCFG(int   nUserID ,  NetworkInterfaceCFG*  lpOutBuffer,  int    nBufferSize);////+1

	NETCORE_API int NET_CORE_SetNetworkInterfaceCFG(int   nUserID,  NetworkInterfaceCFG* lpInBuffer,  int    nBufferSize);////+1

	NETCORE_API int NET_CORE_GetPortsCFG(int   nUserID ,  PortsCFG*  lpOutBuffer,  int    nBufferSize);////+1

	NETCORE_API int NET_CORE_SetPortsCFG(int   nUserID,  PortsCFG* lpInBuffer,  int    nBufferSize);////+1

	NETCORE_API int NET_CORE_GetWhiteListCFG(int   nUserID ,  WhiteListCFG*  lpOutBuffer,  int    nBufferSize);////+1

	NETCORE_API int NET_CORE_SetWhiteListCFG(int   nUserID,  WhiteListCFG* lpInBuffer,  int    nBufferSize);////+1

	NETCORE_API int NET_CORE_GetRS232CFG(int   nUserID ,  RS232CFG*  lpOutBuffer,  int    nBufferSize);////+1

	NETCORE_API int NET_CORE_SetRS232CFG(int   nUserID,  RS232CFG*  lpInBuffer,  int    nBufferSize);////+1

	NETCORE_API int NET_CORE_GetRS485CFG(int   nUserID ,  RS485CFG*  lpOutBuffer,  int    nBufferSize);////+1

	NETCORE_API int NET_CORE_SetRS485CFG(int   nUserID,  RS485CFG*  lpInBuffer,  int    nBufferSize);////+1

	NETCORE_API int NET_CORE_GetTimeCFG(int   nUserID ,  TimeSettins*  lpOutBuffer,  int    nBufferSize);////+1

	NETCORE_API int NET_CORE_SetTimeCFG(int   nUserID,  TimeSettins*  lpInBuffer,  int    nBufferSize);////+1

	NETCORE_API int NET_CORE_GetAllVideoSettings(int     nUserID  , AllVideoSettings* lpOutBuffer , int    nBufferSize );

	NETCORE_API int NET_CORE_SetAllVideoSettings(int     nUserID , AllVideoSettings* lpInBuffer , int    nBufferSize );

	NETCORE_API int NET_CORE_GetImagingSettings(int     nUserID , int     nChannel,	 ImagingSettings* lpOutBuffer , int    nBufferSize );

	NETCORE_API int NET_CORE_SetImagingSettings(int     nUserID , int     nChannel,	    ImagingSettings* lpInBuffer , int    nBufferSize );

	NETCORE_API int NET_CORE_SetPalette(int nUserID,   int   nChannel ,  IRColorPalette nColorPaletteIndex);

	NETCORE_API int NET_CORE_GetDayNightSwitchingCFG(int     nUserID , int     nChannel,	 DayNightSwitchingCFG* lpOutBuffer , int    nBufferSize );

	NETCORE_API int NET_CORE_SetDayNightSwitchingCFG(int     nUserID , int     nChannel,	    DayNightSwitchingCFG* lpInBuffer , int    nBufferSize );

	NETCORE_API int NET_CORE_GetImageEnhancementCFG(int     nUserID , int     nChannel,	    ImageEnhancementCFG* lpOutBuffer , int    nBufferSize);

	NETCORE_API int NET_CORE_SetImageEnhancementCFG(int     nUserID , int     nChannel,	    ImageEnhancementCFG* lpInBuffer , int    nBufferSize);

	NETCORE_API int NET_CORE_GetWhiteBalanceCFG(int     nUserID , int     nChannel,	    WhiteBalanceCFG* lpOutBuffer , int    nBufferSize);

	NETCORE_API int NET_CORE_SetWhiteBalanceCFG(int     nUserID , int     nChannel,	    WhiteBalanceCFG* lpInBuffer , int    nBufferSize);

	NETCORE_API int NET_CORE_GetBacklightCFG(int     nUserID , int     nChannel,	    BacklightCFG* lpOutBuffer , int    nBufferSize);

	NETCORE_API int NET_CORE_SetBacklightCFG(int     nUserID , int     nChannel,	    BacklightCFG* lpInBuffer , int    nBufferSize);

	NETCORE_API int NET_CORE_GetOSD_CFG(int     nUserID , int     nChannel,	    OSD_CFG* lpOutBuffer , int    nBufferSize);

	NETCORE_API int NET_CORE_SetOSD_CFG(int     nUserID , int     nChannel,	    OSD_CFG* lpInBuffer , int    nBufferSize);

	NETCORE_API int NET_CORE_GetFireDetectionCFG(int     nUserID , int     nChannel,   int  nPresetIndex,  NET_CORE_FIRE_DETECTION_CFG*  lpOutBuffer,  int    nBufferSize);////+1

	NETCORE_API int NET_CORE_SetFireDetectionCFG(int     nUserID , int     nChannel,   int  nPresetIndex,   NET_CORE_FIRE_DETECTION_CFG*  lpInBuffer,  int    nBufferSize);////+1

	NETCORE_API int NET_CORE_GetSnapshotScheduleCFG(  int     nUserID , int     nChannel,  NET_CORE_SNAPSHOT_SCHEDULE_CFG*   lpOutBuffer,  int    nBufferSize);////+1

	NETCORE_API int NET_CORE_SetSnapshotScheduleCFG( int     nUserID,   int     nChannel, NET_CORE_SNAPSHOT_SCHEDULE_CFG*   lpInBuffer,  int    nBufferSize    ); ////+1

	NETCORE_API int NET_CORE_GetGlobalVCACFG( int     nUserID,   int     nChannel, NET_CORE_GLOBAL_VCA_CFG*   lpOutBuffer,  int    nBufferSize    );////+1

	NETCORE_API int NET_CORE_SetGlobalVCACFG( int     nUserID,   int     nChannel, NET_CORE_GLOBAL_VCA_CFG*   lpInBuffer,  int    nBufferSize    );////+1

	NETCORE_API int NET_CORE_GetMotionDetectionVCACFG( int     nUserID,   int     nChannel, NET_CORE_MOTION_DETECTION_VCA_CFG*   lpOutBuffer,  int    nBufferSize    );////+1

	NETCORE_API int NET_CORE_SetMotionDetectionVCACFG( int     nUserID,   int     nChannel, NET_CORE_MOTION_DETECTION_VCA_CFG*   lpInBuffer,  int    nBufferSize    ); ////+1	

	NETCORE_API int NET_CORE_GetEnterAreaVCACFG( int     nUserID,   int     nChannel, NET_CORE_MOTION_DETECTION_VCA_CFG*   lpOutBuffer,  int    nBufferSize    );////+1		//bug pointer pBin

	NETCORE_API int NET_CORE_SetEnterAreaVCACFG( int     nUserID,   int     nChannel, NET_CORE_MOTION_DETECTION_VCA_CFG*   lpInBuffer,  int    nBufferSize    );////+1	//bug pointer pBin

	NETCORE_API int NET_CORE_GetLeaveAreaVCACFG( int     nUserID,   int     nChannel, NET_CORE_MOTION_DETECTION_VCA_CFG*   lpOutBuffer,  int    nBufferSize    );////+1		//bug pointer pBin

	NETCORE_API int NET_CORE_SetLeaveAreaVCACFG( int     nUserID,   int     nChannel, NET_CORE_MOTION_DETECTION_VCA_CFG*   lpInBuffer,  int    nBufferSize    );////+1	//bug pointer pBin

	NETCORE_API int NET_CORE_GetCrossLineDetectionVCACFG( int     nUserID,   int     nChannel, NET_CORE_MOTION_DETECTION_VCA_CFG*   lpOutBuffer,  int    nBufferSize    );////+1

	NETCORE_API int NET_CORE_SetCrossLineDetectionVCACFG( int     nUserID,   int     nChannel, NET_CORE_MOTION_DETECTION_VCA_CFG*   lpInBuffer,  int    nBufferSize    );////+1

	NETCORE_API int NET_CORE_GetAreaIntrusionDetectionVCACFG( int     nUserID,   int     nChannel, NET_CORE_MOTION_DETECTION_VCA_CFG*   lpOutBuffer,  int    nBufferSize    );////+1

	NETCORE_API int NET_CORE_SetAreaIntrusionDetectionVCACFG( int     nUserID,   int     nChannel, NET_CORE_MOTION_DETECTION_VCA_CFG*   lpInBuffer,  int    nBufferSize    );////+1

	NETCORE_API int NET_CORE_GetOcclusionDetectionVCACFG( int     nUserID,   int     nChannel, NET_CORE_OCCLUSION_DETECTION_VCA_CFG*   lpOutBuffer,  int    nBufferSize    );////+1

	NETCORE_API int NET_CORE_SetOcclusionDetectionVCACFG( int     nUserID,   int     nChannel, NET_CORE_OCCLUSION_DETECTION_VCA_CFG*   lpInBuffer,  int    nBufferSize    );////+1

	 //Manufacturer's private function
	NETCORE_API int NET_CORE_Request(int   nUserID,   char* pURI,  void*  buff,  int    nBufferSize); 

#ifdef _WIN32
	NETCORE_API void NET_CORE_SetPluginDir(const wchar_t * wPluginDir);
#endif


	/*
		Thermal - Online Analysis
	*/
	NETCORE_API int NET_IR_GetMTPreferences(int   nUserID,    MT_Preferences*   lpOutBuffer,  int    nBufferSize  );

	NETCORE_API int NET_IR_SetMTPreferences(int   nUserID,    MT_Preferences*   lpInBuffer,  int    nBufferSize  );

	NETCORE_API int NET_IR_EnableTemperatureMeasurement(int   nUserID, int enable);

	NETCORE_API int NET_IR_StartRecvTempInfo(int   nUserID, FunTempInfo funTempInfo,  int fps);

	NETCORE_API int NET_IR_StopRecvTempInfo(int   nUserID);

	NETCORE_API int NET_IR_StartProcessImage(int   nUserID,   FunInfraredImage  funInfraredImage,  RawFrameTransferSettings* lpInBuffer);

	NETCORE_API int NET_IR_StartProcessPulseImage(int   nUserID,   FunInfraredImage  funInfraredImage); 

	NETCORE_API bool NET_IR_IsProcessingImage(int   nUserID); 

	NETCORE_API int NET_IR_TransferPulseImage(int   nUserID);

	NETCORE_API int NET_IR_StopProcessImage(int   nUserID);

	NETCORE_API int NET_IR_SetRawFps(int   nUserID, int fps);

	NETCORE_API int NET_IR_LockImage(int   nUserID);

	NETCORE_API int NET_IR_UnLockImage(int   nUserID);

	NETCORE_API int NET_IR_GetSensorSize(int   nUserID,   MT_SIZE* lpOutBuffer);

	NETCORE_API int NET_IR_GetTemperatureData(int   nUserID, float* lpOutBuffer, int nBufferSize );		//Default:   width * height * sizeof(float)

	NETCORE_API int NET_IR_GetRawFrameData(int   nUserID,  short* lpOutBuffer, int nBufferSize );		//Default:   width * height * sizeof(short)

	NETCORE_API int NET_IR_SetFixPara(int   nUserID, FixPara* lpInBuffer , int nBufferSize);

	NETCORE_API int NET_IR_ResetTempPara(int   nUserID);

	NETCORE_API int NET_IR_SetPalette(int nUserID, IRColorPalette nColorPaletteIndex);

	NETCORE_API int NET_IR_TriggerFFC(int   nUserID);		//Perform a flat-field correction, or FFC

	NETCORE_API int NET_IR_SetTemperatureRange(int   nUserID, int index);

	NETCORE_API int NET_IR_SetTemperatureUnit(int   nUserID , TEMPER_UNIT unit);	//Degree Celsius (¡ãC)/ Degree Fahrenheit (¡ãF)/ Degree Kelvin (K).

	NETCORE_API int NET_IR_DisplayTempInfoOnStream(int   nUserID ,  int enable);

	NETCORE_API int NET_IR_ClearAllMarkers(int   nUserID , int  nPresetIndex   );

	NETCORE_API int NET_IR_GetAllMarkersCfg(int   nUserID,  int  nPresetIndex,  MT_ALL_MARKERS_CFG* lpOutBuffer , int nBufferSize );

	NETCORE_API int NET_IR_SetAllMarkersCfg(int   nUserID,   int  nPresetIndex, MT_ALL_MARKERS_CFG* lpInBuffer , int nBufferSize );

	NETCORE_API int NET_IR_SetTempOffset(int   nUserID , float  offset  );

#ifdef _WIN32
	NETCORE_API int NET_IR_SaveBMP(int   nUserID,  const wchar_t * wFilename);

	NETCORE_API int NET_IR_SaveIR2(int   nUserID,  const wchar_t * wFilename);

#else
	NETCORE_API int NET_IR_SaveBMP(int   nUserID,  const char * wFilename);

	NETCORE_API int NET_IR_SaveIR2(int  nUserID ,  const char * wFilename);
#endif

	/*
		Thermal - Offline Analysis ,  IR2 File
	*/
//	NETCORE_API int NET_IR2_CreateHandle();
//
//	NETCORE_API int NET_IR2_DestoryHandle(int   nIR2Handle);
//
//	NETCORE_API int NET_IR2_isValid(int   nIR2Handle);
//
//	NETCORE_API int NET_IR2_IsEmpty(int   nIR2Handle);
//
//	
//#ifdef _WIN32
//	NETCORE_API int NET_IR2_Load(int   nIR2Handle , const wchar_t * wFilename);
//
//	NETCORE_API int NET_IR2_Save(int   nIR2Handle, const wchar_t * wFilename);
//
//#else
//	NETCORE_API int NET_IR2_Load(int   nIR2Handle , const char * wFilename);
//
//	NETCORE_API int NET_IR2_Save(int   nIR2Handle, const char * wFilename);
//
//#endif
//
//	NETCORE_API int NET_IR2_GetFileHeader(int   nIR2Handle,  IR2_FILE_HEADER *  lpOutBuffer,  int    nBufferSize );
//
//	NETCORE_API int NET_IR2_GetFileInfo(int   nIR2Handle,  IR2_FILE_INFO *  lpOutBuffer,  int    nBufferSize );
//
//	NETCORE_API int NET_IR2_GetParameters(int   nIR2Handle,  IR2_PARAMETERS *  lpOutBuffer,  int    nBufferSize );
//
//	NETCORE_API int NET_IR2_SetParameters(int   nIR2Handle,  IR2_PARAMETERS *  lpInBuffer,  int    nBufferSize );
//
//	NETCORE_API int NET_IR2_SetIRImgFormat(int   nIR2Handle,  IRImgFormat imgFormat);  	//Default:  Format_BGR888
//
//	NETCORE_API int NET_IR2_RedrawBits(int   nIR2Handle);
//
//	//Returns a pointer to the first pixel data   (Default :  width * height * 3,     BGR or RGB )
//	NETCORE_API unsigned char * NET_IR2_GetBitsPtr(int   nIR2Handle);		
//
//	NETCORE_API short * NET_IR2_GetRawFramePtr(int   nIR2Handle);		


#ifdef __cplusplus
}
#endif


#endif
