import UnityEngine
import System


[RequireComponent(typeof(AIBehaviours))]
[RequireComponent(typeof(HealthModule))]
[RequireComponent(typeof(WeaponsModule))]
[RequireComponent(typeof(MovementModule))]
[RequireComponent(typeof(Rigidbody))]
[AddComponentMenu('Neworld/Space Unit')]
class Unit(SpaceObject):
    private speed as single                // Current speed/velocity

    public target as GameObject // target
    public moveToPosition as Vector3 // move to position
    public player as Player // Owner of this ship
    public isEnemy as bool = false // Is this an enemy?

    [HideInInspector]
    public fsm as AIBehaviours  /// Relation to the attached FSM
    
    [HideInInspector]
    public health as HealthModule
    [HideInInspector]
    public weapons as WeaponsModule

    public select as SelectController
    public baseProperties as UnitProperties

    #private _collisionSphere as SphereCollider // Collision Sphere, used as trigger

    def Awake():
        // Setup initial values and references
        fsm = gameObject.GetComponent[of AIBehaviours]() // REQUIRED
        health = gameObject.GetComponent[of HealthModule]() // REQUIRED
        weapons = gameObject.GetComponent[of WeaponsModule]() // REQUIRED
        
        // Set rigibody
        gameObject.rigidbody.mass = baseProperties.mass
        gameObject.rigidbody.detectCollisions = false // For now

        // Setup collision sphere
        #_collisionSphere = gameObject.AddComponent("SphereCollider")
        #_collisionSphere.radius = baseProperties.collisionRadius
        #_collisionSphere.isTrigger = true
        #print(_collisionSphere.Rigidbody)

        #print(collider)

        // Check our setup
        if baseProperties.maxVelocity == 0.0:
            Debug.Log("WARNING: Ships maximum velocity is zero")

    def Update():
        pass
        #print("update")

    #def Attack():


    def setTarget(t as GameObject):
        target = t

    def setTargetPosition(p as Vector3):
        targetPosition = p

    /*
    * Receivers
    */

    /// Shoot receiver
    #def Shoot():
        # VALIDATE TARGET
        #weapons.Shoot(target)

    /// Selected state receiver
    def IsSelected(s as bool):
        select.isSelected = s   

    /*
    def OnCollisionEnter(collision as Collision):
        print("collision")
        Debug.Log("yes")

    def OnTriggerEnter(collider as Collider):
        // Debug-draw all contact points and normals
        #for contact as ContactPoint in collision.contacts:
            #Debug.DrawRay(contact.point, contact.normal, Color.white)
        
        print("collision")
        Debug.Log("yes")
        #behaviours.ChangeState(behaviours.behaviourOnIdle)
    */
