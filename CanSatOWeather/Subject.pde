public interface Subject{
  public void registerObserver(Observers obs);
  public void removeObserver(Observers obs);
  
  public void notifyObservers(String[] data, int i) ;
}
