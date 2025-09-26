#include <iostream>
using namespace std;

int main() {
    setlocale(LC_ALL, "rus");

	int i = 0;
	int j = 1;
	cout << "ВВедите номер машины";
	cin >> i;

	if (i < 0) {
		cout << "Введите неотрицательное число" << endl;
	}
	else {
		long long factorial = 1;
	
		while (j <= i) {
			factorial = factorial * j;
			j++;
		}
		cout << "производительность машин" << factorial << endl;
	}

	return 0;
}

