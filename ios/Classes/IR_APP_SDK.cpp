#include "IR_APP_SDK.h"
#include "IR_APP_Private.h"
#include "wifipacketinfo.h"

#define MAX_PACKET_SIZE (1400)

#define SOL_TCP 6
#define TCP_KEEPIDLE 4

enum
{
    UPGRADE_FILE_HEADR = 0x10000,
    UPGRADE_FILE_DATA,
    UPGRADE_FILE_END,
};

int IR_APP_NewChannel(char *ipv4, FunGetJsonCamera funGetJsonCamera, FunGetJsonDevConfig funGetJsonDevConfig, FunGetUpgrade funGetUpgrade, FunGetJsonAnalyseResult funGetJsonAnalyseResult)
{

    if (strlen(ipv4) < 0 || strlen(ipv4) > 30)
    {
        printf("%s", "Invalid ipv4 address\n");
    }
    else
    {

        for (int i = 0; i < MAX_CHANNEL_COUNT; i++)
        {
            /* code */
            if (g_session[i].bUsing)
            {
            }
            else
            {
                g_session[i].bUsing = 1;

                strcpy(g_session[i].ipv4, ipv4);

                g_session[i].pSocket = new AppTool::Socket;

                g_session[i].pClientThread = new ClientThread;

                g_session[i].pClientThread->_funGetJsonCamera = funGetJsonCamera;
                g_session[i].pClientThread->_funGetJsonDevConfig = funGetJsonDevConfig;
                g_session[i].pClientThread->_funGetUpgrade = funGetUpgrade;
                g_session[i].pClientThread->_funGetJsonAnalyseResult = funGetJsonAnalyseResult;

                int channelNo = index2No(i);
                g_session[i].pClientThread->_channelNo = channelNo;

                g_session[i].tcpConnect = 0;

                return channelNo;
            }
        }
    }

    return DEFAULT_RET;
}

void IR_APP_DelChannel(int channelNo)
{

    IR_APP_SynDisLink(channelNo);

    /////////////////////////
    int index = No2index(channelNo);
    if (isValidIndex(index))
    {
        SAFE_DELETE(g_session[index].pSocket);

        SAFE_DELETE(g_session[index].pClientThread);

        memset(g_session + index, 0, sizeof(Session));
    }
}

int IR_APP_IsChannelAvailable(int channelNo)
{

    int index = No2index(channelNo);

    if (isValidIndex(index))
    {
        if (g_session[index].bUsing && g_session[index].pSocket && g_session[index].pClientThread)
        {
            return 1;
        }
    }

    return DEFAULT_RET;
}

int IR_APP_SynLink(int channelNo, int msTimeOut)
{

    if (IR_APP_IsLinked(channelNo))
    {
        IR_APP_SynDisLink(channelNo);
    }

    if (IR_APP_IsChannelAvailable(channelNo))
    {
        int index = No2index(channelNo);

        g_session[index].pSocket->Close();

        g_session[index].pSocket->Create(AF_INET, SOCK_STREAM, IPPROTO_IP);

        bool bConnected = false;

        g_session[index].tcpConnect = 0;

        do
        {

            if (!g_session[index].pSocket->IsValid())
            {
                break;
            }

            if (msTimeOut <= 0)
            {
                msTimeOut = 1000;
            }

            AppTool::SockAddr peer(g_session[index].ipv4, DEFAULT_TCP_PORT);

            bConnected = g_session[index].pSocket->ConnectTimeOut(peer, msTimeOut);

            if (!bConnected)
            {
                break;
            }

            g_session[index].tcpConnect = 1;

            if (1)
            {
                int keepAlive = 1;    // ??????keepalive??????
                int keepIdle = 10;    // ???????????????10??????????????????????????????,???????????????
                int keepInterval = 3; // ?????????????????????????????????3 ???
                int keepCount = 3;    // ?????????????????????.?????????1??????????????????????????????,??????2???????????????.

                SOCKET rs = g_session[index].pSocket->Handle();

                setsockopt(rs, SOL_SOCKET, SO_KEEPALIVE, (void *)&keepAlive, sizeof(keepAlive));
                setsockopt(rs, SOL_TCP, TCP_KEEPIDLE, (void *)&keepIdle, sizeof(keepIdle));
                setsockopt(rs, SOL_TCP, TCP_KEEPINTVL, (void *)&keepInterval, sizeof(keepInterval));
                setsockopt(rs, SOL_TCP, TCP_KEEPCNT, (void *)&keepCount, sizeof(keepCount));
            }

        } while (0);

        if (!bConnected)
        {
            g_session[index].pSocket->Close();
        }
        else
        {

            printf("%s", "TCP Success Connect");

            g_session[index].pClientThread->set_socket(g_session[index].pSocket->Handle());

            g_session[index].pClientThread->Run();

            return 1;
        }
    }

    return DEFAULT_RET;
}

