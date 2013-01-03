import UnityEngine

[AddComponentMenu('New World/Unit Modules/Defenses Module')]
class DefensesModule(MonoBehaviour): 
    public MaxStructureHitPoints as single = 100
    private structureHitPoints as single
    public MaxShieldHitPoints as single = 0
    private shieldHitPoints as single

    #public regenerateSpeed as single = 0.0
    public invincible as bool = false

    def Awake():
        structureHitPoints = MaxStructureHitPoints
        shieldHitPoints = MaxShieldHitPoints
    
    def Update ():
        pass
