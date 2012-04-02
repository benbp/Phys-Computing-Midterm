#include <Servo.h>

Servo dropperServo;

const int PIR = 0;
unsigned long time = 0;
int motion;
int calibrationTime = 10;
const int LED = 13;
int servoCounter = 0;

void setup(){
	Serial.begin(9600);
	
	pinMode(PIR, INPUT);
	pinMode(LED, OUTPUT);
		
	dropperServo.attach(9);
	dropperServo.write(90);
	
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

void loop(){
	motion = analogRead(PIR);
	Serial.print(motion);
	Serial.print("\n");
	
	if(motion > 150 && (millis() - time) > 3000){
		drop_tweet();
		time = millis();
	}
	
	if(motion < 150 && millis() - time > 45000){
		drop_tweet();
		time = millis();
	}

}

void drop_tweet(){
	signal_bird();
	switch(servoCounter){
		case 0: dropperServo.write(179); servoCounter++; delay(300); Serial.print("servo 179"); Serial.print("\n"); break;
		case 1: dropperServo.write(90); servoCounter--; delay(300); Serial.print("servo 90"); Serial.print("\n"); break;
	}
}

void signal_bird(){
	digitalWrite(LED, HIGH);
	delay(2000);
	digitalWrite(LED, LOW);
	delay(2000);
}