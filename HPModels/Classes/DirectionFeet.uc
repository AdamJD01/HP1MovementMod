//===============================================================================
//  [DirectionFeet] 
//===============================================================================

class DirectionFeet extends actor;
#exec MESH  MODELIMPORT MESH=DirectionFeetMesh MODELFILE=models\DirectionFeetMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=DirectionFeetMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=DirectionFeetAnims ANIMFILE=models\DirectionFeetAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=DirectionFeetMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=DirectionFeetMesh ANIM=DirectionFeetAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=DirectionFeetAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=DirectionFeetTex0  FILE=TEXTURES\DirectionFeetTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=DirectionFeetMesh NUM=0 TEXTURE=DirectionFeetTex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: feet.bmp  Path: D:\Harry Potter\Art\Objects\General Objects\project objects

defaultproperties
{
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HPModels.DirectionFeetMesh'
}
