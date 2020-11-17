class FELevSelectPage expands baseFEPage;


var UWindowComboControl LangSelect;


struct MyButtonDefinition{
	var string        name;
	var Color         col;
	var string        levURL;
	var int           StoryBookIdx; // 0 based
	var UWindowButton button;
};

var MyButtonDefinition levSelectButtonsDef[60];	// Only 10 thru 59 used (tens = hub#/column#)

function Created()
{
local int i;
local float x,y;
local float colWidth;
local string tempString;
local UWindowButton tempButton;
local color black,white;
local font saveFont;
local bool bSecondCol;

	colWidth=256;
	black.r=0;
	black.g=0;
	black.b=0;
	white.r=255;
	white.g=255;
	white.b=255;


	Super.Created();


	y=20;
	x=20;
	for(i=10;i<60;i++)
	{
		if(i%10==0)
			{
			y+=15;
			if(!bSecondCol)	//chapters heading is in a diffrent place in the second colum.
				tempButton = UWindowButton(CreateWindow(class'UWindowButton', x+128, y, 128, 18));
			else
				tempButton = UWindowButton(CreateWindow(class'UWindowButton', x, y, 128, 18));
			tempButton.SetFont(F_HPMenuLarge);
			tempButton.TextColor=black;
			tempString="Chapter " $string(i/10);
			tempButton.SetText(tempString);
			y+=20;
			}
		if ( levSelectButtonsDef[i].name!="" )
			{
			levSelectButtonsDef[i].button = UWindowButton(CreateWindow(class'UWindowButton', x, y, colWidth, 18));
			levSelectButtonsDef[i].button.Register(self);
			levSelectButtonsDef[i].button.SetFont(F_HPMenuLarge);
			levSelectButtonsDef[i].button.TextColor=levSelectButtonsDef[i].col;
			levSelectButtonsDef[i].button.SetText(levSelectButtonsDef[i].name);
			y+=18;
			}
		if (y>WinHeight-80 && bSecondCol==false)
			{
			y=20;
			x+=colWidth;
			bSecondCol=true;
			}
	}

}


function Notify(UWindowDialogControl C, byte E)
{
local int    i;

	Super.Notify(C, E);

	if(c==LangSelect && e==DE_Change)
		{
		baseHarry(root.console.Viewport.Actor).theNarrator.SetLanguage(LangSelect.GetValue());
		}
	
	if(E!=DE_Click)
		return;

	if(c==levSelectButtonsDef[56].button)	//special saved game hack
		{
		FESlotPage(FEBook(book).SlotPage).SetSelectedSlot(9);		
		FESlotPage(FEBook(book).SlotPage).LoadSelectedSlot();
		}

	for(i=10;i<60;i++)
	{
		if(levSelectButtonsDef[i].name!="")
		{
			if(levSelectButtonsDef[i].button==C)
			{
				if(levSelectButtonsDef[i].name=="Exit")
					Root.DoQuitGame();

				if(levSelectButtonsDef[i].levURL!="")
				{
					//See if theres a Story book we should play
					if( levSelectButtonsDef[i].StoryBookIdx != -1 )
					{
						FESlotPage(FEBook(book).SlotPage).SetSelectedSlot(9);		
						FEStoryBookPage(FEBook(book).StoryBookPage).SetStory( levSelectButtonsDef[i].StoryBookIdx, levSelectButtonsDef[i].levURL, false/*dont go back to chapter page when done*/, '' );
						FEBook(book).ChangePageNamed("StoryBookPage");
					}
					else
					{
						FESlotPage(FEBook(book).SlotPage).SetSelectedSlot(9);		
						FEBook(book).RunURL( levSelectButtonsDef[i].levURL, true );

					}
				}
			}
		}
	}

//	ParentWindow.Close();
}

