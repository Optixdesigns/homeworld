import UnityEngine

class testmove (MonoBehaviour): 
	public maxspeed as single = 10 // Max speed/velocity
	public acceleration as single = 2 // Acceleration / seconds

	def Start ():
		pass
	
	def Update ():
		pass

	def FixedUpdate():
		// Add speed
        rigidbody.AddRelativeForce(Vector3.forward * acceleration)
        // Limit velocity to maxspeed
        rigidbody.velocity = Vector3.ClampMagnitude(rigidbody.velocity, maxspeed)
        Debug.Log(rigidbody.velocity)