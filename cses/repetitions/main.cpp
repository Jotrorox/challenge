#include <cstddef>
#include <iostream>
#include <string>

using namespace std;

int main() {
    string input;
    cin >> input;

    size_t max = 1;
    size_t cur = 1;
    for (size_t i = 1; i < input.length(); i++) {
        if(input[i] == input[i-1]){
            cur ++;
        }else{
            cur = 1;
            
            size_t edge = i+max - 1;
            if(edge <= input.length()){

                if (input[edge] != input[edge-1]){
                    i = edge;
                }
            }
            
        }
        if(cur > max){
            max = cur;
        }
    }

    cout << max << "\n";

    return 0;
}