#include <stdio.h>
#include <stdlib.h>

int main(int argc, char* argv[]){

	setuid(0);
	char cmd[256];

	sprintf(cmd, "./mssetting.sh %s %s %s", argv[1], argv[2], argv[3]);
	system(cmd);

	return 0;
}
