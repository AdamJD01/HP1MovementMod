//===============================================================================
//  [HedwigsScroll] 
//===============================================================================

class demoscroll extends basescroll;
//#EXEC MESH  MODELIMPORT MESH=HedwigsScrollMesh MODELFILE=models\HedwigsScroll.PSK LODSTYLE=10
//#EXEC MESH  ORIGIN MESH=HedwigsScrollMesh X=0 Y=0 Z=00 YAW=0 PITCH=0 ROLL=0
//#EXEC ANIM  IMPORT ANIM=HedwigsScrollAnims ANIMFILE=models\HedwigsScroll.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#EXEC MESHMAP   SCALE MESHMAP=HedwigsScrollMesh X=1.0 Y=1.0 Z=1.0
//#EXEC MESH  DEFAULTANIM MESH=HedwigsScrollMesh ANIM=HedwigsScrollAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
//#EXEC ANIM DIGEST  ANIM=HedwigsScrollAnims VERBOSE

//#EXEC TEXTURE IMPORT NAME=HedwigsScrollTex0  FILE=TEXTURES\HedwScrl_64.bmp  GROUP=Skins

//#EXEC MESHMAP SETTEXTURE MESHMAP=HedwigsScrollMesh NUM=0 TEXTURE=HedwigsScrollTex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: HedwScrl_64.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\General Objects 




function PreBeginPlay()
{
	local rotator rot;

	scrollparticle=spawn(class'scrollfx');
	rot.pitch=-16000;
	rot.roll=0;
	rot.yaw=0;
	scrollparticle.setrotation(rot);
	Super.PreBeginPlay();
}

function touch(actor other)
{
	if(other==playerharry)
	{
		// AE:
		PlaySound(sound 'HPSounds.magic_sfx.pickup_page');

		playerharry.clientMessage("demo scroll touch");
		baseHud(playerharry.myHud).ShowPopup(class'hagletter2');
		popup=baseHud(playerharry.myHud).curPopup;
		gotostate('popstate');

		scrollparticle.destroy();
	}
}	

defaultproperties
{
     Mesh=SkeletalMesh'HarryPotter.HedwigsScrollMesh'
     CollisionHeight=100
}
