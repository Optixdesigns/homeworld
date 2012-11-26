import UnityEngine
import System


#[System.Serializable]
[AddComponentMenu('Neworld/Unit Modules/Weapons Module')]
public class WeaponsModule(MonoBehaviour):
    public damage as single
    public minShootDistance as single = 5.0    // Attack range minum
    public maxShootDistance as single = 20.0   // Attack range maximum
    #public projectileSpeed as single = 10.0
    public RateOfFire as single = 1.0
    public fieldOfViewRange as single = 50

    public projectilePrefab as GameObject
    #public weapons as (Weapon) = array(Weapon, 0)

    private fireTimer as single // cooldown timer
    private unit as Unit

    private hit as RaycastHit

    def Start():
        unit = gameObject.GetComponent(typeof(Unit))
        fireTimer = Time.time + RateOfFire

    def Update():
        if unit.target:
            Shoot()

    def TargetInRange(t as GameObject) as bool:
        rayDirection as Vector3 = t.transform.position - transform.position
        angle as single = Vector3.Angle(rayDirection, transform.forward)
        if angle < fieldOfViewRange and (unit.targetDistance > minShootDistance and unit.targetDistance < maxShootDistance):
            Debug.Log("target is in range")
            return true
        
        return false

    public def Shoot():
        if Time.time > fireTimer and TargetInRange(unit.target):
            clone as GameObject = Instantiate(projectilePrefab, transform.position, transform.rotation)
            fireTimer = Time.time + RateOfFire

    def OnDrawGizmosSelected():
        // Debug attack field of view
        totalFOV as single = 70.0f;
        rayRange as  single = fieldOfViewRange;
        halfFOV as single = totalFOV / 2.0f;
        leftRayRotation as Quaternion = Quaternion.AngleAxis( -halfFOV, Vector3.up )
        rightRayRotation as Quaternion = Quaternion.AngleAxis( halfFOV, Vector3.up )
        leftRayDirection as Vector3 = leftRayRotation * transform.forward
        rightRayDirection as Vector3 = rightRayRotation * transform.forward
        Gizmos.DrawRay( transform.position, leftRayDirection * rayRange )
        Gizmos.DrawRay( transform.position, rightRayDirection * rayRange )