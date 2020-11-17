//===============================================================================
//  [masterScroll] 
//===============================================================================

class masterScroll extends baseProps;
//#EXEC MESH  MODELIMPORT MESH=HedwigsScrollMesh MODELFILE=models\HedwigsScroll.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=HedwigsScrollMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=HedwigsScrollAnims ANIMFILE=models\HedwigsScroll.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=HedwigsScrollMesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=HedwigsScrollMesh ANIM=HedwigsScrollAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=HedwigsScrollAnims VERBOSE

//#EXEC TEXTURE IMPORT NAME=HedwigsScrollTex0  FILE=TEXTURES\HedwScrl_64.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=HedwigsScrollMesh NUM=0 TEXTURE=HedwigsScrollTex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: HedwScrl_64.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\General Objects 


function touch(actor other)
{
	if(other==playerharry)
	{
		
		if(puzzle!=none)
		{
		
			puzzle.settimer(60,false);
			hpHud(playerharry.myHud).StartCountdown(60.0);
			baseWand(playerharry.weapon).selectSpell(Class'spellAvif');
    
		}
		baseHud(playerharry.myHud).ShowPopup(class'masterLetter');
		destroy();
	}
}

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HarryPotter.HedwigsScrollMesh'
     DrawScale=3
}
