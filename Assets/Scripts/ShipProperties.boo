import UnityEngine
import System


/*-----------------------------------------------------------------------------
    Holds the ship static properties
-----------------------------------------------------------------------------*/
[System.Serializable]
public class ShipProperties:
    public mass as single = 0.1
    public maxVelocity as single = 1.0               // // maximum velocity
    public maxRotate as single = 1.0             // maximum rotate speed
    public accelerationSpeed as single = 1.0         // Acceleration speed
    public collisionRadius as single = 2.0 // Collision Radius
    public attackPattern as AttackPattern // The attack pattern for this ship


    #public thrustStrength as single
    #public rotationStrength as single
    #public turnSpeed as single  // How fast this ship can turn