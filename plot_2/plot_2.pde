import grafica.*;

final int n = 10000;
final double DELTA_0 = 1e-10;

final double R_Iniziale = 3;
final double R_Finale = 4;
final double passo = 0.0005;

GPlot plot;
GPointsArray points;
GPointsArray linea;

void setup() {
  size(1000, 1000);
  
  linea = new GPointsArray();
  linea.add(3, 0);
  linea.add(4, 0);
  
  // Initialize plot
  plot = new GPlot(this);
  plot.setPos(0, 0);
  plot.setDim(800, 800);
  plot.getXAxis().setAxisLabelText("R");
  plot.getYAxis().setAxisLabelText("λ");
  plot.setXLim(3.0, 4.0);  // Set range for x-axis
  plot.addLayer("linea", linea);
  plot.getLayer("linea").setLineColor(200);
  plot.activatePointLabels();


  // Set axis ticks
  plot.getXAxis().setNTicks(10);
  plot.getYAxis().setNTicks(10);

  // Calculate Lyapunov exponents and add to points
  points = new GPointsArray();
  double R = R_Iniziale;
  
  while (R <= R_Finale) {
    double x = 0.1, x1 = 0;
    double xb = x + DELTA_0, xb1 = 0;
    double somma = 0;

    for (int i = 1; i <= n; i++) {
      x1 = f(x, R);
      xb1 = f(xb, R);

      somma += Math.log(Math.abs(x1 - xb1) / Math.abs(x - xb));
      xb1 = x1 + DELTA_0 * Math.copySign(1.0, x1 - xb1);

      x = x1;
      xb = xb1;
    }

    somma /= n;
    points.add((float) R, (float) somma);

    R += passo;
  }

  // Apply points to plot
  plot.setPoints(points);

  // Disable red dots
  plot.getMainLayer().setPointSize(0);  // Hides default point markers
  plot.getLayer("linea").setPointSize(0);

  // Optional: draw a smooth curve instead of dots
  // plot.getMainLayer().setDrawLines(true);
  // plot.getMainLayer().setDrawPoints(false);
  
  background(255);
  plot.defaultDraw();
  
  save("plot.png");
}

double f(double x, double R) {
  return R * x - R * x * x;
}
