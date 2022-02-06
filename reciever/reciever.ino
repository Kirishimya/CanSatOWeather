//Receptor
#include <SPI.h>
#include <nRF24L01.h>
#include <RF24.h>
#include <Wire.h> 
const uint64_t pipeIn = 0xE8E8F0F0E1LL; 
RF24 radio(9, 10);
struct MyCansat {
  //dht
  byte h; 
  byte t;
  //bmp
  long p;
  float alt;
  //mpu
  float accX;
  float accY;
  float accZ;
  float gyroX;
  float gyroY;
  float gyroZ;
};
MyCansat cansat;
void setup()
{
  Serial.begin(9600); 
  radio.begin();
  radio.setAutoAck(false);
  radio.setDataRate(RF24_250KBPS);
  radio.openReadingPipe(1, pipeIn);
  radio.startListening();
  //lcd.println("Receiver ");
}
void recvCansat()
{
  if ( radio.available() ) {
    radio.read(&cansat, sizeof(MyCansat));
    }
}
void loop()
{
  recvCansat();
  //dht
  //Serial.print("Humidity: ");
  Serial.print(cansat.h);Serial.print(",");/*Serial.println("%");*/
  //Serial.print("Temperature: ");
  Serial.print(cansat.t);Serial.print(","); /*Serial.println(" C");*/
  //bmp
  //Serial.print("Pressure: ");
  Serial.print(cansat.p);Serial.print(","); /*Serial.println(" Pa");*/
  //Serial.print("Altitude: ");
  Serial.print(cansat.alt);Serial.print(","); /*Serial.println(" m");*/
  //mpu
  //Serial.print("AccX: ");
  Serial.print(cansat.accX);Serial.print(","); /*Serial.println(" m/s^2");*/
  //Serial.print("AccY: ");
  Serial.print(cansat.accY);Serial.print(","); /*Serial.println(" m/s^2");*/
  //Serial.print("AccZ: ");
  Serial.print(cansat.accZ);Serial.print(","); /*Serial.println(" m/s^2");*/
  //Serial.print("GyroX: ");
  Serial.print(cansat.gyroX);Serial.print(","); /*Serial.println(" rad/s");*/
  //Serial.print("GyroY: ");
  Serial.print(cansat.gyroY);Serial.print(","); /*Serial.println(" rad/s");*/
  //Serial.print("GyroZ: ");
  Serial.print(cansat.gyroZ);Serial.print("\n"); /*Serial.println(" rad/s ;");*/
  //Serial.print("\n");
}
