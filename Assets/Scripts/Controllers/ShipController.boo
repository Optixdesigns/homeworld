import UnityEngine
import System

/*-----------------------------------------------------------------------------
    Ship Object
-----------------------------------------------------------------------------*/
class ShipController(MonoBehaviour):
    public maxHealth as single               // Maximum health
    public health as single                  // current healt
    public selectable as bool                // Selectable object
    public selected as bool                // Selected or not

    public player as Player // Owner of this ship