import UnityEngine

class Perimeter(MonoBehaviour):
    // The layer the perimeter will be added to when it is created at run-time. 
    // The perimeter is created when the GameObject with this TargetTracker is instantiated. 
    // You are given this object because the perimeter uses a collider trigger and you may wish to add it to a layer that is ignored by other physics objects in your game. 
    // We recommend creating a layer in your game called "Perimeters".
    #public layer as LayerMask
    // The shape of the area that will be used to detect targets in range.
    #public shape as int = 10

    #private targets as (Target) = array(Target, 0)
    public targets as List[of Target] = List[of Target]()
    internal targetTracker as TargetTracker

    def Awake ():
        pass
    
    def Update ():
        pass

    private def OnTriggerEnter(other as Collider):
        target as Target = Target(other.transform, self.targetTracker)

        // Do Add() only if this is targetable
        if not target.targetable:
            return

        self.Add(target)

    private def OnTriggerExit(other as Collider):
        self.Remove(other.transform)

    public def Add(target as Target):
        targets.Add(target)

    public def Remove(t as Transform):
        targets.Remove(Target(t, self.targetTracker))
