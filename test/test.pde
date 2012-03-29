
String[] lines;
float i;
int j;
String file;
void setup(){

}

void draw(){
  i = random(1, 5);
  j = int(i);
  lines = loadStrings(j + ".txt");
  
//  println(lines[0] + " " + j);
  
  
  switch(j) {
    case 1: pr("1.wav" + "\n" + j); break;
    case 2: pr("2.wav" + "\n" + j); break;
    case 3: pr("3.wav" + "\n" + j); break;
    case 4: pr("4.wav" + "\n" + j); break;
}
  
  delay(1000);
}

void pr(String name){
  println(name);
}
