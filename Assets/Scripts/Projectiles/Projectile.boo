import UnityEngine

abstract class Projectile(MonoBehaviour):
    public TTL as single = 10
    public muzzleVelocity as Vector3

    def Start ():
        Destroy(gameObject, TTL)    // Kill ourselfs
    
    def Update ():
        transform.position += muzzleVelocity * Time.deltaTime
        transform.LookAt(transform.position + muzzleVelocity.normalized)
        Debug.DrawLine(transform.position, transform.position + muzzleVelocity.normalized, Color.red)