void IR_APP_SynDisLink(int channelNo)
{

    if (IR_APP_IsChannelAvailable(channelNo))
    {
        int index = No2index(channelNo);

        g_session[index].tcpConnect = 0;

        g_session[index].pClientThread->set_stop(true);

        g_session[index].pClientThread->Join();

        g_session[index].pSocket->Close();
    }
    return;
}

int IR_APP_IsLinked(int channelNo)
{
    if (IR_APP_IsChannelAvailable(channelNo))
    {
        int index = No2index(channelNo);

        return g_session[index].tcpConnect;
    }
    return 0;
}

int IR_APP_SET_PALETTE(int channelNo, int value)
{
    if (IR_APP_IsLinked(channelNo))
    {
        int index = No2index(channelNo);

        if (g_session[index].pSocket->IsValid())
        {

            char cmdData[256] = {0};

            int cmdLength = zs_CPMakePacket(cmdData,
                                            &value,
                                            COMMAND_APP_SET_PALETTE,
                                            CMD_STEM_FROM_PC,
                                            sizeof(int));

            int sendLen = g_session[index].pSocket->Send(cmdData, cmdLength);

            if (sendLen > 0)
            {
                return 1;
            }
        }
    }
    return DEFAULT_RET;
}

int IR_APP_SET_ZOOM(int channelNo, int value)
{
    if (IR_APP_IsLinked(channelNo))
    {
        int index = No2index(channelNo);

        if (g_session[index].pSocket->IsValid())
        {

            char cmdData[256] = {0};

            int cmdLength = zs_CPMakePacket(cmdData,
                                            &value,
                                            COMMAND_APP_SET_ZOOM,
                                            CMD_STEM_FROM_PC,
                                            sizeof(int));

            int sendLen = g_session[index].pSocket->Send(cmdData, cmdLength);

            if (sendLen > 0)
            {
                return 1;
            }
        }
    }
    return DEFAULT_RET;
}

