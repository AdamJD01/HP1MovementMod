class FEFilePage expands baseFEPage;

var int titleHeight;
var int pictureWidth, pictureHeight;
var int pictureID;

var GameSaveInfo info;


struct FileStruct
{
	var int start_x, start_y; // top left coordinates from which to lay the file details out

//	var LevelInfo info; // data extracted from save file

	// Buttons
	var UWindowButton Picture;
	var UWindowSmallButton SelectBtn;

	var UWindowSmallButton details [3];
};

var FileStruct SaveFileDetails [8];

// pure fns
function CreateFileDetails (int i);
function ShowFileDetails (int i);
function SelectFile (int i); // called when button is clicked

function Created()
{
	local int i, j, k, xx, i_max;
	pictureID = 0;

	i_max = ArrayCount(SaveFileDetails) /2;

	info = new class'GameSaveInfo';

	Super.Created();

	for (i=0; i<i_max; ++i)
	{
		for (j=0; j<2; ++j)
		{
			xx = i*2 + j;

			SaveFileDetails [xx].start_x = WinWidth*j/2+20;
			SaveFileDetails [xx].start_y = i*84+28;

			SaveFileDetails [xx].SelectBtn = UWindowSmallButton(CreateControl(class'UWindowSmallButton', 
				SaveFileDetails [xx].start_x, SaveFileDetails [xx].start_y, 120, titleHeight));

			SaveFileDetails [xx].SelectBtn.setFont(F_Bold);
			SaveFileDetails [xx].SelectBtn.TextColor.r=60;
			SaveFileDetails [xx].SelectBtn.TextColor.g=60;
			SaveFileDetails [xx].SelectBtn.TextColor.b=60;
			SaveFileDetails [xx].SelectBtn.Align=TA_Left;
			CreateFileDetails (xx);

			SaveFileDetails [xx].Picture = UWindowButton(CreateControl(class'UWindowButton',  
				SaveFileDetails [xx].start_x, 
				SaveFileDetails [xx].start_y+titleHeight, 
				pictureWidth, pictureHeight));

			for (k=0; k<ArrayCount(SaveFileDetails[xx].details); ++k)
			{
				SaveFileDetails [xx].details[k] = UWindowSmallButton(CreateControl(class'UWindowSmallButton', 
					SaveFileDetails [xx].start_x+80+20, SaveFileDetails [xx].start_y+titleHeight+20*k, 100, 20));

				SaveFileDetails [xx].details[k].setFont(F_Bold);
				SaveFileDetails [xx].details[k].TextColor.r=80;
				SaveFileDetails [xx].details[k].TextColor.g=80;
				SaveFileDetails [xx].details[k].TextColor.b=80;
				SaveFileDetails [xx].details[k].Align=TA_Left;
			}

		}//endfor j
	}//endfor i
}

function Notify(UWindowDialogControl Ctrl, byte msg)
{
	local int i;

	if(msg==DE_Click)
	{
		for (i=0; i<10; ++i)
		{
			if (SaveFileDetails[i].SelectBtn.bDisabled != true)
			{
				if (SaveFileDetails[i].SelectBtn == Ctrl ||
					SaveFileDetails[i].Picture ==Ctrl
					)
					SelectFile (i);
			}
		}
	}
}

function ShowWindowFile (int i)
{
	local Texture tmpTexture;

	local hpHud hud;
	local int j;
	local LevelSummary summary;
	local string savepath;

	

	savepath=(GetPlayerOwner().ConsoleCommand("get Core.System savepath"));

	if (root.console.Viewport.Actor.LoadGameSaveInfo("GameSaveInfo"$i, info))
	{		
		SaveFileDetails [i].SelectBtn.setText(info.currentLevelString);

		tmpTexture = GetLevel().CreateTextureFromBMP("save" $pictureID,savePath$"\\SaveGameSnap" $i $".bmp");
		++pictureID;

		SaveFileDetails [i].Picture.UpTexture   = tmpTexture;
		SaveFileDetails [i].Picture.DownTexture = tmpTexture;
		SaveFileDetails [i].Picture.OverTexture = tmpTexture;

		SaveFileDetails [i].details[0].setText(info.numBeans $" Beans");
		SaveFileDetails [i].details[1].setText(info.numStars $" Stars");
		SaveFileDetails [i].details[2].setText(info.numPoints $" Points");
	}
	else
	{
		SaveFileDetails [i].SelectBtn.Text = "";
	}

	ShowFileDetails (i);
}

function ShowWindow()
{
	local int i;

	for (i=0; i<ArrayCount(SaveFileDetails); ++i)
		ShowWindowFile (i);

	super.ShowWindow ();
}

defaultproperties
{
     titleHeight=18
     pictureWidth=80
     pictureHeight=60
}
