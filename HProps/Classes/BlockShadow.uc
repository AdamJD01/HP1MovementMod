//===============================================================================
//  [BlockShadow] 
//===============================================================================

class BlockShadow extends ActorShadow;

#exec TEXTURE IMPORT FILE=Textures\BlockShadowT.bmp NAME=BlockShadowT

defaultproperties
{
     ShadowSizeFactor=1.5
     bOriented=True
     MultiDecalLevel=3
     Texture=Texture'HProps.BlockShadowT'
}
