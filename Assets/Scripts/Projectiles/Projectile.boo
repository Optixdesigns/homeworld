import UnityEngine

abstract class Projectile(MonoBehaviour):
    public TTL as single = 10   // time to life
    public muzzleVelocity as Vector3
    #public size as Vector3

    def Start ():
        #transform.localScale = Vector3(0.1,0,0)
        Destroy(gameObject, TTL)
    
    def Update ():
        rigidbody.velocity = transform.TransformDirection(muzzleVelocity)
        #Debug.DrawLine(transform.position, transform.position + muzzleVelocity.normalized, Color.red)


    def OnCollisionEnter(collision as Collision):
        #contact as ContactPoint = collision.contacts[0]
        #rot as Quaternion = Quaternion.FromToRotation(Vector3.up, contact.normal)
        #pos as Vector3 = contact.point
        #(Instantiate(explosionPrefab, pos, rot) as Transform)
        
        Destroy(gameObject)
        Debug.Log("Collision yes")

   # def OnTriggerEnter(other as Collider):
        #Destroy(gameObject)
        #Debug.Log("trigger")
