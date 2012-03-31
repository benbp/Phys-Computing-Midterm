
// motion sensor
int pirPin = 0;
// counter for increasing volume/distortion
int counter = 0;
unsigned long time = 0;

// for PIR sensor Serial debugging
int calibrationTime = 2;

// for debugging/communication to other arduino


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