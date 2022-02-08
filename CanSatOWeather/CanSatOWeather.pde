//CanSatOWeather show the data from the arduino

import processing.serial.*;
import java.util.List;
//import org.apache.commons.lang3.StringUtils;

Serial myPort;  // Create object from Serial class
String val;   // Data received from the serial port
String[] splitval;
int disS = 0;
Subject cansat = new MyCansat();
Observers[] displays = {new CurrentConditionsDisplay(cansat), new ForecastDisplay(cansat)};
NavBarDisplay nav = new NavBarDisplay(displays, cansat);
void setup() 
{
  size(300, 600);
  // I know that the first port in the serial list on my mac
  // is always my  FTDI adaptor, so I open Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
  for(int i = 0; i<displays.length; i++){
    cansat.registerObserver(displays[i]);
  }
}

void draw()
{
  /*if ( myPort.available() > 0) {  // If data is available,
    val = myPort.read();         // read it and store it in val
    println(val);
  }
  background(255);             // Set background to white
  /*if (val == 0) {              // If the serial value is 0,
    fill(0);                   // set fill to black
  } 
  else {                       // If the serial value is not 0,
    fill(204);                 // set fill to light gray
  }*/
  while (myPort.available() > 0) {
    val = myPort.readStringUntil(10);
    if (val != null) {
      //println(val);
      splitval=split(val, ",");
      for(int i = 0; i<splitval.length; i++){
        //println(splitval[i]); 
      }
    }
  }

  //fill(0);
  //rect(0, 0, width, height);
  //dis = new NavBarDisplay();
  //dis.display(0,0,0);
  //dis = new CurrentConditionsDisplay();
  //dis.display(0,0,0);
  cansat.notifyObservers(splitval, disS);
  disS = nav.selectDisplay();
  //nav.display(0.0,0.0,0.0);
}



/*

// Wiring / Arduino Code
// Code for sensing a switch status and writing the value to the serial port.

int switchPin = 4;                       // Switch connected to pin 4

void setup() {
  pinMode(switchPin, INPUT);             // Set pin 0 as an input
  Serial.begin(9600);                    // Start serial communication at 9600 bps
}

void loop() {
  if (digitalRead(switchPin) == HIGH) {  // If switch is ON,
    Serial.write(1);               // send 1 to Processing
  } else {                               // If the switch is not ON,
    Serial.write(0);               // send 0 to Processing
  }
  delay(100);                            // Wait 100 milliseconds
}

*/
