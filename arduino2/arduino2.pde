#include <Servo.h>

Servo dropperServo;

const int BLOWUPBUTTON = 13;
const int PHOTORESISTOR = 0;
int blowupCounter = 0;
unsigned long time = 0;
int light;

const int BUTTONLED1 = 12;
const int BUTTONLED2 = 11;

void setup(){
	// Debugging
	Serial.begin(9600);
	Serial.print("dropper arduino initialized");
	Serial.print("\n");
	
	pinMode(BLOWUPBUTTON, INPUT);
	pinMode(PHOTORESISTOR, INPUT);
	
	pinMode(BUTTONLED1, OUTPUT);
	pinMode(BUTTONLED2, OUTPUT);
	
	dropperServo.attach(9);
	
	dropperServo.write(90);
}

void loop(){
	light = analogRead(PHOTORESISTOR);
	
	if(light > 300){
		// Debugging
		Serial.print("LED reading  - ");
		Serial.print(blowupCounter);
		
		blowupCounter++;
		time = millis();
		
		drop_tweet();
		
		delay(200);
	}
	
	if(millis() - time > 15000){
		blowupCounter = 0;
	}
	
	if(blowupCounter >= 15){
		enable_blowup();
	} else {
		disable_blowup();
	}
	
	if(digitalRead(BLOWUPBUTTON) == HIGH){
		blowup();
	}
}

void drop_tweet(){
	dropperServo.write(135);
	delay(500);
	dropperServo.write(90);
	delay(100);
}

void enable_blowup(){
	digitalWrite(BUTTONLED1, HIGH);
	digitalWrite(BUTTONLED2, HIGH);
	delay(500);
	digitalWrite(BUTTONLED1, LOW);
	digitalWrite(BUTTONLED2, LOW);
	delay(200);
}

void disable_blowup(){
	digitalWrite(BUTTONLED1, LOW);
	digitalWrite(BUTTONLED2, LOW);
}

void blowup(){
	// insert function to pour out contents of the box here
}
