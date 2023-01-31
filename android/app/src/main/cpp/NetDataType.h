#ifndef NET_DATA_TYPE_H
#define NET_DATA_TYPE_H

////////////////////////////////////////////////
#define RET_Success (1)
#define RET_Fail (0)
#define RET_InvalidHandle (-1)

///////////////////////////////////////////////////
/*
Tip:   Each VCA configuration, up to 4 zones, 6 points per zone.
*/
#define MAX_VCA_AREA_COUNT (4)
#define MAX_VCA_PLOY_PT_COOUNT (6)

#define MAX_FIRE_DETECTION_AREA_COUNT (4)
#define MAX_FIRE_DETECTION_PLOY_PT_COOUNT (6)

#define FIXED_Fire_Detection_ZOOM_RATIO (1) //Fire Detection:  Zoom Ratio

//Tip:    VCA ,  Fire Detection ... The resolution is normalized to 8192,  except NET_IR_* Funcion
#define DEFAULT_NORMALIZED_SIZE (8192)

#define MAX_MARKER_PLOY_PT_COUNT (6)


typedef struct{
	unsigned short    nMaxLoginNum;
	unsigned short    nMaxRealPlayNum;
	unsigned short    nRes[20];
}NET_CORE_SDKABL;


typedef struct{
	unsigned char channel_visual_ability;						//1: ON ,  0: OFF
	unsigned char channel_infrared_ability;					//1: ON ,  0: OFF
	unsigned char channel_fused_ability;						//1: ON ,  0: OFF
	unsigned char channel_res[13];
	unsigned char network_tcpip_ability;						//1: ON ,  0: OFF
	unsigned char network_multicast_ability;				//......
	unsigned char network_port_ability;
	unsigned char network_whitelist_ability;
	unsigned char network_gb28181_ability;
	unsigned char network_network_4g_ability;
	unsigned char network_cloud_ability;
	unsigned char network_wifi_ability;
	unsigned char network_res[16];
	unsigned char codec_visualMain_ability;
	unsigned char codec_visualSub_ability;
	unsigned char codec_infraredMain_ability;
	unsigned char codec_infraredSub_ability;
	unsigned char codec_audio_ability;
	unsigned char codec_res[11];
	unsigned char vca_enable_ability;
	unsigned char vca_motion_ability;
	unsigned char vca_cross_ability;
	unsigned char vca_areain_ability;
	unsigned char vca_areaout_ability;
	unsigned char vca_intrusion_ability;
	unsigned char vca_firedetect_ability;
	unsigned char vca_res[17];
	unsigned char vca_object_human_ability;
	unsigned char vca_object_car_ability;
	unsigned char vca_object_boat_ability;
	unsigned char vca_object_res[13];
	unsigned char image_imageSet_ability;
	unsigned char image_osdSet_ability;
	unsigned char image_pictureInPicture_ability;
	unsigned char image_blindElement_ability;
	unsigned char image_res[12];
	unsigned char event_alarmIn_ability;
	unsigned char event_alarmOut_ability;
	unsigned char event_occlusion_ability;
	unsigned char event_exception_ability;
	unsigned char event_res[12];
	unsigned char history_enable_ability;
	unsigned char history_record_ability;
	unsigned char history_picture_ability;
	unsigned char history_res[13];
	unsigned char storage_enable_ability;
	unsigned char storage_eventRecord_ability;
	unsigned char storage_timingRecord_ability;
	unsigned char storage_eventSnapshot_ability;
	unsigned char storage_timingSnapshot_ability;
	unsigned char storage_res[11];
	unsigned char temperature_enable_ability;
	unsigned char temperature_basic_ability;
	unsigned char temperature_advanced_ability;
	unsigned char temperature_schedule_ability;
	unsigned char temperature_historyTemper_ability;
	unsigned char temperature_rawFrame_ability;
	unsigned char temperature_temperRange_ability;
	unsigned char temperature_res[9];
	unsigned char ptz_enable_ability;
	unsigned char ptz_direct_ability;
	unsigned char ptz_speed_ability;
	unsigned char ptz_zoom_ability;
	unsigned char ptz_focus_ability;
	unsigned char ptz_iris_ability;
	unsigned char ptz_focusing_ability;
	unsigned char ptz_wiper_ability;
	unsigned char ptz_positon3D_ability;
	unsigned char ptz_light_ability;
	unsigned char ptz_demisting_ability;
	unsigned char ptz_init_ability;
	unsigned char ptz_preset_ability;
	unsigned char ptz_cruise_ability;
	unsigned char ptz_ptzBasicCfg_ability;
	unsigned char ptz_keepWatch_ability;
	unsigned char ptz_zeroAzimuth_ability;
	unsigned char ptz_scheduleTask_ability;
	unsigned char ptz_setAzimuth_ability;
	unsigned char ptz_fan_ability;
	unsigned char ptz_heater_ability;
	unsigned char ptz_adaption_ability;
	unsigned char ptz_res[14];
	unsigned char res[256];
}NET_CORE_DEVABL;

typedef struct TagUserState{
	unsigned short userID;		//fixed value
	unsigned short res0;
	unsigned char isIdle;
	unsigned char isRunning;
	unsigned char isConnected;
	unsigned char isRawLocked;
	unsigned char isPlaying0;
	unsigned char isPlaying1;
	unsigned char isPlaying2;
	unsigned char res[9];
}NET_CORE_USER_STATE;

#define MAX_SDKSTATE_COUNT (64)
typedef struct{
	NET_CORE_USER_STATE struUserState[MAX_SDKSTATE_COUNT];
}NET_CORE_SDKSTATE;

typedef struct TagNET_CORE_DEVICE_INFO{  
	char                     byRes[256];
}NET_CORE_DEVICE_INFO;

#ifdef _WIN32
//nUserID:  User ID   ;      nResult: 0-fail, 1-Success;       
typedef void(__stdcall *CallBackLoginResult)(int   nUserID,  int  nResult,   NET_CORE_DEVICE_INFO*    lpDeviceInfo,  void    *pUserData);
#else
//nUserID:  User ID   ;      nResult: 0-fail, 1-Success;       
typedef void( *CallBackLoginResult)(int   nUserID,  int  nResult,   NET_CORE_DEVICE_INFO*    lpDeviceInfo,  void    *pUserData);
#endif

typedef struct TagNET_CORE_USER_LOGIN_INFO{  
	char                    sIpAddr[64];			//IPV4
	int						   nServerPort;			
	char                    sUserName[64];
	char                    sPassword[64];
	unsigned char		bUseAsynLogin;
	unsigned char		res[63];
	CallBackLoginResult   cbLoginResult;
	void                      *pUserData;
	char                     byRes[120];
}NET_CORE_USER_LOGIN_INFO;



typedef struct TagCameraSimpleInfo
{
	char _ipV4[32];
	char _name[32];
	char _hardware[32];
	char _version[64];
	int _port;
	char _szRes[128];
}CameraSimpleInfo;


////////////////////////////////////////////////
typedef struct TagNET_CORE_ALARM_MSG{
	char eventName[32];
	char eventType[16];
	unsigned char eventStatus;
	unsigned char res0[3];
	char szAlarmTime[32];
	char channel[32];
	char snapshotName[64];
	char recordName[64];
	int index;
	char presetTitle[32];
	char userdata[64];
	char res1[64];
}NET_CORE_ALARM_MSG;

////////////////////////////////////////////////
typedef struct TagNET_CORE_SETUPALARM_PARAM{

}NET_CORE_SETUPALARM_PARAM;


//////////////////////////////////////////////
typedef struct TagNET_CORE_SCHEDTIME{  
	unsigned char    enable;				//	1:enable   0: disable
	unsigned char    byStartHour;	// 0~24  Start Hour
	unsigned char    byStartMin;		//0~59  Start Min
	unsigned char    byStartSec;		//0~59  Start Sec
	unsigned char    byStopHour;   // 0~24  Stop Hour
	unsigned char    byStopMin;		//0~59  Stop Min
	unsigned char    byStopSec;		//0~59  Stop Sec
	unsigned char    res;
}NET_CORE_SCHEDTIME;

///////////////////////////////////////////////
typedef struct TagAlarmLinkage{
	unsigned char email;			// 0 or 1
	unsigned char upload;		// 0 or 1
	unsigned char ioout;			// 0 or 1
	unsigned char record;		// 0 or 1
	unsigned char snapshot;		// 0 or 1
	unsigned char http;			// 0 or 1
	unsigned char httpMethod;		// 1: get   2: post
	unsigned char res[9];
	char httpUrl[256];		//htttp addr 
}AlarmLinkage;

