#include <iostream>
#include <climits>
#include <cmath>
#include <string>
using namespace std;

#define float_SI "01001011100000000000000000000000"
#define float_SP "00000000000000000000000000000001"
#define float_LI "01111111011111111111111111111111"

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
		return char(dec - 10 + 'A');
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

string floattobinary(float f){
	if (f == 0){
		return "00000000000000000000000000000000";
	}

	string sign = "";
	string exp = "";
	string sig = "";
	if (f >= 0){
		sign = "0";
	} else {
		sign = "1";
	}
	f = abs(f);

	int dec_exp = floor(log2(f))+127;
	exp = decimalToBinary(dec_exp).substr(24,8);

	sig = "";
	float curr_pow = float(pow(2,dec_exp-127));
	f -= curr_pow;
	curr_pow /= 2.;
	while(sig.length() < 23){
		if (f >= curr_pow){
			sig += '1';
			f -= curr_pow;
		} else{
			sig += '0';
		}
		curr_pow = curr_pow/2.;
	}
	return sign + exp + sig;
}

int main(){
	printf("Enter F or LI or SP or SI or Q\n");
	while(true){
		string input = "";
		cin >> input;

		if (input == "F"){
			float dec;
			cin >> dec;
			cout << binarytohex(floattobinary(dec)) << endl;
		} else if (input == "LI"){
			cout << binarytohex(float_LI) << endl;
		} else if (input == "SI"){
			cout << binarytohex(float_SI) << endl;
		} else if (input == "SP"){
			cout << binarytohex(float_SP) << endl;
		} else if (input == "Q"){
			break;
		} else{
			cout << "Invalid Input\n";
		}
	}
}