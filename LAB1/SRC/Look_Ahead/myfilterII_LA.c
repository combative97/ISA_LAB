#include<stdio.h>
#include<stdlib.h>

#define N 1 /// order of the filter 
#define NB 8  /// number of bits

const int b0 = 53; /// coefficient b0
const int b[N]={53}; /// b array
const int a[N]={-21}; /// a array
const int a1_2 = 441;

/// Perform fixed point filtering assuming direct form II
///\param x is the new input sample
///\return the new output sample
int myfilter(int x)
{
  static int sw[N]; /// w shift register
  static int sw_2[N];
  static int sw_3[N];
  static int first_run = 0; /// for cleaning the shift register
  int i; /// index
  int w, w_2; /// intermediate value (w)
  int y; /// output sample
  int out_mul_a1, out_mul_b1, out_mul_a1_2; /// feed-back and feed-forward results

  /// clean the buffer
  if (first_run == 0)
  {
    first_run = 1;
    for (i=0; i<N; i++)
      sw[i] = 0;
      sw_2[i] = 0;
      sw_3[i] = 0;
  }

  /// compute feed-back and feed-forward
  out_mul_a1 = 0;
  out_mul_a1_2 = 0;
  out_mul_b1 = 0;
  for (i=0; i<N; i++)
  {
    out_mul_a1 -= (sw[i]*a[i]) >> (NB);
    out_mul_a1_2 += (sw_3[i]*a1_2) >> (2*NB);
    out_mul_b1 += (sw_2[i]*b[i]) >> (NB);
  }

  /// compute intermediate value (w) and output sample
  w = x + out_mul_a1;
  w_2 = w + out_mul_a1_2;
  y = (w_2*b0) >> (NB);
  y += out_mul_b1;

  /// update the shift register
  for (i=N-1; i>0; i--)
    sw[i] = sw[i-1];
    sw_2[i] = sw_2[i-1];
    sw_3[i] = sw_3[i-1];
  sw[0] = w;
  sw_2[0] = w_2;
  sw_3[0] = sw_2[N];
 
  return y;
}

int main (int argc, char **argv)
{
  FILE *fp_in;
  FILE *fp_out;

  int x;
  int y;

  /// check the command line
  if (argc != 3)
  {
    printf("Use: %s <input_file> <output_file>\n", argv[0]);
    exit(1);
  }

  /// open files
  fp_in = fopen(argv[1], "r");
  if (fp_in == NULL)
  {
    printf("Error: cannot open %s\n");
    exit(2);
  }
  fp_out = fopen(argv[2], "w");

  /// get samples and apply filter
  fscanf(fp_in, "%d", &x);
  do{
    y = 2*myfilter(x);
    fprintf(fp_out,"%d\n", y);
    fscanf(fp_in, "%d", &x);
  } while (!feof(fp_in));

  fclose(fp_in);
  fclose(fp_out);

  return 0;

}
