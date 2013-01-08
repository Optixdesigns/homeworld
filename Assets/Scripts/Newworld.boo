
public enum DEBUG_LEVELS:
    Off
    Normal
    High

public struct HitEffect:

    public name as string
    public value as single
    public duration as single
    public hitTime as single

    public def constructor(hitEffect as HitEffect):
        self.name = hitEffect.name
        self.value = hitEffect.value
        self.duration = hitEffect.duration
        self.hitTime = hitEffect.hitTime

    public deltaDurationTime as single:
        get:
            // If smaller than 0, return 0.
            return Mathf.Max(((hitTime + duration) - Time.time), 0)

    public override def ToString() as string:
        return string.Format('(name \'{0}\', value {1}, duration {2}, hitTime {3}, deltaDurationTime {4})', self.name, self.value, self.duration, self.hitTime, self.deltaDurationTime)

public static List<Type> GetClasses(Type baseType) {
 return Assembly.GetCallingAssembly().GetTypes().Where(type => type.IsSubclassOf(baseType)).ToList();
 }

public class HitEffectList(List[of HitEffect]):

    // Impliment both constructors to enable the 1 arg copy-style initilizer
    public def constructor():
        super()

    public def constructor(hitEffectList as HitEffectList):
        super(hitEffectList)

    public override def ToString() as string:
        effectStrings as (string) = array(string, super.Count)
        i = 0
        #super.ForEach(def (effect as HitEffect):
        for effect as HitEffect in self:
            effectStrings[i] = effect.ToString()
            i += 1
        #)
        
        return System.String.Join(', ', effectStrings)

    public def CopyWithHitTime() as HitEffectList:
        newlist = HitEffectList()
        for effect as HitEffect in self:
            effect.hitTime = Time.time
            newlist.Add(effect)
        
        return newlist


[System.Serializable]
public class HitEffectGUIBacker:

    public name = 'Effect'
    public value as single = 0
    public duration as single

    public def constructor():
        pass

    public def constructor(effect as HitEffect):
        self.name = effect.name
        self.value = effect.value
        self.duration = effect.duration

    public def GetHitEffect() as HitEffect:
        return HitEffect()