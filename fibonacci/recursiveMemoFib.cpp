#include <iostream>
#include <vector>
using namespace std;

vector<int> F;

int solve_fib(int n) {

    // If we've reached a "known" n value (0 or 1), update the appropriate index in the
    // tracking vector and return the known value
    if (n <= 1) {
        F[n] = n;
        return n;
    }

    // If not, let's update accordingly
    else {

        // If we HAVE NOT yet solved for the value of n-2, solve for it and update the appropriate
        // index in the tracking vector
        if (F[n-2] == -1) {
            F[n-2] = solve_fib(n-2);
        }

        // If we HAVE NOT yet solved for the value of n-1, solve for it and update the appropriate
        // index in the tracking vector
        if (F[n-1] == -1) {
            F[n-1] = solve_fib(n-1);
        } 

        // Return the sum of the two previously solved indices in our tracking vector
        return F[n-2] + F[n-1];
    }
}

int fib(int n) {

    // Update our tracking vector -> clear it and fill with -1 n times
    F.clear();
    for (int i = 0; i < n; i ++) {
        F.push_back(-1);
    }

    // Solve for n
    return solve_fib(n);
}


int main() {
    cout << fib(7) << endl;
    cout << fib(8) << endl;;
    return 0;
}