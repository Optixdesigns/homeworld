import UnityEngine
import System

/*-----------------------------------------------------------------------------
    Ship Controller: Controls the current state of an ship
-----------------------------------------------------------------------------*/
#import Ship as AIShip
#[System.Serializable]
public class AIShipBehaviours(AIBehaviours):
    public behaviourOnIdle as MonoBehaviour
    public behaviourOnMove as MonoBehaviour
    public behaviourOnAttack as MonoBehaviour
    public behaviourOnAttackCancel as MonoBehaviour
    public behaviourOnGuard as MonoBehaviour
    public behaviourOnStart as MonoBehaviour

    public triggerOnAttack as MonoBehaviour

    private currentBehaviour as MonoBehaviour
    /*
    def Awake():
        pass
        # Set current behaviour
        currentBehaviour = behaviourOnStart
        currentBehaviour.enabled = true
        
        # Loop through all behaviours and disable them just to be sure
        if behaviourOnMove:
            behaviourOnMove.enabled = false
        if behaviourOnAttack:
            behaviourOnAttack.enabled = false
        if behaviourOnAttackCancel:
            behaviourOnAttackCancel.enabled = false
        if behaviourOnGuard:
            behaviourOnGuard.enabled = false

        // Setup collision sphere
        #sphere = gameObject.GetComponent("SphereCollider")
        #sphere.radius = baseProperties.collisionRadius
        #_collisionSphere.isTrigger = true
        #print(_collisionSphere.Rigidbody)
   */
    #def Update():
        #ChangeState(behaviourOnMove)

    public def ChangeState(behaviour as MonoBehaviour):
        # ADD EXIT POST AND PRE PROCESSORS FOR SMOOTH TRANSITIONS
        // Disable current state
        currentBehaviour.enabled = false
        // Enable new bahavior
        currentBehaviour = behaviour
        currentBehaviour.enabled = true
    
    def OnTriggerEnter(collider as Collider):
        // Debug-draw all contact points and normals
        #for contact as ContactPoint in collision.contacts:
            #Debug.DrawRay(contact.point, contact.normal, Color.white)
        
        print("collision")
        Debug.Log("yes")

    def OnCollisionEnter(collider as Collision):
        // Debug-draw all contact points and normals
        #for contact as ContactPoint in collision.contacts:
            #Debug.DrawRay(contact.point, contact.normal, Color.white)
        
        print("collision")
        Debug.Log("yes")