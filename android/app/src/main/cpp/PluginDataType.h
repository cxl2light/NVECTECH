#ifndef PLUGIN_DATATYPE_H
#define PLUGIN_DATATYPE_H

#define CALLBACK_DATA_TYPE_DEFAULT    (0)
#define CALLBACK_DATA_TYPE_THERMAL   (1)					//Only supports infrared temperature measurement devices

#define CALLBACK_DATA_BITS_ARGB			(0)
#define CALLBACK_DATA_BITS_ABGR			(1)
#define CALLBACK_DATA_BITS_RGBA			(2)
#define CALLBACK_DATA_BITS_BGRA			(3)

#define CALLBACK_DATA_ORIGIN_TOP_LEFT				(0)
#define CALLBACK_DATA_ORIGIN_BOTTOM_LEFT		(1)

typedef struct TagNET_CORE_PREVIEWINFO
{
	char	    	rtspUrl[160];						//[ required ]  rtsp url --- rtsp://192.168.1.243:554/visiblemain?t=unicast
	unsigned char callbackEnableVideoBmp;			//[optional]	1 for enable ,  0 for disable
	unsigned char callbackVideoBmpBits;				//[optional]	CALLBACK_DATA_BITS_ARGB ~ CALLBACK_DATA_BITS_BGRA
	unsigned char callbackVideoBmpOrigin;			///[optional]	only support TOP_LEFT
    unsigned char noDecode;
	unsigned short callbackVideoBmpWidth;		///[optional]	0 is the default resolution , 
	unsigned short callbackVideoBmpHeight;		///[optional]	0 is the default resolution ,
	void*    pScaledBmpData;						///[optional] Exported BMP data, only supports zoom mode
	void*    hPlayWnd;								///[optional]	Display video stream directly to HWND
	char		szRes[248];								//MAX = 256 bytes
}NET_CORE_PREVIEWINFO;

#if _WIN32

typedef void(__stdcall *REALDATACALLBACK)(  int      nRealHandle, 		 int     dwDataType,  unsigned char      *pBuffer,   int     dwBufSize,   int	 width,	 int	 height, void      *pUser);

#else

typedef void( *REALDATACALLBACK)(  int      nRealHandle, 		 int     dwDataType,  unsigned char      *pBuffer,   int     dwBufSize,   int	 width,	 int	 height, void      *pUser);

#endif

#endif
