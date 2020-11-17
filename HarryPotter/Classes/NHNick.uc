//=============================================================================
// NHNick.
//=============================================================================
class NHNick expands baseChar;

defaultproperties
{
     bFollowPatrolPoints=True
     firstPatrolPointObjectName=PatrolPoint0
     bCutFlying=True
     CutWalkAnim=Walk
     CutIdleAnim=Breathe
     CutTalkAnim=Talk
     CutTalkStartAnim=trans2talk
     CutTalkEndAnim=transfromtalk
     Physics=PHYS_Flying
     AnimSequence=Breathe
     Tag=NHNick
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HPModels.skNHNickMesh'
     AmbientGlow=50
     Opacity=0.4
     CollisionHeight=51
     bBlockActors=False
     bBlockPlayers=False
}
