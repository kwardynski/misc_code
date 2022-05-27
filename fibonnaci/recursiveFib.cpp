#include <iostream>
using namespace std;

int fib(int n) {
    if (n <= 1) {
        return n;
    }
    else {
        return fib(n-1) + fib(n-2);
    }
}


int main() {
    cout << fib(8) << endl;
    cout << fib(7) << endl;
    return 0;
}