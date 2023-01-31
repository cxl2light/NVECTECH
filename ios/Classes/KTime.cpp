#include "KTime.h"

#include <sys/time.h>

#include <time.h>
#include"stdio.h"


char* KTime::getDateTime()
{
	static char dataTime[256] = {0};

	time_t now ;

	struct tm *tm_now ;

	time(&now) ;

	tm_now = localtime(&now) ;

	sprintf(dataTime,"now datetime: %d-%d-%d %d:%d:%d\n",
		tm_now->tm_year+1900, tm_now->tm_mon+1, tm_now->tm_mday, 
		tm_now->tm_hour, tm_now->tm_min, tm_now->tm_sec) ;

	return dataTime;

}
