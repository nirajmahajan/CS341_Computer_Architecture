#include <iostream>
#include <climits>
#include <cmath>
#include <string>
using namespace std;

string complement(string a){
	string ans = "";
	for(int i = a.length()-1; i >= 0; i--){
		if (a[i] == '0'){
			ans += '1';
		} else{
			ans += '0';
		}
	}
	return ans;
}

string add1(string a){
	bool carry = true;
	string ans = "";
	for(int i = a.length()-1; i >= 0; i--){
		if (a[i] == '0'){
			if (carry) {
				ans += '1';
				carry = false;
			} else{
				ans += '0';
			}
		} else{
			if (carry){
				ans += '0';
				carry = true;
			} else{
				ans += '1';
			}
		}
	}
	return ans;
}

string decimalToBinary(int decimal){
	string ans;
	if (decimal >= 0){
		ans = '0';
		int curr_pow = int(pow(2,30));
		for(int i = 0; i < 31; i++){
			if (decimal >= curr_pow){
				ans += '1';
				decimal -= curr_pow;
			} else{
				ans += '0';
			}
			curr_pow = curr_pow/2;
		}
	} else{
		decimal = decimal + INT_MAX + 1;
		ans = '1';
		int curr_pow = int(pow(2,30));
		for(int i = 0; i < 31; i++){
			if (decimal >= curr_pow){
				ans += '1';
				decimal -= curr_pow;
			} else{
				ans += '0';
			}
			curr_pow = curr_pow/2;
		}

	}
	return ans;
}

char binarytohex_single(string bin){
	int pow = 1;
	int dec = 0;
	for(int i = 3; i >= 0; i--){
		if (bin[i] == '1') {
			dec += pow;
		}
		pow *= 2;
	}
	if (dec > 9){
		return char(dec - 10 + 'a');
	} else{
		return char(dec + '0');
	}
}

string binarytohex(string binary){
	string ans = "";
	for(int i = 0; i <= 28; i += 4){
		ans += binarytohex_single(binary.substr(i,4));
	}
	return ans;
}

int main(){
	while(true){
		string input = "";
		cin >> input;

		if (input == "I"){
			int dec;
			cin >> dec;
			cout << binarytohex(decimalToBinary(dec)) << endl << endl;
		} else if (input == "LI"){
			cout << binarytohex(decimalToBinary(INT_MAX)) << endl << endl;
		} else if (input == "SI"){
			cout << binarytohex(decimalToBinary(INT_MIN)) << endl << endl;
		} else if (input == "Q"){
			break;
		} else{
			cout << "Invalid Input\n";
		}
	}
}