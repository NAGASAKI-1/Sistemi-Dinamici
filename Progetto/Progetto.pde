final int iterazioni = 1200;
final int Xpx = 1;
final int Ypx = 25;
final float R = 3.95;
final float r = 0.1;
float tp = 0.1;
float t;

void setup ()
{
  size (1200, 600);
  background (255);
  
  translate (0, height);
  scale (1, -1);
  
  
  for (int i = 0; i<iterazioni; i++)
  {
    t = R * tp * (1 - r * tp);
    
    line (i * Xpx, tp * Ypx, (i+1) * Xpx, t * Ypx);
    
    tp = t;
  }
}

/*void draw ()
{
  
  
}*/
