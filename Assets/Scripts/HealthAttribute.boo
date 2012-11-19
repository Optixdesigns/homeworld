import UnityEngine
import System

[System.Serializable]
class HealthAttribute:
    public maxHealth as single = 100.0
    public regenerateSpeed as single = 0.0
    public invincible as bool = false
    public dead as bool = false

    public damagePrefab as GameObject
    public damageEffectTransform as Transform
    public damageEffectMultiplier as single = 1.0
    public damageEffectCentered as bool = true

    public healthBar as Texture2D

    private screenPos as Vector3
    private scale as single

    #[HideInInspector]
    public health as single = 100.0