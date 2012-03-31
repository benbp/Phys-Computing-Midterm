#include <FatReader.h>
#include <SdReader.h>
#include <avr/pgmspace.h>
#include "WaveUtil.h"
#include "WaveHC.h"


SdReader card;    // This object holds the information for the card
FatVolume vol;    // This holds the information for the partition on the card
FatReader root;   // This holds the information for the filesystem on the card
FatReader f;      // This holds the information for the file we're play

WaveHC wave;      // This is the only wave (audio) object, since we will only play one at a time

#define DEBOUNCE 100  // button debouncer

// this handy function will return the number of bytes currently free in RAM, great for debugging!   
int freeRam(void)
{
  extern int  __bss_end; 
  extern int  *__brkval; 
  int free_memory; 
  if((int)__brkval == 0) {
    free_memory = ((int)&free_memory) - ((int)&__bss_end); 
  }
  else {
    free_memory = ((int)&free_memory) - ((int)__brkval); 
  }
  return free_memory; 
} 

void sdErrorCheck(void)
{
  if (!card.errorCode()) return;
  putstring("\n\rSD I/O error: ");
  Serial.print(card.errorCode(), HEX);
  putstring(", ");
  Serial.println(card.errorData(), HEX);
  while(1);
}


// motion sensor
int pirPin = 0;
// counter for increasing volume/distortion
int counter = 0;
unsigned long time = 0;

// for PIR sensor Serial debugging
int calibrationTime = 10;

const int BUTTON = 12;
const int LED = 13;
boolean ledstate = false;


void setup() {
  // set up serial port
  Serial.begin(9600);

  // Set the output pins for the DAC control. This pins are defined in the library
  pinMode(2, OUTPUT);
  pinMode(3, OUTPUT);
  pinMode(4, OUTPUT);
  pinMode(5, OUTPUT);
  pinMode(LED, OUTPUT);
 
  pinMode(pirPin, INPUT);
  pinMode(BUTTON, INPUT);

  //give the sensor some time to calibrate
  Serial.print("calibrating sensor ");
    for(int i = 0; i < calibrationTime; i++){
      Serial.print(".");
      delay(1000);
      }
    Serial.println(" done");
    Serial.println("SENSOR ACTIVE");
    delay(50);
}

void loop() {
        ledstate = true;
	while(ledstate == true){
		Serial.print("on");
		Serial.print("\n");
		digitalWrite(LED, HIGH);
	}
		
	if(ledstate == true){
		digitalWrite(LED, HIGH);
		Serial.print("LED ON");
		Serial.print("\n");
	} else {
		Serial.print("LED OFF");
		Serial.print("\n");
		digitalWrite(LED, LOW);
	}
		
	if(digitalRead(BUTTON) == HIGH){}
}