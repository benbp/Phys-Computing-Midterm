#include <Servo.h>

Servo dropperServo;

const int PIR = 0;
unsigned long time = 0;
int motion;
int calibrationTime = 10;
const int LED = 8;

void setup(){
	Serial.begin(9600);
	
	pinMode(BLOWUPBUTTON, INPUT);
	pinMode(PIR, INPUT);
	
	pinMode(BUTTONLED1, OUTPUT);
	pinMode(PIR, OUTPUT);
	
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
}

void loop(){
	motion = analogRead(PIR);
	
	if(motion > 150 && (millis() - time) > 3000){
		drop_tweet();
		time = millis();
	}
	
	if(motion < 150 && millis() - time > 15000){
		drop_tweet();
		time = millis();
	}

}

void drop_tweet(){
	dropperServo.write(135);
	delay(500);
	dropperServo.write(90);
	signal_bird();
}

void signal_bird(){
	digitalWrite(LED, HIGH);
	delay(2000);
	digitalWrite(LED, LOW);
	delay(2000);
}
