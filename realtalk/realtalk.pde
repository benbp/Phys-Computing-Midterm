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

unsigned long time = 0;

const int PRES = 0;
int light;

void setup() {
  // set up serial port
  Serial.begin(9600);
  putstring_nl("Realtalk");
  
   putstring("Free RAM: ");       // This can help with debugging, running out of RAM is bad
  Serial.println(freeRam());      // if this is under 150 bytes it may spell trouble!
  
  // Set the output pins for the DAC control. This pins are defined in the library
  pinMode(2, OUTPUT);
  pinMode(3, OUTPUT);
  pinMode(4, OUTPUT);
  pinMode(5, OUTPUT);
  pinMode(PRES, INPUT);

 
  //  if (!card.init(true)) { //play with 4 MHz spi if 8MHz isn't working for you
  if (!card.init()) {         //play with 8 MHz spi (default faster!)  
    putstring_nl("Card init. failed!");  // Something went wrong, lets print out why
    sdErrorCheck();
    while(1);                            // then 'halt' - do nothing!
  }
  
  // enable optimize read - some cards may timeout. Disable if you're having problems
  card.partialBlockRead(true);
 
// Now we will look for a FAT partition!
  uint8_t part;
  for (part = 0; part < 5; part++) {     // we have up to 5 slots to look in
    if (vol.init(card, part))
      break;                             // we found one, lets bail
  }

  if (part == 5) {                       // if we ended up not finding one  :(
    putstring_nl("No valid FAT partition!");
    sdErrorCheck();      // Something went wrong, lets print out why
    while(1);                            // then 'halt' - do nothing!
  }
  
  // Lets tell the user about what we found
  putstring("Using partition ");
  Serial.print(part, DEC);
  putstring(", type is FAT");
  Serial.println(vol.fatType(),DEC);     // FAT16 or FAT32?

  // Try to open the root directory
  if (!root.openRoot(vol)) {
    putstring_nl("Can't open root dir!"); // Something went wrong,
    while(1);                             // then 'halt' - do nothing!
  }
  
  // Whew! We got past the tough parts.
  putstring_nl("Ready!");
}

void loop() {
	light = analogRead(PRES);
	
	if(light > 200 && !wave.isplaying) {
  		choose_tweet(int(random(1,21)));
	}

}

void choose_tweet(int i){
	switch(i) {
		case 1: play_tweet("1.WAV"); break;
	    case 2: play_tweet("2.WAV"); break;
	    case 3: play_tweet("3.WAV"); break;
	    case 4: play_tweet("4.WAV"); break;
	    case 5: play_tweet("5.WAV"); break;
	    case 6: play_tweet("6.WAV"); break;
	    case 7: play_tweet("7.WAV"); break;
		case 8: play_tweet("8.WAV"); break;
		case 9: play_tweet("9.WAV"); break;
		case 10: play_tweet("10.WAV"); break;
		case 11: play_tweet("11.WAV"); break;
		case 12: play_tweet("12.WAV"); break;
		case 13: play_tweet("13.WAV"); break;
		case 14: play_tweet("14.WAV"); break;
		case 15: play_tweet("15.WAV"); break;
		case 16: play_tweet("16.WAV"); break;
		case 17: play_tweet("17.WAV"); break;
		case 18: play_tweet("18.WAV"); break;
		case 19: play_tweet("19.WAV"); break;
		case 20: play_tweet("20.WAV"); break;
	}
}

void play_tweet(char *file) {
  f.open(root, file);
  wave.create(f);
  wave.play();

  while (wave.isplaying){
  }
}