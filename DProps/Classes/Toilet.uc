//===============================================================================
//  [Toilet] 
//===============================================================================

class Toilet extends DProps;
#exec MESH  MODELIMPORT MESH=ToiletMesh MODELFILE=models\Toilet.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=ToiletMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=ToiletAnims ANIMFILE=models\Toilet.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=ToiletMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=ToiletMesh ANIM=ToiletAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=ToiletAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=ToiletTex0  FILE=TEXTURES\ToiletTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=ToiletMesh NUM=0 TEXTURE=ToiletTex0

// Original material [0] is [Material #2] SkinIndex: 0 Bitmap: Toilet_128.bmp  Path: \\Baker\HPotterPC\Art\Models\Objects\Dursley Props

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'DProps.ToiletMesh'
}
