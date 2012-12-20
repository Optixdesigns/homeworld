import UnityEngine

class AutoScaler(MonoBehaviour):
	/// Autoscale to the 1 unit (1 kilomter
	public meters as single = 10 	// Size of the object (z axis)
	private unitMeterSize = 1000	// Unit size in meters

	def Awake ():
		z = (1.00/unitMeterSize) * meters
		x = (1.00/unitMeterSize) * meters
		y = (1.00/unitMeterSize) * meters
		transform.localScale = Vector3(x, y, z)
	
	def Update ():
		pass
