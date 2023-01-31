#include "StdAfx.h"
#include "DeviceManagement.h"
#include "DemoMFCV3Dlg.h"
#include "AutoPen.h"
#include <atltime.h>

volatile bool  DeviceManagement::s_CanUpdate2GUI = true;

void __stdcall FunctionExceptionCallBack(  int    dwType,  int     lUserID,  void     *pUser)
{
	if( EXCEPTION_HEART_BEAT_TIMEOUT == dwType)
	{
		TRACE("EXCEPTION_HEART_BEAT_TIMEOUT \n");
	}
	else if( EXCEPTION_SOCKET_ERROR == dwType)
	{
		TRACE("EXCEPTION_SOCKET_ERROR \n");
	}
	else if( EXCEPTION_RELOGIN	 == dwType)
	{
		TRACE("EXCEPTION_RELOGIN \n");
	}
	else if( RELOGIN_SUCCESS == dwType)
	{
		TRACE("RELOGIN_SUCCESS \n");
	}
}

DeviceManagement::DeviceManagement(void)
{
	_nUserID = RET_InvalidHandle;

	_realPlayVisibleMain= RET_InvalidHandle;
	_realPlayVisibleSub= RET_InvalidHandle;
	_realPlayThermalMain= RET_InvalidHandle;

	_pWnd = 0;
	_pListCtrl = 0;
	_pSerialEdit = 0;
	_pAlarmCtrl = 0;

	_recvRawFPS = 0;

	_srcPan = 0;
	_srcTilt = 0;
	_displayPan = 0;
	_displayTilt = 0;
	_ftPan = 0;
	_ftTIlt = 0;

	NET_CORE_SetExceptionCallBack(FunctionExceptionCallBack);

	NET_CORE_SetConnectTime(3000);//Set connection timeout (milliseconds)
	NET_CORE_SetRecvTimeOut(1000);//Set receive timeout (milliseconds)

}


DeviceManagement::~DeviceManagement(void)
{
	Logout();
}

void DeviceManagement::SetUserID(int nUserID)
{
	_nUserID = nUserID;
}

void DeviceManagement::BmpData2Gui(MT_BASIC_CFG* pBasicCfg,   unsigned char* pBits, int width, int height)
{
   CWnd* pWnd	= ( CWnd*)_pWnd;

	if (pWnd && pWnd->GetSafeHwnd() )
	{

		BITMAPINFO       dibInfo; 
		  
		dibInfo.bmiHeader.biSize  = sizeof(BITMAPINFO);  
		dibInfo.bmiHeader.biWidth   = width;  
		dibInfo.bmiHeader.biHeight  = -height;  
		dibInfo.bmiHeader.biPlanes   = 1;  
		dibInfo.bmiHeader.biBitCount  = 24;  
		dibInfo.bmiHeader.biCompression   = 0;  
		dibInfo.bmiHeader.biSizeImage   = width*height*3;  
		dibInfo.bmiHeader.biXPelsPerMeter   = 0x0ec4;  
		dibInfo.bmiHeader.biYPelsPerMeter   = 0x0ec4;  
		dibInfo.bmiHeader.biClrUsed   = 0;  
		dibInfo.bmiHeader.biClrImportant   = 0; 

		CClientDC dc(pWnd);

		SetStretchBltMode(dc.GetSafeHdc(),STRETCH_HALFTONE); 

		RECT rect;
		pWnd->GetClientRect(&rect);

		int nResult = StretchDIBits( 	dc.GetSafeHdc(),  	0, 0,  	rect.right-rect.left, rect.bottom - rect.top,  0,  0,  	width, height,  	pBits,  	&dibInfo,  DIB_RGB_COLORS,  	SRCCOPY);

		/*if (pBasicCfg && pBasicCfg->bEnable)
		{
		CAutoPen NewPenRed(&dc, PS_SOLID, 1, RGB(255,0,0));

		int width = 5;
		CPoint pt((	rect.right-rect.left) *pBasicCfg->stMaxPt.f32ScaleX,
		(rect.bottom - rect.top) *pBasicCfg->stMaxPt.f32ScaleY);
		CPoint leftPt = pt - CPoint(width,0);
		CPoint rightPt = pt + CPoint(width,0);
		CPoint UpPt = pt - CPoint(0,width);
		CPoint DownPt = pt + CPoint(0,width);
		dc.MoveTo(leftPt   );
		dc.LineTo(rightPt);

		dc.MoveTo(UpPt   );
		dc.LineTo(DownPt);
		}*/

	}
}

