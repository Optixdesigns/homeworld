import UnityEngine
import System

/*-----------------------------------------------------------------------------
    Ship Controller: Controls the current state of an ship
-----------------------------------------------------------------------------*/
class ShipController(MonoBehaviour):

    #private health as single                  // current health
    private selected as bool                // Selected flag
    private speed as single                // Current speed/velocity

    public target as GameObject
    public player as Player // Owner of this ship

    public behaviourOnIdle as MonoBehaviour
    public behaviourOnMove as MonoBehaviour
    public behaviourOnAttack as MonoBehaviour
    public behaviourOnAttackCancel as MonoBehaviour
    public behaviourOnGuard as MonoBehaviour

    def OnEnable():
        behaviourOnIdle.enabled = true
        behaviourOnMove.enabled = false
        #behaviourOnAttack.enabled = false
        #behaviourOnAttack.enabled = false
        #behaviourOnAttack.enabled = false

    #public def ChangeState(state as States):
        #fsm.ChangeState(state)
