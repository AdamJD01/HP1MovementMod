//===============================================================================
//  [mirror response] 
//===============================================================================

class mirrortarget extends HProps;
#exec MESH  MODELIMPORT MESH=GobletMesh MODELFILE=models\GobletMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=GobletMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=GobletAnims ANIMFILE=models\GobletAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=GobletMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=GobletMesh ANIM=GobletAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=GobletAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=GobletTex0  FILE=TEXTURES\GobletTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=GobletMesh NUM=0 TEXTURE=GobletTex0



// Original material [0] is [Material #9] SkinIndex: 0 Bitmap: hoggoblet_128.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\General Objects 

var float localScale;

function bool takespellEffect(baseSpell spell)
{
	if(localScale>0.9)		//avoid shrinking twice
		gotostate( 'shrinkHarry');
}

state shrinkHarry
{

begin:
	localScale=1.0;
//	PlaySound(sound 'spellShrinkSound', SLOT_Misc, 1.0, true, 1000.0, 1.0);
loop:
	localScale=localScale-0.1;
	playerharry.drawscale=localScale;
//	playerharry.weapon.drawscale=localScale;
	if(localScale<=0.30)
	{
		playerharry.drawscale=1.0;
		playerharry.Mesh=SkeletalMesh'harrypotter.skSmallHarryMesh';
		gotostate('expandharry');
	}
	sleep(0.01);
	goto 'loop';



}

state expandHarry
{


begin:
//     playerharry.BaseEyeHeight=40.0;
//     playerharry.EyeHeight=40.0;
//	 playerharry.CollisionHeight=42.0;

	sleep(10);
	playerharry.Mesh=SkeletalMesh'harrypotter.skHarryMesh';
//	PlaySound(sound 'spellUnShrinkSound', SLOT_Misc, 1.0, true, 1000.0, 1.0);
loop:
	localScale=localScale+0.1;
	playerharry.drawscale=localScale;
//	playerharry.weapon.drawscale=localScale;
	if(localScale>=1.0)
	{
		playerharry.drawscale=1.0;
//		playerharry.weapon.drawscale=1.0;
		gotostate('donothing');
		
	}
	sleep(0.01);
	goto 'loop';


}

state donothing
{

	begin:
		sleep (5);
		goto 'begin';
}

defaultproperties
{
     localScale=1
     bStatic=False
     bHidden=True
     Texture=Texture'Engine.S_Trigger'
}