int IR_APP_GET_CAMERA(int channelNo)
{

    if (IR_APP_IsLinked(channelNo))
    {
        int index = No2index(channelNo);

        if (g_session[index].pSocket->IsValid())
        {

            char cmdData[256] = {0};

            int cmdLength = zs_CPMakePacket(cmdData,
                                            0,
                                            COMMAND_APP_GET_CAMERA,
                                            CMD_STEM_FROM_PC,
                                            0);

            int sendLen = g_session[index].pSocket->Send(cmdData, cmdLength);

            if (sendLen > 0)
            {
                return 1;
            }
        }
    }

    return DEFAULT_RET;
}
int IR_APP_GET_DEVCONFIG(int channelNo)
{

    if (IR_APP_IsLinked(channelNo))
    {
        int index = No2index(channelNo);

        if (g_session[index].pSocket->IsValid())
        {

            char cmdData[256] = {0};

            int cmdLength = zs_CPMakePacket(cmdData,
                                            0,
                                            COMMAND_APP_GET_DEVCONFIG,
                                            CMD_STEM_FROM_PC,
                                            0);

            int sendLen = g_session[index].pSocket->Send(cmdData, cmdLength);

            if (sendLen > 0)
            {
                return 1;
            }
        }
    }

    return DEFAULT_RET;
}
int IR_APP_GET_ANALYSERESULT(int channelNo)
{

    if (IR_APP_IsLinked(channelNo))
    {
        int index = No2index(channelNo);

        if (g_session[index].pSocket->IsValid())
        {

            char cmdData[256] = {0};

            int cmdLength = zs_CPMakePacket(cmdData,
                                            0,
                                            COMMAND_APP_GET_ANALYSERESULT,
                                            CMD_STEM_FROM_PC,
                                            0);

            int sendLen = g_session[index].pSocket->Send(cmdData, cmdLength);

            if (sendLen > 0)
            {
                return 1;
            }
        }
    }

    return DEFAULT_RET;
}
int IR_APP_SET_SHARPNESS(int channelNo, int value)
{

    if (IR_APP_IsLinked(channelNo))
    {
        int index = No2index(channelNo);

        if (g_session[index].pSocket->IsValid())
        {

            char cmdData[256] = {0};

            int cmdLength = zs_CPMakePacket(cmdData,
                                            &value,
                                            COMMAND_APP_SET_SHARPNESS,
                                            CMD_STEM_FROM_PC,
                                            sizeof(int));

            int sendLen = g_session[index].pSocket->Send(cmdData, cmdLength);

            if (sendLen > 0)
            {
                return 1;
            }
        }
    }

    return DEFAULT_RET;
}
int IR_APP_SET_BRIGHTNESS(int channelNo, int value)
{

    if (IR_APP_IsLinked(channelNo))
    {
        int index = No2index(channelNo);

        if (g_session[index].pSocket->IsValid())
        {

            char cmdData[256] = {0};

            int cmdLength = zs_CPMakePacket(cmdData,
                                            &value,
                                            COMMAND_APP_SET_BRIGHTNESS,
                                            CMD_STEM_FROM_PC,
                                            sizeof(int));

            int sendLen = g_session[index].pSocket->Send(cmdData, cmdLength);

            if (sendLen > 0)
            {
                return 1;
            }
        }
    }

    return DEFAULT_RET;
}
int IR_APP_SET_CONTRAST(int channelNo, int value)
{

    if (IR_APP_IsLinked(channelNo))
    {
        int index = No2index(channelNo);

        if (g_session[index].pSocket->IsValid())
        {

            char cmdData[256] = {0};

            int cmdLength = zs_CPMakePacket(cmdData,
                                            &value,
                                            COMMAND_APP_SET_CONTRAST,
                                            CMD_STEM_FROM_PC,
                                            sizeof(int));

            int sendLen = g_session[index].pSocket->Send(cmdData, cmdLength);

            if (sendLen > 0)
            {
                return 1;
            }
        }
    }

    return DEFAULT_RET;
}
int IR_APP_SET_NOISEREDUCTION(int channelNo, int value)
{

    if (IR_APP_IsLinked(channelNo))
    {
        int index = No2index(channelNo);

        if (g_session[index].pSocket->IsValid())
        {

            char cmdData[256] = {0};

            int cmdLength = zs_CPMakePacket(cmdData,
                                            &value,
                                            COMMAND_APP_SET_NOISEREDUCTION,
                                            CMD_STEM_FROM_PC,
                                            sizeof(int));

            int sendLen = g_session[index].pSocket->Send(cmdData, cmdLength);

            if (sendLen > 0)
            {
                return 1;
            }
        }
    }

    return DEFAULT_RET;
}
int IR_APP_SET_RETICLE(int channelNo, int value)
{

    if (IR_APP_IsLinked(channelNo))
    {
        int index = No2index(channelNo);

        if (g_session[index].pSocket->IsValid())
        {

            char cmdData[256] = {0};

            int cmdLength = zs_CPMakePacket(cmdData,
                                            &value,
                                            COMMAND_APP_SET_RETICLE,
                                            CMD_STEM_FROM_PC,
                                            sizeof(int));

            int sendLen = g_session[index].pSocket->Send(cmdData, cmdLength);

            if (sendLen > 0)
            {
                return 1;
            }
        }
    }

    return DEFAULT_RET;
}
int IR_APP_SET_XCORDINATE(int channelNo, int value)
{

    if (IR_APP_IsLinked(channelNo))
    {
        int index = No2index(channelNo);

        if (g_session[index].pSocket->IsValid())
        {

            char cmdData[256] = {0};

            int cmdLength = zs_CPMakePacket(cmdData,
                                            &value,
                                            COMMAND_APP_SET_XCORDINATE,
                                            CMD_STEM_FROM_PC,
                                            sizeof(int));

            int sendLen = g_session[index].pSocket->Send(cmdData, cmdLength);

            if (sendLen > 0)
            {
                return 1;
            }
        }
    }

    return DEFAULT_RET;
}
int IR_APP_SET_YCORDINATE(int channelNo, int value)
{

    if (IR_APP_IsLinked(channelNo))
    {
        int index = No2index(channelNo);

        if (g_session[index].pSocket->IsValid())
        {

            char cmdData[256] = {0};

            int cmdLength = zs_CPMakePacket(cmdData,
                                            &value,
                                            COMMAND_APP_SET_YCORDINATE,
                                            CMD_STEM_FROM_PC,
                                            sizeof(int));

            int sendLen = g_session[index].pSocket->Send(cmdData, cmdLength);

            if (sendLen > 0)
            {
                return 1;
            }
        }
    }

    return DEFAULT_RET;
}
int IR_APP_SET_GPSENABLE(int channelNo, int value)
{

    if (IR_APP_IsLinked(channelNo))
    {
        int index = No2index(channelNo);

        if (g_session[index].pSocket->IsValid())
        {

            char cmdData[256] = {0};

            int cmdLength = zs_CPMakePacket(cmdData,
                                            &value,
                                            COMMAND_APP_SET_GPSENABLE,
                                            CMD_STEM_FROM_PC,
                                            sizeof(int));

            int sendLen = g_session[index].pSocket->Send(cmdData, cmdLength);

            if (sendLen > 0)
            {
                return 1;
            }
        }
    }

    return DEFAULT_RET;
}
int IR_APP_SET_TRACEENABLE(int channelNo, int value)
{

    if (IR_APP_IsLinked(channelNo))
    {
        int index = No2index(channelNo);

        if (g_session[index].pSocket->IsValid())
        {

            char cmdData[256] = {0};

            int cmdLength = zs_CPMakePacket(cmdData,
                                            &value,
                                            COMMAND_APP_SET_TRACEENABLE,
                                            CMD_STEM_FROM_PC,
                                            sizeof(int));

            int sendLen = g_session[index].pSocket->Send(cmdData, cmdLength);

            if (sendLen > 0)
            {
                return 1;
            }
        }
    }
    return DEFAULT_RET;
}
int IR_APP_SET_PIP(int channelNo, int value)
{

    if (IR_APP_IsLinked(channelNo))
    {
        int index = No2index(channelNo);

        if (g_session[index].pSocket->IsValid())
        {

            char cmdData[256] = {0};

            int cmdLength = zs_CPMakePacket(cmdData,
                                            &value,
                                            COMMAND_APP_SET_PIP,
                                            CMD_STEM_FROM_PC,
                                            sizeof(int));

            int sendLen = g_session[index].pSocket->Send(cmdData, cmdLength);

            if (sendLen > 0)
            {
                return 1;
            }
        }
    }
    return DEFAULT_RET;
}
int IR_APP_SET_DISTANCEENABLE(int channelNo, int value)
{

    if (IR_APP_IsLinked(channelNo))
    {
        int index = No2index(channelNo);

        if (g_session[index].pSocket->IsValid())
        {

            char cmdData[256] = {0};

            int cmdLength = zs_CPMakePacket(cmdData,
                                            &value,
                                            COMMAND_APP_SET_DISTANCEENABLE,
                                            CMD_STEM_FROM_PC,
                                            sizeof(int));

            int sendLen = g_session[index].pSocket->Send(cmdData, cmdLength);

            if (sendLen > 0)
            {
                return 1;
            }
        }
    }

    return DEFAULT_RET;
}

