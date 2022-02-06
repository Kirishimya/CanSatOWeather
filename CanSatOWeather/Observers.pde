public interface Observers{
  public void update(float temp, float hum, float pres);
  public String getDisplayName();
  public void requestRegister(Subject sbj);
  public void requestRemove(Subject sbj);
}
/*
public void requestRegister(Subject sbj){
  sbj.registerObserver(this);
}
public void requestRemove(Subject sbj){
  sbj.removeObserver(this);
}
*/
