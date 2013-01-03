import UnityEngine

[AddComponentMenu('New World/Target/Targetable')]
[RequireComponent(typeof(Rigidbody))]
class Targetable(MonoBehaviour):
    public perimeters as List[of Perimeter] = List[of Perimeter]()

    #public callable OnhitCallable(target as Target)
    event OnhitEvent as callable(HitEffectList, Target)

    // Triggered once when this target is first detected by a TargetTracker.
    // Argument: A reference back to the Radar component which triggered this event
    #public callable OnDetectedCallable(source as TargetTracker)
    event OnDetectedEvent as callable(TargetTracker)

    // Triggered once when this target is no longer detected by a TargetTracker.
    // Argument: A reference back to the Radar component which triggered this event
    #event OnNotDetected as OnNotDetectedEvent
    #public callable OnNotDetectedEvent(source as TargetTracker)
    event OnNotDetectedEvent as callable(TargetTracker)

    public def OnDetected(source as TargetTracker):
        OnDetectedEvent(source)

    public def OnNotDetected(source as TargetTracker):
        OnNotDetectedEvent(source)

    public def OnHit(effects as HitEffectList, target as Target):
        OnhitEvent(effects, target)