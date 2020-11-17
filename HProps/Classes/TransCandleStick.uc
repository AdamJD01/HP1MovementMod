//===============================================================================
//  [TransCandleStick] 
//===============================================================================

class TransCandleStick extends HProps;
#exec MESH  MODELIMPORT MESH=TransCandleStickMesh MODELFILE=models\TransCandleStickMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=TransCandleStickMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=TransCandleStickAnims ANIMFILE=models\TransCandleStickAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=TransCandleStickMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=TransCandleStickMesh ANIM=TransCandleStickAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=TransCandleStickAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=TransCandleStickTex0  FILE=TEXTURES\TransCandleStickTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=TransCandleStickMesh NUM=0 TEXTURE=TransCandleStickTex0

// Original material [0] is [Material #9] SkinIndex: 0 Bitmap: dblecndl_128.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\Transfigurations Class

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.TransCandleStickMesh'
}
