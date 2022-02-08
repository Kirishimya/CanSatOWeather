public class ForecastDisplay implements Display, Observers{
  float navL = width, navH = 9*height/10, collum = 160;
  float atmInPascal = 101325.0, lowestTemp = 100, highestTemp = 0;
  String displayName  = "Simples Previsão";
  Subject mySub;
  public ForecastDisplay(Subject sbj){
    this.mySub = sbj;
  }
  public void display(float temp, float hum, float pres, float alt){
   // pushStyle();
    //PFont mono;
    //mono = createFont("andalemo.ttf", 128);
    this.lowestTemp = ((temp<lowestTemp)?temp:lowestTemp);
    this.highestTemp = ((temp>highestTemp)?temp:highestTemp);
    fill(255);
    textSize(16);
    text("O dia está com"+temp+"°C e\na menor temperatura registrada\né "+this.lowestTemp+"ºC\ne a maior é"+this.highestTemp+"°C", width-width*0.8, 3*navH/2);
    text("\n\n\nHumidade: "+hum+"%", width-width*0.8, 4*navH/2);
    text("\n\n\nPressão: "+pres/this.atmInPascal+" atm.\n"+((pres/this.atmInPascal)>0.8?("Perfeito para um céu limpo."):("Pode ter algumas nuvens.")), width-width*0.8, 5*navH/2);
    //popStyle();
    pushStyle();
    //temperature
    fill(((255*(temp/100.0)+100)%255),255,(255-255*(temp/100.0))%255);
    rect(0, height, width/4, -collum*(temp/100.0));
    fill(0,0,0,0);
    stroke(255);
    rect(0, height, width/4, -this.collum);
    fill(255);
    textSize(20);
    text("°C", (width/4)/2-10, height-this.collum-20);
    textSize(10);
    text("100___", (width/4)/2-10, height-this.collum);
    text(" 50___", (width/4)/2-10, height-this.collum*0.5);
    text(" 30___", (width/4)/2-10, height-this.collum*0.3);
    text(" 25___", (width/4)/2-10, height-this.collum*0.25);
    //teperature
    //humidity
    fill(255*(hum/100.0),255*(hum/100.0),255);
    rect(width/4, height, width/4, -this.collum*(hum/100.0));
    fill(0,0,0,0);
    stroke(255);
    rect(width/4, height, width/4, -this.collum);
    fill(255);
    textSize(20);
    text("%(umi)", 4*(width/4)/2-30, height-this.collum-20);
    textSize(10);
    text("100___", 4*(width/4)/2-10, height-this.collum);
    text(" 50___", 4*(width/4)/2-10, height-this.collum*0.5);
    text(" 30___", 4*(width/4)/2-10, height-this.collum*0.3);
    text(" 25___", 4*(width/4)/2-10, height-this.collum*0.25);
    //humidity
    //pressure
    fill(160*(pres/atmInPascal),190*(pres/atmInPascal),200*(pres/atmInPascal));
    rect(2*width/4, height, width/4, -this.collum*(pres/atmInPascal));
    fill(0,0,0,0);
    stroke(255);
    rect(2*width/4, height, width/4, -this.collum);
    fill(255);
    textSize(20);
    text("%(atm)", 4*(width/4)/2+10, height-this.collum-20);
    //fill(50, 50, 100);
    textSize(10);
    text("100___", 5*(width/4)/2-10, height-this.collum);
    text(" 50___", 5*(width/4)/2-10, height-this.collum*0.5);
    text(" 30___", 5*(width/4)/2-10, height-this.collum*0.3);
    text(" 25___", 5*(width/4)/2-10, height-this.collum*0.25);
    //pressure
    //height
    fill(160*(alt/300),190*(alt/300),200*(alt/300));
    rect(3*width/4, height, width/4, -this.collum*(alt/300));
    fill(0,0,0,0);
    stroke(255);
    rect(3*width/4, height, width/4, -this.collum);
    fill(255);
    textSize(20);
    text("%(3hm)", 5*(width/4)/2+10, height-this.collum-20);
    //fill(50, 50, 100);
    textSize(10);
    text("100___", 7*(width/4)/2-10, height-this.collum);
    text(" 50___", 7*(width/4)/2-10, height-this.collum*0.5);
    text(" 30___", 7*(width/4)/2-10, height-this.collum*0.3);
    text(" 25___", 7*(width/4)/2-10, height-this.collum*0.25);
    //height
    popStyle();
    
  }
    
  }
  public void update(float temp, float hum, float pres, float alt){
    this.display(temp, hum, pres, alt);
  }
  public String getDisplayName(){
    return this.displayName;
  }
  public void requestRegister(Subject sbj){
    sbj.registerObserver(this);
  }
  public void requestRemove(Subject sbj){
    sbj.removeObserver(this);
  }
}
