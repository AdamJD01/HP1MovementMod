class FESlotPage expands baseFEPage;

#EXEC TEXTURE IMPORT NAME=SaveSlotEmptyTexture	 FILE=TEXTURES\SaveSlotEmptyTexture.bmp GROUP="Icons" FLAGS=2 MIPS=OFF

var UWindowSmallButton NewGameButton;
var UWindowButton LogoWindow;

var HPMessageBox ConfirmReplace;

const NUM_SAVE_SLOTS=6;
const SAVE_SLOT_WIDTH=128;
const SAVE_SLOT_HEIGHT=128;

struct SaveSlotInfo{
	var bool bUsed;
	var UWindowButton button;
};
var SaveSlotInfo SaveSlots[6];//NUM_SAVE_SLOTS
var int nSelectedSlot;	//temp storage.


var UWindowButton WindowTitle;

var UWindowButton ResumeButton;
var UWindowButton ReplaceButton;

var GameSaveInfo info;
var int TextureId;



// AWRIGHT_111001_001
var UWindowButton SlotNumberDisplays[6];//NUM_SAVE_SLOTS


function PreSwitchPage()
{
	UpdateSlots();
	ResumeButton.HideWindow();
	ReplaceButton.HideWindow();
}
function UpdateSlots()
{
	local Texture tmpTexture;
	local int i;

	// AWRIGHT_111001_001
	local string ThumbnailFileName;



	for(i=0;i<NUM_SAVE_SLOTS;i++)
		{
		if (root.console.Viewport.Actor.LoadGameSaveInfo("GameSaveInfo"$i, info))
			{	
			// AWRIGHT_111001_001	

			// tmpTexture = GetLevel().CreateTextureFromBMP(
			//		"save" $TextureId, 
			//		"..\\Save\\DefaultGameSnap.bmp");

			// load texture relevant for current level, 
			// and current save point ID  within save slot. 
			// If missing, use the level default texture. 
			// If that missing, use the game default texture.

			if ( info.savePointID >= 0 )
			{
				ThumbnailFileName = "..\\Save\\SGS " $info.currentLevelString $info.savePointID $".bmp";
				Log( "Trying Thumbnail File :" $ThumbnailFileName );
				tmpTexture = GetLevel().CreateTextureFromBMP( "save" $TextureId, ThumbnailFileName );

				if ( tmpTexture == None )
				{
					ThumbnailFileName = "..\\Save\\SGS " $info.currentLevelString $".bmp";
					Log( "Trying Thumbnail File :" $ThumbnailFileName );
					tmpTexture = GetLevel().CreateTextureFromBMP( "save" $TextureId, ThumbnailFileName );
				}
			}
			else
			{
				ThumbnailFileName = "..\\Save\\SGS " $info.currentLevelString $".bmp";
				Log( "Trying Thumbnail File :" $ThumbnailFileName );
				tmpTexture = GetLevel().CreateTextureFromBMP( "save" $TextureId, ThumbnailFileName );
			}

			if ( tmpTexture == None )
			{
				ThumbnailFileName = "..\\Save\\DefaultGameSnap.bmp";
				Log( "Trying Thumbnail File :" $ThumbnailFileName );
				tmpTexture = GetLevel().CreateTextureFromBMP( "save" $TextureId, ThumbnailFileName );
			}

			Log( "Slot " $i $"Has Save Point ID " $info.savePointID );
			Log( "Loaded Thumbnail File :" $ThumbnailFileName );

			// AWRIGHT_111001_001 - end



			TextureId++;
			SaveSlots[i].button.UpTexture=tmpTexture;
			SaveSlots[i].button.DownTexture=tmpTexture;
			SaveSlots[i].button.OverTexture=tmpTexture;
			SaveSlots[i].button.TextColor.r=250;
			SaveSlots[i].button.TextColor.g=250;
			SaveSlots[i].button.TextColor.b=250;
			
			SaveSlots[i].button.setText(GetLocalizedString("select_game_03",SaveSlots[i].button.ToolTipString ));		//"Start Game");
//			SaveSlots[i].button.setText("Load Game");
//			SaveSlots[i].button.ToolTipString="Resume a saved game";
			SaveSlots[i].bUsed=true;
			}
		else
			{
			SaveSlots[i].button.UpTexture=Texture'SaveSlotEmptyTexture';
			SaveSlots[i].button.DownTexture=Texture'SaveSlotEmptyTexture';
			SaveSlots[i].button.OverTexture=Texture'SaveSlotEmptyTexture';
			SaveSlots[i].button.TextColor.r=250;
			SaveSlots[i].button.TextColor.g=4;
			SaveSlots[i].button.TextColor.b=30;

			SaveSlots[i].button.setText(GetLocalizedString("select_game_02",SaveSlots[i].button.ToolTipString ));		//"Start Game");
//			SaveSlots[i].button.setText("New Game");
//			SaveSlots[i].button.ToolTipString="Start a new game";
			SaveSlots[i].bUsed=false;
			}
		}
}

