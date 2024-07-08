#include <stdio.h>
#include <stdint.h>

uint32_t doubleToFixedPoint(double num) {
    return (uint32_t)(num * (1 << 16));
}

void printBinary(uint32_t num) {
    printf("    Binary: [");
    for (int i = 31; i >= 0; i--) {
        printf("%d", (num >> i) & 1);
    }
    printf("]\n");
}

double power(double base, int exponent) {
    double result = 1.0;
    for (int i = 0; i < exponent; ++i) {
        result *= base;
    }
    return result;
}

int main(){
    double X=0;
    double Y=0;
    int K=0;
    int iterations=0;

    printf("Insert the X value:");
    scanf("%lf", &X);

    printf("Insert the K value:");
    scanf("%d", &K);

    printf("\nHow many times do you want to iterate?");
    scanf("%d", &iterations);

    for(int i=0;i<iterations;i++){

        Y= (X/ power(2,K))+ Y - Y/power(2,K);

        printf("\nY: %.16lf\t %.0lf", Y, Y* power(2,16));

        printBinary(doubleToFixedPoint(Y));
    }

    return 0;
}