class HPMenuOptionCombo extends UWindowComboControl;

#EXEC TEXTURE IMPORT NAME=FEOverOptionTexture	 FILE=TEXTURES\FEOverOptionTexture.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#EXEC TEXTURE IMPORT NAME=FEOverOption3Texture	 FILE=TEXTURES\FEOverOption3Texture.bmp GROUP="Icons" FLAGS=2 MIPS=OFF

function Created()
{
	Super.Created();
}

function CreateEditBox ()
{
	EditBox = HPMenuOptionEditBox(CreateWindow(class'HPMenuOptionEditBox', 0, 0, WinWidth-12, WinHeight)); 
}

function CreateComboButton ()
{
	Button = HPMenuOptionComboButton(CreateWindow(class'HPMenuOptionComboButton', WinWidth-12, 0, 12, 10)); 
}

function CreateComboList ()
{
	List = HPMenuOptionComboList(Root.CreateWindow(ListClass, 0, 0, 150, 58)); 
}


function BeforePaint(Canvas C, float X, float Y)
{
	local float W, H;

	Super.BeforePaint(C, X, Y);

	WinHeight = 18;

	TextSize(C, Text, W, H);

	TextY = (WinHeight - H) / 2;
	TextX = WinWidth - W - 20 - EditBoxWidth;
}


function Paint(Canvas C, float X, float Y)
{
	if(Text != "")
	{
		C.DrawColor = TextColor;
		ClipText(C, TextX, TextY, Text);
		C.DrawColor.R = 255;
		C.DrawColor.G = 255;
		C.DrawColor.B = 255;
	}

	if (bListVisible)
		DrawClippedTexture( C, WinWidth-EditBoxWidth, 1, Texture'FEOverOptionTexture');
	else
	{
		if (MouseIsOver() ||
			EditBox.MouseIsOver() ||
			Button.MouseIsOver()
			)
			DrawClippedTexture( C, WinWidth-EditBoxWidth, 1, Texture'FEOverOption3Texture');
//		else
//			DrawClippedTexture( C, WinWidth-EditBoxWidth, 1, Texture'FEOverOption3Texture');
	}
}

defaultproperties
{
     ListClass=Class'HPMenu.HPMenuOptionComboList'
}
