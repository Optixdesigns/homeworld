import UnityEngine
import System

/*-----------------------------------------------------------------------------
    Ship Controller: Controls the current state of an ship
-----------------------------------------------------------------------------*/
class Ship(MonoBehaviour):

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

    public currentBehaviour as MonoBehaviour

    def OnEnable():
        currentBehaviour = behaviourOnIdle
        currentBehaviour.enabled = true
        
        # Loop through all behaviours and disable them
        behaviourOnMove.enabled = false
        #behaviourOnAttack.enabled = false
        #behaviourOnAttack.enabled = false
        #behaviourOnAttack.enabled = false

    def Update():
        ChangeState(behaviourOnMove)

    public def ChangeState(behaviour as MonoBehaviour):
        # ADD EXIT POST AND PRE PROCESSORS FOR SMOOTH TRANSITIONS

        // Disable current state
        currentBehaviour.enabled = false
        // Enable new bahavior
        currentBehaviour = behaviour
        currentBehaviour.enabled = true
