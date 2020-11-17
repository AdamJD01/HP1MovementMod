class flintPage expands baseSpellPage;


#EXEC TEXTURE IMPORT NAME=flintPageTexture1	 FILE=TEXTURES\flintPageTexture1.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#EXEC TEXTURE IMPORT NAME=flintPageTexture2	 FILE=TEXTURES\flintPageTexture2.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#EXEC TEXTURE IMPORT NAME=flintPageTexture3	 FILE=TEXTURES\flintPageTexture3.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#EXEC TEXTURE IMPORT NAME=flintPageTexture4	 FILE=TEXTURES\flintPageTexture4.bmp GROUP="Icons" FLAGS=2 MIPS=OFF

defaultproperties
{
     pagePieces(0)=Texture'HPMenu.Icons.flintPageTexture1'
     pagePieces(1)=Texture'HPMenu.Icons.flintPageTexture2'
     pagePieces(2)=Texture'HPMenu.Icons.flintPageTexture3'
     pagePieces(3)=Texture'HPMenu.Icons.flintPageTexture4'
     LifeSpan=2
}
