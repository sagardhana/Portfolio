#include "iostream"
#include "ctime"
#include "cstdlib"

using namespace std;
void initialize(float *array, int n);
void smooth(float* x, float* y, int n, int a, int b, int c);
void count(float* array, int n, float t, int &result);

int main(void)
{
    float a = 0.05, b  = 0.1,c= 0.4,t = 0.1;
    float timer_allocx, timer_allocy,timer_init, timer_smooth, timer_countx, timer_county;
    float *x,*y;   
    int n = 16386, resultx = 0, resulty = 0;
    

    timer_allocy = (float)clock();
    y = new float[n*n];
    timer_allocy =((float)clock()-timer_allocy)/(float)CLOCKS_PER_SEC; 

    timer_allocx = (float)clock();
    x = new float[n*n];
    timer_allocx =((float)clock()-timer_allocx)/(float)CLOCKS_PER_SEC; 
   
    timer_init =(float) clock(); 
    initialize(x,n);
    timer_init =((float)clock()-timer_init)/(float)CLOCKS_PER_SEC; 

    timer_smooth =(float) clock(); 
    smooth(x,y,n,a,b,c);
    timer_smooth =((float)clock()-timer_smooth)/(float)CLOCKS_PER_SEC; 

    timer_countx =(float) clock(); 
    count(x,n,t,resultx);    
    timer_countx =((float)clock()-timer_countx)/(float)CLOCKS_PER_SEC; 

    timer_county =(float) clock(); 
    count(y,n,t,resulty);
    timer_county =((float)clock()-timer_county)/(float)CLOCKS_PER_SEC; 

    cout<<"Total number of elements in a row/column of an array: "<<n<<"\n";
    cout<<"Total number of inner elements in a column/row of an array: "<<(n-2)<<"\n";
    cout<<"Total number of elements in an array: "<<n*n<<"\n";
    cout<<"Total number of inner elements in an array: "<<(n-2)*(n-2)<<"\n";
    cout<<"total number of bytes that are used by one array: "<<n*n*sizeof(float)<<"bytes\n";
    
    cout<<"Threshold: "<<t<<" \n";
    cout<<"Smoothing constants: a="<<a<<", b="<<b<<", c="<<c<<" \n";
    cout<<"Number of elements below threshold in x: "<< resultx<< "\n";
    cout<<"Fraction of elements bellow threshold in x: "<<(float)resultx/(n*n)<<" \n";
    cout<<"Number of elements below threshold in y: "<< resulty<< "\n";
    cout<<"Fraction of elements bellow threshold in y: "<<(float)resulty/(n*n)<<" \n";


    cout<<"Time take to allocate array x: "<<timer_allocx<<" seconds\n";    
    cout<<"Time take to allocate array y: "<<timer_allocy<<" seconds\n";    
    cout<<"Time taken  to initialize array x: "<<timer_init<<" seconds\n";
    cout<<"Time taken to run smoothing function: "<<timer_smooth<<" seconds\n";
    cout<<"Time taken to count array x values less than threshold: "<<timer_countx<<" seconds\n";
    cout<<"Time taken to count array y values less than threshold: "<<timer_county<<" seconds\n";
    
}


void initialize(float *array, int n)
{

    for(int i =0; i<n; i++)
    {
	for(int j =0; j<n;j++)
	{
            array[i*n+j] = random()/(float)RAND_MAX;
	}
    }
}

void smooth(float* x, float* y, int n, int a, int b, int c)
{

    for(int i =1; i < n -1 ; i++)
    {
        for(int j =1; j<n-1; j++)
        {
                 y[i,j] = a*(x[(i-1)+n*(j-1)] + x[(i-1)*n+(j+1)] + x[(i+1)*n+(j-1)] + x[(i+1)*n+(j+1)]) + b*(x[(i-1)*n+(j+0)] + x[(i+1)*n+(j+0)] + x[(i+0)*n+(j-1)]  + x[(i+0)*n+(j+1)]) + c*x[(i+0)*n+(j+0)];
        }
    }


}

void count(float* array, int n, float t, int& result)
{

   int count =0;

   for(int i = 1; i <n-1; i++)
   {
        for(int j = 1; j< n-1; j++)
        {
           if(array[i*n+j] < t)
           {
             count++;
           }
        }


   }
result = count;
}
