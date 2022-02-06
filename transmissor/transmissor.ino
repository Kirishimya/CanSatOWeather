//Transmissor
#include <SPI.h>
#include <nRF24L01.h>
#include <RF24.h>
#include <Wire.h>
#include <Adafruit_BMP085.h>
#include <Adafruit_MPU6050.h>
#include <Adafruit_Sensor.h>
#include "DHT.h"
const uint64_t pipeOut = 0xE8E8F0F0E1LL; 
#define DHTPIN A1
#define DHTTYPE DHT11 
DHT dht(DHTPIN, DHTTYPE);
RF24 radio(9, 10); //  CN and CSN  pins of nrf
struct MyCansat{
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
Adafruit_BMP085 bmp;
Adafruit_MPU6050 mpu;
void setup()
{
  Serial.begin(9600);
  dht.begin();
   
  if (!mpu.begin()) {
    Serial.println("Failed to find MPU6050 chip");
    while (1) {
      delay(10);
    }
  }
  mpu.setAccelerometerRange(MPU6050_RANGE_16_G);
  mpu.setGyroRange(MPU6050_RANGE_250_DEG);
  mpu.setFilterBandwidth(MPU6050_BAND_21_HZ);
  
  if (!bmp.begin()) {
  Serial.println("Could not find a valid BMP085 sensor, check wiring!");
  while (1) {}
  }
  if (!radio.begin()) {
    Serial.println("Failed to find RADIO!");
    while (1) {
      delay(10);
    }
  }
  radio.setAutoAck(false);
  radio.setDataRate(RF24_250KBPS);
  radio.openWritingPipe(pipeOut);
}
void loop()
{
  /* Get new sensor events with the readings */
  sensors_event_t a, g, temp;
  mpu.getEvent(&a, &g, &temp);
  
 cansat.h = dht.readHumidity();
 cansat.t = dht.readTemperature();
 cansat.p = bmp.readPressure();
 cansat.alt = bmp.readAltitude();
 cansat.accX = a.acceleration.x;
 cansat.accY = a.acceleration.y;
 cansat.accZ = a.acceleration.z;
 cansat.gyroX = g.gyro.x;
 cansat.gyroY = g.gyro.y;
 cansat.gyroZ = g.gyro.z;
 
  if (isnan(cansat.h) || isnan(cansat.t)){
    Serial.println(F("Failed to read from DHT sensor!"));
    return;
  }
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
  radio.write(&cansat, sizeof(MyCansat));
  delay(50);
}
