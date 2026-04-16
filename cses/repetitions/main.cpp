#include <cstddef>
#include <iostream>
#include <string>

using namespace std;

int main() {
    string input;
    cin >> input;

    size_t max = 0;
    size_t cur = 1;
    for (size_t i = 1; i < input.length(); i++) {
        cur = (input[i] == input[i-1]) ? cur + 1 : 1;
        max = (cur > max) ? cur : max;
    }

    cout << max << "\n";

    return 0;
}