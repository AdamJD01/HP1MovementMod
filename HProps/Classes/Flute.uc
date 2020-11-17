//===============================================================================
//  [Flute] 
//===============================================================================

class Flute extends HProps;
#exec MESH  MODELIMPORT MESH=FluteMesh MODELFILE=models\FluteMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=FluteMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=-64
#exec ANIM  IMPORT ANIM=FluteAnims ANIMFILE=models\FluteAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=FluteMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=FluteMesh ANIM=FluteAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=FluteAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=FluteTex0  FILE=TEXTURES\FluteTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=FluteMesh NUM=0 TEXTURE=FluteTex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: flute_128.bmp  Path: D:\Harry Potter\Art\Objects\General Objects\flute 

var ParticleFX FluteFX;

function touch (actor other)
{
	if(other==playerharry && other!=owner)
	{
		gotostate('killFlute');

	}

}

function Tick(float dtime)
{
	local vector   v;

	if( Owner == playerHarry )
	{
		SetLocation( playerHarry.weaponLoc );
		SetRotation( playerHarry.weaponRot );
	}

	if( FluteFX != none )
	{
		v = vect(0,0,15);
		v = v >> playerHarry.weaponRot;
		FluteFX.SetLocation( playerHarry.weaponLoc + v );
	}

}

state killFlute
{
	begin:
		playerharry.bHasFlute = true;
		
		destroy();
	loop:
		sleep(1);
		goto 'loop';
}

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.FluteMesh'
}
