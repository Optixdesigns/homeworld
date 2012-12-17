import UnityEngine

class EmissionController (MonoBehaviour):

	def Awake ():
		unit as Unit = transform.parent.GetComponent(typeof(Unit))
		GetComponent(TrailRenderer).material.SetColor("_Color", unit.player.color)
	
	def Update ():
		pass
