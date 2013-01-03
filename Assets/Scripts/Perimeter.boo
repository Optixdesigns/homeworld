import UnityEngine

[RequireComponent(typeof(Rigidbody))]
class Perimeter(MonoBehaviour, IList[of Target]):
    // The layer the perimeter will be added to when it is created at run-time. 
    // The perimeter is created when the GameObject with this TargetTracker is instantiated. 
    // You are given this object because the perimeter uses a collider trigger and you may wish to add it to a layer that is ignored by other physics objects in your game. 
    // We recommend creating a layer in your game called "Perimeters".
    #public layer as LayerMask
    // The shape of the area that will be used to detect targets in range.
    #public shape as int = 10

    #private targets as (Target) = array(Target, 0)
    public targets as TargetList = TargetList()
    internal targetTracker as TargetTracker
    internal dirty as bool = true

    def Awake ():
        self.rigidbody.isKinematic = true
        self.rigidbody.useGravity = false
    
    def Update ():
        pass

    def OnTriggerEnter(other as Collider):
        target as Target = Target(other.transform, self.targetTracker)
        #Debug.Log("Collided")

        // Do Add() only if this is targetable
        if not target.targetable:
            return

        self.Add(target)

    def OnTriggerExit(other as Collider):
        self.Remove(other.transform)

    #region List Interface
    public def Add(target as Target):
        self.targets.Add(target)
        target.targetable.perimeters.Add(self)

    public def Remove(t as Transform) as bool:
        return self.Remove(Target(t, self.targetTracker))

    public def Remove(targetable as Targetable) as bool:
        // Fillout the struct directly to avoid internal GetComponent calls.
        target = Target()
        target.gameObject = targetable.gameObject
        target.transform = targetable.transform
        target.targetable = targetable
        
        return self.Remove(target)

    public def Remove(target as Target) as bool:
        // Quit if nothing was removed
        if not self.targets.Remove(target):
            return false
        
        // Remove this perimeter from targetable's list to keep in sync
        target.targetable.perimeters.Remove(self)
        
        // Trigger sorting.
        self.dirty = true
        
        // Silence errors on game exit / unload clean-up
        #if ((target.transform is null) or (self.xform is null)) or (self.xform.parent is null):
            #return false
 
        // Trigger the delegate execution for this event
        target.targetable.OnNotDetected(self.targetTracker)
        
        return true

    public self[index as int] as Target:
        get:
            return self.targets[index]
        set:
            raise System.NotImplementedException('Read-only.')

    public def Clear():
        // Trigger the delegate execution for this event
        for target as Target in self.targets:
            target.targetable.OnNotDetected(self.targetTracker)
        
        self.targets.Clear()
        
        // Trigger sorting.
        self.dirty = true

    public def Contains(transform as Transform) as bool:
        return self.targets.Contains(Target(transform, self.targetTracker))

    public def Contains(target as Target) as bool:
        return self.targets.Contains(target)

    public def GetEnumerator() as IEnumerator[of Target]:
        for target as Target in self.targets:
            yield target

    // Non-generic version? Not sure why this is used by the interface
    def IEnumerable.GetEnumerator() as IEnumerator:
        for target as Target in self.targets:
            yield target
    
    public def CopyTo(array as (Target), arrayIndex as int):
        self.targets.CopyTo(array, arrayIndex)

    // Not implimented from iList
    public def IndexOf(item as Target) as int:
        raise System.NotImplementedException()

    public def Insert(index as int, item as Target):
        raise System.NotImplementedException()

    public def RemoveAt(index as int):
        raise System.NotImplementedException()

    public IsReadOnly as bool:
        get:
            raise System.NotImplementedException()

    #endregion List Interface

    public Count as int:
        get:   
            return self.targets.Count
