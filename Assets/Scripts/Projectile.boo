import UnityEngine

class Projectile (MonoBehaviour):
	public selfDestructTime as single = 10 

	def Start ():
		Destroy(gameObject, selfDestructTime)	// Kil ourselfs
	
	def Update ():
		pass
