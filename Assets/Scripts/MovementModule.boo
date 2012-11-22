import UnityEngine

class MovementModule (MonoBehaviour): 
	def Start ():
		pass
	
	def Update ():
		pass

	def MoveTo():
		gameobject.transform.position = Vector3.MoveTowards(gameObject.transform.position, unit.target.transform.position, unit.baseProperties.maxVelocity / 5)

	def Stop():
		pass
		#gameobject.transform.position = Vector3.MoveTowards(gameObject.transform.position, unit.target.transform.position, unit.baseProperties.maxVelocity / 5)