typedef struct TagNET_CORE_POINT{
	short x;
	short y;
}NET_CORE_POINT;

typedef struct TagNET_CORE_SIZE{
	unsigned short width;
	unsigned short height;
}NET_CORE_SIZE;

typedef struct TagNET_CORE_RECT{
	short left;
	short top;
	short right;
	short bottom;
}NET_CORE_RECT;

typedef struct TagFireDetectionAreaMask{
	unsigned char index;
	unsigned char enable;
	unsigned char display;
	unsigned char zoomRatio;		//multiple
	char szTitle[32];
	int validPointsCount;
	NET_CORE_POINT polyPoints[10];		//Up to 6 valid, others reserved
}FireDetectionAreaMask;

typedef struct TagNET_CORE_FIRE_DETECTION_CFG{
	unsigned char enable;			//	1:enable   0: disable
	unsigned char model;				//invalid parameter
	unsigned char res[2];
	float temperature;					//invalid parameter
	short sensitivity;						//No Unit
	short timefilter;						//Unit:  sec
	NET_CORE_SCHEDTIME struFireDetectionSched[7][6];  // 7: Sunday to Saturday        6: One day is divided into 6 time periods
	AlarmLinkage struFireDetectionLinkage;								// Alarm Linkage
	int nValidFireDetectionAreaMasksCount;
	FireDetectionAreaMask struFireDetectionAreaMasks[10];		//Up to 4 valid, others reserved
}NET_CORE_FIRE_DETECTION_CFG;

///////////////////////////////////////////////
typedef struct TagNET_CORE_SNAPSHOT_TIMER{
	unsigned char enable;			//	1:enable   0: disable
	unsigned char type;				//	1:jpg
	unsigned char quality;			//	1: low   2: middle   3: high
	unsigned char delayUnit;		//	0:ms,		1:sec,		2:min,	3: hour
	unsigned short delayTime;		//  for example: =500
	unsigned char res[2];
	unsigned short width;				//read only
	unsigned short height;			//read only
	NET_CORE_SCHEDTIME struCaptureSched[7][6];  // 7: Sunday to Saturday        6: One day is divided into 6 time periods
}NET_CORE_SNAPSHOT_TIMER;

typedef struct TagNET_CORE_SNAPSHOT_EVENT{
	unsigned char enable;			//	1:enable   0: disable
	unsigned char type;				//	1:jpg
	unsigned char quality;			//	1: low   2: middle   3: high
	unsigned char delayUnit;		//	0:ms,		1:sec,		2:min,	3: hour
	unsigned short delayTime;		//  for example: =500
	unsigned short count;				// Number of snapshots  1~4
	unsigned short width;				//read only
	unsigned short height;			//read only
}NET_CORE_SNAPSHOT_EVENT;

typedef struct TagNET_CORE_SCHED_SNAPSHOT_CFG{
	NET_CORE_SNAPSHOT_TIMER timerCfg;
	NET_CORE_SNAPSHOT_EVENT eventCfg;
}NET_CORE_SNAPSHOT_SCHEDULE_CFG;


typedef struct TagNET_CORE_GLOBAL_VCA_CFG{
	unsigned char enable;							//	1:enable   0: disable
	unsigned char enableOsdVcaInfo;			//	1:enable   0: disable
	unsigned char enableOsdObjectInfo;		//	1:enable   0: disable	
	unsigned char enableOsdRuleInfo;			//	1:enable   0: disable
	unsigned char nSensitivity;						 //0 ~100  default:30
	unsigned char res[11];
}NET_CORE_GLOBAL_VCA_CFG;

typedef struct TagBoxFilter{
	unsigned char enable;		//	1:enable   0: disable
	unsigned char res[3];			
	NET_CORE_RECT maxRect;
	NET_CORE_RECT minRect;
}BoxFilter;

typedef struct TagNET_CORE_MOTION_DETECTION_VCA_CFG_ITEM{
	unsigned char enable;						//	1:enable   0: disable
	unsigned char index;							// The index number
	unsigned char supportPerson;
	unsigned char supportCar;
	unsigned char supportBoat;
	unsigned char supportRes0[11];	
	char szTitle[32];
	BoxFilter boxFilter;
	short timefilter;								//Filter time, in seconds
	short sensitivity;
	short duration;								//Only Used in Area Intrusion Detection  ,    duration, in seconds
	short ptCount;									//valid Poly Points Count
	NET_CORE_POINT polyPoints[10];		//Up to 6 valid, others reserved
	unsigned char suppressingBackgroundNoise;		//0 means off, 1 means on, 2 means adaptive
	unsigned char direction;					//Only Used in CrossLineDetection:   Across the direction, 0 means from A to B, 1 means from B to A, 2 means bidirectional
	unsigned char res2[6];
	NET_CORE_SCHEDTIME struMotionDetectionSched[7][6];			// 7: Sunday to Saturday        6: One day is divided into 6 time periods
	AlarmLinkage alarmLinkage;
	unsigned char res3[128];
}NET_CORE_MOTION_DETECTION_VCA_CFG_ITEM;

typedef struct TagNET_CORE_MOTION_DETECTION_VCA_CFG{
	int itemCount;
	NET_CORE_MOTION_DETECTION_VCA_CFG_ITEM items[10];		//Up to 4 valid, others reserved
}NET_CORE_MOTION_DETECTION_VCA_CFG;

typedef struct TagNET_CORE_OCCLUSION_DETECTION_VCA_CFG{
	unsigned char enable;						//	1:enable   0: disable
	unsigned char res0[7];
	short sensitivity;
	short preset;
	short timefilter;
	short res2;
	NET_CORE_RECT rect;
	NET_CORE_SCHEDTIME struOcclusionDetectionSched[7][6];	
	AlarmLinkage alarmLinkage;
}NET_CORE_OCCLUSION_DETECTION_VCA_CFG;


typedef struct TagNetworkInterfaceCFG{
	unsigned char bUseDhcp;					// 1 or 0
	unsigned char res0[7];
	char sIpV4[32];								//192.168.1.128
	char sSubnetMask[32];						//255.255.255.0
	char sDefaultGateway[32];				//192.168.1.1
	char sDnsServer1IpAddr[32];			//0.0.0.0
	char sDnsServer2IpAddr[32];			//0.0.0.0
	char sMACAddr[32];						//read only
}NetworkInterfaceCFG;

typedef struct TagPortsCFG{
	unsigned short nRtspPort;
	unsigned short nTcpServerPort;
	unsigned short nWebsocketPort;
	unsigned short nOnvifPort;		   
	unsigned short nHttpPort;			              
	unsigned short nhttpsPort;			
	unsigned short res[16];
}PortsCFG;

typedef struct TagWhiteListCFG{
	unsigned char bEnable;							// 1 or 0
	unsigned char nValidIpV4Count;			//upper limit 64
	unsigned char nValidMacAddrCount;	//upper limit 64
	unsigned char res[5];
	char sIpV4[64][32];							//Format  "192.168.1.128"   "192.168.1.129"  "192.168.1.130" ...
	char sMacAddr[64][32];					//Format  "aa:bb:cc:11:22:33"	"aa:bb:cc:11:22:34" "aa:bb:cc:11:22:35"  "aa:bb:cc:11:22:36" ....
}WhiteListCFG;


typedef struct TagDeviceInformation{
	char name[64];
	int devtype;
	int res0;
	char model[64];
	char sn[64];
	char softver[64];
	char OnvifVersion[64];
	char StartTime[64];
	double longitude;
	double latitude;
	double altitude;
	char res1[256];
}DeviceInformation;


typedef struct TagRS232CFG{
	int baud;			//2400 4800 9600 19200 38400 57600 115200
	unsigned char databits;		//5 ~ 8
	char parity;			//"N"-no parity "O"-odd parity "E"-even parity
	unsigned char stopbits;			//1 ~ 2
	unsigned char res;
}RS232CFG;

typedef struct TagRS485CFG{
	int baud;						  //2400 4800 9600 19200 38400 57600 115200	
	unsigned char databits;     //5 ~ 8
	char parity;						//"N"-no parity "O"-odd parity "E"-even parity
	unsigned char stopbits;         //1 ~ 2
	unsigned char address;          //0 ~ 255
	unsigned char protocol;		  //0: PELCOD
	unsigned char  res[3];
}RS485CFG;

