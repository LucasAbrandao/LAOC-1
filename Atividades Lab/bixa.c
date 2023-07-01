#include <stdio.h>

int main()
{
    int n = 5;
    int v[] = {1,2,3,4,5};

    int max = v[n-1];
    int min = v[n-1];
    
    while (n) {
        n--;
        if (v[n] < min) min = v[n];
        if (v[n] > max) max = v[n];
    }
}
