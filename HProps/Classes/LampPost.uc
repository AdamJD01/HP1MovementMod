//===============================================================================
//  [LampPost] 
//===============================================================================

class LampPost extends HProps;
#exec MESH  MODELIMPORT MESH=LampPostMesh MODELFILE=models\LampPostMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=LampPostMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=LampPostAnims ANIMFILE=models\LampPostAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=LampPostMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=LampPostMesh ANIM=LampPostAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=LampPostAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=LampPostTex0  FILE=TEXTURES\LampPostTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=LampPostMesh NUM=0 TEXTURE=LampPostTex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: lamppost_128.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\Grand Entrance

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.LampPostMesh'
}