defaultproperties
{
     levSelectButtonsDef(10)=(Name="Hogwarts Entrance",levURL="Lev_Tut1.unr",StoryBookIdx=3)
     levSelectButtonsDef(11)=(Name="Flipendo Challenge",levURL="Lev_Tut1b.unr",StoryBookIdx=-1)
     levSelectButtonsDef(12)=(Name="Broomstick Training",levURL="Lev_Tut2.unr",StoryBookIdx=-1)
     levSelectButtonsDef(13)=(Name="Wingardium Leviosa",levURL="Lev_Tut3.unr",StoryBookIdx=-1)
     levSelectButtonsDef(14)=(Name="Second Floor Landing",levURL="Lev_Tut3b.unr",StoryBookIdx=-1)
     levSelectButtonsDef(20)=(Name="Hogwarts Grounds",levURL="Lev2_HogFront.unr",StoryBookIdx=-1)
     levSelectButtonsDef(21)=(Name="Incendio Challenge",levURL="Lev2_Inc_A.unr",StoryBookIdx=-1)
     levSelectButtonsDef(22)=(Name="Incendio B",levURL="Lev2_Inc_B.unr",StoryBookIdx=-1)
     levSelectButtonsDef(23)=(Name="Hogwarts Front",levURL="Lev2_HogFront_2.unr",StoryBookIdx=-1)
     levSelectButtonsDef(24)=(Name="Remembrall Chase",levURL="Lev2_RemChase.unr",StoryBookIdx=-1)
     levSelectButtonsDef(25)=(Name="Hogwarts Front II",levURL="Lev2_HogFront_3.unr",StoryBookIdx=-1)
     levSelectButtonsDef(26)=(Name="Forest Edge",levURL="Lev2_fire2.unr",StoryBookIdx=-1)
     levSelectButtonsDef(27)=(Name="Fireseed Caves",levURL="Lev2_fire1.unr",StoryBookIdx=-1)
     levSelectButtonsDef(28)=(Name="Quidditch 1",levURL="Lev2_Quid1.unr",StoryBookIdx=-1)
     levSelectButtonsDef(30)=(Name="Intro",levURL="Lev3_Intro.unr",StoryBookIdx=-1)
     levSelectButtonsDef(31)=(Name="Lumos",levURL="Lev3_Lumos.unr",StoryBookIdx=-1)
     levSelectButtonsDef(32)=(Name="PreDungeon",levURL="Lev3_PreDungeon.unr",StoryBookIdx=-1)
     levSelectButtonsDef(33)=(Name="Dungeon",levURL="Lev3_Dungeon.unr",StoryBookIdx=-1)
     levSelectButtonsDef(34)=(Name="Dungeon B",levURL="Lev3_DungeonB.unr",StoryBookIdx=-1)
     levSelectButtonsDef(35)=(Name="Troll",levURL="Lev3_Troll",StoryBookIdx=-1)
     levSelectButtonsDef(36)=(Name="Quidditch 2",levURL="Lev3_Quid2.unr",StoryBookIdx=-1)
     levSelectButtonsDef(40)=(Name="The Sneak",levURL="Lev4_Sneak.unr",StoryBookIdx=-1)
     levSelectButtonsDef(41)=(Name="The Sneak II",levURL="Lev4_Sneak2.unr",StoryBookIdx=-1)
     levSelectButtonsDef(50)=(Name="Fluffy",levURL="Lev5_Fluffy.unr",StoryBookIdx=-1)
     levSelectButtonsDef(51)=(Name="Devil's Snare",levURL="Lev5_snare.unr",StoryBookIdx=-1)
     levSelectButtonsDef(52)=(Name="Winged Keys",levURL="Lev5_flykeys.unr",StoryBookIdx=-1)
     levSelectButtonsDef(53)=(Name="Chess",levURL="Lev5_chess.unr",StoryBookIdx=-1)
     levSelectButtonsDef(54)=(Name="Voldemort ",levURL="Lev5_final.unr",StoryBookIdx=-1)
     levSelectButtonsDef(55)=(StoryBookIdx=-1)
     levSelectButtonsDef(56)=(Name="Saved Game",col=(R=200),StoryBookIdx=-1)
}
