import UnityEngine
import System


[System.Serializable]
public class DamageAttribute(MonoBehaviour):

    public damage as single
    public minAttackDistance as single = 5.0	// Attack range minum
    public maxAttackDistance as single = 10.0	// Attack range maximum

    public projectilePrefab as GameObject
    #public weapons as (Weapon) = array(Weapon, 0)

    public def Shoot(t as GameObject):
    	pass

