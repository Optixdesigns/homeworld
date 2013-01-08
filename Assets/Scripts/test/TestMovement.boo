import UnityEngine

class TestMovement (MonoBehaviour):
	public speed as single = 10

	def Start ():
		pass
	
	def Update ():
		transform.position += Vector3(0, 0, speed)
