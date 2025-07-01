#define R 4
#include <iostream>
#include <cmath>

using namespace std;

long double f (long double x);

int main()
{

    const int n = 230;
    const long double DELTA_0=1e-10;
    long double x=0.1, x1=0;
    long double xb=x+DELTA_0, xb1=0;
    long double somma = 0;

    for (int i = 1; i<=n; i++)
    {
        x1 = f(x);
        xb1 = f(xb);

        cout << x1 << '\t' << xb1 << '\t';

        somma += log(abs(x1-xb1) / abs(x-xb));

        cout << somma << endl;

        xb1 = x1 + DELTA_0 * copysign(1.0, x1-xb1);  // mantiene direzione della separazione

        x = x1;
        xb = xb1;

    }

    cout << "lambda: " << somma * (1.l/n) << endl;




    return 0;
}

long double f (long double x)
{
    return R * x - R * pow(x, 2);
}
