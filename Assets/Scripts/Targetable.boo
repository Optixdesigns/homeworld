import UnityEngine

class Targetable(MonoBehaviour):

	public callable Onhit(target as Targetable)

	// Triggered once when this target is first detected by a TargetTracker.
	// Argument: A reference back to the Radar component which triggered this event
	public callable OnDetected(source as Radar)

	// Triggered once when this target is no longer detected by a TargetTracker.
	// Argument: A reference back to the Radar component which triggered this event
	public callable OnNotDetected(source as Radar)


	def Start ():
		pass
	
	def Update ():
		pass
