import UnityEngine

class Perimeter (MonoBehaviour):
	// The layer the perimeter will be added to when it is created at run-time. 
	// The perimeter is created when the GameObject with this TargetTracker is instantiated. 
	// You are given this object because the perimeter uses a collider trigger and you may wish to add it to a layer that is ignored by other physics objects in your game. 
	// We recommend creating a layer in your game called "Perimeters".
	#public layer as LayerMask
	// The shape of the area that will be used to detect targets in range.
	#public shape as int = 10
	public range as single = 10
	[SerializeField]
	public drawGizmo as bool = false

	private targetList as (Target) = array(Target, 0)

	def Start ():
		pass
	
	def Update ():
		pass

	private def OnTriggerEnter(other as Collider):
		pass
