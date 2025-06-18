float pxAscisse;
float pxOrdinate;
float y_offset;

final int n = 10000;
final double DELTA_0=1e-10;

final double R_Iniziale = 3;
final double R_Finale = 4;
final double passo = 0.000001;

double R_Precedente = R_Iniziale;
double lambda_Precedente = 0;

PGraphics pg;

void setup()
{
    size (1000, 1000);
    
    pg = createGraphics(35000, 28000);
    pg.beginDraw();
    pg.background(255);
    pg.translate(0, pg.height);
    pg.scale (1, -1);
    
    pxAscisse = pg.width / (float)(R_Finale - R_Iniziale); 
    pxOrdinate = (pg.height * 0.75f) / 3.0f;
    y_offset = (pg.height * 13)/16 /*height / 2.0f*/;
  
    double R = R_Iniziale;
    
    while (R<=R_Finale)
    {
      
      double x=0.1, x1=0;
      double xb=x+DELTA_0, xb1=0;
      double somma = 0;
  
      for (int i = 1; i<=n; i++)
      {
          x1 = f(x, R);
          xb1 = f(xb, R);
  
          somma += Math.log(Math.abs(x1-xb1) / Math.abs(x-xb));
  
          xb1 = x1 + DELTA_0 * Math.copySign(1.0, x1-xb1);  // mantiene direzione della separazione
  
          x = x1;
          xb = xb1;
  
      }
      
      somma /= n;
      
      pg.line(
          (float)((R_Precedente - R_Iniziale) * pxAscisse), 
          (float)(lambda_Precedente * pxOrdinate + y_offset), 
          (float)((R - R_Iniziale) * pxAscisse), 
          (float)(somma * pxOrdinate + y_offset)
        );
      
      R_Precedente = R;
      lambda_Precedente = somma;
      
      R+=passo;
      
      //println (R);
      
    }
    
    pg.endDraw();
    
    pg.save("plot-#####.png");
    
    color (0, 255, 0);
    
    rect (0, 0, width, height);
}


double f (double x, double R) {
    return R * x - R * x * x;
}
