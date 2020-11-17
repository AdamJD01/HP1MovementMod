class ectoMark expands Scorch;

#exec TEXTURE IMPORT NAME=ectosplat FILE=TEXTURES\ectosplat.bmp LODSET=2
//#exec TEXTURE IMPORT NAME=ectosplat2 FILE=TEXTURES\goo_splat2.PCX LODSET=2
#exec TEXTURE IMPORT NAME=ectosplat2 FILE=TEXTURES\ectosplat2.bmp LODSET=2

simulated function BeginPlay()
{
	if ( !Level.bDropDetail && (FRand() < 0.5) )
		Texture = texture'HPBase.ectosplat2';
	Super.BeginPlay();
}

defaultproperties
{
     MultiDecalLevel=2
     Texture=Texture'HPBase.ectosplat'
     DrawScale=0.65
}
