//===============================================================================
//  [TrollThrowFrag3] 
//===============================================================================

class TrollThrowFrag3 extends TrollThrowbaseFragment;
#exec MESH  MODELIMPORT MESH=TrollThrowFrag3Mesh MODELFILE=models\TrollThrowFrag3Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=TrollThrowFrag3Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=TrollThrowFrag3Anims ANIMFILE=models\TrollThrowFrag3Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=TrollThrowFrag3Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=TrollThrowFrag3Mesh ANIM=TrollThrowFrag3Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=TrollThrowFrag3Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=TrollThrowFrag3Tex0  FILE=TEXTURES\TrollThrowFrag3Tex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=TrollThrowFrag3Mesh NUM=0 TEXTURE=TrollThrowFrag3Tex0

// Original material [0] is [Material #2] SkinIndex: 0 Bitmap: TrollThrowToilet.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.TrollThrowFrag3Mesh'
     bCollideWorld=True
     bBlockActors=True
     bBlockPlayers=True
}
