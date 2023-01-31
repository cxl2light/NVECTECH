/*
±à¼­Ê±¼ä:  2022-08-09
*/


#ifndef IPC_SDK_PLAYER_H
#define IPC_SDK_PLAYER_H

#if _WIN32

#ifdef DLL_IMPLEMENT 
#define DLL_API __declspec(dllexport) 
#else 
#define DLL_API __declspec(dllimport) 
#endif

#else

#define DLL_API

#endif

#include "PluginDataType.h"

#ifdef __cplusplus
extern "C"
{
#endif

	DLL_API unsigned int IPC_GetPluginVersion();

	DLL_API void IPC_SDK_Init();

	DLL_API void IPC_SDK_Quit();

	DLL_API int IPC_NewRealHandle();

	DLL_API void IPC_DelRealHandle(int nRealHandle);

	DLL_API int IPC_IsRealHandleAvailable(int nRealHandle);

	DLL_API int IPC_StarPlay(int nRealHandle,  NET_CORE_PREVIEWINFO* info,  REALDATACALLBACK fRealDataCallBack , void   *pUser);

	DLL_API void IPC_StopPlay(int nRealHandle);

	DLL_API int IPC_IsPlaying(int nRealHandle);

	DLL_API int IPC_GetRecentHeartBeat(int nRealHandle);

	DLL_API int IPC_EnableLowCpu(int nRealHandle,   int enable);	//Only reserved interface, not implemented

#if _WIN32
	DLL_API int IPC_Snapshot(int nRealHandle,   wchar_t* path);	//just *.jpg

	DLL_API int IPC_StartRecord(int nRealHandle,   wchar_t* path,   int nFPS);		//just *.mp4
#else
        DLL_API int IPC_Snapshot(int nRealHandle, const  char* path);	//just *.jpg

        DLL_API int IPC_StartRecord(int nRealHandle,  const char* path,   int nFPS);		//just *.mp4
#endif

	DLL_API void IPC_StopRecord(int nRealHandle);

	DLL_API int IPC_IsRecording(int nRealHandle);

    DLL_API int IPC_StartRecordMp4(int nRealHandle, const char* url, const char* path);

    DLL_API void IPC_StopRecordMp4(int nRealHandle);

#ifdef __cplusplus
}
#endif


#endif
