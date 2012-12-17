import UnityEngine

class EmissionController (MonoBehaviour):

	def Awake ():
		unit as Unit = transform.parent.GetComponent(typeof(Unit))
		p = unit.player.GetComponent(PlayerController)
		GetComponent(TrailRenderer).material.SetColor("_Color", p.color)
	
	def Update ():
		pass
