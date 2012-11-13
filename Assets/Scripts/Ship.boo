import UnityEngine
import System

[RequireComponent(typeof(AIShipBehaviours))]
[RequireComponent(typeof(HealthAttribute))]
[RequireComponent(typeof(DamageAttribute))]
[RequireComponent(typeof(Rigidbody))]
class Ship(MonoBehaviour):
    public shipName as string
    private selected as bool                // Selected flag
    private speed as single                // Current speed/velocity

    public target as GameObject // target
    public moveToPosition as Vector3 // move to position
    public player as Player // Owner of this ship

    public baseProperties as ShipProperties

    [HideInInspector]
    public behaviours as AIShipBehaviours
    [HideInInspector]
    public healthAttribute as HealthAttribute
    [HideInInspector]
    public damageAttribute as DamageAttribute

    #private _collisionSphere as SphereCollider // Collision Sphere, used as trigger

    def Awake():
        // Setup initial values and references
        behaviours = gameObject.GetComponent[of AIShipBehaviours]() // REQUIRED
        healthAttribute = gameObject.GetComponent[of HealthAttribute]() // REQUIRED
        damageAttribute = gameObject.GetComponent[of DamageAttribute]() // REQUIRED
        
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

    def setTarget(t as GameObject):
        target = t

    def setTargetPosition(p as Vector3):
        targetPosition = p


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
