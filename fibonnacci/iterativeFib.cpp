#include <iostream>
using namespace std;

int fib(int n) {
    int v1 = 0;     // first value in the fibonacci series
    int v2 = 1;     // second value in the fibonacci series
    int s;          // variable for tracking the current sum 

    // If we're given 1 or 0, no need to perform any computation, just return that number
    if (n <= 1) {
        return n;
    }

    // If we're given a value greater than 1, we need to compute the series
    // We can start from i=2 in this case (since i=0 and i=1 are known and covered by
    // the if statement above)
    for (int i = 2; i <= n; i++) {
        s = v1 + v2;    // update the sum    
        v1 = v2;        // "increment" the v1 variable
        v2 = s;         // "increment" the v2 variable
    }
    return s;
}


int main() {
    cout << fib(8) << endl;
    cout << fib(7) << endl;
    return 0;
}