void DeviceManagement::BasicCfg2Gui(MT_BASIC_CFG* pBasicCfg)
{
	CListCtrl * pListCtrl	= ( CListCtrl *)_pListCtrl;

	if (pListCtrl && pListCtrl->GetSafeHwnd() )
	{
		CString strItem = pBasicCfg->bEnable ? _T("ON") : _T("OFF");
		pListCtrl->SetItemText(0,0,  strItem);

		strItem.Format(_T("%.1f"),  pBasicCfg->fMaxTemper);
		pListCtrl->SetItemText(0,1,  strItem);

		strItem.Format(_T("%.1f"),  pBasicCfg->fMinTemper);
		pListCtrl->SetItemText(0,2,  strItem);

		strItem.Format(_T("%.1f"),  pBasicCfg->fAvgTemper);
		pListCtrl->SetItemText(0,3,  strItem);

		strItem=  CString(  TEMPER_UNIT_TO_STR(pBasicCfg->unit));
		pListCtrl->SetItemText(0,4,  strItem);

		strItem.Format(_T("%.2f"),  pBasicCfg->ftEmiss);
		pListCtrl->SetItemText(0,5,  strItem);

		strItem.Format(_T("%.1f"),  pBasicCfg->ftBKTemper);
		pListCtrl->SetItemText(0,6,  strItem);

		strItem.Format(_T("%.1f m"),  pBasicCfg->ftDistance);
		pListCtrl->SetItemText(0,7,  strItem);

		strItem.Format(_T("%d * %d"),  pBasicCfg->u32RawWidth,  pBasicCfg->u32RawHeight);
		pListCtrl->SetItemText(0,8,  strItem);

	}
}

int DeviceManagement::Init()
{
	return NET_CORE_Init();	
}

int DeviceManagement::Cleanup()
{
	return  NET_CORE_Cleanup();	
}

int DeviceManagement::GetSDKVersion()
{
	return NET_CORE_GetSDKVersion();
}

int DeviceManagement::GetSDKBuildVersion()
{
	return NET_CORE_GetSDKBuildVersion();
}

int DeviceManagement::SearchCameras()
{
	return NET_CORE_SearchCameras(0);
}

int DeviceManagement::SearchCameras(const char* NIC)
{
	return NET_CORE_SearchCameras(NIC);
}

int DeviceManagement::GetCamerasList(CameraSimpleInfo pCameraSimpleInfo[], int byteOutBufferSize)
{
	return NET_CORE_GetCamerasList( pCameraSimpleInfo,    byteOutBufferSize);
}

void DeviceManagement::SetConnectTime(int timeout)
{
	NET_CORE_SetConnectTime(timeout);//Set connection timeout (milliseconds)
	
}

void DeviceManagement::SetRecvTimeOut(int timeout)
{
	NET_CORE_SetRecvTimeOut(timeout);//Set receive timeout (milliseconds)

}

const char* DeviceManagement::TEMPER_UNIT_TO_STR(TEMPER_UNIT unit)
{
	static const char pCentigrade[]= "°Ê";
	static const char pFahrenheit[] = "®H";
	static const char pKelvin[] = "K";

	if(CENTIGRADE == unit)
	{
		return pCentigrade;
	}
	else if(FAHRENHEIT == unit)
	{
		return pFahrenheit;
	}
	else if(KELVIN == unit)
	{
		return pKelvin;
	}

	return pCentigrade;
}

int DeviceManagement::SynLogin(char* szIp, int port)
{
	NET_CORE_USER_LOGIN_INFO loginInfo = {0};

	//192.168.1.138     192.168.1.227  "192.168.22.136"
	strcpy(loginInfo.sIpAddr,  szIp) ;		//192.168.1.227 ,  192.168.8.128
	loginInfo.nServerPort = port ;
	loginInfo.pUserData = this;
	strcpy(loginInfo.sUserName,    "admin" );
	strcpy(loginInfo.sPassword ,    "admin123");

	_nUserID = NET_CORE_Login(&loginInfo);

	return _nUserID;
}

void __stdcall FCallBackLoginResult(int   nUserID,  int  nResult,   NET_CORE_DEVICE_INFO*    lpDeviceInfo,  void    *pUserData)
{
	TRACE("************************\n");
	TRACE("FCallBackLoginResult = ID:%d, nResult:%d,  Info:%x,   UserData:%x  \n"  , nUserID , nResult,  lpDeviceInfo, pUserData);

	DeviceManagement* pThis = (DeviceManagement*)pUserData;

	if(pThis)
	{
		pThis->SetUserID(nUserID );
	}

}

