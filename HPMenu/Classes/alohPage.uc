class alohPage expands baseSpellPage;


//#EXEC TEXTURE IMPORT NAME=alohPageTexture1	 FILE=TEXTURES\HUD\alohPage1.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
//#EXEC TEXTURE IMPORT NAME=alohPageTexture2	 FILE=TEXTURES\HUD\alohPage2.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
//#EXEC TEXTURE IMPORT NAME=alohPageTexture3	 FILE=TEXTURES\HUD\alohPage3.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
//#EXEC TEXTURE IMPORT NAME=alohPageTexture4	 FILE=TEXTURES\HUD\alohPage4.bmp GROUP="Icons" FLAGS=2 MIPS=OFF

#EXEC TEXTURE IMPORT NAME=alohPageTexture1	 FILE=TEXTURES\alohPageTexture1.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#EXEC TEXTURE IMPORT NAME=alohPageTexture2	 FILE=TEXTURES\alohPageTexture2.bmp GROUP="Icons" FLAGS=2 MIPS=OFF

defaultproperties
{
     pagePieces(0)=Texture'HPMenu.Icons.alohPageTexture1'
     pagePieces(1)=Texture'HPMenu.Icons.alohPageTexture2'
     LifeSpan=2
}
