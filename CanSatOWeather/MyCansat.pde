
public class MyCansat implements Subject{
  //dht
  float h; 
  float t;
  //bmp
  float p;
  float alt;
  //mpu
  float accX;
  float accY;
  float accZ;
  float gyroX;
  float gyroY;
  float gyroZ;
  List<Observers> observers = new ArrayList<Observers>();
  public MyCansat(){}
  public void registerObserver(Observers ob){
    observers.add(ob);
  }
  public void removeObserver(Observers ob){
      observers.remove(ob);
  }
  public void notifyObservers(String[] data, int i){
    this.setMeasurements(data);
    for(Observers o: observers){
      o.update(this.t, this.h, this.p);
    }
    fill(0);
    rect(0, 0, width, height);
    observers.get(i).update(this.t, this.h, this.p);
  }
  public void setMeasurements(String[] m){
    
    if(m!=null){   
    float h=float(trim(m[0]));
    float t=float(trim(m[1]));
    float p=float(trim(m[2]));
    float alt=float(trim(m[3]));
    float accX=float(trim(m[4]));float accY=float(trim(m[5]));float accZ=float(trim(m[6]));
    float gyroX=float(trim(m[7]));float gyroY=float(trim(m[8]));float gyroZ=float(trim(m[9]));
    this.measurementsChanged( h,  t,  p,  alt,  accX,  accY,  accZ,  gyroX,  gyroY,  gyroZ);
    }
  }
  public void measurementsChanged(float h, float t, float p, float alt, float accX, float accY, float accZ, float gyroX, float gyroY, float gyroZ){
    //if(this.h!=h||this.t!=t||this.p!=p||this.alt!=alt
    //  ||this.accX!=accX||this.accY!=accY||this.accZ!=accZ
    //  ||this.gyroX!=gyroX||this.gyroY!=gyroY||this.gyroZ!=gyroZ){
        
        this.h=h;
        this.t=t;
        this.p=p;
        this.alt=alt;
        this.accX=accX;this.accY=accY;this.accZ=accZ;
        this.gyroX=gyroX;this.gyroY=gyroY;this.gyroZ=gyroZ;  
        
        //this.notifyObservers();
      //}
      
  }
}
