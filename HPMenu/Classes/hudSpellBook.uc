class hudSpellBook extends UWindowWindow;

#EXEC TEXTURE IMPORT NAME=SpellBookTexture1	 FILE=TEXTURES\SpellBookTexture1.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#EXEC TEXTURE IMPORT NAME=SpellBookTexture2	 FILE=TEXTURES\SpellBookTexture2.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#EXEC TEXTURE IMPORT NAME=SpellBookTexture3	 FILE=TEXTURES\SpellBookTexture3.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#EXEC TEXTURE IMPORT NAME=SpellBookTexture4	 FILE=TEXTURES\SpellBookTexture4.bmp GROUP="Icons" FLAGS=2 MIPS=OFF


#exec new TrueTypeFontFactory Name=spellBookFont FontName="Black Chancery" Height=16 AntiAlias=1 CharactersPerPage=32 

var bool bShowSpellBook;
var bool bSpellBookVisible;
var int iSpellBookOffsetY;
var baseWand wand;
var hudSpellButton spellButtons[16];

var hudSpellButton test1;


event Tick(float delta)
{
	if(!bShowSpellBook && iSpellBookOffsetY<=0)
		{
		bSpellBookVisible=false;
		return;
		}

	if(bShowSpellBook)
		{
			//scroll in if needed 
		if(iSpellBookOffsetY<440)
			iSpellBookOffsetY+=((440-iSpellBookOffsetY)/10)+2;
		}
	else if(iSpellBookOffsetY>0)
		iSpellBookOffsetY-=((440-iSpellBookOffsetY)/10)+5;

	if(iSpellBookOffsetY<0)
		iSpellBookOffsetY=0;

	if(iSpellBookOffsetY>0)
		bSpellBookVisible=true;

}


function Created()
{
local int i;

	Super.Created();

//	test1=hudSpellButton(CreateWindow(class'hudSpellButton', 10, 10, 100, 100));
//	test1.setText("Hello there");
//	test1.spellBook=self;
//	test1.spellId=1;

}


function Paint(Canvas canvas,float x,float y)
{
local int width;
local int i;
local int ox,oy;
local color saveColor;

	if(bSpellBookVisible)
		{

		width=Texture'SpellBookTexture1'.USize+Texture'SpellBookTexture2'.USize;

		Canvas.SetPos((canvas.sizeX/2)-(width/2),canvas.sizeY-iSpellBookOffsetY);
		Canvas.DrawIcon(Texture'SpellBookTexture1',1);

		Canvas.SetPos(((canvas.sizeX/2)-(width/2))+256,canvas.sizeY-iSpellBookOffsetY);
		Canvas.DrawIcon(Texture'SpellBookTexture2',1);

		Canvas.SetPos((canvas.sizeX/2)-(width/2),(canvas.sizeY-iSpellBookOffsetY)+256);
		Canvas.DrawIcon(Texture'SpellBookTexture3',1);

		Canvas.SetPos(((canvas.sizeX/2)-(width/2))+256,(canvas.sizeY-iSpellBookOffsetY)+256);
		Canvas.DrawIcon(Texture'SpellBookTexture4',1);

		if(wand==none)
			{
			wand=baseWand(canvas.Viewport.Actor.weapon);
			}
		if(wand!=None)
			{
			ox=((canvas.sizeX/2)-(width/2))+85;
			oy=canvas.sizeY-iSpellBookOffsetY+20;
			Canvas.Font=Font'spellBookFont';
			saveColor=Canvas.DrawColor;
			for(i=0;i<16;i++)
				{
				if(wand.spellList[i]==None)
					break;

				if(i==8)
					{
					ox=((canvas.sizeX/2)-(width/2))+85+240;
					oy=canvas.sizeY-iSpellBookOffsetY+20;
					}
				if(spellButtons[i]==None)
					{
					spellButtons[i]=hudSpellButton(CreateWindow(class'hudSpellButton', ox, oy, 240, 50));
					spellButtons[i].spellBook=self;
					spellButtons[i].spellId=i;
					}
					
					//update button positions				
				spellButtons[i].winTop=oy;
				spellButtons[i].winLeft=ox;

				Canvas.SetPos(ox,oy);
				
				Canvas.DrawColor=saveColor;
				if(wand.spellList[i]!=wand.curSpell)
					{	//darken if not current spell.
					Canvas.DrawColor.r/=3;
					Canvas.DrawColor.g/=3;
					Canvas.DrawColor.b/=3;
					}
				Canvas.DrawIcon(wand.spellList[i].default.spellIcon,1);

				Canvas.SetPos(ox+61,oy+26);
				Canvas.DrawColor.r=0;
				Canvas.DrawColor.g=0;
				Canvas.DrawColor.b=0;
				Canvas.DrawText(wand.spellList[i].default.spellName);

				Canvas.SetPos(ox+60,oy+25);
				Canvas.DrawColor=saveColor;
				Canvas.DrawText(wand.spellList[i].default.spellName);
				Canvas.DrawColor=saveColor;
				oy+=45;
				}			
			}

		}

}

function spellClicked(int spellId)
{
//	log("SpellClicked "$spellId);
	if(wand!=None && wand.spellList[spellId]!=None)
		wand.SelectSpell(wand.spellList[spellId]);
}

defaultproperties
{
}
