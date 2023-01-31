//
// Created by colin on 2022/8/5.
//
#include <stdint.h>
#include "IR_APP_SDK.h"
#include "IR_APP_Define.h"

using namespace std;

extern "C"{

#include <stdint.h>

void CallbackGetJsonCamera(int channelNo, char *pJson)
{
    printf("GetJsonCamera:  %d-%s\n", channelNo, pJson);
}

void *jsonDev;
void CallbackGetJsonDevConfig(int channelNo, char *pJson)
{
    printf("GetJsonDevConfig: %d-%s\n", channelNo, pJson);
    jsonDev = pJson;
}

void *jsonUpdate;
void CallbackGetUpgrade(int channelNo, char *pJson)
{
    printf("CallbackGetUpgrade: %d-%s\n", channelNo, pJson);
    jsonUpdate = pJson;
}

void GetUpgradeProgress(int channelNo,float nProgress, int endFlag)
{
    printf("CallbackGetUpgrade: %d-%f-%d\n", channelNo, nProgress, endFlag);
}

void *jsonAnalyseResult = nullptr;
void CallbackGetJsonAnalyseResult(int channelNo, char *pJson)
{
    printf("jsonAnalyseResult: %d-%s\n", channelNo, pJson);
    if(pJson==nullptr){
        printf("jsonAnalyseResult: %d-null\n", channelNo);
    } else {
        jsonAnalyseResult = pJson;
    }
}

void* getJsonDev(){
    return jsonDev;
}

void* getJsonAnalyseResult(){
    return jsonAnalyseResult;
}


int init_device(char *ip){
        
//        char ipv4[32];

        int nChannelNo = IR_APP_NewChannel(ip,0, CallbackGetJsonDevConfig , 0, CallbackGetJsonAnalyseResult);  //1.创建通道
        printf("ZeOne=nChannelNo = %d\n\n", nChannelNo);

        int retLink = IR_APP_SynLink(nChannelNo,3000);  //2.连接设备
        printf("ZeOne=retLink = %d\n\n", retLink);

        return nChannelNo;
}

void checkLink(int nChannelNo){
    if(IR_APP_IsLinked(nChannelNo) != 1){
         IR_APP_SynLink(nChannelNo,3000);  //2.连接设备
    }
}


int init_get_camera(int nChannelNo){
        checkLink(nChannelNo);
        return IR_APP_GET_CAMERA(nChannelNo); //3.发送命令   //返回 0，发送命令失败； 成功 1
}


int init_upgrade(int nChannelNo, char *filePath){
        checkLink(nChannelNo);
        return IR_APP_UPGRADE(nChannelNo, filePath, 0); //3.发送命令   //返回 0，发送命令失败； 成功 1
}


int init_get_analyseresult(int nChannelNo){
        checkLink(nChannelNo);
        return IR_APP_GET_ANALYSERESULT(nChannelNo); //3.发送命令   //返回 0，发送命令失败； 成功 1
}


int init_get_device_config(int nChannelNo){
        checkLink(nChannelNo);
        return IR_APP_GET_DEVCONFIG(nChannelNo); //3.发送命令   //返回 0，发送命令失败； 成功 1
}

int set_palette(int nChannelNo, int index){
        checkLink(nChannelNo);
        return IR_APP_SET_PALETTE(nChannelNo,index); //3.发送命令   //返回 0，发送命令失败； 成功 1
}

int set_zoom(int nChannelNo, int index){
        checkLink(nChannelNo);
        return IR_APP_SET_ZOOM(nChannelNo,index); //3.发送命令   //返回 0，发送命令失败； 成功 1
}

int set_sharpness(int nChannelNo, int index){
        checkLink(nChannelNo);
        return IR_APP_SET_SHARPNESS(nChannelNo,index); //3.发送命令   //返回 0，发送命令失败； 成功 1
}

int set_brightness(int nChannelNo, int index){
        checkLink(nChannelNo);
        return IR_APP_SET_BRIGHTNESS(nChannelNo,index); //3.发送命令   //返回 0，发送命令失败； 成功 1
}

int set_contrast(int nChannelNo, int index){
        checkLink(nChannelNo);
        return IR_APP_SET_CONTRAST(nChannelNo,index); //3.发送命令   //返回 0，发送命令失败； 成功 1
}

int set_noise_reduction(int nChannelNo, int index){
        checkLink(nChannelNo);
        return IR_APP_SET_NOISEREDUCTION(nChannelNo,index); //3.发送命令   //返回 0，发送命令失败； 成功 1
}

int set_reticle(int nChannelNo, int index){
        checkLink(nChannelNo);
        return IR_APP_SET_RETICLE(nChannelNo,index); //3.发送命令   //返回 0，发送命令失败； 成功 1
}

int set_trace_enable(int nChannelNo, int index){
        checkLink(nChannelNo);
        return IR_APP_SET_TRACEENABLE(nChannelNo,index); //3.发送命令   //返回 0，发送命令失败； 成功 1
}

int set_pip(int nChannelNo, int index){
        checkLink(nChannelNo);
        return IR_APP_SET_PIP(nChannelNo,index); //3.发送命令   //返回 0，发送命令失败； 成功 1
}

int set_distance_enable(int nChannelNo, int index){
        checkLink(nChannelNo);
        return IR_APP_SET_DISTANCEENABLE(nChannelNo,index); //3.发送命令   //返回 0，发送命令失败； 成功 1
}


}


