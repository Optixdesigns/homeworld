import UnityEngine

class WeaponAutomator(MonoBehaviour): 
    public targetTracker as TargetTracker
    public weapon as Weapon

    #private target as Target

    def Awake ():
        #weapon as typeof(Weapon) = gameObject.GetComponent(typeof(Weapon))
        #Debug.Log(weapon)

        if not targetTracker:
            targetTracker = gameObject.GetComponent(typeof(TargetTracker))
    
    def Update ():
        #transform.position += Vector3(0,0,1)

        #target = FindTarget()
        if not weapon.target:
            target = FindTarget()
            #Debug.Log(target)
            if target:
                weapon.target = target

    public def FindTarget():
        #Debug.Log(self.targetTracker.targets.Count)
        // Find a target from the targettracker pool
        if self.targetTracker:
           if self.targetTracker.targets.Count != 0:
                return self.targetTracker.targets[0].transform

        return false
