public class NavBarDisplay implements Display, Observers{
  float navL = width, navH = 9*height/10
  ;
  boolean selEn = false;//display selection
  String displayName = "Barra De Navegação";
  Observers[] Dlist;
  Subject mySub;
  int i=0;//current display
  public NavBarDisplay(Observers[] disList, Subject sbj){
    this.Dlist = disList;
    this.mySub = sbj;
  }
  public void display(float temp, float hum, float pres){
    //pushStyle();
    //PFont mono;
    //mono = createFont("andalemo.ttf", 128);
    textSize(20);
    fill(100, 100, 255);
    rect(0,0,width,navH);
    fill(255);
    text(this.Dlist[i].getDisplayName(), width-width*0.8, navH/2);
    //popStyle();
    //this.selectDisplay();
  }
  public int selectDisplay(){
    //hide||show selection
    this.display(0,0,0);
    if(this.selEn){
      textSize(16);
      for(int j=0;j<Dlist.length;j++){
        pushStyle();
        fill(200, 0, 200);
        if(
           mouseX>0&&mouseX<width&&
           mouseY>((j+1)*navH-navH)&&mouseY<((j+1)*navH)
           ){
          fill(50, 60, 200);
          rect(0, (j+1)*navH-navH, width, navH);
        }
        rect(0, (j+1)*navH-navH, width, navH);
        stroke(255);
        line(0, (j+1)*navH, width, (j+1)*navH);
        popStyle();
        text(this.Dlist[j].getDisplayName(), width-(8*width/10), (j*1+(1+j))*navH/2);
        if(mousePressed==true&&
           mouseX>0&&mouseX<width&&
           mouseY>((j+1)*navH-navH)&&mouseY<((j+1)*navH)){
          this.i = j;
          this.selEn = !selEn;
        }
      }
    }
    //pushStyle();
      fill(50,0,255);
      float slx = width-(9*width/10), sly = (9*width/10), sld=width/9;
      ellipse(slx, sly, sld, sld);
      fill(255,0,155);
      ellipse(slx, sly, sld/1.5, sld/1.5);
    //popStyle();
    
    if(mousePressed==true&&
    ((mouseX-slx)*(mouseX-slx)+(mouseY-sly)*(mouseY-sly)<(sld/2)*(sld/2))){
      selEn = !selEn;
    }
    
    return this.i;
  }
  public void update(float temp, float hum, float pres){
    //this.display(temp, hum, pres);
    //this.selectDisplay();
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
