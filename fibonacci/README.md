# A few solutions to the classic Fibonacci Problem

## Recursive Solution - C++
The code in [Recursive Solution](recursiveFib.cpp) has the "classic", un-optimized recursive solution. We define a function called `fib(n)` which calls itself recursively until the input is less than or equal to `1`, upon which the input value is returned. This solution requires approximately O(n²) time and O(n²) space as it performs excessive recursive calls (i.e. the function is called with the same input many times over),

## Iterative Solution - C++
The code for the [Iterative Solution](iterativeFib.cpp) solves the Fibonacci problem using a for loop and some "tracking" variables to save on the time and space required by the [Recursive Solution](recursiveFib.cpp). While the [Recursive Solution](recursiveFib.cpp) works "backwards" (i.e. starting at `n` and decreasing), the [Iterative Solution](iterativeFib.cpp) works "forwards". We utilize two variables, `v1` and `v2`, which store the previous two numbers in the Fibonacci series, and a variable `s` which tracks the current sum. With each loop, we update the values accordingly until we reach `n`, then we can return the sum. This solution runs in O(n) time and requires O(1) space since we initialize the same number of variables to help us solve the problem, regardless of `n`. 

## Recursive Solution with Memoization (record keeping) - C++
Tracing the calls of the [Recursive Solution](recursiveFib.cpp) shows we're calling the `fib(n)` function _many_ times with the same value of `n` - if we can store the result of `fib(n)` for each new value of `n`, we don't have to call it the next time, we can just recall the stored solution and avoid excessive calls - this is done using ["memoization"](recursiveMemoFib.exe).  
We'll define a vector for tracking the results of `fib(n)`, which will be reset and updated for each new call. The initial values will all be -1, so we can easily tell if we've solved for that value yet or not. This solution runs in O(n) time since we're only calling `fib(n)` n times, and requires O(n) space since we initialize a vector of length n to help us solve this problem.

## Recusrive Solution with Memoization (Agent Cache) - Elixir
The [FibSolver](/fib_solver/) application is a pretty bare-bones OTP(esque) implementation of the C++ memoization solution. There are two modules:
1. [FibSolver.Cache](/fib_solver/lib/cache.ex) - This is initialized with the results for `fib(0)` and `fib(1)` as a map. The `handle_call` callback returns cached solutions, and the asynchronous `handle_cast` callback stores  solutions.
2. [FibSolver.Calculator](/fib_solver/lib/calculator.ex) - This is the logic driver and "client-facing" module. The `solve_fib/1` function checks if a solution has already been stored in the cache - if so it simply returns that value. If it is _not_ previously calculated, the function will recursively call itself for `solve_fib(n-1)` and `solve_fib(n-2)`, storing results as it goes. Since `solve_fib(n-2)` comes _after_ `solve_fib(n-1)` in the recursive call, we are almost guaranteed that the answer for `solve_fib(n-2)` has already been calculated and exists in the cache.  
#### Usage:
- Start the application with `iex -S mix`
- Calculate Fibonacci values using `FibSolver.Calculator.solve_fib(n)`  
Since this is a bare-bones implementation, there is very little error handling and no unit test. This may be expanded on in the future by using a GenServer worker pool for the `Calculator` module.