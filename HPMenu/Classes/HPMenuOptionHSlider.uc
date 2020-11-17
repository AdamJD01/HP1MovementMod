class HPMenuOptionHSlider extends UWindowHSliderControl;

#EXEC TEXTURE IMPORT NAME=FEOverSliderTexture	 FILE=TEXTURES\FEOverSliderTexture.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#EXEC TEXTURE IMPORT NAME=FESliderKnobTexture	 FILE=TEXTURES\FESliderKnobTexture.bmp GROUP="Icons" FLAGS=2 MIPS=OFF

var Texture overImage, knobImage;

function Created ()
{
	Super.Created ();

	SliderWidth = 134;
	overImage = Texture'FEOverSliderTexture';
	knobImage = Texture'FESliderKnobTexture';
	TrackWidth = 9;

	//log("HPMenuOptionHSlider WinHeight"@ WinHeight);
	WinHeight = 25;
}


function BeforePaint(Canvas C, float X, float Y)
{
	local float W, H;

//	Super.BeforePaint(C, X, Y);
	
	TextSize(C, Text, W, H);
	
	SliderDrawX = WinWidth - SliderWidth;
	TextX = SliderDrawX - W - 23;

	SliderDrawY = (WinHeight - 2) / 2;
	TextY = (WinHeight - H) / 2;

	TrackStart = SliderDrawX + (SliderWidth - TrackWidth) * ((Value - MinValue)/(MaxValue - MinValue));
}

function Paint(Canvas C, float X, float Y)
{
	local Texture T;
	local Region R;

	T = GetLookAndFeelTexture();


	if(Text != "")
	{
		C.DrawColor = TextColor;
		ClipText(C, TextX, TextY, Text);
		C.DrawColor.R = 255;
		C.DrawColor.G = 255;
		C.DrawColor.B = 255;
	}
	
	R = LookAndFeel.HLine;

	if (MouseIsOver())
	{
		DrawClippedTexture( C, SliderDrawX, 8, overImage);
	}

	DrawClippedTexture( C, TrackStart, 0, knobImage);
}

defaultproperties
{
}