typedef struct TagDaylightSavingsTime{
	unsigned char bEnable;							// 1 or 0
	unsigned char offset;								//30( 00:30:00),    60( 01:00:00),    90( 01:30:00),   120( 02:00:00)
	unsigned char startMonth;						//1 <= m <= 12
	unsigned char startWeek;						//1 <= w <= 5
	unsigned char startDay;							//0 <= d <= 6   ,  0 for sunday
	unsigned char startHour;
	unsigned char endMonth;						//1 <= m <= 12
	unsigned char endWeek;						//1 <= w <= 5
	unsigned char endDay;							//0 <= d <= 6   ,  0 for sunday
	unsigned char endHour;
	unsigned char res[6];
}DaylightSavingsTime;

typedef struct TagNetworkTimeProtocol{
	int ntpEnable;
	char ntpServer[64];
	int ntpPort;
	int ntpInterval;
}NetworkTimeProtocol;

typedef struct TagDateTime{
	unsigned short Year;
	unsigned short Month;			//Range is 1 to 12.
	unsigned short Day;				//Range is 1 to 31.
	unsigned short Hour;				//Range is 0 to 23.
	unsigned short Minute;			//Range is 0 to 59.
	unsigned short Second;			//Range is 0 to 59
}DateTime;

typedef struct TagDevCoreData{
	char devModel[32];          
	short devType;              
	short res0;
	char devSN[32];             
	char devMac[32];            
	short language;             
	short watchdog;
	char hardwareVer[32];       
	short boardNo;   
	char irCfgFileName[128];	
	short irFocus;              
	short irZoom;               
	short visualZoom;           
	char productionDate[32];    
	short ptzFactory;           
	short res1;
	char userData[32];         
}DevCoreData;

////////////////////////////////////////////////////////////////////////////////////
typedef struct TagFixPara{
	float fEmissivity;						 // 0.0 ~ 1.0
	float fReflTemp;						//¡æ
	float fDistance;						// Meter
	float res0[4];
	char res1[16*4];
}FixPara;

enum RawImageType{
	RawImageType_16Bit_Short,  //16-bit short
};
typedef struct TagRawFrameInfo
{
	int nImageType;			//RawImageType_16Bit_Short (16-bit short  ) 
	int nRawWidth;				//pixels
	int nRawHeight;			//pixels
	int nMaxFPS;				//FPS
	int nCurrentFPS;			//FPS
	char res[64];					
}RawFrameInfo;

typedef struct TagRealTempInfo{

}RealTempInfo;





typedef struct TagPTZPresetCFG 
{
	char enable;		//1: enable ,   0 : disable
	char res[7];
	char name[32];
	int pan;
	int tilt;
	int zoom;
}PTZPresetCFG;

#define MAX_PRESET_COUNT (255)
typedef struct TagPTZPresetsCFG 
{
	PTZPresetCFG aPTZPresetCFG[MAX_PRESET_COUNT];
}PTZPresetsCFG;

typedef struct TagPTZCruisePoint {
	unsigned short presetIdx;   //1~255
	unsigned short speed;		//1~64
	unsigned short staytime;		//second
	unsigned short res;
}PTZCruisePoint ;

typedef struct TagOneCruiseCFG {
	PTZCruisePoint aPTZCruisePoint[20];
}OneCruiseCFG ;

typedef struct TagPTZCruisesCFG{
	OneCruiseCFG aPTZCruiseCFG[8];
}PTZCruisesCFG;

typedef struct TagRawFrameTransferSettings{
	int fps;								//frame rate per second
	int udpMode;					//0:  TCP  ,   1: UDP
	int udpPort;						//Only valid in UDP mode
	int BmpFormatType;			// 0 : Format_BGR888   ,   1:   Format_RGB888
	char res[32];
}RawFrameTransferSettings;

enum IRColorPalette{
	IRColorPalette_unknown = -1,
	IRColorPalette_WHITE_HOT,
	IRColorPalette_BLACK_HOT,
	IRColorPalette_IRON,
	IRColorPalette_RAINBOW,
	IRColorPalette_LAVA,
	IRColorPalette_RAINBOW_ENHANCE,
	IRColorPalette_MOLTEN_METAL,
	IRColorPalette_BLUE_RED,
	IRColorPalette_AMBER,
};

///////////////////////////////////////////////////////////////////////////////////



/////////////////////////////////////////////////////////////////////////////////////
typedef enum
{
	CENTIGRADE = 0x01,
	FAHRENHEIT, 
	KELVIN,  
	UNKOWN_TEMPER_UNIT
}TEMPER_UNIT;

typedef struct TagMT_Preferences{
	char			channelName[32];		//Read Only
	int             bEnableTempMeasurement;                
	int             bDisplayColorScale;        
	int             bDisplayInfoOnOpticalStream; 
	int				 bDisplayTempInfoOnThermalStream;     
	int             bDisplayMaxTemper;          
	int             bDisplayMinTemper;         
	int             bDisplayAvgTemper;
	unsigned int      uDisplayLoc; 
	int             bSnapshotWithRaw;         
	int             bStreamWithRaw; 
	unsigned int      nRawFPS;
	TEMPER_UNIT  unit;            
	int					nTempRange; 
	int					nAlarmInterval;			//Unit:   sec
	float              ftTemperaturOffset;  
	float				 ftEmiss;       
	float				ftDistance;        
	float				ftBKTemper;  
}MT_Preferences;


typedef struct TagMT_POINT
{
	unsigned short  u16X;
	unsigned short  u16Y;
	float      f32ScaleX;			
	float      f32ScaleY;
}MT_POINT;


typedef struct TagMT_SIZE{
	int width;
	int height;
}MT_SIZE;

typedef struct TagMT_BASIC_CFG
{
    int             bEnable;						     /*Enable Temperature Measurement  */
    int             bDisplayColorScale;        /*displays a color map and its scale */
    int             bDisplayMaxTemper;          
    int             bDisplayMinTemper;         
    int             bDisplayAvgTemper;
    int				 bDisplayGlobalTempInfo;         
    int				 bDisplayTemperatureInfoOnStream;          
    int             bSnapshotWithRaw;         
    int             bStreamWithRaw; 
    unsigned int      uDisplayLoc; 
    unsigned int      nRawFPS;		      
    TEMPER_UNIT  unit;            //Display temperature with Degree Celsius (¡ãC)/ Degree Fahrenheit (¡ãF)/ Degree Kelvin (K).
    unsigned int   uCurTempRangeIndex;  
    float              ftCurTempRangeMin;                  
    float              ftCurTempRangeMax;                  
    float              ftTemperaturOffset;       
    unsigned int  u32RawWidth;            
    unsigned int  u32RawHeight;     
    float             ftSensorTemper;      
    float             ftDeviceTemper;     
    unsigned int   u32Version; 
	unsigned int   uTempRangeCount;          
	float           ftTempRangeMin[3];
	float           ftTempRangeMax[3];
	  float           ftEmiss;       
	  float           ftDistance;        
	 float				ftBKTemper;  
	  short        sMaxGray;       
	  short        sMinGray;     
	  short        sAvgGray; 
	 unsigned short  paletteMode;
	  float           fMaxTemper;       
	  float           fMinTemper;        
	  float           fAvgTemper;    
	 MT_POINT  stMaxPt; 
	 MT_POINT  stMinPt; 
    unsigned char    res[128];     
}MT_BASIC_CFG;

typedef enum
{
	TEMPER_TYPE_POINT = 0x01, 
	TEMPER_TYPE_LINE,         
	TEMPER_TYPE_AREA,         
	TEMPER_TYPE_FRAME,        
	UNKOWN_TYPE
}TEMPER_TYPE;

typedef enum{
	ThermalImageProcessMode_BOTH,					//Default
	ThermalImageProcessMode_CALLBACK,			// Only obtain the raw frame from the callback function
	ThermalImageProcessMode_FRAME_BUFF,		//Only obtain  the raw frame form the frame buff
}ThermalImageProcessMode;

#define MAX_MT_POINT_CNT   (10)

enum AlarmRuleType{
	AlarmRuleType_AlarmAboveThreshold = 1,
	AlarmRuleType_AlarmBelowThreshold,
	AlarmRuleType_AlarmInsideRange,
	AlarmRuleType_AlarmOutsideRange,
	AlarmRuleType_disabled,
};

