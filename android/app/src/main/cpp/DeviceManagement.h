#pragma once

#include "NetDataType.h"
#include "NetCoreSDK.h"
#pragma comment(lib, "NetCore.lib")

#include <sstream>

/*
Note:
- User ID  -   Control one camera (>=0)
- Channel  -   0: Day Channel ,  1:  Thermal Channel 
- Real Handle  -  Control one video stream
*/


class DeviceManagement
{
public:
	DeviceManagement(void);
	~DeviceManagement(void);

public:
	static volatile bool s_CanUpdate2GUI;

protected:
	volatile int _nUserID;
	
	int _realPlayVisibleMain;
	int _realPlayVisibleSub;
	int _realPlayThermalMain;

public:
	volatile int _recvRawFPS;

	//PTZ From Serial Callback Function
	volatile int _srcPan;
	volatile int _srcTilt;
	volatile int _displayPan;
	volatile int _displayTilt;
	volatile float _ftPan;
	volatile float _ftTIlt;


public:
	void SetUserID(int nUserID);

public:
	void* _pWnd;			//only windows   Show RAW Frame
	void* _pListCtrl;		//only windows   Show Basic Temp CFG
	void* _pSerialEdit;	//only windows   Show Serial Call back
	void* _pAlarmCtrl;	//only windows 

	void BmpData2Gui(MT_BASIC_CFG* pBasicCfg, unsigned char* pBits, int width, int height);
	void BasicCfg2Gui(MT_BASIC_CFG* pBasicCfg);

public:
	//SDK Initialization and Shutdown
	static int Init();	
	static int Cleanup();	 

	//SDK Version
	static int GetSDKVersion();
	static int GetSDKBuildVersion();

	//Online Search
	static int SearchCameras();
	static int SearchCameras(const char* NIC);
	static int GetCamerasList(CameraSimpleInfo pCameraSimpleInfo[],   int byteOutBufferSize);

	//timeout setting
	static void SetConnectTime(int nTimeoutMS);//Set connection timeout (milliseconds)
	static void SetRecvTimeOut(int nTimeoutMS);//Set receive timeout (milliseconds)


	//UNIT
	static const char* TEMPER_UNIT_TO_STR(TEMPER_UNIT unit);
public:
	//login and logout
	int SynLogin(char* ip,  int port);
	int AsynLogin(char* ip,  int port);
	int Logout();
	bool isValidUserId();

	//Dev Info And Dev Ability
	int GetDeviceInformation(DeviceInformation*  lpOutBuffer,  int  byteOutBufferSize);
	int GetDeviceAbilit(NET_CORE_DEVABL*  lpOutBuffer,  int  nOutBufferSize);
	std::string DeviceAbilit2String(NET_CORE_DEVABL* pDevABL);

	//Visible Main Stream
	int PlayVisibleMainStream(HWND hwnd);
	int StopPlayVisibleMainStream();
	int SnapshotVisibleMainStream( const wchar_t* path);	//just *.jpg
    int StartRecordVisibleMainStream( const wchar_t* path);		//just *.mp4
	void StopRecordVisibleMainStream();
	int MakeKeyFrameVisibleMainStream();	
	int EnableLowCpuVisibleMainStream(  int enable);

	//Thermal Main Stream
	int PlayThermalMainStream(HWND hwnd);
	int StopPlayThermalMainStream();
	int SnapshotThermalMainStream( const wchar_t* path);	//just *.jpg
	int StartRecordThermalMainStream(  const wchar_t* path);		//just *.mp4
	void StopRecordThermalMainStream();
	int MakeKeyFrameThermalMainStream();	
	int EnableLowCpuThermalMainStream(   int enable);

	//PTZ    
	int PTZControl(  int  nChannel, int  nPTZCommand,  int nStop);//nPTZCommand=PTZ_TILT_UP ,   PTZ_TILT_DOWN,   PTZ_PAN_LEFT,   PTZ_PAN_RIGHT,   PTZ_ZOOM_IN,  PTZ_ZOOM_OUT,  PTZ_FOCUS_NEAR........
	int PTZPreset(   int  nChannel, int    nPTZPresetCmd,  int  nPresetIndex,   int  nSpeed);//nPTZPresetCmd = PTZ_SET_PRESET,  PTZ_CLE_PRESET,  PTZ_GOTO_PRESET 
	int PTZCruise(   int   nChannel,   int    nPTZCruiseCmd,  int  nCruiseRoute);//nPTZCruiseCmd = PTZ_RUN_CRUISE,  PTZ_STOP_CRUISE

	//Image Settings
	int FocusOnePush(   int    nChannel);
	int GetImagingSettings(int     nChannel,	 ImagingSettings* lpOutBuffer , int    nBufferSize );
	int SetImagingSettings(int     nChannel,	  ImagingSettings* lpInBuffer , int    nBufferSize );
	int SetImagePalette(   int   nChannel ,  IRColorPalette nColorPaletteIndex);
	
	//Video Settings
	int GetAllVideoSettings(AllVideoSettings* lpOutBuffer , int    nBufferSize );
	int SetAllVideoSettings( AllVideoSettings* lpInBuffer , int    nBufferSize );

	//maintain
	int Reboot( );
	int ShutDown( );
	int RestoreCFG( );
	int HardFactoryReset( );

	//Seria Port
	int SerialStart(  );
	int SerialStop(  );
	int SerialSend( int    nSerialPort,  char     *pSendBuf,  int    nBufSize);		//nSerialPort - 1(232),2(485) 
	int DecodeRS232Data(char* frame, int framelen);

	//Alarm
	int SetupAlarmChan( );
	int CloseAlarmChan( );

	//Thermal Image Process (Temperature Measurement)
	int GetMTPreferences(MT_Preferences*   lpOutBuffer,  int    nBufferSize  );
	int SetMTPreferences(MT_Preferences*   lpInBuffer,  int    nBufferSize  );
	int StartProcessImage();
	int StartProcessPulseImage();
	int TransferPulseImage();
	int StopProcessImage();
	int EnableTemperatureMeasurement( int enable);
	int SetRawFps( int fps);
	int LockImage();
	int UnLockImage( );
	int SaveBMP( const wchar_t * wFilename);
	int GetSensorSize(MT_SIZE* lpOutBuffer);
	int GetTemperatureData( float* lpOutBuffer, int nBufferSize );
	int GetRawFrameData(short* lpOutBuffer, int nBufferSize );
	int SetFixPara( FixPara* lpInBuffer , int nBufferSize);
	int ResetTempPara(   );
	int SetPalette( IRColorPalette nColorPaletteIndex);
	int TriggerFFC( );		//Perform a flat-field correction, or FFC
	int SetTemperatureRange(  int index);
	int SetTemperatureUnit( TEMPER_UNIT unit);	//Degree Celsius (°„C)/ Degree Fahrenheit (°„F)/ Degree Kelvin (K).
	int DisplayTempInfoOnStream( int enable);
	int ClearAllMarkers(int nPresetIndex );
	int GetAllMarkersCfg(  int nPresetIndex, MT_ALL_MARKERS_CFG* lpOutBuffer , int nBufferSize );
	int SetAllMarkersCfg(  int nPresetIndex, MT_ALL_MARKERS_CFG* lpInBuffer , int nBufferSize );
	int SetTempOffset( float  offset  );
};

