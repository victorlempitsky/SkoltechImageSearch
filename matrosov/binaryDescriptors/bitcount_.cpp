// compile with "gcc bitcount.cpp -lrt -lstdc++"

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main() {
	struct timespec tp;
	clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &tp);
	long time1 = tp.tv_sec*1000 + tp.tv_nsec/1000000;
	
	for(int i=0; i<10; i++) {
		long long n = random()<<32 | random();
		int k = __builtin_popcount(n);
		printf("%lld - %d\n", n, k);
	}
	
	clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &tp);
	long time2 = tp.tv_sec*1000 + tp.tv_nsec/1000000;
	
	printf("%d ms elapsed\n", time2-time1);
	
	printf("Size of long long is %d\n", sizeof(long long));
	
	return 0;
}
