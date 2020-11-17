class SpellBlackboard expands actor;

#exec OBJ LOAD FILE=..\textures\HP_FX.utx PACKAGE=HPparticle.hp_fx
#exec OBJ LOAD FILE=..\textures\Particles.utx PACKAGE=HPparticle.particle_fx

//    texture=Texture'HPParticle.hp_fx.Particles.bluefog_01'
//    Texture=Texture'HPParticle.hp_fx.Particles.les_spellbackgrnd_01'

defaultproperties
{
     Style=STY_Modulated
     Texture=IceTexture'HPParticle.hp_fx.General.les_spellbackgrnd'
     DrawScale=0.7
}
