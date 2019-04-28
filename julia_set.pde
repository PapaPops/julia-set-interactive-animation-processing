int maxIterations = 100;
float treshold = 16;
float real_c = 0.285 , imaginary_c = 0.01 ;


int iterator(float real_z, float imaginary_z)
{
  for(int i = 0; i < maxIterations; i++)
   {
     float previous_imaginary = imaginary_z, previous_real = real_z;
     
     real_z = previous_real * previous_real - previous_imaginary * previous_imaginary + real_c;
     imaginary_z = 2 * previous_real * previous_imaginary + imaginary_c;
     if(real_z+imaginary_z > treshold)
     {
       return i;
     }
   }
   
   return maxIterations;
}
//helper method
float mapto(float x, float mina, float maxa, float minb, float maxb)
{
  float result = x;
  result -= mina;
  float intervalA = maxa-mina;
  float intervalB = maxb-minb;
  
  result/= intervalA;
  result *= intervalB;
  
  result += minb;
  return result;
}

void setup()
{
  size(800,800);
}

void draw()
{
  
  real_c = mapto((float)mouseY,0,width,-2,2);
  imaginary_c = mapto((float)mouseX,0,height,-2,2);
  loadPixels();
  for(int i = 0; i < height; i++)
    {
      for(int j = 0; j < width; j++)
      {
        float real_z = mapto(j,0,width,-2,2);
        float imaginary_z = mapto(i,0,height,-2,2);
        int result = (int)iterator(real_z,imaginary_z);
        
        pixels[j+i*width] = color((int)mapto(result,0,maxIterations,0,255));
      }
    }
  updatePixels();
}