typedef struct TagMT_MARKER_CFG_EXT
{
	int             bEnable;            
	unsigned int    uIndex;             
	char            name[128];          
	unsigned int   res; 
	float           fEmissivity;           
	float           fDistance;          //meter
	TEMPER_TYPE     enType;       //TEMPER_TYPE_POINT     TEMPER_TYPE_LINE    TEMPER_TYPE_AREA
	unsigned int    uPointNum;
	MT_POINT        arrArea[MAX_MT_POINT_CNT];
	unsigned int    uRuleItem;          // 1:Alarm Above Threshold 2:Alarm Below Threshold 3:Alarm Inside Range 4:Alarm Outside Range, 5:disabled  
	float           fTempAlarmThreshold;         
	float           fUpperTempThreshold;            
	float           fLowerTempThreshold;      
	float           ftBKTemper;        
	float           fMaxTemper;        
	float           fMinTemper;       
	float           fAvgTemper;       
	short        sMaxGray;       
	short        sMinGray;         
	short        sAvgGray;           
	short        s16Reserve;       
	int             bAalrmFlag;             //Trigger an alarm
	MT_POINT     stMaxPt;            
	MT_POINT     stMinPt;          
	char        u8Reserve[128];  
}MT_MARKER_CFG_EXT;


#define MAX_MARKER_COUNT (9)
typedef struct TagMT_ALL_MARKERS_CFG{
	MT_MARKER_CFG_EXT markers[MAX_MARKER_COUNT];
	int nMarkerAlarmInterval[MAX_MARKER_COUNT];					//unit:  sec
	NET_CORE_SCHEDTIME struMarkersSched[7][6];	
	AlarmLinkage alarmLinkage;
}MT_ALL_MARKERS_CFG;

#define DEFAULT_ALARM_INTERVAL (15)

////////////////////////////////////////////////
#ifdef _WIN32
typedef void (__stdcall  *AlarmMessageCallBack)(  int     nUserID,     NET_CORE_ALARM_MSG   *pAlarmMSG,  void  *pUser);

typedef void (__stdcall  *SerialDataCallBack)(   int     nUserID,   int    nType,   unsigned char     *pRecvDataBuffer,  int   dwBufSize,void     *pUser);

typedef void(__stdcall *ExceptionCallBack)(  int    dwType,  int     lUserID,  void     *pUser);

typedef void(__stdcall *AsynchronousEventCallBack)(int     nUserID,   int    nOperationType,   void* pBuff,  int  nBufLen,  void   *pUser);

typedef void (__stdcall   *FunInfraredImage)(int nUserID ,  MT_BASIC_CFG* pBasicCfg, MT_MARKER_CFG_EXT* pMarkerCfg,   int nMarkerCount, 
																	unsigned char* pBGR, int bgrLen,  float* tempMatrix ,  short* grayMatrix ,  int width, int height,  void   *pUser );

typedef void (__stdcall   *FunTempInfo)(int nUserID ,   MT_BASIC_CFG* pBasicCfg, MT_MARKER_CFG_EXT* pMarkerCfg,   int nMarkerCount,  void   *pUser );

#else
typedef void (  *AlarmMessageCallBack)(  int     nUserID,   NET_CORE_ALARM_MSG   *pAlarmMSG,  void  *pUser);

typedef void (  *SerialDataCallBack)(   int     nUserID,   int    nType,     unsigned char     *pRecvDataBuffer,  int   dwBufSize,void     *pUser);

typedef void( *ExceptionCallBack)(  int    dwType,  int     lUserID , void     *pUser);

typedef void( *AsynchronousEventCallBack)(int     nUserID,   int    nOperationType,   void* pBuff,  int  nBufLen,  void   *pUser);

typedef void ( *FunInfraredImage)(int nUserID ,  MT_BASIC_CFG* pBasicCfg, MT_MARKER_CFG_EXT* pMarkerCfg,   int nMarkerCount,   
																unsigned char* pBGR, int bgrLen,  float* tempMatrix ,  short* grayMatrix ,  int width, int height,  void   *pUser );

typedef void (  *FunTempInfo)(int nUserID , MT_BASIC_CFG* pBasicCfg, MT_MARKER_CFG_EXT* pMarkerCfg,   int nMarkerCount,   void   *pUser );

#endif

/////////////////////////////////////////////////////////////////////////////////////
#define TIMEZONE_GMT_S_12_00    (0)   //0£º GMT-12:00  
#define TIMEZONE_GMT_S_11_00    (1)   //1£º GMT-11:00  
#define TIMEZONE_GMT_S_10_00    (2)   //2£º GMT-10:00  
#define TIMEZONE_GMT_S_09_00    (3)   //3£º GMT-09:00  
#define TIMEZONE_GMT_S_08_00   (4)   //4£º GMT-08:00
#define TIMEZONE_GMT_S_07_00    (5)   //5£º GMT-07:00  
#define TIMEZONE_GMT_S_06_00    (6)   //6£º GMT-06:00  
#define TIMEZONE_GMT_S_05_00    (7)   //7£º GMT-05:00  
#define TIMEZONE_GMT_S_04_30    (8)   //8£º GMT-04:30  
#define TIMEZONE_GMT_S_04_00    (9)   //9£º GMT-04:00
#define TIMEZONE_GMT_S_03_30   (10)   //10£ºGMT-03:30 
#define TIMEZONE_GMT_S_03_00   (11)   //11£ºGMT-03:00 
#define TIMEZONE_GMT_S_02_00   (12)   //12£ºGMT-02:00 
#define TIMEZONE_GMT_S_01_00   (13)   //13£ºGMT-01:00 
#define TIMEZONE_GMT_P_00_00   (14)   //14£ºGMT+00:00
#define TIMEZONE_GMT_P_01_00   (15)   //15£ºGMT+01:00 
#define TIMEZONE_GMT_P_02_00   (16)   //16£ºGMT+02:00 
#define TIMEZONE_GMT_P_03_00   (17)   //17£ºGMT+03:00 
#define TIMEZONE_GMT_P_03_30   (18)   //18£ºGMT+03:30 
#define TIMEZONE_GMT_P_04_00   (19)   //19£ºGMT+04:00 
#define TIMEZONE_GMT_P_04_30   (20)   //20£ºGMT+04:30 
#define TIMEZONE_GMT_P_05_00   (21)   //21£ºGMT+05:00 
#define TIMEZONE_GMT_P_05_30   (22)   //22£ºGMT+05:30
#define TIMEZONE_GMT_P_05_45   (23)   //23£ºGMT+05:45 
#define TIMEZONE_GMT_P_06_00   (24)   //24£ºGMT+06:00 
#define TIMEZONE_GMT_P_06_30   (25)   //25£ºGMT+06:30 
#define TIMEZONE_GMT_P_07_00   (26)   //26£ºGMT+07:00
#define TIMEZONE_GMT_P_08_00   (27)   //27£ºGMT+08:00 
#define TIMEZONE_GMT_P_09_00   (28)   //28£ºGMT+09:00 
#define TIMEZONE_GMT_P_09_30   (29)   //29£ºGMT+09:30 
#define TIMEZONE_GMT_P_10_00   (30)   //30£ºGMT+10:00
#define TIMEZONE_GMT_P_11_00   (31)   //31£ºGMT+11:00 
#define TIMEZONE_GMT_P_12_00   (32)   //32£ºGMT+12:00 
#define TIMEZONE_GMT_P_13_00   (33)   //33£ºGMT+13:00

typedef struct TagTimeSettins{
	int timezone;										//  TIMEZONE_GMT_S_12_00 ~TIMEZONE_GMT_P_13_00
	DaylightSavingsTime struDST;			//Daylight Savings Time
	NetworkTimeProtocol struNTP;		//NTP Settins
	int bManualTiming;							// 1 or 0
	DateTime  manualTimingValue;			// If time is obtained via NTP, DateTime has no meaning	
}TimeSettins;

typedef struct TagVideoSettings{
	unsigned char nEnable;			      // 1  : ON  , 0 : OFF
	unsigned char nEncodeProfile;      // 0: Low ,  1: Middle ,  2 : High            
	unsigned char nFrameRate;          // 25               
	unsigned char nMaxFrameRate;   // 25	 ,  Read Only               
	unsigned char nEncodeType;       // 0: "H264",   1:  "H265"
	char enRcMode;						//"v":VBR  ,    "c":CBR  ,     "f":FIXQP
	unsigned short nIFrameInterval;		// GOP : 1 ~ 400        
	NET_CORE_SIZE encResolution;		// "1920*1080"	
	char availableResolution[64];		//For Example:  "2592*1536 1920*1080 1280*720"  ,  Read Only
	unsigned short nMaxBitrate;        // 128*n   ( n = 1,2,3...)     
	char res0[14];     
}VideoSettings;

