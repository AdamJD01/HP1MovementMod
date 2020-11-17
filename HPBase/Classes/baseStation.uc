class baseStation extends basePath;



#exec Texture Import File=..\engine\Textures\station.pcx Name=station Mips=Off Flags=2


struct stationData
{
var()  name stationDestination;
var()  int  nextStationGroup;
var()  name pathType;
var()  name firstPath;
var()  rotator rotation;
var() float PauseTime;
var() enum EBehavior
{
	BH_Idle1,
	BH_Idle2,
	BH_Idle3,
	BH_None,
	BH_Die
}Behavior;

};


//var (station) float PauseTime;

//var (station) name stationDestination;
//var (station) name pathType;
//var (station) name firstPath;
//var (station) rotator rotation;

var (station)stationData aiData[4];





	

defaultproperties
{
     bDirectional=True
     Texture=Texture'HPEdit.Icons.station'
     bCollideActors=True
}
