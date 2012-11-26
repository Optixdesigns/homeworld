import UnityEngine
import System


/*-----------------------------------------------------------------------------
    Holds the ship static properties
-----------------------------------------------------------------------------*/
[System.Serializable]
public class UnitProperties:
    public mass as single = 0.1
    public collisionRadius as single = 2.0 // Collision Radius
    #public attackPattern as AttackPattern // The attack pattern for this ship


    #public thrustStrength as single
    #public rotationStrength as single
    #public turnSpeed as single  // How fast this ship can turn