typedef struct TagAllVideoSettings{
	VideoSettings dayMain;
	VideoSettings daySub;
	VideoSettings thermalMain;
	VideoSettings thermalSub;
	VideoSettings res[2];
}AllVideoSettings;

typedef struct TagImagingSettings{
	unsigned char contrast;           //0 ~ 100
	unsigned char brightness;         //0 ~ 100
	unsigned char res[6];
	unsigned char saturation_day;     //0 ~ 100			is valid only for day camera
	unsigned char sharpness_day;      //0 ~ 100		is valid only for day camera
	unsigned char defog_day;          //0£ºOFF   1:ON			is valid only for day camera
	unsigned char res_day[125];
	unsigned char noiseFilter_ir;     //0 ~ 10				is valid only for thermal camera
	unsigned char enhancement_ir;     //0 ~ 10			is valid only for thermal camera
	unsigned char res_ir[126];
}ImagingSettings;

enum DayNightSwitchingMode{
	DayNightSwitchingMode_unknown = 0,
	DayNightSwitchingMode_day,
	DayNightSwitchingMode_night,
	DayNightSwitchingMode_auto,
	DayNightSwitchingMode_schedule_switch,
};

typedef struct TagDayNightSwitchingCFG
{
	DayNightSwitchingMode mode;	 //"day" "night" "auto" "schedule-switch"
	int sensitivity;									//0 ~ 100  is valid only for [mode="auto"]
	char schedule_begin[16];				// = "07:00:00"    ,   is valid only for  [mode="schedule-switch"]
	char schedule_end[16];					//=  "18:00:00"     	,   is valid only for  [mode="schedule-switch"]
}DayNightSwitchingCFG;

//typedef struct TagExposureCFG{
//	unsigned char nMode;		//0: auto ,   1: manual
//	unsigned char nGain;
//	unsigned char nIris;
//}ExposureCFG;

typedef struct TagImageEnhancementCFG{
	unsigned char denoise_bEnable;				// 0: OFF  ,  1: ON
	unsigned char denoise_mode;					//0: Normal,    1: 3D
	unsigned char denoise_normal_level;			//0 ~100
	unsigned char denoise_3D_spatialLevel;		//0 ~100
	unsigned char denoise_3D_temporalLevel;	//0 ~100
	unsigned char denoise_res[3];
	unsigned char heatWave_bEnable;				// 0: OFF  ,  1: ON
	unsigned char heatWave_level;					//0 ~100
	unsigned char dehaze_bEnable;					// 0: OFF  ,  1: ON
	unsigned char dehaze_level;						//0 ~100
	unsigned char ImageStabilization_bEnable;		// 0: OFF  ,  1: ON
	unsigned char ImageStabilization_level;				//0 ~100
	unsigned char res[10];
}ImageEnhancementCFG;


typedef struct TagWhiteBalanceCFG{
	int nMode;			//0: "auto",     1: "manual"
	int redGain;
	int blueGain;
}WhiteBalanceCFG;


typedef struct TagBacklightCFG{
	unsigned char nWideDynamicRange_Mode;		//0:OFF  ,  1:ON
	unsigned char nWideDynamicRange_Level;		//0 ~ 100
	unsigned char res0[2];
	unsigned char nBacklightCompensation_Mode;	//0:OFF  ,  1:ON
	unsigned char nBacklightCompensation_Area;	//1: UP    ,    2:DOWN		, 3:LEFT	,	4:RIGHT		,	5:CENTER
	unsigned char res1[2];
}BacklightCFG;

typedef struct TagOSD_CFG{
	unsigned char timeOSD_dataDisplay;
	unsigned char timeOSD_weekDisplay;
	unsigned char timeOSD_timeFormat;
	unsigned char timeOSD_dataFormat;
	unsigned char timeOSD_XPos;
	unsigned char timeOSD_YPos;
	unsigned char timeOSD_res[2];
	unsigned char channelOSD_bDisplay;
	char channelOSD_name[63];
	unsigned char channelOSD_XPos;
	unsigned char channelOSD_YPos;
	unsigned char channelOSD_res[2];
	unsigned char ptzOSD_zoom_display;
	unsigned char ptzOSD_zoom_XPos;
	unsigned char ptzOSD_zoom_YPos;
	unsigned char ptzOSD_zoom_res;
	unsigned char ptzOSD_PT_display;
	unsigned char ptzOSD_PT_format;
	unsigned char ptzOSD_PT_XPos;
	unsigned char ptzOSD_PT_YPos;
	unsigned char ptzOSD_Preset_display;
	unsigned char ptzOSD_Preset_XPos;
	unsigned char ptzOSD_Preset_YPos;
	unsigned char ptzOSD_Preset_res;
	unsigned char ptzOSD_res[4];
	unsigned char ptzOSD_Self1_display;
	char ptzOSD_Self1_name[63];
	unsigned char ptzOSD_Self1_XPos;
	unsigned char ptzOSD_Self1_YPos;
	unsigned char ptzOSD_Self1_res[2];
	unsigned char ptzOSD_Self2_display;
	char ptzOSD_Self2_name[63];
	unsigned char ptzOSD_Self2_XPos;
	unsigned char ptzOSD_Self2_YPos;
	unsigned char ptzOSD_Self2_res[2];
	unsigned char res[16];
}OSD_CFG;

////////////////////////////////////////////////////////Video plugin must be loaded successfully
#define CALLBACK_DATA_TYPE_DEFAULT    (0)
#define CALLBACK_DATA_TYPE_THERMAL   (1)					//Only supports infrared temperature measurement devices

#define CALLBACK_DATA_BITS_ARGB			(0)
#define CALLBACK_DATA_BITS_ABGR			(1)
#define CALLBACK_DATA_BITS_RGBA			(2)
#define CALLBACK_DATA_BITS_BGRA			(3)

#define CALLBACK_DATA_ORIGIN_TOP_LEFT				(0)
#define CALLBACK_DATA_ORIGIN_BOTTOM_LEFT		(1)

typedef struct TagStreamInfo{
	char hasDayStream;
	char hasThermalStream;
	char hasFusedStream;
	char res[5];
	char dayMainRtsp[128];
	char daySubRtsp[128];
	char thermalMainRtsp[128];
	char thermalSubRtsp[128];
	char fusedRtsp[128];
	char resRtsp[11*128];
}StreamInfo;

enum StreamType{
	StreamType_Unknown = 0,
	StreamType_VisibleMain,
	StreamType_VisibleSub,
	StreamType_ThermalMain,
	StreamType_ThermalSub,
	StreamType_Fused,
};

typedef struct TagNET_CORE_PREVIEWINFO_EX
{
	StreamType streamType;							    	//[Required]   
	char	    	userRtspUrl[160];								//[optional]   rtsp url --- rtsp://192.168.1.243:554/visiblemain?t=unicast   (Only streamType == StreamType_Unknown )
	unsigned char callbackEnableVideoBmp;			//[optional]	1 for enable ,  0 for disable
	unsigned char callbackVideoBmpBits;				//[optional]	CALLBACK_DATA_BITS_ARGB ~ CALLBACK_DATA_BITS_BGRA
	unsigned char callbackVideoBmpOrigin;			//[optional]	only support TOP_LEFT
	unsigned char res0;	
	unsigned short callbackVideoBmpWidth;		///[optional]	0 is the default resolution , 
	unsigned short callbackVideoBmpHeight;		///[optional]	0 is the default resolution ,
	void*    pScaledBmpData;						///[optional] Exported BMP data, only supports zoom mode
	void*    hPlayWnd;								///[optional]	Display video stream directly to HWND
	char		szRes[248];								//MAX = 256 bytes
}NET_CORE_PREVIEWINFO_EX;


typedef struct TagNET_CORE_PREVIEWINFO
{
	char	    	userRtspUrl[160];								//[optional]   rtsp url --- rtsp://192.168.1.243:554/visiblemain?t=unicast   (Only streamType == StreamType_Unknown )
	unsigned char callbackEnableVideoBmp;			//[optional]	1 for enable ,  0 for disable
	unsigned char callbackVideoBmpBits;				//[optional]	CALLBACK_DATA_BITS_ARGB ~ CALLBACK_DATA_BITS_BGRA
	unsigned char callbackVideoBmpOrigin;			//[optional]	only support TOP_LEFT
	unsigned char res0;	
	unsigned short callbackVideoBmpWidth;		///[optional]	0 is the default resolution , 
	unsigned short callbackVideoBmpHeight;		///[optional]	0 is the default resolution ,
	void*    pScaledBmpData;						///[optional] Exported BMP data, only supports zoom mode
	void*    hPlayWnd;								///[optional]	Display video stream directly to HWND
	char		szRes[248];								//MAX = 256 bytes
}NET_CORE_PREVIEWINFO;

