import UnityEngine
import System


#[System.Serializable]
[AddComponentMenu('Neworld/Unit Modules/Weapons Module')]
public class WeaponsModule(MonoBehaviour):
    #public damage as single
    #public minShootDistance as single = 5.0    // Attack range minum
    #public maxShootDistance as single = 20.0   // Attack range maximum
    #public projectileSpeed as single = 10.0
    #public RateOfFire as single = 1.0
    #public fieldOfViewRange as single = 50
    #public fieldOfViewSide as Vector3 = transform.forward

    #public projectilePrefab as GameObject
    #public weapons as (Weapon) = array(Weapon, 0)

    #private fireTimer as single // cooldown timer
    #private unit as Unit

    private hit as RaycastHit

    private weapons as (Weapon) = array(Weapon, 0)

    def Awake():
        GetWeapons()

    def Start():
        pass
        #unit = gameObject.GetComponent(typeof(Unit))
        #fireTimer = Time.time + RateOfFire

    def Update():
        pass
        //Fire()

    def Fire():
        pass

    def GetWeapons():
        // load all weapons on this gameobject
        weapons = GetComponentsInChildren[of Weapon]()
        Debug.Log(weapons.Length)
        return weapons

    def AddWeapon(weapon as Weapon):
        pass
