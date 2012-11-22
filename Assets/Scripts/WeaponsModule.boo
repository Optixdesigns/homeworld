import UnityEngine
import System


#[System.Serializable]
[AddComponentMenu('Neworld/Unit Modules/Weapons Module')]
public class WeaponsModule(MonoBehaviour):
    public damage as single
    public minAttackDistance as single = 5.0    // Attack range minum
    public maxAttackDistance as single = 10.0   // Attack range maximum
    public projectileSpeed as single = 10.0
    public cooldownPeriod as single = 50.0

    public projectilePrefab as GameObject
    #public weapons as (Weapon) = array(Weapon, 0)

    private coolDownTimer as single // cooldown timer

    def Awake():
        pass

    def Start():
        coolDownTimer = 0

    def Update():
        #Debug.Log(coolDownTimer)
        if coolDownTimer > 0:
            #Debug.Log(coolDownTimer)
            coolDownTimer = coolDownTimer - 1

    public def IsOnCooldown() as bool:
        if coolDownTimer > 0:
            return true

        return false

    public def CanShoot() as bool:
        if IsOnCooldown():
            return false
        
        return true

    public def Shoot():
        if CanShoot():
            clone as GameObject = Instantiate(projectilePrefab, transform.position, transform.rotation)
            clone.rigidbody.velocity = transform.TransformDirection(Vector3( 0, 0, projectileSpeed))
            coolDownTimer = cooldownPeriod