#ifdef _WIN32
typedef void(__stdcall *CALLBACK_REALDATA)(  int      nRealHandle, 		 int     dwDataType,  unsigned char      *pBuffer,   int     dwBufSize,   int	 width,	 int	 height, void      *pUser);
#else
typedef void( *CALLBACK_REALDATA)(  int      nRealHandle, 		 int     dwDataType,  unsigned char      *pBuffer,   int     dwBufSize,   int	 width,	 int	 height, void      *pUser);
#endif




//////////////////////////////////////////////////PTZPresetCmd
#define PTZ_SET_PRESET		(1)
#define PTZ_CLE_PRESET		(2)
#define PTZ_GOTO_PRESET	(3)



//////////////////////////////////////////////////PTZCruiseCmd
//#define PTZ_FILL_PRE_SEQ		(1)		
//#define PTZ_SET_SEQ_DWELL	(2)		
//#define PTZ_SET_SEQ_SPEED	(3)		
//#define PTZ_CLE_PRE_SEQ		(4)	
//#define PTZ_RUN_SEQ			(5)
//#define PTZ_STOP_SEQ		(6)	
#define PTZ_RUN_CRUISE		(1)
#define PTZ_STOP_CRUISE		(2)

//////////////////////////////////////////////////PTZCommand
#define PTZ_LIGHT				(1)	
#define PTZ_WIPER				(2)	
#define PTZ_FAN_PWRON				(3)	
#define PTZ_HEATER_PWRON			(4)		
#define PTZ_AUX_PWRON1				(5)	
#define PTZ_AUX_PWRON2				(6)	
#define PTZ_ZOOM_IN					(7)
#define PTZ_ZOOM_OUT				(8)	
#define PTZ_FOCUS_NEAR				(9)	
#define PTZ_FOCUS_FAR				(10)	
#define PTZ_IRIS_OPEN				(11)	
#define PTZ_IRIS_CLOSE				(12)	
#define PTZ_TILT_UP					(13)
#define PTZ_TILT_DOWN				(14)	
#define PTZ_PAN_LEFT				(15)	
#define PTZ_PAN_RIGHT				(16)	
#define PTZ_UP_LEFT					(17)
#define PTZ_UP_RIGHT				(18)	
#define PTZ_DOWN_LEFT				(19)	
#define PTZ_DOWN_RIGHT				(20)	
#define PTZ_PAN_AUTO				(21)	
#define PTZ_TILT_DOWN_ZOOM_IN		(22)			
#define PTZ_TILT_DOWN_ZOOM_OUT		(23)			
#define PTZ_PAN_LEFT_ZOOM_IN		(24)			
#define PTZ_PAN_LEFT_ZOOM_OUT		(25)			
#define PTZ_PAN_RIGHT_ZOOM_IN		(26)			
#define PTZ_PAN_RIGHT_ZOOM_OUT		(27)			
#define PTZ_UP_LEFT_ZOOM_IN			(28)		
#define PTZ_UP_LEFT_ZOOM_OUT		(29)			
#define PTZ_UP_RIGHT_ZOOM_IN		(30)			
#define PTZ_UP_RIGHT_ZOOM_OUT		(31)			
#define PTZ_DOWN_LEFT_ZOOM_IN		(32)			
#define PTZ_DOWN_LEFT_ZOOM_OUT		(33)			
#define PTZ_DOWN_RIGHT_ZOOM_IN		(34)			
#define PTZ_DOWN_RIGHT_ZOOM_OUT		(35)			
#define PTZ_TILT_UP_ZOOM_IN			(36)		
#define PTZ_TILT_UP_ZOOM_OUT		(37)			


////////////////////////////////////////////////////
#define EXCEPTION_HEART_BEAT_TIMEOUT (4000)
#define EXCEPTION_SOCKET_ERROR				(4001)
#define EXCEPTION_RELOGIN							(4002)
#define RELOGIN_SUCCESS								(4003)


/////////////////////////////////////////////////Call back an asynchronous event
#define ASYN_EVENT_NET_CORE_Login  (1)
#define ASYN_EVENT_NET_CORE_Logout (2)
#define ASYN_EVENT_NET_CORE_GetDeviceInformation (3)
#define ASYN_EVENT_NET_CORE_PTZControl (4)
#define ASYN_EVENT_NET_CORE_PTZControlWithSpeed  (5)
#define ASYN_EVENT_NET_CORE_PTZPreset  (6)
#define ASYN_EVENT_NET_CORE_PTZCruise  (7)
#define ASYN_EVENT_NET_CORE_FocusOnePush (8)
#define ASYN_EVENT_NET_CORE_RestoreCFG (9)
#define ASYN_EVENT_NET_CORE_SetupAlarmChan (10)
#define ASYN_EVENT_NET_CORE_CloseAlarmChan (11)
#define ASYN_EVENT_NET_CORE_SendToSerialPort (12)
#define ASYN_EVENT_NET_CORE_Reboot (13)
#define ASYN_EVENT_NET_CORE_ShutDown (14)
#define ASYN_EVENT_NET_CORE_GetNetworkInterfaceCFG (15)
#define ASYN_EVENT_NET_CORE_SetNetworkInterfaceCFG (16)
#define ASYN_EVENT_NET_CORE_GetPortsCFG  (17)
#define ASYN_EVENT_NET_CORE_SetPortsCFG  (18)
#define ASYN_EVENT_NET_CORE_GetWhiteListCFG  (19)
#define ASYN_EVENT_NET_CORE_SetWhiteListCFG  (20)
#define ASYN_EVENT_NET_CORE_GetRS232CFG  (21)
#define ASYN_EVENT_NET_CORE_SetRS232CFG  (22)
#define ASYN_EVENT_NET_CORE_GetRS485CFG  (23)
#define ASYN_EVENT_NET_CORE_SetRS485CFG  (24)
#define ASYN_EVENT_NET_CORE_GetTimeCFG (25)
#define ASYN_EVENT_NET_CORE_SetTimeCFG (26)
#define ASYN_EVENT_NET_CORE_GetFireDetectionCFG  (27)
#define ASYN_EVENT_NET_CORE_SetFireDetectionCFG  (28)
#define ASYN_EVENT_NET_CORE_GetSnapshotScheduleCFG (29)
#define ASYN_EVENT_NET_CORE_SetSnapshotScheduleCFG (30)
#define ASYN_EVENT_NET_CORE_GetGlobalVCACFG  (31)
#define ASYN_EVENT_NET_CORE_SetGlobalVCACFG  (32)
#define ASYN_EVENT_NET_CORE_GetMotionDetectionVCACFG (33)
#define ASYN_EVENT_NET_CORE_SetMotionDetectionVCACFG (34)
#define ASYN_EVENT_NET_CORE_GetEnterAreaVCACFG (35)
#define ASYN_EVENT_NET_CORE_SetEnterAreaVCACFG (36)
#define ASYN_EVENT_NET_CORE_GetLeaveAreaVCACFG (37)
#define ASYN_EVENT_NET_CORE_SetLeaveAreaVCACFG (38)
#define ASYN_EVENT_NET_CORE_GetCrossLineDetectionVCACFG  (39)
#define ASYN_EVENT_NET_CORE_SetCrossLineDetectionVCACFG  (40)
#define ASYN_EVENT_NET_CORE_GetAreaIntrusionDetectionVCACFG  (41)
#define ASYN_EVENT_NET_CORE_SetAreaIntrusionDetectionVCACFG  (42)
#define ASYN_EVENT_NET_CORE_GetOcclusionDetectionVCACFG  (43)
#define ASYN_EVENT_NET_CORE_SetOcclusionDetectionVCACFG  (44)
#define ASYN_EVENT_NET_CORE_GetDevCoreData (45)
#define ASYN_EVENT_NET_CORE_SetDevCoreData (46)




