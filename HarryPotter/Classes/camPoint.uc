//---------
// navigation point for the camera rail
//---------


class camPoint extends Actor;

//#EXEC Texture Import File=Textures\node.bmp Name=node Mips=Off Flags=2

var() int  next;
var() int  id;
var() int  rotationSpeed;   // the greater the number the slower the turn
var() int  speed;

defaultproperties
{
     rotationSpeed=200
     Speed=2
     Texture=Texture'HarryPotter.Node'
}
