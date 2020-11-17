class wingPage expands baseSpellPage;


//#EXEC TEXTURE IMPORT NAME=verdPageTexture1	 FILE=TEXTURES\HUD\verdPage1.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
//#EXEC TEXTURE IMPORT NAME=verdPageTexture2	 FILE=TEXTURES\HUD\verdPage2.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
//#EXEC TEXTURE IMPORT NAME=verdPageTexture3	 FILE=TEXTURES\HUD\verdPage3.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
//#EXEC TEXTURE IMPORT NAME=verdPageTexture4	 FILE=TEXTURES\HUD\verdPage4.bmp GROUP="Icons" FLAGS=2 MIPS=OFF

#EXEC TEXTURE IMPORT NAME=wingPageTexture1	 FILE=TEXTURES\wingPageTexture1.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#EXEC TEXTURE IMPORT NAME=wingPageTexture2	 FILE=TEXTURES\wingPageTexture2.bmp GROUP="Icons" FLAGS=2 MIPS=OFF

defaultproperties
{
     pagePieces(0)=Texture'HPMenu.Icons.wingPageTexture1'
     pagePieces(1)=Texture'HPMenu.Icons.wingPageTexture2'
     LifeSpan=2
}
