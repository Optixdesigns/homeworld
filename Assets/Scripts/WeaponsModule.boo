import UnityEngine
import System


#[System.Serializable]
[AddComponentMenu('Neworld/Unit Modules/Weapons Module')]
public class WeaponsModule(MonoBehaviour):
    public damage as single
    public minAttackDistance as single = 5.0	// Attack range minum
    public maxAttackDistance as single = 10.0	// Attack range maximum
    public projectileSpeed as single = 10.0
    public cooldown as single = 10.0

    public projectilePrefab as GameObject
    #public weapons as (Weapon) = array(Weapon, 0)

    def Awake():
        pass

    def Start():
        pass

    public def Shoot(t as GameObject):
    	clone as GameObject = Instantiate(projectilePrefab, transform.position, transform.rotation)
    	clone.rigidbody.AddForce(clone.transform.forward * projectileSpeed)