function BeforePaint(Canvas C, float X, float Y)
{
	Super.BeforePaint(C,X,Y);
}


function Created()
{
local int i;
local Texture tempTexture;
local float x,y;

	Super.Created(); 

	info = new class'GameSaveInfo';

	WindowTitle=UWindowButton(CreateControl(class'UWindowButton', 320-150,30,300,25));
	WindowTitle.setFont(F_HPMenuLarge);
	WindowTitle.TextColor.r=250;
	WindowTitle.TextColor.g=0;
	WindowTitle.TextColor.b=250;
	WindowTitle.Align=TA_Center;
	WindowTitle.bShadowText=true;

	WindowTitle.setText(GetLocalizedString("select_game_01"));


	x=78;
	y=90;

	for(i=0;i<NUM_SAVE_SLOTS;i++)
		{
		SaveSlots[i].button=UWindowButton(CreateControl(class'UWindowButton', x,y,SAVE_SLOT_WIDTH, SAVE_SLOT_HEIGHT));

		// AWRIGHT_111001_001
		SlotNumberDisplays[i]=UWindowButton(CreateControl(class'UWindowButton', x-0,y-24,32,32));
		SlotNumberDisplays[i].TextColor.r=255;
		SlotNumberDisplays[i].TextColor.g=255;
		SlotNumberDisplays[i].TextColor.b=255;
		SlotNumberDisplays[i].Align=TA_Left;
		SlotNumberDisplays[i].bShadowText=true;
		SlotNumberDisplays[i].setText( "" $(i+1) );
		SlotNumberDisplays[i].setFont(F_HPMenuLarge);
		// AWRIGHT_111001_001 - end

		x+=SAVE_SLOT_WIDTH+46;
		if(i==2)
			{
			x=78;
			y=264;
			}

		SaveSlots[i].button.setFont(F_HPMenuLarge);
		SaveSlots[i].button.TextColor.r=250;
		SaveSlots[i].button.TextColor.g=4;
		SaveSlots[i].button.TextColor.b=30;
		SaveSlots[i].button.Align=TA_Center;
		SaveSlots[i].button.UpTexture=Texture'SaveSlotEmptyTexture';
		SaveSlots[i].button.DownTexture=Texture'SaveSlotEmptyTexture';
		SaveSlots[i].button.OverTexture=Texture'SaveSlotEmptyTexture';
		SaveSlots[i].button.bShadowText=true;

		SaveSlots[i].button.setText(GetLocalizedString("select_game_02",SaveSlots[i].button.ToolTipString ));		
//		SaveSlots[i].button.setText("New Game");
//		SaveSlots[i].button.ToolTipString="Start a new game";

		SaveSlots[i].button.DownSound=Sound'HPSounds.Magic_sfx.pickups.beans_good';
		}

	y=y+128+16;


	ResumeButton=UWindowButton(CreateControl(class'UWindowButton', 320-150,y,300,25));
	ResumeButton.setFont(F_HPMenuLarge);
	ResumeButton.TextColor.r=215;
	ResumeButton.TextColor.g=0;
	ResumeButton.TextColor.b=215;
	ResumeButton.Align=TA_Center;
	ResumeButton.HideWindow();
	ResumeButton.bShadowText=true;

	ResumeButton.setText(GetLocalizedString("select_game_03",ResumeButton.ToolTipString ));	//Load game
//	ResumeButton.setText("Load Game");
//	ResumeButton.ToolTipString="Resume this game";
	ResumeButton.DownSound=Sound'HPSounds.Magic_sfx.pickups.beans_good';
	y=y+30;

	ReplaceButton=UWindowButton(CreateControl(class'UWindowButton', 320-150,y,300,25));
	ReplaceButton.setFont(F_HPMenuLarge);
	ReplaceButton.TextColor.r=250;
	ReplaceButton.TextColor.g=0;
	ReplaceButton.TextColor.b=250;
	ReplaceButton.Align=TA_Center;
	ReplaceButton.HideWindow();
	ReplaceButton.bShadowText=true;

	ReplaceButton.setText(GetLocalizedString("select_game_04",ReplaceButton.ToolTipString ));	//Load game
//	ReplaceButton.setText("Replace Game");
//	ReplaceButton.ToolTipString="Overwrite this save game";
	ReplaceButton.DownSound=Sound'HPSounds.Magic_sfx.pickups.beans_good';

	y=y+32;

	nSelectedSlot=-1;
//	UpdateSlots();
	Log("SavePointStuff: Created");

}
function LoadSelectedSlot()
{
//	if (root.console.Viewport.Actor.LoadGameSaveInfo("open save" $nSelectedSlot $".usa", info))
	if (true)
		{
		if(nSelectedSlot<0)
		{
			Log("SavePointStuff: Load From slot:99");
			GetLevel().ConsoleCommand("open save99.usa");
		}
		else
		{
			Log("SavePointStuff: Load From slot:nSelectedSlot name:"$nSelectedSlot$".usa");
			GetLevel().ConsoleCommand("open save" $nSelectedSlot $".usa");
		}
					
		HPConsole(root.console).bInHubFlow = true;	// We're returning to the normal hub-to-hub game flow

		FEBook(book).bGamePlaying=true;
		FEBook(book).CloseBook();
		}
	else
		{
		baseHarry(root.console.viewport.Actor).Level.Game.RestartGame();
		}
}

