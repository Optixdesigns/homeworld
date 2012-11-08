import UnityEngine
import System


/*-----------------------------------------------------------------------------
    Holds the ship static properties
-----------------------------------------------------------------------------*/
class ShipProperties (MonoBehaviour):

	public maxHealth as single               // Maximum health 
	public selectable as bool                // Selectable object
	public maxSpeed as single               // Top speed of this ship
	public accelerationSpeed as single               // Acceleration speed

	public thrustStrength as single
    public rotationStrength as single
    public turnSpeed as single	// How fast this ship can turn