int IR_APP_UPGRADE(int channelNo, char *filePath, FunGetUpgradeProgress funGetUpgradeProgress)
{
    printf("%s", filePath);
    if (IR_APP_IsLinked(channelNo) && filePath)
    {
        int index = No2index(channelNo);
        if (g_session[index].pSocket->IsValid())
        {
            bool upgradeEnd = false;
            FILE *f = fopen(filePath, "rb");
            if (f)
            {
                fseek(f, 0L, SEEK_END);
                long long fileSize = ftell(f);
                long long packetCount = fileSize / MAX_PACKET_SIZE + 1;
                if (fileSize % MAX_PACKET_SIZE == 0)
                {
                    packetCount = fileSize / MAX_PACKET_SIZE;
                }

                fseek(f, 0L, 0);

                unsigned int crc = 0;
                unsigned char data[16] = {0};

                for (long long i = 0; i < fileSize; ++i)
                {
                    if (fread(data, 1, 1, f) > 0)
                    {
                        crc += *data;
                    }
                    else
                    {
                        break;
                    }
                }

                char packet[MAX_PACKET_SIZE + 1] = {0};
                fseek(f, 0L, 0);
                float percentage = 0;
                for (long long i = 0; i < packetCount; ++i)
                {
                    int realSize = fread(packet, 1, MAX_PACKET_SIZE, f);
                    if (realSize <= 0)
                    {
                        break;
                    }

                    //_sessionPrivate.sendUpgradePacket(packet,realSize,crc,i+1,fileSize,packetCount);

                    unsigned int FrameNo = i + 1;
                    unsigned int uDataFrameSize = fileSize;
                    unsigned int uDataFrameTotal = packetCount;

                    char cmdData[2048] = {0};

                    char contentData[2048] = {0};
                    WIFI_FRAME_HEADER *wifiHeader = (WIFI_FRAME_HEADER *)contentData;
                    wifiHeader->uDataType = ((i == 0) ? UPGRADE_FILE_HEADR : UPGRADE_FILE_DATA);
                    wifiHeader->uHdrCRC = 0;
                    wifiHeader->uDataCRC = crc;
                    wifiHeader->uTransFrameHdrSize = sizeof(WIFI_FRAME_HEADER);         //sizeof(WIFI_FRAME_HEADER)
                    wifiHeader->uTransFrameSize = sizeof(WIFI_FRAME_HEADER) + realSize; //sizeof(WIFI_FRAME_HEADER) + Data Size
                    wifiHeader->uTransFrameNo = FrameNo;                                //??????????????????
                    //???????????????
                    wifiHeader->uDataFrameSize = uDataFrameSize;                      //?????????????????????
                    wifiHeader->uDataFrameTotal = uDataFrameTotal;                    //???????????????????????????????????????
                    wifiHeader->uDataFrameCurr = FrameNo;                             //????????????????????????
                    wifiHeader->uDataInFrameOffset = (FrameNo - 1) * MAX_PACKET_SIZE; //???????????????????????????
                    memcpy(wifiHeader->Data, packet, realSize);
                    int cmdLength = zs_CPMakePacket(cmdData,
                                                    wifiHeader,
                                                    COMMAND_APP_UPGRADE,
                                                    CMD_STEM_FROM_PC,
                                                    wifiHeader->uTransFrameSize);
                    bool bSendSuccess = false;
                    for (int times = 0; times < 3; ++times)
                    {
                        /* code */
                        usleep(1000);
                        int retSelect = g_session[index].pSocket->SOCKET_Select(g_session[index].pSocket->Handle(),
                                                                                3000,
                                                                                false);
                        if (retSelect)
                        {
                            int sendLen = g_session[index].pSocket->Send(cmdData, cmdLength);
                            if (sendLen > 0)
                            {
                                bSendSuccess = true;
                                break;
                            }
                            else
                            {
                                printf("%s", "error send error\n");
                                break;
                            }
                        }
                        else
                        {
                            continue;
                        }
                    }
                    if (!bSendSuccess)
                    {
                        printf("%s", "error send failure");
                        break;
                    }

                    int stopFlag = 0;
                    if (funGetUpgradeProgress)
                    {
                        int endFlag = 0;
                        if (FrameNo == uDataFrameTotal)
                        {
                            endFlag = 1;

                            upgradeEnd = true;
                        }

                        float newPercentage = 1.0 * FrameNo / uDataFrameTotal;
                        if (endFlag)
                        {
                            stopFlag = funGetUpgradeProgress(channelNo, newPercentage, endFlag);
                        }
                        else
                        {
                            if ((int)(newPercentage * 100) != (int)(percentage * 100))
                            {
                                stopFlag = funGetUpgradeProgress(channelNo, newPercentage, endFlag);
                            }
                        }
                        percentage = newPercentage;
                    }

                    if(stopFlag)
                    {
                        break;
                    }
                }

                fclose(f);
            }

            if (upgradeEnd)
            {
                return 1;
            }
        }
    }

    return DEFAULT_RET;
}

int IR_APP_REBOOT(int channelNo)
{

    if (IR_APP_IsLinked(channelNo))
    {
        int index = No2index(channelNo);

        if (g_session[index].pSocket->IsValid())
        {

            char cmdData[256] = {0};

            int cmdLength = zs_CPMakePacket(cmdData,
                                            0,
                                            COMMAND_APP_REBOOT,
                                            CMD_STEM_FROM_PC,
                                            0);

            int sendLen = g_session[index].pSocket->Send(cmdData, cmdLength);

            if (sendLen > 0)
            {
                return 1;
            }
        }
    }

    return DEFAULT_RET;
}