function SaveSelectedSlot()
{
	if (baseHarry(root.console.viewport.Actor).LifePotions < baseHarry(root.console.viewport.Actor).MaxLifePotions / 2)
	{
		baseHarry(root.console.viewport.Actor).LifePotions = baseHarry(root.console.viewport.Actor).MaxLifePotions / 2;
	}

	if(nSelectedSlot<0)
	{
		Log("SavePointStuff: Save to slot:99");
		HPConsole(root.console).DoLevelSave(99);
	}
	else
	{
		Log("SavePointStuff: Save to slot:"$nSelectedSlot);
		HPConsole(root.console).DoLevelSave(nSelectedSlot);
	}
}
function SetSelectedSlot(int slot)
{
	Log("SavePointStuff: SetSelectedSlot:"$slot);
	nSelectedSlot=slot;
}
function CreateSelectedSlot()
{
	FEBook(book).bNewGame=true;
	FEStoryBookPage(FEBook(book).StoryBookPage).SetStory( 3, "Lev_Tut1.unr", false/*dont go back to chapter page when done*/, '' );
	FEBook(book).bGamePlaying=true;
	FEBook(book).ChangePageNamed("StoryBookPage");

}
function WindowDone(UWindowWindow W)
{
	if(W == ConfirmReplace)
		{
		if(ConfirmReplace.Result == ConfirmReplace.button1.text)

			{
			CreateSelectedSlot();
			}
		ConfirmReplace = None;
		}
}

function Notify(UWindowDialogControl C, byte E)
{
local int i;


	if(e==DE_Click)
		{
		if(c==ResumeButton)
			{
			if(nSelectedSlot<0)		//shouldnt ever happen.
				return;
			LoadSelectedSlot();
			return;
			}
		if(c==ReplaceButton)
			{
				//revisit. Do Confirm.
//			ConfirmReplace = MessageBox("Overwrite Save Game", "Are you sure you want to replace this save game?", MB_YesNo, MR_No, MR_None, 10);
			ConfirmReplace = doHPMessageBox(
				//		GetLocalizedString("select_game_04"), 
						GetLocalizedString("select_game_05"), 
						GetLocalizedString("main_menu_09"),// "Yes"
						GetLocalizedString("main_menu_10"), //"No"
					);

			ResumeButton.HideWindow();
			ReplaceButton.HideWindow();
			}
		for(i=0;i<NUM_SAVE_SLOTS;i++)
			{
			if(c==SaveSlots[i].button)
				{
				nSelectedSlot=i;
				if(SaveSlots[i].bUsed)
					{
					ResumeButton.ShowWindow();
					ReplaceButton.ShowWindow();
					}
				else
					{
					CreateSelectedSlot();
					}
				return;
				}
			}

		}
}

defaultproperties
{
     nSelectedSlot=-1
}
