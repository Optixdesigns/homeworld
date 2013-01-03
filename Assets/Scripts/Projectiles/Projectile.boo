import UnityEngine
import System.Collections
import System.Collections.Generic


[AddComponentMenu('New World/Ammo/Projectile')]
#[RequireComponent(typeof(Rigidbody))]
class Projectile(MonoBehaviour):
    public TTL as single = 10   // time to life
    public damage as single = 5
    public damageRadius as single = 5
    public speed as single = 200
    public explosionPrefab as GameObject
    public target as Target

    /// If true, more than just the primary target will be affected when this projectile
    /// detonates. Use the range options to determine the behavior.
    /*
    public areaHit as bool = false

    public detonationMode as DETONATION_MODES = DETONATION_MODES.HitLayers

    public enum DETONATION_MODES:
        TargetOnly
        HitLayers
    */

    public _effectsOnTarget as List[of HitEffectGUIBacker] = List[of HitEffectGUIBacker]()

    // Encodes / Decodes HitEffects to and from HitEffectGUIBackers
    public effectsOnTarget as HitEffectList:
        get:
            // Convert the stored _effectsOnTarget backing field to a list of HitEffects
            returnHitEffectsList = HitEffectList()
            for effectBacker in self._effectsOnTarget:
                // Create and add a struct-form of the backing-field instance
                returnHitEffectsList.Add(HitEffect())
            
            return returnHitEffectsList
        set:
            
            // Convert and store the bassed list of HitEffects as HitEffectGUIBackers
            // Clear and set the backing-field list also used by the GUI
            self._effectsOnTarget.Clear()
            
            effectBacker as HitEffectGUIBacker
            for effect in value:
                effectBacker = HitEffectGUIBacker(effect)
                self._effectsOnTarget.Add(effectBacker)

    public debugLevel as DEBUG_LEVELS = DEBUG_LEVELS.Off

    /// Keeps the state of each individual foldout item during the editor session
    public _editorListItemStates as Dictionary[of object, bool] = Dictionary[of object, bool]()

    def Start ():
        #transform.localScale = Vector3(0.1,0,0)
        Destroy(gameObject, TTL)
    
    def Update():
        #speed = Mathf.Clamp(speed + acceleration, 0, maxSpeed)
        transform.position += transform.forward * speed * Time.deltaTime
        #rigidbody.velocity = transform.TransformDirection(muzzleVelocity)
        #Debug.DrawLine(transform.position, transform.position + muzzleVelocity.normalized, Color.red)

    def OnCollisionEnter(collision as Collision):
        #contact as ContactPoint = collision.contacts[0]
        #rot as Quaternion = Quaternion.FromToRotation(Vector3.up, contact.normal)
        #pos as Vector3 = contact.point
        #(Instantiate(explosionPrefab, pos, rot) as Transform)
        
        #collision.gameObject.SendMessage("ApplyDamage", damage, SendMessageOptions.DontRequireReceiver)
        #if collision.gameObject.health:
           #collision.gameObject.health.ApplyDamage(damage) 
        
        
        Debug.Log(collision.gameObject.name + ": Collision yes")
        Destroy(gameObject)

   # def OnTriggerEnter(other as Collider):
        #Destroy(gameObject)
        #Debug.Log("trigger")
