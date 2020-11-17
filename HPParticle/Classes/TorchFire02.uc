//=============================================================================
// TorchFire02.
//=============================================================================
class TorchFire02 expands Fire01;

defaultproperties
{
     ParticlesPerSec=(Base=10)
     SourceWidth=(Base=8)
     SourceHeight=(Base=8)
     SourceDepth=(Base=4)
     AngularSpreadWidth=(Base=5)
     AngularSpreadHeight=(Base=5)
     Speed=(Base=10,Rand=10)
     Lifetime=(Base=1,Rand=0.8)
     ColorStart=(Base=(G=223,B=208),Rand=(R=233,G=33,B=53))
     ColorEnd=(Base=(R=170))
     SizeWidth=(Base=16)
     SizeLength=(Base=16)
     SizeEndScale=(Base=-1,Rand=2)
     SpinRate=(Base=-5,Rand=10)
     DripTime=(Base=0.25)
}