int DeviceManagement::AsynLogin(char* szIp, int port)
{
	NET_CORE_USER_LOGIN_INFO loginInfo = {0};

	//192.168.1.138     192.168.1.227  "192.168.22.136"
	strcpy(loginInfo.sIpAddr,  szIp) ;		//192.168.1.227 ,  192.168.8.128
	loginInfo.nServerPort = port ;
	loginInfo.pUserData = this;
	strcpy(loginInfo.sUserName,    "admin" );
	strcpy(loginInfo.sPassword ,    "admin123");

	loginInfo.bUseAsynLogin = 1;
	loginInfo.cbLoginResult = FCallBackLoginResult;


	_nUserID = RET_InvalidHandle;

	NET_CORE_Login(&loginInfo);

	return RET_InvalidHandle;

}

int DeviceManagement::Logout()
{
	int ret = NET_CORE_Logout(_nUserID);

	_nUserID = RET_InvalidHandle;
	
	return ret;
}


bool DeviceManagement::isValidUserId()
{
	return _nUserID != RET_InvalidHandle;
}

int DeviceManagement::GetDeviceInformation(DeviceInformation* lpOutBuffer, int byteOutBufferSize)
{
	return NET_CORE_GetDeviceInformation(_nUserID , lpOutBuffer,  byteOutBufferSize);
}

int DeviceManagement::GetDeviceAbilit(NET_CORE_DEVABL* lpOutBuffer, int nOutBufferSize)
{
	return NET_CORE_GetDeviceAbility(_nUserID, lpOutBuffer, nOutBufferSize);
}

