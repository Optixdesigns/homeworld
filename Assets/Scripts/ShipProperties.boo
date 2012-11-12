import UnityEngine
import System


/*-----------------------------------------------------------------------------
    Holds the ship static properties
-----------------------------------------------------------------------------*/
[System.Serializable]
public class ShipProperties:

    public mass as single = 0.1
    public selectable as bool                // Selectable object
    public maxVelocity as single = 0.0               // // maximum velocity
    public maxRotate as single               // // maximum rotate speed
    public accelerationSpeed as single               // Acceleration speed


    #public thrustStrength as single
    #public rotationStrength as single
    #public turnSpeed as single  // How fast this ship can turn