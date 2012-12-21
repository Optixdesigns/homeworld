import UnityEngine

public class SimpleTurret(Weapon):

    def Update():
        pass

    public def Fire():
        if Time.time > fireTimer and TargetInRange(target):
            clone as GameObject = Instantiate(projectilePrefab, transform.position, transform.rotation)
            #clone.GetComponent(typeof(Projectile)).speed = unit.movement.Speed // Same momentum as this object
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