std::string DeviceManagement::DeviceAbilit2String(NET_CORE_DEVABL* pDevABL)
{
	std::ostringstream stream_out;
	stream_out<<"channel_visual_ability"<<":\t\t"<<(pDevABL->channel_visual_ability ? "ON":"OFF")<<"\r\n";
	stream_out<<"channel_infrared_ability"<<":\t\t"<<(pDevABL->channel_infrared_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"channel_fused_ability"<<":\t\t"<<(pDevABL->channel_fused_ability? "ON":"OFF")<<"\r\n";

	stream_out<<"network_tcpip_ability"<<":\t\t"<<(pDevABL->network_tcpip_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"network_multicast_ability"<<":\t\t"<<(pDevABL->network_multicast_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"network_port_ability"<<":\t\t"<<(pDevABL->network_port_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"network_whitelist_ability"<<":\t\t"<<(pDevABL->network_whitelist_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"network_gb28181_ability"<<":\t\t"<<(pDevABL->network_gb28181_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"network_network_4g_ability"<<":\t\t"<<(pDevABL->network_network_4g_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"network_cloud_ability"<<":\t\t"<<(pDevABL->network_cloud_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"network_wifi_ability"<<":\t\t"<<(pDevABL->network_wifi_ability? "ON":"OFF")<<"\r\n";

	stream_out<<"codec_visualMain_ability"<<":\t\t"<<(pDevABL->codec_visualMain_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"codec_visualSub_ability"<<":\t\t"<<(pDevABL->codec_visualSub_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"codec_infraredMain_ability"<<":\t\t"<<(pDevABL->codec_infraredMain_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"codec_infraredSub_ability"<<":\t\t"<<(pDevABL->codec_infraredSub_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"codec_audio_ability"<<":\t\t"<<(pDevABL->codec_audio_ability? "ON":"OFF")<<"\r\n";

	stream_out<<"vca_enable_ability"<<":\t\t"<<(pDevABL->vca_enable_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"vca_motion_ability"<<":\t\t"<<(pDevABL->vca_motion_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"vca_cross_ability"<<":\t\t"<<(pDevABL->vca_cross_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"vca_areain_ability"<<":\t\t"<<(pDevABL->vca_areain_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"vca_areaout_ability"<<":\t\t"<<(pDevABL->vca_areaout_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"vca_intrusion_ability"<<":\t\t"<<(pDevABL->vca_intrusion_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"vca_firedetect_ability"<<":\t\t"<<(pDevABL->vca_firedetect_ability? "ON":"OFF")<<"\r\n";

	stream_out<<"vca_object_human_ability"<<":\t\t"<<(pDevABL->vca_object_human_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"vca_object_car_ability"<<":\t\t"<<(pDevABL->vca_object_car_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"vca_object_boat_ability"<<":\t\t"<<(pDevABL->vca_object_boat_ability? "ON":"OFF")<<"\r\n";

	stream_out<<"image_imageSet_ability"<<":\t\t"<<(pDevABL->image_imageSet_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"image_osdSet_ability"<<":\t\t"<<(pDevABL->image_osdSet_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"image_pictureInPicture_ability"<<":\t\t"<<(pDevABL->image_pictureInPicture_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"image_blindElement_ability"<<":\t\t"<<(pDevABL->image_blindElement_ability? "ON":"OFF")<<"\r\n";

	stream_out<<"event_alarmIn_ability"<<":\t\t"<<(pDevABL->event_alarmIn_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"event_alarmOut_ability"<<":\t\t"<<(pDevABL->event_alarmOut_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"event_occlusion_ability"<<":\t\t"<<(pDevABL->event_occlusion_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"event_exception_ability"<<":\t\t"<<(pDevABL->event_exception_ability? "ON":"OFF")<<"\r\n";

	stream_out<<"history_enable_ability"<<":\t\t"<<(pDevABL->history_enable_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"history_record_ability"<<":\t\t"<<(pDevABL->history_record_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"history_picture_ability"<<":\t\t"<<(pDevABL->history_picture_ability? "ON":"OFF")<<"\r\n";

	stream_out<<"storage_enable_ability"<<":\t\t"<<(pDevABL->storage_enable_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"storage_eventRecord_ability"<<":\t\t"<<(pDevABL->storage_eventRecord_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"storage_timingRecord_ability"<<":\t\t"<<(pDevABL->storage_timingRecord_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"storage_eventSnapshot_ability"<<":\t\t"<<(pDevABL->storage_eventSnapshot_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"storage_timingSnapshot_ability"<<":\t\t"<<(pDevABL->storage_timingSnapshot_ability? "ON":"OFF")<<"\r\n";

	stream_out<<"temperature_enable_ability"<<":\t\t"<<(pDevABL->temperature_enable_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"temperature_basic_ability"<<":\t\t"<<(pDevABL->temperature_basic_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"temperature_advanced_ability"<<":\t\t"<<(pDevABL->temperature_advanced_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"temperature_schedule_ability"<<":\t\t"<<(pDevABL->temperature_schedule_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"temperature_historyTemper_ability"<<":\t\t"<<(pDevABL->temperature_historyTemper_ability? "ON":"OFF")<<"\r\n";

	stream_out<<"ptz_enable_ability"<<":\t\t"<<(pDevABL->ptz_enable_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"ptz_direct_ability"<<":\t\t"<<(pDevABL->ptz_direct_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"ptz_speed_ability"<<":\t\t"<<(pDevABL->ptz_speed_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"ptz_zoom_ability"<<":\t\t"<<(pDevABL->ptz_zoom_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"ptz_focus_ability"<<":\t\t"<<(pDevABL->ptz_focus_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"ptz_iris_ability"<<":\t\t"<<(pDevABL->ptz_iris_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"ptz_focusing_ability"<<":\t\t"<<(pDevABL->ptz_focusing_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"ptz_wiper_ability"<<":\t\t"<<(pDevABL->ptz_wiper_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"ptz_positon3D_ability"<<":\t\t"<<(pDevABL->ptz_positon3D_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"ptz_light_ability"<<":\t\t"<<(pDevABL->ptz_light_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"ptz_demisting_ability"<<":\t\t"<<(pDevABL->ptz_demisting_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"ptz_init_ability"<<":\t\t"<<(pDevABL->ptz_init_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"ptz_preset_ability"<<":\t\t"<<(pDevABL->ptz_preset_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"ptz_cruise_ability"<<":\t\t"<<(pDevABL->ptz_cruise_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"ptz_ptzBasicCfg_ability"<<":\t\t"<<(pDevABL->ptz_ptzBasicCfg_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"ptz_keepWatch_ability"<<":\t\t"<<(pDevABL->ptz_keepWatch_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"ptz_zeroAzimuth_ability"<<":\t\t"<<(pDevABL->ptz_zeroAzimuth_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"ptz_scheduleTask_ability"<<":\t\t"<<(pDevABL->ptz_scheduleTask_ability? "ON":"OFF")<<"\r\n";
	stream_out<<"ptz_setAzimuth_ability"<<":\t\t"<<(pDevABL->ptz_setAzimuth_ability? "ON":"OFF")<<"\r\n";

	return stream_out.str();
}

int DeviceManagement::PlayVisibleMainStream(HWND hwnd)
{
	NET_CORE_PREVIEWINFO_EX info ;
	memset(&info, 0, sizeof(NET_CORE_PREVIEWINFO_EX));

	info.streamType = StreamType_VisibleMain;
	info.hPlayWnd = hwnd;

	_realPlayVisibleMain = NET_CORE_RealPlay(_nUserID,  &info, 0 );

	return _realPlayVisibleMain;
}

int DeviceManagement::StopPlayVisibleMainStream()
{
	int  ret = NET_CORE_StopRealPlay(_realPlayVisibleMain);

	_realPlayVisibleMain = RET_InvalidHandle;

	return ret;
}

int DeviceManagement::SnapshotVisibleMainStream( const wchar_t* path)
{
	return NET_CORE_Snapshot(_realPlayVisibleMain,path);
}	//just *.jpg

int DeviceManagement::StartRecordVisibleMainStream( const wchar_t* path)
{
	return NET_CORE_StartRecord(_realPlayVisibleMain,path);
}		//just *.mp4

void DeviceManagement::StopRecordVisibleMainStream()
{
	 NET_CORE_StopRecord(_realPlayVisibleMain);
}

int DeviceManagement::MakeKeyFrameVisibleMainStream()
{
	return NET_CORE_MakeKeyFrame(_realPlayVisibleMain);
}

int DeviceManagement::EnableLowCpuVisibleMainStream(int enable)
{
	return NET_CORE_EnableLowCpu(_realPlayVisibleMain ,enable);
}

int DeviceManagement::PlayThermalMainStream(HWND hwnd)
{
	NET_CORE_PREVIEWINFO_EX info ;
	memset(&info, 0, sizeof(NET_CORE_PREVIEWINFO_EX));

	info.streamType = StreamType_ThermalMain;
	info.hPlayWnd = hwnd;

	_realPlayThermalMain = NET_CORE_RealPlay(_nUserID,  &info, 0 );

	return _realPlayThermalMain;
}

int DeviceManagement::StopPlayThermalMainStream()
{
	int  ret = NET_CORE_StopRealPlay(_realPlayThermalMain);

	_realPlayThermalMain = RET_InvalidHandle;

	return ret;
}

int DeviceManagement::SnapshotThermalMainStream(const wchar_t* path)
{
	return NET_CORE_Snapshot(_realPlayThermalMain,path);

}//just *.jpg

int DeviceManagement::StartRecordThermalMainStream( const wchar_t* path)
{
	return NET_CORE_StartRecord(_realPlayThermalMain,path);
}		//just *.mp4

void DeviceManagement::StopRecordThermalMainStream()
{
    NET_CORE_StopRecord(_realPlayThermalMain);
}


int DeviceManagement::MakeKeyFrameThermalMainStream()
{
	return NET_CORE_MakeKeyFrame(_realPlayThermalMain);
}

int DeviceManagement::EnableLowCpuThermalMainStream(int enable)
{
	return NET_CORE_EnableLowCpu(_realPlayThermalMain ,enable);
}

int DeviceManagement::PTZControl(int nChannel, int nPTZCommand, int nStop)
{
	return NET_CORE_PTZControl(_nUserID,		nChannel,		nPTZCommand,		nStop);
}

int DeviceManagement::PTZPreset(int nChannel, int nPTZPresetCmd, int nPresetIndex, int nSpeed)
{
	return NET_CORE_PTZPreset(_nUserID ,  nChannel,  nPTZPresetCmd ,  nPresetIndex , nSpeed );
}

int DeviceManagement::PTZCruise(int nChannel, int nPTZCruiseCmd, int nCruiseRoute)
{
	return NET_CORE_PTZCruise(_nUserID,   nChannel,   nPTZCruiseCmd,  nCruiseRoute);
}

int DeviceManagement::FocusOnePush(int nChannel)
{
	return NET_CORE_FocusOnePush(_nUserID,      nChannel);
}

int DeviceManagement::GetImagingSettings(int nChannel, ImagingSettings* lpOutBuffer , int nBufferSize)
{
	return NET_CORE_GetImagingSettings(_nUserID,  nChannel, lpOutBuffer, nBufferSize  );
}

int DeviceManagement::SetImagingSettings(int nChannel, ImagingSettings* lpInBuffer , int nBufferSize)
{
	return NET_CORE_SetImagingSettings(_nUserID,  nChannel, lpInBuffer, nBufferSize  );
}

int DeviceManagement::SetImagePalette(int nChannel , IRColorPalette nColorPaletteIndex)
{
	return NET_CORE_SetPalette(_nUserID , nChannel , nColorPaletteIndex);
}

int DeviceManagement::GetAllVideoSettings(AllVideoSettings* lpOutBuffer , int nBufferSize)
{
	return NET_CORE_GetAllVideoSettings(_nUserID  , lpOutBuffer, nBufferSize);
}

int DeviceManagement::SetAllVideoSettings(AllVideoSettings* lpInBuffer , int nBufferSize)
{
	return NET_CORE_SetAllVideoSettings(_nUserID  , lpInBuffer, nBufferSize);
}

int DeviceManagement::Reboot(  )
{
	return NET_CORE_Reboot(_nUserID);
}

int DeviceManagement::ShutDown(  )
{
	return NET_CORE_ShutDown(_nUserID);
}

int DeviceManagement::RestoreCFG(  )
{
	return NET_CORE_RestoreCFG(_nUserID);
}

int DeviceManagement::HardFactoryReset()
{
	return NET_CORE_HardFactoryReset(_nUserID);
}

void __stdcall FunSerialDataCallBack( int nUserID, int nType, unsigned char *pRecvDataBuffer, int dwBufSize,void *pUser)
{
	if (false == DeviceManagement::s_CanUpdate2GUI)
	{
		return;
	}

	OutputDebugStringA("Serial Data Call Back \n");

	if (1 == nType)
	{
		TRACE("RS232\n");
	}else if (2 == nType)
	{
		TRACE("RS485\n");
	}

	for (int i = 0 ; i < dwBufSize; ++i)
	{
		TRACE("%02x ", pRecvDataBuffer[i]);
	}
	TRACE("\n");


	CString strRS232;

	DeviceManagement* pThis = (DeviceManagement*)pUser;
	if (pThis &&  
		1 == nType)
	{
		int ret = pThis->DecodeRS232Data((char*)pRecvDataBuffer, dwBufSize);
		if (ret)
		{
			TRACE("\nSource Pan %d  Tilt %d",  pThis->_srcPan,  pThis->_srcTilt);
			TRACE("\nDisplay Pan %d  Tilt %d",  pThis->_displayPan,  pThis->_displayTilt);
			TRACE("\nPan %.2f  Tilt %.2f\n",   pThis->_ftPan,  pThis->_ftTIlt);

			strRS232.Format(_T("Pan %.2f  Tilt %.2f"),   pThis->_ftPan,  pThis->_ftTIlt);
		}
	}


	

	if (pThis)
	{
		if (pThis->_pSerialEdit)
		{
			CListCtrl * pEdit = (CListCtrl * )pThis->_pSerialEdit;

			static CString strMsg;
			static CString strItem;
			strMsg = L"";

			for (int i = 0 ; i < dwBufSize; ++i)
			{
				strItem.Format(L"%02x ", pRecvDataBuffer[i]);
				strMsg += strItem;
			}

			CString strTime;
			CTime tm =CTime::GetCurrentTime();
			strTime=tm.Format("%Y%m%d %X");

			pEdit->InsertItem(0,  strTime);
			pEdit->SetItemText(0,1,   strMsg);
			pEdit->SetItemText(0,2,  strRS232);

		}
	}


}

int DeviceManagement::SerialStart()
{
	return NET_CORE_SerialStart(_nUserID, FunSerialDataCallBack);
}

int DeviceManagement::SerialStop()
{
	return NET_CORE_SerialStop(_nUserID);
}

int DeviceManagement::SerialSend(int nSerialPort, char *pSendBuf, int nBufSize)
{
	return NET_CORE_SerialSend(_nUserID , nSerialPort, pSendBuf,  nBufSize);
}

int DeviceManagement::DecodeRS232Data(char* frame, int framelen)
{
	if ( framelen < 12)
	{
		return 0;
	}

	int s32Pan = frame[4] * 4096 + frame[5] * 256 + frame[6] * 16 + frame[7];
	int s32Tilt = frame[8] * 4096 + frame[9] * 256 + frame[10] * 16 + frame[11];
	int s32PanDisplay = s32Pan;
	int s32TiltDisplay;

#if 0
	if ( s32Tilt > 9000 ){
		s32Tilt -= 36000 ;
	}
#else
	if ( s32Tilt == 0 || s32Tilt == 36000 )
	{
		s32TiltDisplay = 0;
	}
	else if ( s32Tilt < 18000 )
	{
		s32TiltDisplay = 0 - s32Tilt;
	}
	else if ( s32Tilt >= 18000 )
	{
		s32TiltDisplay = 36000 - s32Tilt;
	}
#endif
	static const int i32Precision = 100;
	double pan = (double)s32Pan/(double)i32Precision;
	double title = (double)s32Tilt/(double)i32Precision;


	///////////////////////////////
	_srcPan = s32Pan;
	_srcTilt = s32Tilt;
	_displayPan = s32PanDisplay;
	_displayTilt = s32TiltDisplay;
	_ftPan = pan;
	_ftTIlt = title;

	return 1;
}

void __stdcall FunAlarmMessageCallBack( int nUserID, NET_CORE_ALARM_MSG *pAlarmMSG, void *pUser)
{
	if (false == DeviceManagement::s_CanUpdate2GUI)
	{
		return;
	}

	//OutputDebugStringA("Alarm MSG CallBack \n");

	DeviceManagement* pThis = (DeviceManagement*)pUser;
	if (pThis)
	{
		if (pThis->_pAlarmCtrl)
		{
			CListCtrl* pListCtrl = (CListCtrl* )(pThis->_pAlarmCtrl);

			CString strItem=  CString(pAlarmMSG->szAlarmTime);
		
			pListCtrl->InsertItem(  0,  strItem );
			
			strItem =   CString(pAlarmMSG->eventName);
			pListCtrl->SetItemText(  0,  1,   strItem );

			strItem = CString(pAlarmMSG->eventType);
			pListCtrl->SetItemText(  0,  2,   strItem );

			strItem.Format(_T("%d"),  (pAlarmMSG->eventStatus));
			pListCtrl->SetItemText(  0,  3,    strItem);

			strItem = CString (pAlarmMSG->channel);
			pListCtrl->SetItemText(  0,  4,    strItem);

			strItem = CString (pAlarmMSG->snapshotName);
			pListCtrl->SetItemText(  0,  5,    strItem);

			strItem= CString (pAlarmMSG->recordName);
			pListCtrl->SetItemText(  0,  6,   strItem );

			strItem.Format(_T("%d"),  (pAlarmMSG->index));
			pListCtrl->SetItemText(  0,  7,    strItem);
		}
	}

}

int DeviceManagement::SetupAlarmChan()
{
	return NET_CORE_SetupAlarmChan(_nUserID , FunAlarmMessageCallBack);
}

int DeviceManagement::CloseAlarmChan()
{
	return NET_CORE_CloseAlarmChan(_nUserID);
}

int DeviceManagement::GetMTPreferences(MT_Preferences* lpOutBuffer, int nBufferSize)
{
	return NET_IR_GetMTPreferences(_nUserID,    lpOutBuffer , nBufferSize );
}

int DeviceManagement::SetMTPreferences(MT_Preferences* lpInBuffer, int nBufferSize)
{
	return NET_IR_SetMTPreferences(_nUserID,    lpInBuffer , nBufferSize );
}

void __stdcall   CallbackInfraredImage(int nUserID ,  MT_BASIC_CFG* pBasicCfg, MT_MARKER_CFG_EXT* pMarkerCfg,   int nMarkerCount, 
	unsigned char* pBGR, int bgrLen,  float* tempMatrix ,  short* grayMatrix ,  int width, int height,  void   *pUser )
{

	if (false == DeviceManagement::s_CanUpdate2GUI)
	{
		return;
	}

	//TRACE("CallbackInfraredImage\n");

	///////////////////////////////////////////////////////////////
	DeviceManagement* pThis = (DeviceManagement*)pUser;
	if (pThis)
	{
		pThis->_recvRawFPS += 1;

		if (pThis->_pWnd)
		{
			pThis->BmpData2Gui(pBasicCfg,  pBGR,width,height);
		}

		if (pThis->_pListCtrl)
		{
			pThis->BasicCfg2Gui(pBasicCfg);
		}
	}

	///////////////////////////////////////////////////////////////
#if 0
	CDeviceBrowserDlg* pDlg = (CDeviceBrowserDlg*)(AfxGetApp()->m_pMainWnd);

	if (pDlg)
	{
		pDlg->BmpData2Gui( pBGR, width, height );
	}

	if (pDlg)
	{
		pDlg->TempMatrix2Gui(pBasicCfg , pBGR, grayMatrix,  tempMatrix , width, height);
	}
#endif
	
}

int DeviceManagement::StartProcessImage()
{
	RawFrameTransferSettings rawFrameTransferSettings = {0};
	rawFrameTransferSettings.fps = 3;

	return NET_IR_StartProcessImage(_nUserID,CallbackInfraredImage, &rawFrameTransferSettings);
}


int DeviceManagement::StartProcessPulseImage()
{
	return NET_IR_StartProcessPulseImage(_nUserID,CallbackInfraredImage);
}

int DeviceManagement::TransferPulseImage()
{
	return NET_IR_TransferPulseImage(_nUserID);
}

int DeviceManagement::StopProcessImage()
{
	return NET_IR_StopProcessImage(_nUserID);
}

int DeviceManagement::EnableTemperatureMeasurement(int enable)
{
	return NET_IR_EnableTemperatureMeasurement(_nUserID, enable);
}



int DeviceManagement::SetRawFps( int fps)
{
	return NET_IR_SetRawFps(_nUserID, fps);
}

int DeviceManagement::LockImage()
{
	return NET_IR_LockImage(_nUserID);
}

int DeviceManagement::UnLockImage( )
{
	return NET_IR_UnLockImage(_nUserID);
}

int DeviceManagement::SaveBMP(const wchar_t * charFilename)
{
	return NET_IR_SaveBMP(_nUserID,    charFilename);
}

int DeviceManagement::GetSensorSize(MT_SIZE* lpOutBuffer)
{
	return NET_IR_GetSensorSize(_nUserID , lpOutBuffer);
}

int DeviceManagement::GetTemperatureData( float* lpOutBuffer, int nBufferSize )
{
	return NET_IR_GetTemperatureData(_nUserID , lpOutBuffer , nBufferSize);
}

int DeviceManagement::GetRawFrameData(short* lpOutBuffer, int nBufferSize )
{
	return NET_IR_GetRawFrameData(_nUserID , lpOutBuffer , nBufferSize);
}

int DeviceManagement::SetFixPara( FixPara* lpInBuffer , int nBufferSize)
{
	return NET_IR_SetFixPara(_nUserID ,lpInBuffer , nBufferSize  );
}

int DeviceManagement::ResetTempPara(   )
{
	return NET_IR_ResetTempPara(_nUserID );
}

int DeviceManagement::SetPalette( IRColorPalette nColorPaletteIndex)
{
	return NET_IR_SetPalette(_nUserID , nColorPaletteIndex);
}

int DeviceManagement::TriggerFFC( )
{
	return NET_IR_TriggerFFC(_nUserID  );//Perform a flat-field correction, or FFC
}


int DeviceManagement::SetTemperatureRange(  int index)
{
	return NET_IR_SetTemperatureRange(_nUserID , index);
}

int DeviceManagement::SetTemperatureUnit( TEMPER_UNIT unit)
{
	//Degree Celsius (°„C)/ Degree Fahrenheit (°„F)/ Degree Kelvin (K).
	return NET_IR_SetTemperatureUnit(_nUserID , unit);
}

int DeviceManagement::DisplayTempInfoOnStream( int enable)
{		 
	return NET_IR_DisplayTempInfoOnStream(_nUserID ,enable );
}

int DeviceManagement::ClearAllMarkers(int nPresetIndex  )
{
	return NET_IR_ClearAllMarkers(_nUserID ,nPresetIndex);
}

int DeviceManagement::GetAllMarkersCfg(  int nPresetIndex, MT_ALL_MARKERS_CFG* lpOutBuffer , int nBufferSize )
{
	return NET_IR_GetAllMarkersCfg(_nUserID ,nPresetIndex ,  lpOutBuffer, nBufferSize);
}

int DeviceManagement::SetAllMarkersCfg(   int nPresetIndex,  MT_ALL_MARKERS_CFG* lpInBuffer , int nBufferSize )
{
	return NET_IR_SetAllMarkersCfg(_nUserID , nPresetIndex ,  lpInBuffer, nBufferSize );
}

int DeviceManagement::SetTempOffset( float  offset  )	
{
	return NET_IR_SetTempOffset(_nUserID , offset);
}	