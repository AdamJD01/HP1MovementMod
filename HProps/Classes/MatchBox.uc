//===============================================================================
//  [MatchBox] 
//===============================================================================

class MatchBox extends HProps;
#exec MESH  MODELIMPORT MESH=MatchBoxMesh MODELFILE=models\MatchBoxMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=MatchBoxMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=MatchBoxAnims ANIMFILE=models\MatchBoxAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=MatchBoxMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=MatchBoxMesh ANIM=MatchBoxAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=MatchBoxAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=MatchBoxTex0  FILE=TEXTURES\MatchBoxTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=MatchBoxMesh NUM=0 TEXTURE=MatchBoxTex0

// Original material [0] is [Material #26] SkinIndex: 0 Bitmap: matchbox_128.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\General Objects 


auto state droptoground
{
	begin:
	setphysics(Phys_falling);
	loop:
		sleep(5);
		goto 'loop';




}

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.MatchBoxMesh'
     bCollideWorld=True
}
