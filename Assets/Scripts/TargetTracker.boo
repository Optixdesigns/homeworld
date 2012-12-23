import UnityEngine

#enum radiusShape:


[System.Serializable]
class Perimeter:
	[SerializeField]
	// The layer the perimeter will be added to when it is created at run-time. 
	// The perimeter is created when the GameObject with this TargetTracker is instantiated. 
	// You are given this object because the perimeter uses a collider trigger and you may wish to add it to a layer that is ignored by other physics objects in your game. 
	// We recommend creating a layer in your game called "Perimeters".
	#public layer as LayerMask
	// The shape of the area that will be used to detect targets in range.
	#public shape as int = 10
	public range as single = 10
	public drawGizmo as bool = false


class TargetTracker(MonoBehaviour):
	public numberOfTargets as int = 1
	private targets as (Targetable) = array(Targetable, 0)
	#public targetLaters as int

	#private static _cachedDetectableObjects as Dictionary[of Collider, Detectable] = Dictionary[of Collider, Detectable]()
	[SerializeField]
	public layersChecked as LayerMask
	[SerializeField]
	public perimeter as Perimeter

	def Awake ():
		InitPerimeter()
	
	def Update ():
		pass

	def InitPerimeter():
		// Setup the perimiter object
		p = GameObject.CreatePrimitive(PrimitiveType.Sphere)
		p.name = "Radar Perimeter"
		p.tag = "Perimeter"
		p.transform.parent = transform
		p.renderer.enabled = false
		return p

	private def OnDrawGizmos():
		// Draw perimiter in editor
		if perimeter.drawGizmo:
			pos = transform.position
			Gizmos.color = Color.cyan
			Gizmos.DrawWireSphere(pos, perimeter.range)