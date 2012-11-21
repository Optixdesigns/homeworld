using UnityEngine;
using System.Collections;

[USequencerEvent("Object/ToggleObject")]
public class USEnableObjectEvent : USEventBase
{
    public bool enable = false;
	private bool prevEnable = false;
	
#if UNITY_4_0
#else
	public bool enableRecursively = true;
#endif
	
	public override void FireEvent()
	{
#if UNITY_4_0
		prevEnable = AffectedObject.activeSelf;
#else
		prevEnable = AffectedObject.active;
#endif
		
#if UNITY_4_0
		AffectedObject.SetActive(enable);
#else
		if(enableRecursively)
	        AffectedObject.SetActiveRecursively(enable);
		else
			AffectedObject.active = enable;
#endif
	}
	
	public override void ProcessEvent(float deltaTime)
	{
		
	}
	
	public override void StopEvent()
	{
		UndoEvent();
	}
	
	public override void UndoEvent()
	{
#if UNITY_4_0
		AffectedObject.SetActive(prevEnable);
#else
		if(enableRecursively)
	        AffectedObject.SetActiveRecursively(prevEnable);
		else
			AffectedObject.active = prevEnable;
#endif
	}
}
