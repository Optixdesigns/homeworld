import UnityEngine
import System.Collections
import System.Collections.Generic

public struct Target(System.IComparable[of Target]):

    // Target cache
    public gameObject as GameObject
    public transform as Transform
    public targetable as Targetable
    public targetTracker as TargetTracker

    public def constructor(transform as Transform, targetTracker as TargetTracker):
        self.gameObject = transform.gameObject
        self.transform = transform
        self.targetable = self.transform.GetComponent[of Targetable]()
        self.targetTracker = targetTracker

    public def CompareTo(obj as Target):
        return (1 if (self.gameObject == obj.gameObject) else 0)

/*
public class TargetList(List[of Target]):

    public override def ToString() as string:
        names as (string) = array(string, super.Count)
        i = 0
        super.ForEach(def (target as Target):
            if target.transform is null:
                return
            
            names[i] = target.transform.name
            i += 1
)
        
        return System.String.Join(', ', names)
*/

