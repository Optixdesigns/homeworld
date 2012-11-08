import UnityEngine
import System


class Health(MonoBehaviour):
	public maxHealth as single = 100.0
	public health as single = 100.0
	public regenerateSpeed as single = 0.0
	public invincible as bool = false
	public dead as bool = false

	public damagePrefab as GameObject
	public damageEffectTransform as Transform
	public damageEffectMultiplier as single = 1.0
	public damageEffectCentered as bool = true

	#public damageSignals as SignalSender
	#public dieSignals as SignalSender