//////////////////////////////////////////////// Error Code
#define CODE_NO_ERROR                     0    
#define CODE_PASSWORD_ERROR                 1    
#define CODE_NO_ENOUGH_PRI                 2    
#define CODE_NO_INIT                         3    
#define CODE_CHANNEL_ERROR                 4    
#define CODE_OVER_MAX_LINK                 5    
#define CODE_VERSION_NO_MATCH                6    
#define CODE_NETWORK_FAIL_CONNECT        7    
#define CODE_NETWORK_SEND_ERROR            8    
#define CODE_NETWORK_RECV_ERROR            9    
#define CODE_NETWORK_RECV_TIMEOUT        10    
#define CODE_NETWORK_ERRORDATA            11    
#define CODE_ORDER_ERROR                    12    
#define CODE_OPER_NO_PERMIT                13    
#define CODE_COMMAND_TIMEOUT                14    
#define CODE_ERROR_SERIAL_PORT                15    
#define CODE_ERROR_ALARM_PORT                16    
#define CODE_PARAMETER_ERROR             17  
#define CODE_CHAN_EXCEPTION                18    
#define CODE_NODISK                        19    
#define CODE_ERRORDISKNUM                20    
#define CODE_DISK_FULL                    21    
#define CODE_DISK_ERROR                    22    
#define CODE_NOSUPPORT                    23    
#define CODE_BUSY                        24    
#define CODE_MODIFY_FAIL                    25    
#define CODE_PASSWORD_FORMAT_ERROR        26    
#define CODE_DISK_FORMATING                27    
#define CODE_DVRNORESOURCE                28    
#define CODE_DVROPRATEFAILED                29  
#define CODE_OPENHOSTSOUND_FAIL             30  
#define CODE_DVRVOICEOPENED                 31  
#define CODE_TIMEINPUTERROR                32  
#define CODE_NOSPECFILE                    33  
#define CODE_CREATEFILE_ERROR            34    
#define CODE_FILEOPENFAIL                35  
#define CODE_OPERNOTFINISH                36  
#define CODE_GETPLAYTIMEFAIL                37  
#define CODE_PLAYFAIL                    38  
#define CODE_FILEFORMAT_ERROR            39  
#define CODE_DIR_ERROR                    40    
#define CODE_ALLOC_RESOURCE_ERROR        41  
#define CODE_AUDIO_MODE_ERROR            42    
#define CODE_NOENOUGH_BUF                43    
#define CODE_CREATE_SOCKET_ERROR             44    
#define CODE_SET_SOCKET_ERROR                45    
#define CODE_MAX_NUM                        46    
#define CODE_USERNOTEXIST                47    
#define CODE_WRITEFLASHERROR                48  
#define CODE_UPGRADEFAIL                    49  
#define CODE_CARDHAVEINIT                50  
#define CODE_PLAYERFAILED                51    
#define CODE_MAX_USERNUM                    52  
#define CODE_GETLOCALIPANDMACFAIL        53  
#define CODE_NOENCODEING                    54    
#define CODE_IPMISMATCH                    55    
#define CODE_MACMISMATCH                    56    
#define CODE_UPGRADELANGMISMATCH            57    
#define CODE_MAX_PLAYERPORT                58    
#define CODE_NOSPACEBACKUP                59    
#define CODE_NODEVICEBACKUP                60    
#define CODE_PICTURE_BITS_ERROR            61    
#define CODE_PICTURE_DIMENSION_ERROR        62    
#define CODE_PICTURE_SIZ_ERROR            63    
#define CODE_LOADPLAYERSDKFAILED            64    
#define CODE_LOADPLAYERSDKPROC_ERROR        65    
#define CODE_LOADDSSDKFAILED                66    
#define CODE_LOADDSSDKPROC_ERROR            67    
#define CODE_DSSDK_ERROR                    68    
#define CODE_VOICEMONOPOLIZE                69    
#define CODE_JOINMULTICASTFAILED            70    
#define CODE_CREATEDIR_ERROR                71    
#define CODE_BINDSOCKET_ERROR            72    
#define CODE_SOCKETCLOSE_ERROR            73    
#define CODE_USERID_ISUSING                74    
#define CODE_SOCKETLISTEN_ERROR            75    
#define CODE_PROGRAM_EXCEPTION            76    
#define CODE_WRITEFILE_FAILED            77    
#define CODE_FORMAT_READONLY                78  
#define CODE_WITHSAMEUSERNAME            79  
#define CODE_DEVICETYPE_ERROR            80  
#define CODE_LANGUAGE_ERROR              81  
#define CODE_PARAVERSION_ERROR           82  
#define CODE_IPCHAN_NOTALIVE             83  
#define CODE_RTSP_SDK_ERROR                84    
#define CODE_CONVERT_SDK_ERROR            85    
#define CODE_IPC_COUNT_OVERFLOW            86  
#define CODE_MAX_ADD_NUM                 87  
#define CODE_PARAMMODE_ERROR             88 
#define CODE_CODESPITTER_OFFLINE            89 
#define CODE_BACKUP_COPYING                90  
#define CODE_CHAN_NOTSUPPORT             91  
#define CODE_CALLINEINVALID              92  
#define CODE_CALCANCELCONFLICT           93  
#define CODE_CALPOINTOUTRANGE            94     
#define CODE_FILTERRECTINVALID           95  
#define CODE_DDNS_DEVOFFLINE             96  
#define CODE_DDNS_INTER_ERROR            97  
#define CODE_FUNCTION_NOT_SUPPORT_OS     98  
#define CODE_DEC_CHAN_REBIND             99  
#define CODE_INTERCOM_SDK_ERROR          100 
#define CODE_NO_CURRENT_UPDATEFILE       101 
#define CODE_USER_NOT_SUCC_LOGIN         102  
#define CODE_USE_LOG_SWITCH_FILE            103  
#define CODE_POOL_PORT_EXHAUST            104  
#define CODE_PACKET_TYPE_NOT_SUPPORT        105    
#define CODE_IPPARA_IPID_ERROR           106  
#define CODE_LOAD_HCPREVIEW_SDK_ERROR           107         
#define CODE_LOAD_HCVOICETALK_SDK_ERROR         108         
#define CODE_LOAD_HCALARM_SDK_ERROR             109         
#define CODE_LOAD_HCPLAYBACK_SDK_ERROR          110         
#define CODE_LOAD_HCDISPLAY_SDK_ERROR           111         
#define CODE_LOAD_HCINDUSTRY_SDK_ERROR          112         
#define CODE_LOAD_HCGENERALCFGMGR_SDK_ERROR     113         
#define CODE_LOAD_HCCOREDEVCFG_SDK_ERROR        114         
#define CODE_LOAD_HCNETUTILS_SDK_ERROR          115         
#define CODE_CORE_VER_MISMATCH                  121    
#define CODE_CORE_VER_MISMATCH_HCPREVIEW        122    
#define CODE_CORE_VER_MISMATCH_HCVOICETALK      123    
#define CODE_CORE_VER_MISMATCH_HCALARM          124    
#define CODE_CORE_VER_MISMATCH_HCPLAYBACK       125    
#define CODE_CORE_VER_MISMATCH_HCDISPLAY        126    
#define CODE_CORE_VER_MISMATCH_HCINDUSTRY       127    
#define CODE_CORE_VER_MISMATCH_HCGENERALCFGMGR  128    
#define CODE_COM_VER_MISMATCH_HCPREVIEW         136    
#define CODE_COM_VER_MISMATCH_HCVOICETALK       137    
#define CODE_COM_VER_MISMATCH_HCALARM           138    
#define CODE_COM_VER_MISMATCH_HCPLAYBACK        139    
#define CODE_COM_VER_MISMATCH_HCDISPLAY         140    
#define CODE_COM_VER_MISMATCH_HCINDUSTRY        141    
#define CODE_COM_VER_MISMATCH_HCGENERALCFGMGR   142    
#define NET_ERR_CONFIG_FILE_IMPORT_FAILED          145  
#define NET_ERR_CONFIG_FILE_EXPORT_FAILED          146  
#define CODE_CERTIFICATE_FILE_ERROR      147  
#define CODE_LOAD_SSL_LIB_ERROR          148  
#define CODE_SSL_VERSION_NOT_MATCH       149  
#define CODE_ALIAS_DUPLICATE                150    
#define CODE_INVALID_COMMUNICATION        151    
#define CODE_USERNAME_NOT_EXIST            152    
#define CODE_USER_LOCKED                    153 
#define CODE_INVALID_USERID              154 
#define CODE_LOW_LOGIN_VERSION           155 
#define CODE_LOAD_LIBEAY32_DLL_ERROR     156 
#define CODE_LOAD_SSLEAY32_DLL_ERROR     157 
#define NET_ERR_LOAD_LIBICONV           158 
#define NET_ERR_SSL_CONNECT_FAILED      159 
#define NET_ERR_MCAST_ADDRESS_ERROR      160 
#define NET_ERR_LOAD_ZLIB                   161 
#define NET_ERR_OPENSSL_NO_INIT             162 
#define CODE_SERVER_NOT_EXIST         164 
#define CODE_TEST_SERVER_FAIL_CONNECT            165    
#define CODE_NAS_SERVER_INVALID_DIR                166    
#define CODE_NAS_SERVER_NOENOUGH_PRI                167    
#define CODE_EMAIL_SERVER_NOT_CONFIG_DNS            168    
#define CODE_EMAIL_SERVER_NOT_CONFIG_GATEWAY        169    
#define CODE_TEST_SERVER_PASSWORD_ERROR            170    
#define CODE_EMAIL_SERVER_CONNECT_EXCEPTION_WITH_SMTP    171    
#define CODE_FTP_SERVER_FAIL_CREATE_DIR            172    
#define CODE_FTP_SERVER_NO_WRITE_PIR                173    
#define CODE_IP_CONFLICT                            174    
#define CODE_INSUFFICIENT_STORAGEPOOL_SPACE      175  
#define CODE_STORAGEPOOL_INVALID      176  
#define CODE_EFFECTIVENESS_REBOOT     177  
#define NET_ERR_ANR_ARMING_EXIST         178  
#define NET_ERR_UPLOADLINK_EXIST         179  
#define NET_ERR_INCORRECT_FILE_FORMAT    180  
#define NET_ERR_INCORRECT_FILE_CONTENT   181  
#define NET_ERR_MAX_HRUDP_LINK           182 
#define NET_SDK_ERR_ACCESSKEY_SECRETKEY    183   
#define NET_SDK_ERR_CREATE_PORT_MULTIPLEX    184 
#define CODE_NONBLOCKING_CAPTURE_NOTSUPPORT   185 
#define NET_SDK_ERR_FUNCTION_INVALID   186  
#define NET_SDK_ERR_MAX_PORT_MULTIPLEX     187   
#define CODE_INVALID_LINK                   188  

