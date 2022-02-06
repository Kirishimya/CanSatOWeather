public class CurrentConditionsDisplay implements Display, Observers{
  float navL = width, navH = 9*height/10, collum = 160;
  float atmInPascal = 101325.0;
  String displayName  = "Condições Atuais";
  Subject mySub;
  public CurrentConditionsDisplay(Subject sbj){
    this.mySub = sbj;
  }
  public void display(float temp, float hum, float pres){
   // pushStyle();
    //PFont mono;
    //mono = createFont("andalemo.ttf", 128);
    fill(255);
    textSize(16);
    text("Temperatura: "+temp+"°C", width-width*0.8, 3*navH/2);
    text("Humidade: "+hum+"%", width-width*0.8, 4*navH/2);
    text("Pressão: "+pres+" pascal", width-width*0.8, 5*navH/2);
    //popStyle();
    pushStyle();
    //temperature
    fill(((255*(temp/100.0)+100)%255),255,(255-255*(temp/100.0))%255);
    rect(0, height, width/3, -collum*(temp/100.0));
    fill(0,0,0,0);
    stroke(255);
    rect(0, height, width/3, -this.collum);
    fill(255);
    textSize(20);
    text("°C", (width/3)/2-10, height-this.collum-20);
    textSize(10);
    text("100_________", (width/3)/2-10, height-this.collum);
    text(" 50_________", (width/3)/2-10, height-this.collum*0.5);
    text(" 30_________", (width/3)/2-10, height-this.collum*0.3);
    text(" 25_________", (width/3)/2-10, height-this.collum*0.25);
    //teperature
    //humidity
    fill(255*(hum/100.0),255*(hum/100.0),255);
    rect(width/3, height, width/3, -this.collum*(hum/100.0));
    fill(0,0,0,0);
    stroke(255);
    rect(width/3, height, width/3, -this.collum);
    fill(255);
    textSize(20);
    text("%(umi)", 3*(width/3)/2-30, height-this.collum-20);
    textSize(10);
    text("100_________", 3*(width/3)/2-10, height-this.collum);
    text(" 50_________", 3*(width/3)/2-10, height-this.collum*0.5);
    text(" 30_________", 3*(width/3)/2-10, height-this.collum*0.3);
    text(" 25_________", 3*(width/3)/2-10, height-this.collum*0.25);
    //humidity
    //pressure
    fill(160*(pres/atmInPascal),190*(pres/atmInPascal),200*(pres/atmInPascal));
    rect(2*width/3, height, width/3, -this.collum*(pres/atmInPascal));
    fill(0,0,0,0);
    stroke(255);
    rect(2*width/3, height, width/3, -this.collum);
    fill(255);
    textSize(20);
    text("%(atm)", 4*(width/3)/2+10, height-this.collum-20);
    //fill(50, 50, 100);
    textSize(10);
    text("100_________", 5*(width/3)/2-10, height-this.collum);
    text(" 50_________", 5*(width/3)/2-10, height-this.collum*0.5);
    text(" 30_________", 5*(width/3)/2-10, height-this.collum*0.3);
    text(" 25_________", 5*(width/3)/2-10, height-this.collum*0.25);
    //pressure
    popStyle();
    
  }
  public void update(float temp, float hum, float pres){
    this.display(temp, hum, pres);
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
