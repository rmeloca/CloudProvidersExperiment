#include <stdio.h>
#include <stdlib.h>

int main (){
	FILE* file;
	char str = ' ';
	int i, j;

	file = fopen("155", "w");
	for (i = 0; i < 155000; i++) {
		fwrite(&str, sizeof(str), 1, file);
	}
	fclose(file);

	file = fopen("310", "w");
	for (i = 0; i < 310000; i++) {
		fwrite(&str, sizeof(str), 1, file);
	}
	fclose(file);

	file = fopen("620", "w");
	for (i = 0; i < 620000; i++) {
		fwrite(&str, sizeof(str), 1, file);
	}
	fclose(file);

	file = fopen("1240", "w");
	for (i = 0; i < 1240000; i++) {
		fwrite(&str, sizeof(str), 1, file);
	}
	fclose(file);
	
	file = fopen("2480", "w");
	for (i = 0; i < 2480000; i++) {
		fwrite(&str, sizeof(str), 1, file);
	}
	fclose(file);
	return 0;
}