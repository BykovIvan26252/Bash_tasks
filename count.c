#include <stdio.h>
#include <unistd.h>

int main() {
	int c = 0;
	while (1){
		printf("counter = %d\n", c);
		fflush(stdout);
		sleep(1);
		c++;
	}
	return 0;
}
