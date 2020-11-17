//===============================================================================
//  [DeskBooksTwo] 
//===============================================================================

class DeskBooksTwo extends HProps;
#exec MESH  MODELIMPORT MESH=DeskBooksTwoMesh MODELFILE=models\DeskBooksTwoMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=DeskBooksTwoMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=DeskBooksTwoAnims ANIMFILE=models\DeskBooksTwoAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=DeskBooksTwoMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=DeskBooksTwoMesh ANIM=DeskBooksTwoAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=DeskBooksTwoAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=DeskBooksTwoTex0  FILE=TEXTURES\DeskBooksTwoTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=DeskBooksTwoMesh NUM=0 TEXTURE=DeskBooksTwoTex0

// Original material [0] is [Material #8] SkinIndex: 0 Bitmap: BooksRow_128.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\General Objects

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.DeskBooksTwoMesh'
}
