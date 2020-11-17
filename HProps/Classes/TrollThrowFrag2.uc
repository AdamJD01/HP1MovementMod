//===============================================================================
//  [TrollThrowFrag2] 
//===============================================================================

class TrollThrowFrag2 extends TrollThrowbaseFragment;
#exec MESH  MODELIMPORT MESH=TrollThrowFrag2Mesh MODELFILE=models\TrollThrowFrag2Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=TrollThrowFrag2Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=TrollThrowFrag2Anims ANIMFILE=models\TrollThrowFrag2Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=TrollThrowFrag2Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=TrollThrowFrag2Mesh ANIM=TrollThrowFrag2Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=TrollThrowFrag2Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=TrollThrowFrag2Tex0  FILE=TEXTURES\TrollThrowFrag2Tex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=TrollThrowFrag2Mesh NUM=0 TEXTURE=TrollThrowFrag2Tex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: TrollThrowSink.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.TrollThrowFrag2Mesh'
     bCollideWorld=True
     bBlockActors=True
     bBlockPlayers=True
}
