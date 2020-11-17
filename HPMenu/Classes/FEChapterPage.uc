class FEChapterPage expands baseFEPage;


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
	local float StartY;

	colWidth=256;
	black.r=0;
	black.g=0;
	black.b=0;
	white.r=255;
	white.g=255;
	white.b=255;

	Super.Created();

	StartY = 40;
	y = StartY; //20
	x = 40; //20

	for(i=10;i<60;i++)
	{
		/*
		if(i%10==0)
		{
			y+=15;
			if(!bSecondCol)	//chapters heading is in a diffrent place in the second colum.
				tempButton = UWindowButton(CreateWindow(class'UWindowButton', x+128, y, 128, 81));
			else
				tempButton = UWindowButton(CreateWindow(class'UWindowButton', x, y, 128, 81));
			tempButton.SetFont(F_HPMenuLarge);
			tempButton.TextColor=black;
			tempString="Chapter " $string(i/10);
			tempButton.SetText(tempString);
			y+=20;
		}
		*/

		if ( levSelectButtonsDef[i].name!="" )
		{
			levSelectButtonsDef[i].button = UWindowButton(CreateWindow(class'UWindowButton', x, y, colWidth, 18));
			levSelectButtonsDef[i].button.Register(self);
			levSelectButtonsDef[i].button.SetFont(F_HPMenuLarge);
			levSelectButtonsDef[i].button.TextColor=levSelectButtonsDef[i].col;
			levSelectButtonsDef[i].button.SetText(levSelectButtonsDef[i].name);
			y+=28;
		}

		if (y>WinHeight-100)
		{
			y=StartY;
			x+=colWidth;
			bSecondCol=true;
		}
	}

	/*
	LangSelect = UWindowComboControl(CreateControl(class'UWindowComboControl',300,260,160, 25));
	LangSelect.setFont(F_HPMenuLarge);
	LangSelect.TextColor.r=50;
	LangSelect.TextColor.g=50;
	LangSelect.TextColor.b=50;
	//	LangSelect.Align=TA_Center; 
	LangSelect.AddItem("English"); 
	LangSelect.AddItem("German"); 
	LangSelect.AddItem("Spanish"); 
	LangSelect.AddItem("Portuguese"); 
	LangSelect.AddItem("French"); 
	LangSelect.AddItem("Italian"); 
	LangSelect.SetButtons(true);

	i=LangSelect.FindItemIndex(baseHarry(root.console.Viewport.Actor).theNarrator.CurLanguageName, true);
	LangSelect.SetSelectedIndex(i);
	*/
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

	for(i=10;i<60;i++)
	{
		if(levSelectButtonsDef[i].name!="")
		{
			if(levSelectButtonsDef[i].button==C)
			{
				if(levSelectButtonsDef[i].name=="Exit")
					Root.DoQuitGame();

				//See if theres a Story book we should play
				if( levSelectButtonsDef[i].StoryBookIdx != -1 )
				{
					FEStoryBookPage(FEBook(book).StoryBookPage).SetStory( levSelectButtonsDef[i].StoryBookIdx, "", true/*come back here when done*/, '' );
					FEBook(book).ChangePageNamed("StoryBookPage");
				}
			}
		}
	}

	//	ParentWindow.Close();
}

defaultproperties
{
     levSelectButtonsDef(10)=(Name="StoryBook 0")
     levSelectButtonsDef(11)=(Name="StoryBook 1",StoryBookIdx=1)
     levSelectButtonsDef(12)=(Name="StoryBook 2",StoryBookIdx=2)
     levSelectButtonsDef(13)=(Name="StoryBook 3",StoryBookIdx=3)
     levSelectButtonsDef(14)=(Name="StoryBook 4",StoryBookIdx=4)
     levSelectButtonsDef(15)=(Name="StoryBook 5",StoryBookIdx=5)
     levSelectButtonsDef(16)=(Name="StoryBook 6",StoryBookIdx=6)
     levSelectButtonsDef(17)=(Name="StoryBook 9",StoryBookIdx=9)
     levSelectButtonsDef(18)=(Name="StoryBook 13",StoryBookIdx=13)
     levSelectButtonsDef(19)=(Name="StoryBook 14",StoryBookIdx=14)
     levSelectButtonsDef(20)=(Name="StoryBook 15",StoryBookIdx=15)
     levSelectButtonsDef(21)=(Name="Credits",StoryBookIdx=16)
}