/////////////////////////////////////////////////////////offline analysis
// IR2 = IR2_FILE_HEADER + IR2_FILE_INFO + ... + IR2_FILE_FOOTER
typedef struct TagIR2_FILE_HEADER{
	unsigned short nFileType;				//nFileType == 61800
	unsigned short nFileVersion;			//nFileVersion >= 100
	unsigned short nFileReserved0;		//
	unsigned short nFileReserved1;  	//
	unsigned int     nFileTotalSize;		//byte length
	/////////////////////////////////////////////////////////offset and jump  
	unsigned short   nFileInfoOffset;		//
	unsigned short   nFileInfoLen;			//sizeof(IR2_FILE_INFO)
	unsigned short   nParametersOffset;
	unsigned short   nParametersLen;			//sizeof(IR2_PARAMETERS)
	unsigned short   nMTDataOffset;			//Key data including grayscale-temperature mapping table, etc.
	unsigned short   nMTDataLen;
	unsigned short   nMarkersOffset;			//Point,Line,Box,Ellipse,Polygon
	unsigned short   nMarkersLen;
	unsigned short   nTextRemarkOffset;		//a NULL-terminated string
	unsigned short   nTextRemarkLen;			
	unsigned short   res[8];
	unsigned int		nRawFrameOffset;
	unsigned int		nRawFrameLen;				//defualt == Width* Height * sizeof(short)
	unsigned int		nReferenceImageOffset;
	unsigned int		nReferenceImageLen;
}IR2_FILE_HEADER;

typedef struct TagIR2_FILE_FOOTER
{
	unsigned int nFileHeaderReverseOffset;		//
	unsigned int nFileFooterType;					//nFileFooterType == 61803
}IR2_FILE_FOOTER;

typedef struct TagIR2_FILE_INFO
{
	char szDateOfCreation[16];				// default format:    1/1/2001
	char szTimeOfCreation[16];				// default format:    15:30:40
	char szCameraType[32];					//
	char szCameraSerialNumber[32];		//
	char szLensDescription[16];				//
	unsigned short nSensorWidth;				//640 * 512   283*288 ...
	unsigned short nSensorHeight;				//640 * 512   283*288 ...
	int res1[4];
}IR2_FILE_INFO;

typedef struct TagIR2_PARAMETERS
{
	unsigned char nTempRangeIndex;
	unsigned char nTempRangeCount;
	unsigned char nRes0;
	unsigned char nRes1;
	short nTempRange0MaxTemp10;					// Default float: 150.0
	short nTempRange0MinTemp10;					// Default float: -20.0
	short nTempRange1MaxTemp10;					// Default float: 400.0
	short nTempRange1MinTemp10;					// Default float: 0.0
	short nTempRange2MaxTemp10;
	short nTempRange2MinTemp10;
	short nTempRange3MaxTemp10;
	short nTempRange3MinTemp10;
	unsigned short nEmissivity1000;			//0 ~ 1000  ,   float:  0.0 ~ 1.0,    Default float: 0.97
	unsigned short nObjectDistance10;		// 0 ~ 60000  ,  float: 0.0 ~ 6000.0 m,   Default float: 2.0 m
	short nReflectedTemperature10;			//float : 25.0 ¡ãC
	short nMaxTemp10;								//Temperature Value
	short nMinTemp10;								//Temperature Value
	short nAvgTemp10;								//Temperature Value
	short	nAtmosphericTemperature10;		//float : 25.0 ¡ãC
	unsigned char nAtmosphericTransmission100;		//0 ~ 100,   float:  0.0 ~ 1.0,
	unsigned char res0;
	short nReferenceTemperature10;			//
	short nExternalOpticsTemperature10;
	unsigned char nExternalOpticsTransmission100;		//0 ~ 100,   float:  0.0 ~ 1.0
	unsigned char nColorAlarm;				//0:  Disabled  , 1:  Alarm Above Threshold ,  2:   Alarm Below Threshold ,  3:  Alarm Inside Range ,  4 :  Alarm Outside Range ,
	short nColorAlarmRangeMax10;			//Temperature Value
	short nColorAlarmRangeMin10;			//Temperature Value
	unsigned char nEnableAutoAGC;			//Default: 1
	unsigned char res1;
	short nAGC_RangeMax10;					//Temperature Value
	short nAGC_RangeMin10;					//Temperature Value
	unsigned char nBlendingLevel;			// 0 ~ 100     float:  0.0 ~ 1.0
	unsigned char res2;
	unsigned short nBlendingRectLeft1000;
	unsigned short nBlendingRectTop1000;
	unsigned short nBlendingRectRight1000;
	unsigned short nBlendingRectBottom1000;
	unsigned short nZoomFactor10;		//   ,    float : 1.0 ~ 
	unsigned short res3;
	unsigned char nDisplayMode; 			//0:  Thermal ,    1:  Fusion  ,   2:  PIP(Picture In Picture) ,  3: Optical
	unsigned char nPaletteIndex;				//
	unsigned char nRelativeHumidity100;						//0 ~ 100,   float:  0.0 ~ 1.0
	unsigned char nTemperatureUnit;							//0:   ¡ãC    ,       1: ¡ãF     ,     2: K
	unsigned char nDisplayMarkers;				//0: hide    1: show
	unsigned char nDisplayCenterPoint;			//0: hide    1: show
	unsigned char nDisplayCenterBox;			//0: hide    1: show
	unsigned char nDisplayHotCursor;				//0: hide    1: show
	unsigned char nDisplayColorCursor;			//0: hide    1: show
	unsigned char nRotationAngle;				   // 0:	 0¡ã,   1:	90¡ã ,   2:	180¡ã,   3:	270¡ã
	unsigned char nSeverity;						    //problem severity level   ( User data )
	unsigned char nRawFrameCompression;		// 0: no compression,      
	unsigned char nRawFrameType;					// 0:  Short,         
	char res[33];
}IR2_PARAMETERS;

enum IRImgFormat {
	Format_BGR888 = 0,
	Format_RGB888,
};

/*
unsigned short   nPointMarkersOffset;
unsigned short   nPointMarkersLen;
unsigned short   nLineMarkersOffset;
unsigned short   nLineMarkersLen;
unsigned short   nBoxMarkersOffset;
unsigned short   nBoxMarkersLen;
unsigned short   nEllipseMarkersOffset;
unsigned short   nEllipseMarkersLen;
unsigned short   nPolygonMarkersOffset;
unsigned short   nPolygonMarkersLen;
*/
#endif 