

import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
private int NUM_ROWS=20;
private int NUM_COLS=20;
private int NUM_BOMB=70;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList<MSButton>(); //ArrayList of just the minesweeper buttons that are mined


void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    buttons=new MSButton[NUM_ROWS][NUM_COLS];
    for(int i=0; i<NUM_ROWS; i++){
        for(int n=0;n<NUM_COLS; n++){
            buttons[i][n]= new MSButton(i,n);
        }
    }
    setBombs();
}


public void setBombs()
{
    //your code
    int row, col;
    while(bombs.size()<NUM_BOMB){
        row=(int)(Math.random()*NUM_ROWS);
        col=(int)(Math.random()*NUM_COLS);
        if(!bombs.contains(buttons[row][col]))
            bombs.add(buttons[row][col]);
    }
    
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    //your code here
    for(int r=0; r<NUM_ROWS; r++){
        for(int c=0; c<NUM_COLS; c++){
            if(bombs.contains(buttons[r][c])&& !buttons[r][c].isClicked()){
                buttons[r][c].marked=false;
                buttons[r][c].clicked=true;
            }
        }
    }
    buttons[9][9].label="y";
    buttons[9][10].label="o";
    buttons[9][11].label="u";
    buttons[10][8].label="l";
    buttons[10][9].label="o";
    buttons[10][10].label="s";
    buttons[10][11].label="e";
    buttons[10][12].label="!";

}
public void displayWinningMessage()
{
    //your code here
    buttons[9][9].label="y";
    buttons[9][10].label="o";
    buttons[9][11].label="u";
    buttons[10][8].label="w";
    buttons[10][9].label="i";
    buttons[10][10].label="n";
    buttons[10][11].label="!";

}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    public boolean isMarked()
    {
        return marked;
    }

    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        if(mouseButton==RIGHT){
            marked=!marked;
        }
        if(mouseButton==LEFT && !marked){
            clicked=true;
        }
        if ( bombs.contains(this) ){
            displayLosingMessage();
        }
        else if(countBombs(r,c)>0){
           label=""+countBombs(r,c);
        }
        else 
        {
          if (isValid(r, c-1)==true && buttons[r][c-1].isClicked()==false)
          {
            buttons[r][c-1].mousePressed();
          }
          if (isValid(r, c+1)==true && buttons[r][c+1].isClicked()==false)
          {
            buttons[r][c+1].mousePressed();
          }
          if (isValid(r-1, c)==true && buttons[r-1][c].isClicked()==false)
          {
            buttons[r-1][c].mousePressed();
          }
          if (isValid(r+1, c)==true && buttons[r+1][c].isClicked()==false)
          {
            buttons[r+1][c].mousePressed();
          }
          if (isValid(r-1, c+1)==true && buttons[r-1][c+1].isClicked()==false)
          {
            buttons[r-1][c+1].mousePressed();
          }
          if (isValid(r+1, c+1)==true && buttons[r+1][c+1].isClicked()==false)
          {
            buttons[r+1][c+1].mousePressed();
          }
          if (isValid(r-1, c-1)==true && buttons[r-1][c-1].isClicked()==false)
          {
            buttons[r-1][c-1].mousePressed();
          }
          if (isValid(r+1, c-1)==true && buttons[r+1][c-1].isClicked()==false)
          {
            buttons[r+1][c-1].mousePressed();
          }
        }
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else
            fill( 100 );
        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }

    public void setLabel(String newLabel)
    {
        label = newLabel;
    }

    public boolean isValid(int r, int c)
    {
        //your code here
        if(r<20 && r>=0 && 0<=c && c<20){
            return true;
        }
        return false;
    }

    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        //your code here
        for(int i=-1; i<=1; i++){
            if(bombs.contains(buttons[row-1][col+i])){
                numBombs++;
            }
            if(bombs.contains(buttons[row+1][col+i])){
                numBombs++;
            }
        }
        if(bombs.contains(buttons[row][col-1]))
            numBombs++;
        if(bombs.contains(buttons[row][col+1]))
            numBombs++;

        return numBombs;
    }
}



