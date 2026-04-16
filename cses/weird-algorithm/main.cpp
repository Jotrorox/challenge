#include <iostream>

using namespace std;

int main() {
    int input;
    cin >> input;

    cout << input;
    while (input != 1) {
        input = (input % 2 == 0) ? input/2 : (input*3)+1;
        cout << " " << input;
    }

    cout << "\n";

    return 0;
}