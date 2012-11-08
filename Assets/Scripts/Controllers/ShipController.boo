import UnityEngine
import System

/*-----------------------------------------------------------------------------
    Ship Object
-----------------------------------------------------------------------------*/
class ShipController(MonoBehaviour):

    private health as single                  // current healt
    private selected as bool                // Selected or not
    private speed as single                // Current speed/velocity

    public player as Player // Owner of this ship